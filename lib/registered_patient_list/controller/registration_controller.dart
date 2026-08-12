import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/already_registered_patient.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_names.dart';

import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:http/io_client.dart';
// import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  String? msg;

  String? status;

  String? scrutinyType;

  String? approvalStat;

  AlreadyRegisteredPatient? alreadyRegisteredPatient;

  SearchRegisteredPatientModel? searchByModel;

  AlreadyRegisteredPatient? searchedPatientResultModel;
  TextEditingController valueController = TextEditingController();
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  bool isLoading = false;

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

  checkScrutinyApproval(patientId) async {
    isLoading = true;
    update();

    try {
      final uri = Uri.parse(
          "${ApiConstants.baseUrl}${ApiNames.getApprovalStatus}?patientId=$patientId");

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      debugPrint(uri.path);

      final response = await ioClient.get(uri, headers: headers);
      debugPrint(response.statusCode.toString());
      debugPrint("response.body : ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        scrutinyType = data['UserType'];
        approvalStat = data['ApprovalStatus'];
      } else {
        throw Exception('Failed getting getAnswers');
      }
    } catch (e) {
      debugPrint("Error in checkScrutinyApproval: $e");
      rethrow;
    } finally {
      isLoading = false;
      update();
    }
  }


  searchRegisteredPatient(String type, String input, unitId, String sId) async {
    isLoading = true;
    update();

    try {
      final uri = Uri.parse(
          ApiConstants.baseUrl + ApiNames.searchRegisteredPatientApi);

      final Map<String, dynamic> body = {
        "unitId": unitId,
        "type": type,
        "input": input,
        "category": "",
        "sId": sId,
      };

      String jsonbody = json.encode(body);
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      debugPrint("Url Registration : ${uri.path}");
      debugPrint("Url Registration : ${uri}");
      debugPrint(body.toString());

      final response = await ioClient.post(uri, headers: headers, body: jsonbody);
      debugPrint(response.statusCode.toString());
      debugPrint("response.body : ${response.body}");

      if (response.statusCode == 200) {
        valueController.text = "";
        final data = json.decode(response.body);
        if (data['status'] == 'Success') {
          alreadyRegisteredPatient = AlreadyRegisteredPatient.fromJson(data);
          print("response of registered user : ${alreadyRegisteredPatient!.data!.length}");
          print("response of registered user : ${data}");
          print("response of registered user : ${alreadyRegisteredPatient!.data![0].patientId}");
        } else {
          status = data['status'];
        }
      } else if (response.statusCode == 401) {
        status = "Something went wrong";
      } else {
        throw Exception('Failed search');
      }
    } catch (e) {
      debugPrint("Error in searchRegisteredPatient: $e");
      rethrow;
    } finally {
      isLoading = false;
      update();
    }
  }

  refreshUi() {
    update();
  }
}
