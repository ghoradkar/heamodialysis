import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/machine_status/model/add_machine_counter_list_model.dart';
import 'package:heamodialysis/machine_status/model/machine_count_model.dart';
import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/already_registered_patient.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_names.dart';

import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

// import 'package:http/http.dart' as http;

class MachineStatusController extends GetxController {
  String? msg;

  String? status;

  String? scrutinyType;

  String? approvalStat;

  List<MachineCountModel>? machineCountList;

  SearchRegisteredPatientModel? searchByModel;

  AlreadyRegisteredPatient? searchedPatientResultModel;
  TextEditingController valueController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController currentReading = TextEditingController();
  TextEditingController lastReading = TextEditingController();
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  bool isLoading = false;

  InstituteList? instituteList;

  String? selectInstitute;

  List<AddMachineCounterListModel>? addMachineCounterListModel;

  List<TextEditingController> currentReadingCtrls = [];

  @override
  void onClose() {
    for (final c in currentReadingCtrls) {
      c.dispose();
    }
    super.onClose();
  }

  getMachineList(
      String callFrom, String startIndex, unitId, String searchDate) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getSavedMachineReading}?callfrom=&startIndex=$startIndex&searchdate=$searchDate&unitId=$unitId");

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

      machineCountList =
          data.map((item) => MachineCountModel.fromJson(item)).toList();

      await getMachineListInAddMachineCounterPage(
          searchDate, searchDate, unitId.toString());
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  Future<void> addMachineCounter(
    List<AddMachineCounterListModel>? body,
    unitId,
    userId,
  ) async {
    if (body == null) return;

    // If you used per-row controllers for "Current Reading", sync them first
    for (int i = 0; i < body.length && i < currentReadingCtrls.length; i++) {
      body[i].todayReading = currentReadingCtrls[i].text.isEmpty
          ? null
          : currentReadingCtrls[i].text;
    }

    // ✅ assign IDs for each item
    for (final e in body) {
      e.unitId = unitId;
      e.userId = userId;
      // optional (if API expects these too):
      e.createdBy = userId;
      // e.updatedBy = userId;
    }

    isLoading = true;
    update();

    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.saveMachineReading}");
    final payload = jsonEncode(body.map((e) => e.toJson()).toList());

    final res = await ioClient.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: payload,
    );

    isLoading = false;
    update();

    if (res.statusCode == 200) {
      // var data = jsonDecode(res.body);
      CustomMessage.toast(res.body);
      await getMachineList('', '0', unitId, '');
      Get.back();
    }
  }

  Future<void> getMachineListInAddMachineCounterPage(
      String fromDate, String toDate, String unitId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiNames.getMachineListreading}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
    );

    final response = await http.Request('POST', uri).send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final List<dynamic> resp = jsonDecode(responseString);

      addMachineCounterListModel = resp
          .map((item) => AddMachineCounterListModel.fromJson(item))
          .toList();

      // init controllers aligned with list length
      currentReadingCtrls = List.generate(
        addMachineCounterListModel!.length,
        (i) => TextEditingController(
          text: addMachineCounterListModel![i].todayReading?.toString() ?? '',
        ),
      );

      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }

  void setTodayReading(int index, String value) {
    // keep as string or parse to num if backend expects number
    addMachineCounterListModel?[index].todayReading =
        value.isEmpty ? null : value; // or num.tryParse(value)
    update(); // if you want UI to react (optional for typing)
  }

  getInstituteList(int unitId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getInstituteList);

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      final data = json.decode(response.body);
      instituteList = InstituteList.fromJson(data);
      selectInstitute =
          instituteList?.data?.firstWhere((e) => e.unitId == unitId).unitName;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }
}
