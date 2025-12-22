import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/model/first_level_scrutiny_approval_list.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/model/first_level_send_req_model.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/model/patient_details_model.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/model/question_model.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/scrutiny_first_level_list.dart';
import 'package:heamodialysis/dashboard/nephro_second_level/model/scrutiny_answer_model.dart';
import 'package:heamodialysis/dashboard/nephro_second_level/scrutiny_second_level_list.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:http/io_client.dart';

class FirstLevelController extends GetxController {
  bool isLoading = true;
  IOClient ioClient = IOClient(ByPassCert().httpClient);
  CustomRadioButtons groupVal = CustomRadioButtons.yes;
  String? groupValLevel;
  List<FirstLevelTmCmScrutinyBean> originalPatientList = [];
  List<FirstLevelTmCmScrutinyBean> filteredPatientList = [];
  TextEditingController searchController = TextEditingController();
  TextEditingController description = TextEditingController();
  FirstLevelScrutinyApprovalList? firstLevelScrutinyApprovalModel;
  List<TmCmScrutinyQuestionDetBean> levelOneList = [];
  List<TmCmScrutinyQuestionDetBean> levelSecondList = [];
  PatientDetailsModel? patientData;
  ScrutinyAnswerModel? answerList;
  QuestionModel? questionModel;
  FirstLevelSendReqModel firstLevelSendReqModel = FirstLevelSendReqModel();

  List<ListTtServiceRequestMovementBean> levelOneAnswerList = [];

  Future<bool> getFirstApprovalList(userId, unitId) async {
    isLoading = true;

    // final uri = Uri.parse(
    //     "${ApiConstants.ipPort}/${ApiConstants.commonPath1}/${ApiConstants.getScrutinyApplication}?userId=$userId&unitId=$unitId");

    final uri = Uri.parse(
        "${ApiConstants.ip}${ApiNames.getScrutinyApplication}?userId=$userId&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      firstLevelScrutinyApprovalModel =
          FirstLevelScrutinyApprovalList.fromJson(data);
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  sendToSecondLevel(bool isFromFirstLevel, userType) async {
    isLoading = true;

    // final uri = Uri.parse(
    //   "${ApiConstants.ipPort}/${ApiConstants.commonPath1}${ApiConstants.sendTOSecondLvl}",
    // );

    final uri = Uri.parse(
      "${ApiConstants.ip}${ApiNames.sendTOSecondLvl}",
    );

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Request URI: ${uri.path}');
    debugPrint('Request Body: ${jsonEncode(firstLevelSendReqModel)}');

    try {
      final response = await ioClient.post(
        uri,
        headers: headers,
        body: jsonEncode(firstLevelSendReqModel),
      );
      debugPrint('📤 Request URL: ${uri.toString()}');
      debugPrint('Response Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading = false;
        final data = json.decode(response.body);
        debugPrint('✅ Message: ${data['message']}');
        // questionModel = QuestionModel.fromJson(data);
        CustomMessage.toast(data['message']);
        if (isFromFirstLevel) {
          Get.off(ScrutinyFirstLevel(
            userType: userType,
          ));
        } else {
          Get.off(ScrutinySecondLevel(
            userType: userType,
          ));
        }
        update();
      } else {
        isLoading = false;
        throw Exception('Failed to get sendToSecondLevel');
      }
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  Future<bool> getPatientDet(patientId) async {
    isLoading = true;
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getDetailsById}?patientId=$patientId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      patientData = PatientDetailsModel.fromJson(data);
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  getQuestions(
    int srnMoveId,
    int scrutinyLevelDetId,
    int unitId,
  ) async {
    isLoading = true;

    // final uri = Uri.parse(
    //   "${ApiConstants.ipPort}/${ApiConstants.commonPath1}${ApiConstants.questionList}",
    // );

    final uri = Uri.parse(
      "${ApiConstants.ip}${ApiNames.questionList}",
    );

    var body = {
      "serviceCode": "NPV",
      "srnMoveId": srnMoveId,
      "scrutinyLevelDetId": scrutinyLevelDetId,
      "unitId": unitId,
    };

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Request URI: ${uri.path}');
    debugPrint('Request Body: ${jsonEncode(body)}');

    try {
      final response = await ioClient.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      debugPrint('Response Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading = false;
        final data = json.decode(response.body);
        questionModel = QuestionModel.fromJson(data["details"]);
        levelOneList.addAll(questionModel!.tmCmScrutinyQuestionDetBean!
            .where((e) => e.lvlName == "Level1")
            .toList());
        levelSecondList.addAll(questionModel!.tmCmScrutinyQuestionDetBean!
            .where((e) => e.lvlName == "Level2")
            .toList());
        update();
      } else {
        isLoading = false;
        throw Exception('Failed to get questions');
      }
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  getAnswers(srnId) async {
    isLoading = true;

    // final uri = Uri.parse(
    //     "${ApiConstants.ipPort}/${ApiConstants.commonPath1}${ApiConstants.getAnswerList}?srnId=$srnId");

    final uri = Uri.parse(
        "${ApiConstants.ip}${ApiNames.getAnswerList}?srnId=$srnId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      answerList = ScrutinyAnswerModel.fromJson(data);
      levelOneAnswerList.addAll(answerList
              ?.details?.listTtServiceRequestMovementBean
              ?.where((e) => e.scrutinyLVL == "Level1") ??
          []);
      update();
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getAnswers');
    }
  }
}
