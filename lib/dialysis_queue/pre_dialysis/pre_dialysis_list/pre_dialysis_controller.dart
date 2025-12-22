import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:heamodialysis/dialysis_queue/pre_dialysis/pre_dialysis_list/pre_dialysis_screen.dart';
import 'package:heamodialysis/new_registration/screens/upload_document_tab.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/already_registered_patient.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../edit_pre_dialysis/model/inter_dialytic_weight.dart';

class PreDialysisController extends GetxController {
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
  IOClient ioClient = IOClient(ByPassCert().httpClient);
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
    final uri = Uri.parse(ApiConstants.ip + ApiNames.savePreDailysis);

    String jsonbody = json.encode(editReqModel);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(jsonbody.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      isSaving = false;
      update();

      //getDeviceDetails
      final data = json.decode(response.body);
      if (data['status'] == 'Success') {
        CustomMessage.toast("Data Successfully save");
        Get.off(const PreDialysisScreen());
      }
    } else {
      isLoading = false;
      isSaving = false;

      update();

      CustomMessage.toast("Data save failed");

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
      //getDeviceDetails
      final data = json.decode(response.body);
      searchByModel = SearchRegisteredPatientModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      update();

      return false;
    } else {
      throw Exception('Failed getting search By list');
    }
  }

  searchPreDialysisPatient(String type, String input, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        // ApiConstants.oldBaseUrl + ApiConstants.getPreDiaList
        ApiConstants.baseUrl + ApiNames.getPreDiaList);

    final Map<String, dynamic> body = {
      "unitId": unitId,
      "type": type,
      "input": input,
      "category": ""
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
      isLoading = false;

      //getDeviceDetails
      final data = json.decode(response.body);
      if (data['status'] == 'Success') {
        preDialysisListModel = PreDialysisListModel.fromJson(data);
      } else {
        isLoading = false;

        status = data['status'];
        preDialysisListModel = null;
      }
    } else if (response.statusCode == 401) {
      isLoading = false;
      preDialysisListModel = null;

      status = "Something went wrong";
    } else {
      isLoading = false;
      preDialysisListModel = null;

      throw Exception('Failed search');
    }
    update();
  }

  getDialysisType() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getDialysisType);

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
      isLoading = false;

      //getDeviceDetails
      final data = json.decode(response.body);
      editPredialysisDetailsModel = DialysisTypeModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      update();

      return false;
    } else {
      isLoading = false;
      update();
      throw Exception('Failed getting getDialysisType');
    }
  }

  getSpecialDialysis() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getSpecialDailysis);

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
      isLoading = false;

      final data = json.decode(response.body);
      specialDialysisModel = SpecialDialysisModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      update();

      return false;
    } else {
      isLoading = false;
      update();
      throw Exception('Failed getting getDialysisType');
    }
  }

  getAccessType() async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getAccessType);

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
      isLoading = false;

      //getDeviceDetails
      final data = json.decode(response.body);
      accessTypeData = AccessTypeModel.fromJson(data);
      update();
      return true;
    } else if (response.statusCode == 401) {
      update();

      return false;
    } else {
      isLoading = false;
      update();
      throw Exception('Failed getting getDialysisType');
    }
  }

  getAccessTypeSite(lookUpId) async {
    isLoading = true;

    final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiNames.getAccessSite}?lookUpId=$lookUpId');

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
      isLoading = false;

      //getDeviceDetails
      final data = json.decode(response.body);
      accessTypeSiteModel = AccessTypeSiteModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      update();

      return false;
    } else {
      throw Exception('Failed getting getAccessTypeSite');
    }
  }

  getDialyzerType() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getDialyserType);

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
      isLoading = false;

      //getDeviceDetails
      final data = json.decode(response.body);
      dialyzerTypeModel = DialyzerTypeModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting dialyzerTypeModel');
    }
  }

  getInterDialyticWeight(String patientId, String treatmentId) async {
    isLoading = true;
    final uri = Uri.parse(
        // ApiConstants.baseUrl + ApiConstants.searchRegisteredPatientApi
        ApiConstants.baseUrl + ApiNames.getIntermediateWait);

    final Map<String, dynamic> body = {
      "patientId": patientId,
      "treatmentId": treatmentId
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
      isLoading = false;

      //getDeviceDetails
      final data = json.decode(response.body);
      if (data['status'] == 'Success') {
        interDialyticWeight = InterDialyticWeight.fromJson(data);
      } else {
        isLoading = false;

        status = data['status'];
      }
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getFiberBundle(String lookupId) async {
    isLoading = true;
    final uri = Uri.parse(
        // ApiConstants.baseUrl + ApiConstants.searchRegisteredPatientApi
        "${ApiConstants.baseUrl}${ApiNames.getFibreBundle}?lookUpId=$lookupId");

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
      List<dynamic> data = json.decode(response.body);
      fiberBundle =
          data.map((json) => FiberBundleModel.fromJson(json)).toList();
      expectedFiber.text = fiberBundle?.first.lookupDetHierDescEn ?? "";
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  Future<void> getViewHistory(int patientId) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse('${ApiConstants.baseUrl}${ApiNames.getPreHistory}'));
    request.body = json.encode({"patientId": patientId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());

      final data = json.decode(await response.stream.bytesToString());

      historyModel = HistoryModel.fromJson(data);
    } else {
      debugPrint(response.reasonPhrase);
    }

    //
    // final String apiUrl =
    //     '${ApiConstants.baseUrl}${ApiConstants.getPreHistory}';
    //
    // // Define headers
    // var headers = {'Content-Type': 'application/json'};
    //
    // try {
    //   // Create request body
    //   String requestBody = json.encode({
    //     "patientId": patientId,
    //   });
    //
    //   // Send POST request
    //   http.Response response = await http.post(
    //     Uri.parse(apiUrl),
    //     headers: headers,
    //     body: requestBody,
    //   );
    //
    //   // Handle the response
    //   if (response.statusCode == 200) {
    //     debugPrint('Response data: ${response.body}');
    //     final data = json.decode(response.body);
    //
    //     historyModel = HistoryModel.fromJson(data);
    //   } else {
    //     debugPrint('Request failed with status: ${response.statusCode}');
    //     debugPrint('Reason: ${response.reasonPhrase}');
    //   }
  }

  getDialyzerDetails(PreDialysisData preDialysis) async {
    isLoading = true;

    var headers = {
      'Content-Type': 'application/json',
    };

    // Base URL
    final String apiUrl = ApiConstants.baseUrl + ApiNames.getDialysisDetails;

    var request = http.Request('GET', Uri.parse(apiUrl));
    request.body = json.encode({
      'patientId': preDialysis.patientId.toString(),
      'treatmentId': preDialysis.treatmentId.toString(),
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await ioClient.send(request);

    debugPrint(ApiConstants.baseUrl + ApiNames.getDialysisDetails);

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(await response.stream.bytesToString());
      getPreDialysisDetailsModel = GetPreDialysisDetailsModel.fromJson(data);

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
      debugPrint(response.reasonPhrase);
    }
    update();
  }

  refreshUi() {
    update();
  }
}
