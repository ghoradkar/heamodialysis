import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/consumable_entry/model/add_consumable_entry_model.dart';
import 'package:heamodialysis/dialysis_queue/consumable_entry/model/consumable_list_model.dart';
import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/get_machine_name_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/add_machine_issue_req_model/add_edit_machine_issue_log_req.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/batch_no_list_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/problem_resolve/problem_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/problem_resolve/problem_resolved_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/product_name_list_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/ro_machine_issue_log/ro_machine_issue_log_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/screens/ro_machine_issue_log.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:http/io_client.dart';

class RoMachineIssueLogController extends GetxController {
  bool isLoading = false;
  InstituteDataModel? dropDownValue;
  TextEditingController issueDateController = TextEditingController();
  TextEditingController infoDateController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController correctionActionController = TextEditingController();
  TextEditingController callAttendedByController = TextEditingController();
  TextEditingController informByController = TextEditingController();
  TextEditingController informToController = TextEditingController();
  TextEditingController issueDescController = TextEditingController();
  InstituteList? instituteList;
  AddConsumableEntryModel addConsumableEntryModel = AddConsumableEntryModel();
  TextEditingController valueController = TextEditingController();
  AddEditMachineIssueLogReq? addEditMachineIssueLogReq =
      AddEditMachineIssueLogReq();

  RoMachineIssueLogModel? roMachineIssueLogModel;

  GetMachineNameModel? getMachineNameModel;
  ProblemResolvedModel? problemResolvedModel;
  List<ProductNameListModel>? productNameListModel;
  List<ConsumableListModel>? consumableListModel;
  List<BatchNoListModel>? batchNoListModel;
  List<BatchNoListModel>? expiryDatelst;
  List<BatchNoListModel>? orderIdlst;
  InstituteDataModel? selectedInsti;
  ProductNameListModel? selectedProdName;

  String? initialInsti;

