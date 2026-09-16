import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/login/model/get_captcha_model.dart';
import 'package:heamodialysis/login/model/login_model.dart';
import 'package:heamodialysis/login/model/unit_name_model.dart';
import 'package:heamodialysis/login/repository/login_repository.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/auth_token_manager.dart';
import 'package:heamodialysis/utils/session_manager.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';

class LoginController extends GetxController {
  final LoginRepository _repository = LoginRepository();

  final userName = TextEditingController().obs;
  final password = TextEditingController().obs;
  final captcha = TextEditingController().obs;
  final isPasswordVisible = true.obs;
  bool obscurePassword = true;

  String? msg;

  GetCaptchaModel? captchaModel;
  List<UnitNameModel>? unitNameList;
  UnitNameModel? unitName;

  String? status;
  int? code;
  // Only present on the OTP_REQUIRED response from verifyLogin - the
  // number the OTP was texted to, for showing a masked hint on the OTP screen.
  String? otpMobileNo;

  LoginModel? loginRespModel;

  bool isLoading = false;

   login(String username, String unitId, String password, String? captcha1,
      String? captcha2) async {
    isLoading = true;
    update();

    try {
      final data =
          await _repository.login(username, unitId, password, captcha1, captcha2);
      code = data['code'];
      if (data['status'] == 'Success') {
        isLoading = false;

        await SessionManager().setLoggedIn(true);
        loginRespModel = LoginModel.fromJson(data);
        if (loginRespModel != null && unitName != null) {
          var resolvedUnitId = checkAndExtractUnitId(
            loginRespModel!.dataDet.unitId.toString(),
            unitName!.unitId.toString(),
          );
          loginRespModel!.dataDet.unitId = int.parse(resolvedUnitId);
        }

        await SharedPref().save(
            const SharedPrefConstant().kUserData, loginRespModel!.dataDet);
        status = data['status'];

        // Pilot: verifyLogin only (not verifyLoginNew/OTP). Silently
        // re-calls this same login every 59 minutes to rotate the token
        // instead of logging the user out on a fixed timer.
        final token = loginRespModel!.token;
        if (token != null) {
          AuthTokenManager().activate(
            token,
            () => _repository.login(username, unitId, password, captcha1, captcha2),
          );
        }

        // So the splash screen can silently re-authenticate (and get a
        // fresh token) when the app reopens via "stay logged in", instead
        // of skipping straight to the dashboard with no token at all.
        const prefs = SharedPrefConstant();
        await SharedPref().save(prefs.kSavedUsername, username);
        await SharedPref().save(prefs.kSavedUnitId, unitId);
        await SharedPref().save(prefs.kSavedPassword, password);
      } else {
        isLoading = false;

        // OTP_REQUIRED (code 2) also lands here: no dataDet is returned yet,
        // so we only record the status/code/mobileNo and let the caller
        // decide to navigate to the OTP screen instead of treating this as
        // a failure.
        SessionManager().setLoggedIn(false);
        status = data['status'];
        otpMobileNo = data['mobileNo'];
      }
    } on ApiException catch (e) {
      isLoading = false;
      SessionManager().setLoggedIn(false);
      if (e.statusCode == 401) {
        status = l10n.commonSomethingWentWrong;
      } else {
        throw Exception('Failed to sign in');
      }
    }
    update();
  }

  /// Verifies the OTP sent by [login] when the backend responded with
  /// code:2 / "OTP_REQUIRED". On success this behaves exactly like a
  /// direct login: same response shape, same session storage.
  Future<void> verifyOtp(String userName, String unitId, String otp) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.verifyOtp(userName, unitId, otp);
      code = data['code'];
      if (data['status'] == 'Success') {
        isLoading = false;

        await SessionManager().setLoggedIn(true);
        loginRespModel = LoginModel.fromJson(data);
        if (loginRespModel != null && unitName != null) {
          var resolvedUnitId = checkAndExtractUnitId(
            loginRespModel!.dataDet.unitId.toString(),
            unitName!.unitId.toString(),
          );
          loginRespModel!.dataDet.unitId = int.parse(resolvedUnitId);
        }

        await SharedPref().save(
            const SharedPrefConstant().kUserData, loginRespModel!.dataDet);
        status = data['status'];
      } else {
        // "Invalid or Expired OTP" or "Invalid User" - both come back as
        // code:1, distinguished only by the status message.
        isLoading = false;

        SessionManager().setLoggedIn(false);
        status = data['status'];
      }
    } on ApiException catch (e) {
      isLoading = false;
      SessionManager().setLoggedIn(false);
      if (e.statusCode == 401) {
        status = l10n.commonSomethingWentWrong;
      } else {
        throw Exception('Failed to verify OTP');
      }
    }
    update();
  }

  String checkAndExtractUnitId(String unitIdString, String selectedUnitId) {
    // Split the unitIdString into a list
    List<String> unitIds = unitIdString.split(',');

    // Check if the selectedUnitId is present in the list
    if (unitIds.contains(selectedUnitId)) {
      // Return only the selected unit ID
      return selectedUnitId;
    } else {
      // Return the original string if the selected ID is not found
      return unitIdString;
    }
  }

  Future<bool> getCaptcha() async {
    try {
      captchaModel = await _repository.getCaptcha();
      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getting captcha');
    }
  }

  getUnitId(String userName) async {
    try {
      final list = await _repository.getUnitByUserName(userName);
      if (list.isNotEmpty) {
        unitNameList = list;
        unitName = unitNameList?.first;
        update();
      }
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        update();
      } else {
        throw Exception('Failed getting unitname');
      }
    }
  }
}
