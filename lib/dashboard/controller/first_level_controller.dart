import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/first_level_scrutiny_approval_list.dart';
import 'package:heamodialysis/dashboard/model/first_level_send_req_model.dart';
import 'package:heamodialysis/dashboard/model/patient_details_model.dart';
import 'package:heamodialysis/dashboard/model/question_model.dart';
import 'package:heamodialysis/dashboard/model/scrutiny_answer_model.dart';
import 'package:heamodialysis/dashboard/repository/first_level_repository.dart';
import 'package:heamodialysis/dashboard/screen/nephro_first_level/scrutiny_first_level_list.dart';
import 'package:heamodialysis/dashboard/screen/nephro_second_level/scrutiny_second_level_list.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

class FirstLevelController extends GetxController {
  final FirstLevelRepository _repository = FirstLevelRepository();

  bool isLoading = true;
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

    try {
      firstLevelScrutinyApprovalModel =
          await _repository.getFirstApprovalList(userId, unitId);
      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  sendToSecondLevel(bool isFromFirstLevel, userType) async {
    isLoading = true;

    try {
      final data = await _repository.sendToSecondLevel(firstLevelSendReqModel);

      isLoading = false;
      debugPrint('✅ Message: ${data['message']}');
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
    } on ApiException catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  Future<bool> getPatientDet(patientId) async {
    isLoading = true;

    try {
      patientData = await _repository.getPatientDet(patientId);
      isLoading = false;
      update();

      return true;
    } on ApiException {
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

    try {
      final data = await _repository.getQuestions(
          srnMoveId, scrutinyLevelDetId, unitId);

      isLoading = false;
      questionModel = QuestionModel.fromJson(data["details"]);
      levelOneList.addAll(questionModel!.tmCmScrutinyQuestionDetBean!
          .where((e) => e.lvlName == "Level1")
          .toList());
      levelSecondList.addAll(questionModel!.tmCmScrutinyQuestionDetBean!
          .where((e) => e.lvlName == "Level2")
          .toList());
      update();
    } on ApiException catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  getAnswers(srnId) async {
    isLoading = true;

    try {
      answerList = await _repository.getAnswers(srnId);
      isLoading = false;
      levelOneAnswerList.addAll(answerList
              ?.details?.listTtServiceRequestMovementBean
              ?.where((e) => e.scrutinyLVL == "Level1") ??
          []);
      update();
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting getAnswers');
    }
  }
}
