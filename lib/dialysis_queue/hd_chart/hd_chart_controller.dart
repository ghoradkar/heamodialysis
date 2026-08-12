import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' show Get, GetNavigation, GetxController, ExtensionDialog;
import 'package:heamodialysis/dialysis_queue/hd_chart/add_edit_hd_chart_screen.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/hd_chart_list.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/first_table_data_model.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/hd_chart_list_model.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/hd_chart_payload.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/hd_chart_table_data.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:http/io_client.dart';

class HdChartController extends GetxController {
  String? msg;
  String? status;
  IOClient ioClient = IOClient(ByPassCert().httpClient);
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
    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiNames.savePatientHdChartPrm);
    debugPrint("SECOND TABLE API URL : $uri");
    String jsonbody = json.encode(hdChart);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(" SECOND TABLE API URL : ${uri.path}");
    // debugPrint(jsonbody);

    debugPrint("SECOND TABLEAPI BODY:$jsonbody");

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      if (jsonDecode(response.body) == 'Success') {
        CustomMessage.toast("Data Saved Successfully");

        Get.off(const HdChartList());
      }
    } else {
      isLoading = false;
      isSaving = false;

      debugPrint('saveSecondTableData fail');
      update();

      throw Exception('Failed saveSecondTableData');
    }
  }

  saveFirstTableData(firstTableData) async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.savePatientHdChart);

    String jsonbody = json.encode(firstTableData);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(" FIRST TABLE API URL :${uri.path}");
    debugPrint(" FIRST TABLE API URL :${uri}");
    debugPrint("FIRST TABLE API BODY:$jsonbody");

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      if (jsonDecode(response.body) == 'Success') {
        isLoading = false;
        update();
      } else {
        isLoading = false;
        isSaving = false;

        debugPrint('saveFirstTableData fail');
        update();
      }
    } else {
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
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getDataForHdChartGrid}?inputValue=$inputType&startIndex=0&callFrom=DIS&searchType=$searchType&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      List<dynamic> data = json.decode(response.body);
      hdChartList =
          data.map((json) => HdChartListModel.fromJson(json)).toList();
    } else {
      isLoading = false;
      update();
      throw Exception('Failed getHdChartList');
    }
  }

  deleteTableRow(String treatmentHdChartId) async {
    isLoading = true;
    update();
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.deleteTreatDetById}?treatmentHdChartId=$treatmentHdChartId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      CustomMessage.toast(response.body);
      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
      throw Exception('Failed deleteTableRow');
    }
  }

  getFirstTableData(String patientId, String treatmentId) async {
    isLoading = true;
    update();
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getHdChartSafetyChecksDetails}?patientId=$patientId&treatmentId=$treatmentId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      var data = json.decode(response.body);
      if (data['status'] == 1) {
        firstTableDataModel = FirstTableDataModel.fromJson(data);
      }
    } else {
      isLoading = false;
      update();
      throw Exception('Failed getHdChartList');
    }
  }

  getSecondTableData(String patientId, String treatmentId) async {
    isLoading = true;
    update();
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getHdChartTreatmentDetails}?patientId=$patientId&treatmentId=$treatmentId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      List<dynamic> data = json.decode(response.body);
      List<HdChartRow> hdChartList =
          data.map((json) => HdChartRow.fromJson(json)).toList();
      hdChartCardData.addAll(hdChartList);
    } else {
      isLoading = false;
      update();
      throw Exception('Failed getHdChartList');
    }
  }

  searchByDropDownList() async {
    isLoading = true;
    update();
    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiNames.searchByDropDownListApi);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      final data = json.decode(response.body);
      searchByModel = SearchRegisteredPatientModel.fromJson(data);
    } else {
      isLoading = false;
      update();
      throw Exception('Failed getting search By list');
    }
  }

  getTableData(String patientId, String treatmentId) async {
    isLoading = true;
    update();
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getDetailsForHemodialysisChartById}?patientId=$patientId&treatmentId=$treatmentId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      var data = json.decode(response.body);
      hdChartTableData = HdChartTableData.fromJson(data);
    } else {
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
      title: "Success",
      middleText: "Data Saved Successfully!",
      textConfirm: "OK",
      onConfirm: () {
        Get.back();
      },
    );
  }

}
