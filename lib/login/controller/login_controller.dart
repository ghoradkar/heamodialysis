import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/login/model/get_captcha_model.dart';
import 'package:heamodialysis/login/model/login_model.dart';
import 'package:heamodialysis/login/model/login_model.dart';
import 'package:heamodialysis/login/model/unit_name_model.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/utils/session_manager.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:http/io_client.dart';

class LoginController extends GetxController {
  final userName = TextEditingController().obs;
  final password = TextEditingController().obs;
  final captcha = TextEditingController().obs;
  final isPasswordVisible = true.obs;
  bool obscurePassword = true;
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  String? msg;

  GetCaptchaModel? captchaModel;
  List<UnitNameModel>? unitNameList;
  UnitNameModel? unitName;

  String? status;

  LoginModel? loginRespModel;

  bool isLoading = false;

   login(String username, String unitId, String password, String? captcha1,
      String? captcha2) async {
    isLoading = true;
    update();
    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.login);
    print(ApiConstants.baseUrl);

    final Map<String, dynamic> body = {
      "userName": username,
      "password": password,
      "captcha2": captcha1 ?? "",
      "unitId": unitId,
      "captcha1": captcha2 ?? ""
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails/
      final data = json.decode(response.body);
      if (data['status'] == 'Success') {
        isLoading = false;

        await SessionManager().setLoggedIn(true);
        loginRespModel = LoginModel.fromJson(data);
        if (loginRespModel != null && unitName != null) {
          var unitId = checkAndExtractUnitId(
            loginRespModel!.dataDet.unitId.toString(),
            unitName!.unitId.toString(),
          );
          loginRespModel!.dataDet.unitId = int.parse(unitId);
        }

        await SharedPref().save(
            const SharedPrefConstant().kUserData, loginRespModel!.dataDet);
        status = data['status'];
      } else {
        isLoading = false;

        SessionManager().setLoggedIn(false);
        status = data['status'];
      }
    } else if (response.statusCode == 401) {
      isLoading = false;

      SessionManager().setLoggedIn(false);
      status = "Something went wrong";
    } else {
      isLoading = false;

      SessionManager().setLoggedIn(false);
      throw Exception('Failed to sign in');
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
    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getCaptcha);
    // final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.getCaptcha);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      captchaModel = GetCaptchaModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      update();

      return false;
    } else {
      throw Exception('Failed getting captcha');
    }
  }

  // Future<bool> getCaptcha() async {
  //   final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.getCaptcha);
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //   };
  //
  //   debugPrint(uri.path);
  //
  //   try {
  //     final response = await ioClient
  //         .get(uri, headers: headers)
  //         .timeout(const Duration(seconds: 10)); // Set a 10-second timeout
  //
  //     debugPrint(response.statusCode.toString());
  //     debugPrint("response.body : ${response.body}");
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       captchaModel = GetCaptchaModel.fromJson(data);
  //       update();
  //       return true;
  //     } else if (response.statusCode == 401) {
  //       update();
  //       return false;
  //     } else {
  //       throw Exception('Failed getting captcha');
  //     }
  //   } on TimeoutException {
  //     debugPrint("Request timed out");
  //     _showTimeoutDialog(); // Show dialog for timeout
  //     return false; // Return false to indicate failure
  //   } catch (e) {
  //     debugPrint("Error occurred: $e");
  //     throw Exception('Failed getting captcha: $e');
  //   }
  // }
  //
  // Future _showTimeoutDialog() {
  //   return Get.dialog(Column(
  //     children: [
  //       const Text("Notice"),
  //       const Text("This app only available in Indian region"),
  //       TextButton(
  //         onPressed: () {
  //           Get.back();
  //         },
  //         child: const Text("OK"),
  //       ),
  //     ],
  //   ));
  // }

  // Future<void> getCaptcha() async {
  //   await Future.delayed(Duration(seconds: 15)); // Simulate a delay
  //   captchaModel = null; // Simulate no captcha received
  //   update();
  // }

  getUnitId(String userName) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getUnitByUserName}?userName=$userName");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      // unitNameM = UnitNameModel.fromJson(data);
      if (data.isNotEmpty) {
        unitNameList =
            data.map((item) => UnitNameModel.fromJson(item)).toList();

        unitName = unitNameList?.first;
        update();
      }
    } else if (response.statusCode == 401) {
      update();
    } else {
      throw Exception('Failed getting unitname');
    }
  }
}
