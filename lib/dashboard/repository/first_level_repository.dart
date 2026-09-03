import 'dart:convert';

import 'package:heamodialysis/dashboard/model/first_level_scrutiny_approval_list.dart';
import 'package:heamodialysis/dashboard/model/first_level_send_req_model.dart';
import 'package:heamodialysis/dashboard/model/patient_details_model.dart';
import 'package:heamodialysis/dashboard/model/question_model.dart';
import 'package:heamodialysis/dashboard/model/scrutiny_answer_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';

class FirstLevelRepository {
  Future<FirstLevelScrutinyApprovalList> getFirstApprovalList(
      userId, unitId) async {
    final response = await ApiClient().get(
        "${ApiConstants.ip}${ApiNames.getScrutinyApplication}?userId=$userId&unitId=$unitId");

    if (response.statusCode == 200) {
      return FirstLevelScrutinyApprovalList.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> sendToSecondLevel(
      FirstLevelSendReqModel firstLevelSendReqModel) async {
    final response = await ApiClient().post(
      "${ApiConstants.ip}${ApiNames.sendTOSecondLvl}",
      body: firstLevelSendReqModel,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<PatientDetailsModel> getPatientDet(patientId) async {
    final response = await ApiClient()
        .get("${ApiConstants.baseUrl}${ApiNames.getDetailsById}?patientId=$patientId");

    if (response.statusCode == 200) {
      return PatientDetailsModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> getQuestions(
      int srnMoveId, int scrutinyLevelDetId, int unitId) async {
    final response = await ApiClient().post(
      "${ApiConstants.ip}${ApiNames.questionList}",
      body: {
        "serviceCode": "NPV",
        "srnMoveId": srnMoveId,
        "scrutinyLevelDetId": scrutinyLevelDetId,
        "unitId": unitId,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<ScrutinyAnswerModel> getAnswers(srnId) async {
    final response = await ApiClient()
        .get("${ApiConstants.ip}${ApiNames.getAnswerList}?srnId=$srnId");

    if (response.statusCode == 200) {
      return ScrutinyAnswerModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }
}