  MachineData? selectedMachine;
  String? selectdBatchNo;
  String? selectdOrderNo;
  String? initialMachine;
  String? initialProblemSolved;
  ProblemData? selectedProblem;
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  getRoMachineIssueLogAndSearchList(unitId, machineName) async {
    isLoading = true;

    final uri = Uri.parse(
        ApiConstants.baseUrl + ApiNames.getallROMachineLogBySearch);
    var body = {"unitId": unitId, "input": machineName};
    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      roMachineIssueLogModel = RoMachineIssueLogModel.fromJson(data);
      isLoading = false;

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();
    } else {
      isLoading = false;

      throw Exception('Failed getting getRoMaintenanceDetAndSearchList');
    }
  }

  saveAddConsumableEntry(roMachineIssueController,patientId) async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.savePhysicalDet);

    String jsonbody = json.encode(addConsumableEntryModel);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      // final data = json.decode(response.body);
      CustomMessage.toast("Success");
      await roMachineIssueController
          .getConsumableList(patientId);
      isLoading = false;
      Get.back();
    } else {
      isLoading = false;

      // throw Exception('Failed getting saveAddConsumableEntry');
    }

    update();
  }

  addEditRoMachineIssueLog() async {
    String? issueDate =
        addEditMachineIssueLogReq?.issueDate?.replaceAll("/", "-");
    String? informationDate =
        addEditMachineIssueLogReq?.informationDate?.replaceAll("/", "-");
    isLoading = true;
    update();
    var headers = {'Content-Type': 'application/json'};

    var body = json.encode({
      "roMachineIssueLogsId": addEditMachineIssueLogReq?.roMachineIssueLogsId,
      "roMachineMasterId": addEditMachineIssueLogReq?.roMachineMasterId,
      "issueDate": issueDate,
      "issueDescription": addEditMachineIssueLogReq?.issueDescription,
      "informedTo": addEditMachineIssueLogReq?.informedTo,
      "informedBy": addEditMachineIssueLogReq?.informedBy,
      "informationDate": informationDate,
      "callAttendedBy": addEditMachineIssueLogReq?.callAttendedBy,
      "correctiveAction": addEditMachineIssueLogReq?.correctiveAction,
      "lookupDetId": addEditMachineIssueLogReq?.lookupDetId,
      "comments": addEditMachineIssueLogReq?.comments,
      "createdBy": addEditMachineIssueLogReq?.createdBy,
      "unitId": addEditMachineIssueLogReq?.unitId
    });

    var response = await ioClient.post(
        Uri.parse(ApiConstants.baseUrl + ApiNames.saveROMachineIssueLog),
        body: body,
        headers: headers);

    // http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      isLoading = false;
      debugPrint(response.body);

      selectedInsti = null;
      initialInsti = null;
      selectedMachine = null;
      initialMachine = null;
      initialProblemSolved = null;
      selectedProblem = null;
      issueDateController.text = "";
      issueDescController.text = "";
      informToController.text = "";
      informByController.text = "";
      commentController.text = "";
      infoDateController.text = "";
      callAttendedByController.text = "";
      correctionActionController.text = "";
      CustomMessage.toast("Saved Successfully");
      Get.off(const RoMachineIssueLogs());
    } else {
      debugPrint(response.reasonPhrase);
      isLoading = false;
      CustomMessage.toast("Save Fail");
    }
    update();
  }

  Future<bool> deleteMachineIssueLog(id, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.roMachineIssueLogDelete}?id=$id");

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
      CustomMessage.toast(response.body);
      update();
      getRoMachineIssueLogAndSearchList(unitId, "");

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  getMachineList(unitId) async {
    isLoading = true;

    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiNames.getMachineNameList);
    var body = {
      "unitId": unitId,
    };
    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      getMachineNameModel = GetMachineNameModel.fromJson(data);
      isLoading = false;

      return getMachineNameModel;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getMachineNameList');
    }

    update();
  }

  getInstituteList() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getInstituteList);

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
      instituteList = InstituteList.fromJson(data);
      isLoading = false;

      return instituteList;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  getProblemResolvedList(unitId) async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getProbResolved);
    var body = {"unitId": unitId};
    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      problemResolvedModel = ProblemResolvedModel.fromJson(data);
      isLoading = false;

      return getMachineNameModel;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getMachineNameList');
    }

    update();
  }

  getProductNameList(unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getProdNameList}?unitId=$unitId");
    // "${ApiConstants.baseUrl}${ApiConstants.getProdNameList}?unitId=$unitId");

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
      productNameListModel =
          data.map((json) => ProductNameListModel.fromJson(json)).toList();

      final uniqueProducts = {
        for (var product in productNameListModel!) product.itemId: product
      }.values.toList();

      productNameListModel = uniqueProducts;
    } else {
      isLoading = false;
    }

    update();
  }

  getConsumableList(patientId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getAllConsumableItems}?patId=$patientId");
    // "${ApiConstants.baseUrl}${ApiConstants.getProdNameList}?unitId=$unitId");

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
      consumableListModel =
          data.map((json) => ConsumableListModel.fromJson(json)).toList();


    } else {
      isLoading = false;
    }

    update();
  }


  getBatchNoList(unitId, itemId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getBatchNoList}?itemId=$itemId&unitId=$unitId");
    // "${ApiConstants.baseUrl}${ApiConstants.getBatchNoList}?itemId=$itemId&unitId=$unitId");

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
      batchNoListModel =
          data.map((json) => BatchNoListModel.fromJson(json)).toList();
    } else {
      isLoading = false;
    }

    update();
  }

  getExpiryList(unitId, prodCode, itemId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getExpiryDateList}?itemId=$itemId&prodCode=$prodCode&unitId=$unitId");
    // "${ApiConstants.baseUrl}${ApiConstants.getExpiryDateList}?itemId=$itemId&prodCode=$prodCode&unitId=$unitId");

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
      expiryDatelst =
          data.map((json) => BatchNoListModel.fromJson(json)).toList();
    } else {
      isLoading = false;
    }

    update();
  }

  getOrderListList(unitId, prodCode, itemId, date) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getProductOrderId}?itemId=$itemId&prodCode=$prodCode&date=$date&unitId=$unitId");
    // "${ApiConstants.baseUrl}${ApiConstants.getProductOrderId}?itemId=$itemId&prodCode=$prodCode&date=$date&unitId=$unitId");

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
      orderIdlst = data.map((json) => BatchNoListModel.fromJson(json)).toList();
    } else {
      isLoading = false;
    }

    update();
  }
}
