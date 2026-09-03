import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/machine_status/model/add_machine_counter_list_model.dart';
import 'package:heamodialysis/machine_status/model/machine_count_model.dart';
import 'package:heamodialysis/machine_status/repository/machine_status_repository.dart';
import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/already_registered_patient.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';

class MachineStatusController extends GetxController {
  final MachineStatusRepository _repository = MachineStatusRepository();

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

    try {
      machineCountList =
          await _repository.getMachineList(startIndex, unitId, searchDate);
      isLoading = false;

      await getMachineListInAddMachineCounterPage(
          searchDate, searchDate, unitId.toString());
    } on ApiException {
      isLoading = false;
      throw Exception('Failed search');
    }
    update();
  }

  Future<void> getMachineListInAddMachineCounterPage(
      String fromDate, String toDate, String unitId) async {
    isLoading = true;
    update();

    final result = await _repository.getMachineListInAddMachineCounterPage(
        fromDate, toDate, unitId);

    if (result != null) {
      addMachineCounterListModel = result;

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

    final resBody = await _repository.addMachineCounter(body);

    isLoading = false;
    update();

    if (resBody != null) {
      CustomMessage.toast(resBody);
      await getMachineList('', '0', unitId, '');
      Get.back();
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

    try {
      instituteList = await _repository.getInstituteList();
      isLoading = false;
      selectInstitute =
          instituteList?.data?.firstWhere((e) => e.unitId == unitId).unitName;
    } on ApiException {
      isLoading = false;
      throw Exception('Failed getting InstituteList');
    }

    update();
  }
}
