import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/access_type_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/access_type_site_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/dialysis_type_mode.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/dialyzer_type_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/edit_req_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/get_pre_dialysis_details_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/special_dialysis_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/model/edit_pre_dialysis/edit_pre_dialysis_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/model/fiber_bundle_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/model/pre_dialysis/edit_history/history_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/model/pre_dialysis/pre_dialysis_data.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/model/pre_dialysis/pre_dialysis_list_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/pre_dialysis_list/screen/pre_dialysis_screen.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/repository/pre_dialysis_repository.dart';
import 'package:heamodialysis/new_registration/screen/upload_document_tab.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/already_registered_patient.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

import '../../edit_pre_dialysis/model/inter_dialytic_weight.dart';

class PreDialysisController extends GetxController {
  final PreDialysisRepository _repository = PreDialysisRepository();

  String? msg;

  String? status;

  PreDialysisListModel? preDialysisListModel;
  EditPreDialysisModel? editPreDialysisModel;
  SearchRegisteredPatientModel? searchByModel;
  DialysisTypeModel? editPredialysisDetailsModel;
  SpecialDialysisModel? specialDialysisModel;
  AccessTypeModel? accessTypeData;
  AccessTypeSiteModel? accessTypeSiteModel;
  DialyzerTypeModel? dialyzerTypeModel;
  HistoryModel? historyModel;
  GetPreDialysisDetailsModel? getPreDialysisDetailsModel;
  EditReqModel editReqModel = EditReqModel();
  AlreadyRegisteredPatient? searchedPatientResultModel;

  TextEditingController doubleTxtController1 = TextEditingController();
  TextEditingController doubleTxtController2 = TextEditingController();
  TextEditingController dialyzerReuseNoController = TextEditingController();
  TextEditingController confirmationRemarkController = TextEditingController();
  TextEditingController dialyzerBarcodeController = TextEditingController();
  TextEditingController tubeBarcodeController = TextEditingController();
  TextEditingController dialyzerTubeReuseNoController = TextEditingController();
  TextEditingController dialyzerRemark = TextEditingController();
  TextEditingController expectedFiber = TextEditingController();
  TextEditingController tubeRemark = TextEditingController();
  TextEditingController oxygenLevel = TextEditingController();
  TextEditingController respiratoryRate = TextEditingController();
  TextEditingController pulseLevel = TextEditingController();
  TextEditingController temperaturController = TextEditingController();
  bool? selectedTemp;
  TextEditingController preDialyWeightController = TextEditingController();
  TextEditingController weightGainController = TextEditingController();
  TextEditingController descardRemarkController = TextEditingController();
  TextEditingController dryWeightController = TextEditingController();
  TextEditingController preConditionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? startDialysisDate;
  TextEditingController timeController = TextEditingController();
  String? startDialysisTime;
  String? dropDownValue;
  CustomRadioButtons groupVal1 = CustomRadioButtons.yes;
  CustomRadioButtons groupVal2 = CustomRadioButtons.yes;
  bool isSaving = false;
  FileDetails userProfilePhoto = FileDetails(
      name: 'patientImage',
      key: 'patientImage',
      isSelected: false,
      isReq: false);

  bool isLoading = false;

  InterDialyticWeight? interDialyticWeight;

  List<FiberBundleModel>? fiberBundle;

  editPreDialysis() async {
    isLoading = true;
    update();

    try {
      final data = await _repository.editPreDialysis(editReqModel);
      isLoading = false;
      isSaving = false;
      update();

      if (data['status'] == 'Success') {
        CustomMessage.toast(l10n.schedDataSaved);
        Get.off(const PreDialysisScreen());
      }
    } on ApiException {
      isLoading = false;
      isSaving = false;

      update();

      CustomMessage.toast(l10n.schedDataSaveFailed);

      throw Exception('Edit Failed');
    }
  }

  String prettyPrintJson(Map<String, dynamic> json) {
    var encoder = const JsonEncoder.withIndent('  ');
    var jsonString = encoder.convert(json);
    // Add newline after each field
    jsonString = jsonString.replaceAllMapped(RegExp(r',\n\s*'), (match) {
      return ',\n';
    });

    return jsonString;
  }

  Future<bool> searchByDropDownList() async {
    try {
      searchByModel = await _repository.searchByDropDownList();
      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getting search By list');
    }
  }

  searchPreDialysisPatient(String type, String input, unitId) async {
    isLoading = true;

    try {
      final data =
          await _repository.searchPreDialysisPatient(type, input, unitId);
      isLoading = false;

      if (data['status'] == 'Success') {
        preDialysisListModel = PreDialysisListModel.fromJson(data);
      } else {
        isLoading = false;

        status = data['status'];
        preDialysisListModel = null;
      }
    } on ApiException catch (e) {
      isLoading = false;
      preDialysisListModel = null;

      if (e.statusCode == 401) {
        status = "Something went wrong";
      } else {
        throw Exception('Failed search');
      }
    }
    update();
  }

  getDialysisType() async {
    isLoading = true;

    try {
      editPredialysisDetailsModel = await _repository.getDialysisType();
      isLoading = false;

      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      isLoading = false;
      update();
      throw Exception('Failed getting getDialysisType');
    }
  }

  getSpecialDialysis() async {
    isLoading = true;

    try {
      specialDialysisModel = await _repository.getSpecialDialysis();
      isLoading = false;

      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      isLoading = false;
      update();
      throw Exception('Failed getting getDialysisType');
    }
  }

