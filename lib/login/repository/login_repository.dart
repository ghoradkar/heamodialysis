import 'dart:convert';

import 'package:heamodialysis/login/model/get_captcha_model.dart';
import 'package:heamodialysis/login/model/unit_name_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/auth_token_manager.dart';

class LoginRepository {
  Future<Map<String, dynamic>> login(
      String username, String unitId, String password, String? captcha1, String? captcha2) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.login,
      body: {
        "userName": username,
        "password": password,
        "captcha2": captcha1 ?? "",
        "unitId": unitId,
        "captcha1": captcha2 ?? ""
      },
    );

    if (response.statusCode == 200) {
      // Some endpoints (confirmed on saveLogoutHistoryMobile) still need
      // this server-side session cookie alongside the JWT - captured here
      // so it covers manual login, the silent refresh, and the splash
      // screen's silent re-login, since they all call this method.
      AuthTokenManager().setSessionCookie(response.headers['set-cookie']);
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> verifyOtp(
      String userName, String unitId, String otp) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.verifyLoginOtp,
      body: {
        "userName": userName,
        "unitId": int.tryParse(unitId) ?? unitId,
        "otp": otp,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<GetCaptchaModel> getCaptcha() async {
    final response =
        await ApiClient().get(ApiConstants.baseUrl + ApiNames.getCaptcha);

    if (response.statusCode == 200) {
      return GetCaptchaModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Bearer-token pilot: this requires a valid Authorization header (403
  /// without one, per replica testing) - exercised via ApiClient's
  /// automatic header injection.
  Future<Map<String, dynamic>> logout() async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.saveLogoutHistoryMobile,
      body: {},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<UnitNameModel>> getUnitByUserName(String userName) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getUnitByUserName}?userName=$userName");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => UnitNameModel.fromJson(item)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }
}
