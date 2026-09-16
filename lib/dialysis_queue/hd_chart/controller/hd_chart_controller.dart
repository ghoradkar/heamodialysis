import 'package:flutter/cupertino.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart' show Get, GetNavigation, GetxController, ExtensionDialog;
import 'package:heamodialysis/dialysis_queue/hd_chart/screen/add_edit_hd_chart_screen.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/screen/hd_chart_list.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/first_table_data_model.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/hd_chart_list_model.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/hd_chart_payload.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/hd_chart_table_data.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/repository/hd_chart_repository.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';

class HdChartController extends GetxController {
  final HdChartRepository _repository = HdChartRepository();

  String? msg;
  String? status;
  var userData;
  bool isLoading = false;
  bool isSaving = false;
  TextEditingController ctrlKtV = TextEditingController();
  TextEditingController airDetLineClampController = TextEditingController();
  TextEditingController alarmLimSet = TextEditingController();
  TextEditingController hepPumpOn = TextEditingController();
  TextEditingController dialysateFlow = TextEditingController();
  TextEditingController dialysateTemp = TextEditingController();
  TextEditingController concentrateNa = TextEditingController();
  TextEditingController conductivity = TextEditingController();
  TextEditingController injection = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController bloodPH = TextEditingController();
  TextEditingController bloodPL = TextEditingController();
  TextEditingController pulseController = TextEditingController();
  TextEditingController vpController = TextEditingController();
  TextEditingController apController = TextEditingController();
  TextEditingController tmpController = TextEditingController();
  TextEditingController ufAchController = TextEditingController();
  TextEditingController ufrController = TextEditingController();
  TextEditingController bfrController = TextEditingController();
  TextEditingController condController = TextEditingController();
  TextEditingController cbvController = TextEditingController();
  TextEditingController ktvController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController infusionDose = TextEditingController();
  TextEditingController bolusDose = TextEditingController();
  List<HdChartListModel>? hdChartList;
  FirstTableDataModel? firstTableDataModel;
  HdChartTableData? hdChartTableData;
  SearchRegisteredPatientModel? searchByModel;
  List<HdChartRow> hdChartCardData = [];

  TextEditingController valueController = TextEditingController();
  final demoRows = <DialysisRow>[];

  saveSecondTableData(HdChartPayload hdChart) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.saveSecondTableData(hdChart);
      isLoading = false;
      update();
      if (data == 'Success') {
        CustomMessage.toast(l10n.schedDataSaved);

        Get.off(const HdChartList());
      }
    } on ApiException {
      isLoading = false;
      isSaving = false;
      debugPrint('saveSecondTableData fail');
      update();
      throw Exception('Failed saveSecondTableData');
    }
  }

  saveFirstTableData(firstTableData) async {
    isLoading = true;

    try {
      final data = await _repository.saveFirstTableData(firstTableData);
      if (data == 'Success') {
        isLoading = false;
        update();
      } else {
        isLoading = false;
        isSaving = false;
        debugPrint('saveFirstTableData fail');
        update();
      }
    } on ApiException {
      isLoading = false;
      isSaving = false;
      debugPrint('saveFirstTableData fail');
      update();
      throw Exception('Failed saveFirstTableData');
    }
  }

  getHdChartList(String inputType, String searchType, String unitId) async {
    isLoading = true;
    update();

    try {
      hdChartList =
          await _repository.getHdChartList(inputType, searchType, unitId);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getHdChartList');
    }
  }

  deleteTableRow(String treatmentHdChartId) async {
    isLoading = true;
    update();

    try {
      final responseBody = await _repository.deleteTableRow(treatmentHdChartId);
      CustomMessage.toast(responseBody);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed deleteTableRow');
    }
  }

  getFirstTableData(String patientId, String treatmentId) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.getFirstTableData(patientId, treatmentId);
      isLoading = false;
      update();
      if (data['status'] == 1) {
        firstTableDataModel = FirstTableDataModel.fromJson(data);
      }
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getHdChartList');
    }
  }

  getSecondTableData(String patientId, String treatmentId) async {
    isLoading = true;
    update();

    try {
      final hdChartList =
          await _repository.getSecondTableData(patientId, treatmentId);
      isLoading = false;
      update();
      hdChartCardData.addAll(hdChartList);
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getHdChartList');
    }
  }

  searchByDropDownList() async {
    isLoading = true;
    update();

    try {
      searchByModel = await _repository.searchByDropDownList();
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting search By list');
    }
  }

  getTableData(String patientId, String treatmentId) async {
    isLoading = true;
    update();

    try {
      hdChartTableData = await _repository.getTableData(patientId, treatmentId);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getTableData');
    }
  }

  clearAllFields() {
    bolusDose.clear();
    infusionDose.clear();
    ctrlKtV.clear();
    airDetLineClampController.clear();
    alarmLimSet.clear();
    hepPumpOn.clear();
    dialysateFlow.clear();
    dialysateTemp.clear();
    concentrateNa.clear();
    conductivity.clear();
    injection.clear();
    // Second table input भी empty
    hdChartCardData.clear();
    update();
  }


  void showSuccessPopup() {
    Get.defaultDialog(
      title: l10n.commonSuccess,
      middleText: "Data Saved Successfully!",
      textConfirm: "OK",
      onConfirm: () {
        Get.back();
      },
    );
  }

}
