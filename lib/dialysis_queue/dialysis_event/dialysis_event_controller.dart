import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/dialysis_event_list.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/add_edit_dialysis_event_req.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_detaisl_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_list_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/incedent_type_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/patient_event_details.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:http/io_client.dart';

class DialysisEventController extends GetxController {
  bool isLoading = false;
  IOClient ioClient = IOClient(ByPassCert().httpClient);
  List<AddEditDialysisEventReq> cardList = [];

  List<IncedentTypeModel> incidentList = [];
  List<DialysisEventListModel> dialysisEventList = [];
  List<DialysisEventDetaislModel> dialysisEventDetList = [];
  List<PatientEventDetails> dialysisPatientEventDetList = [];

  List<IncedentTypeModel> incidentSubTypeList = [];

  String? initialIncident;

  IncedentTypeModel? selectedIncident;
  IncedentTypeModel? selectedIncidentSub;

  String? initialIncidentSubType;

  List<DialysisEventListModel>? filteredDialysisEventList;

  getIncidentSubType(int? lookupId) async {
    isLoading = true;
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.incidentSubType}?value=$lookupId");

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
      List<dynamic> data = json.decode(response.body);
      incidentSubTypeList =
          data.map((json) => IncedentTypeModel.fromJson(json)).toList();
      update();
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  getIncidentType() async {
    isLoading = true;
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.incidentType}");

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
      List<dynamic> data = json.decode(response.body);

      incidentList =
          data.map((json) => IncedentTypeModel.fromJson(json)).toList();

      update();
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  getDialysisEventList(String inputValue, String startIndex, String callFrom,
      String searchType, String unitId) async {
    isLoading = true;

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getPreDialysisQueueList}?inputValue=$inputValue&startIndex=$startIndex&callFrom=$callFrom&searchType=&unitId=$unitId");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      List<dynamic> data = json.decode(response.body);

      dialysisEventList =
          data.map((json) => DialysisEventListModel.fromJson(json)).toList();

      update();
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  getEventPatientDetails(String treatmentId, String patientId) async {
    isLoading = true;
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.patientDetailsbyid}?treatmentId=$treatmentId&patientId=$patientId");

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
      if (json.decode(response.body) is List) {
        List<dynamic> data = json.decode(response.body);

        dialysisEventDetList = data
            .map((json) => DialysisEventDetaislModel.fromJson(json))
            .toList();
      }

      update();
    } else {

      isLoading = false;
      update();
      // throw Exception('Failed getting captcha');
    }
  }

  getEventDetailsList(String patientId) async {
    isLoading = true;
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.eventDataTable}?patientId=$patientId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      List<dynamic> data = json.decode(response.body);

      dialysisPatientEventDetList =
          data.map((json) => PatientEventDetails.fromJson(json)).toList();

      update();
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  saveDialysisEvent(userId, unitId) async {
    isLoading = true;
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.save}?userId=$userId&unitId=$unitId");

    String jsonbody = json.encode(cardList);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      final data = json.decode(response.body);
      CustomMessage.toast(data['return']);
      cardList.clear();
      Get.to(const DialysisEventList());
      update();
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }
}