  getAccessType() async {
    isLoading = true;

    try {
      accessTypeData = await _repository.getAccessType();
      isLoading = false;
      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      isLoading = false;
      update();
      throw Exception('Failed getting getDialysisType');
    }
  }

  getAccessTypeSite(lookUpId) async {
    isLoading = true;

    try {
      accessTypeSiteModel = await _repository.getAccessTypeSite(lookUpId);
      isLoading = false;

      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getting getAccessTypeSite');
    }
  }

  getDialyzerType() async {
    isLoading = true;

    try {
      dialyzerTypeModel = await _repository.getDialyzerType();
      isLoading = false;

      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      isLoading = false;

      throw Exception('Failed getting dialyzerTypeModel');
    }
  }

  getInterDialyticWeight(String patientId, String treatmentId) async {
    isLoading = true;

    try {
      final data =
          await _repository.getInterDialyticWeight(patientId, treatmentId);
      isLoading = false;

      if (data['status'] == 'Success') {
        interDialyticWeight = InterDialyticWeight.fromJson(data);
      } else {
        isLoading = false;

        status = data['status'];
      }
    } on ApiException catch (e) {
      isLoading = false;

      if (e.statusCode == 401) {
        status = "Something went wrong";
      } else {
        throw Exception('Failed search');
      }
    }
    update();
  }

  getFiberBundle(String lookupId) async {
    isLoading = true;

    try {
      fiberBundle = await _repository.getFiberBundle(lookupId);
      isLoading = false;

      expectedFiber.text = fiberBundle?.first.lookupDetHierDescEn ?? "";
    } on ApiException catch (e) {
      isLoading = false;

      if (e.statusCode == 401) {
        status = "Something went wrong";
      } else {
        throw Exception('Failed search');
      }
    }
    update();
  }

  Future<void> getViewHistory(int patientId) async {
    final result = await _repository.getViewHistory(patientId);
    if (result != null) {
      historyModel = result;
    }
  }

  getDialyzerDetails(PreDialysisData preDialysis) async {
    isLoading = true;

    final result = await _repository.getDialyzerDetails(preDialysis);

    if (result != null) {
      isLoading = false;

      getPreDialysisDetailsModel = result;

      dialyzerBarcodeController.text =
          getPreDialysisDetailsModel?.data?.first.dialyserBarcodeSerialNo ?? "";
      tubeBarcodeController.text =
          getPreDialysisDetailsModel?.data?.first.tubeBarcodeSerialNo ?? "";
      dialyzerRemark.text =
          getPreDialysisDetailsModel?.data?.first.dialyserRemarks ?? "";
      tubeRemark.text =
          getPreDialysisDetailsModel?.data?.first.tubeRemarks ?? "";

      if (getPreDialysisDetailsModel?.data != null) {
        if (getPreDialysisDetailsModel?.data?.first.dialyserResueNo == null) {
          getPreDialysisDetailsModel?.data?.first.dialyserResueNo = 0;
          var incrementC =
              (getPreDialysisDetailsModel!.data!.first.dialyserResueNo! + 1);
          getPreDialysisDetailsModel!.data!.first.dialyserResueNo = incrementC;
          dialyzerReuseNoController.text = getPreDialysisDetailsModel
                  ?.data?.first.dialyserResueNo
                  .toString() ??
              "";
        } else {
          var incrementCount =
              (getPreDialysisDetailsModel!.data!.first.dialyserResueNo! + 1);
          getPreDialysisDetailsModel!.data!.first.dialyserResueNo =
              incrementCount;
          dialyzerReuseNoController.text = getPreDialysisDetailsModel
                  ?.data?.first.dialyserResueNo
                  .toString() ??
              "";
        }
      }

      if (getPreDialysisDetailsModel?.data != null) {
        if (getPreDialysisDetailsModel?.data?.first.tubeResueNo == null) {
          getPreDialysisDetailsModel?.data?.first.tubeResueNo = 0;
          var incrementC =
              (getPreDialysisDetailsModel!.data!.first.tubeResueNo! + 1);
          getPreDialysisDetailsModel!.data!.first.tubeResueNo = incrementC;
          dialyzerTubeReuseNoController.text =
              getPreDialysisDetailsModel?.data?.first.tubeResueNo.toString() ??
                  "";
        } else {
          var incrementC =
              (getPreDialysisDetailsModel!.data!.first.tubeResueNo! + 1);

          getPreDialysisDetailsModel!.data!.first.tubeResueNo = incrementC;
          dialyzerTubeReuseNoController.text =
              getPreDialysisDetailsModel?.data?.first.tubeResueNo.toString() ??
                  "";
        }
      }

      int reUseNo =
          getPreDialysisDetailsModel?.data?.first.dialyserResueNo ?? 0;
      int reUseTubeNo =
          getPreDialysisDetailsModel?.data?.first.tubeResueNo ?? 0;
      if (reUseNo > 1 && reUseNo < 9) {
        groupVal1 = CustomRadioButtons.no;
      }

      if (reUseTubeNo > 1 && reUseTubeNo < 9) {
        groupVal2 = CustomRadioButtons.no;
      }
    } else {
      isLoading = false;
    }
    update();
  }

  refreshUi() {
    update();
  }
}
