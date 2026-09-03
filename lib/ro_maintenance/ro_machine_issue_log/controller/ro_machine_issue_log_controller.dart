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
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/repository/ro_machine_issue_log_repository.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/screen/ro_machine_issue_log.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';

class RoMachineIssueLogController extends GetxController {
  final RoMachineIssueLogRepository _repository = RoMachineIssueLogRepository();

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

  getRoMachineIssueLogAndSearchList(unitId, machineName) async {
    isLoading = true;

    try {
      roMachineIssueLogModel = await _repository
          .getRoMachineIssueLogAndSearchList(unitId, machineName);
      isLoading = false;

      update();
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode == 401) {
        update();
      } else {
        throw Exception('Failed getting getRoMaintenanceDetAndSearchList');
      }
    }
  }

  saveAddConsumableEntry(roMachineIssueController, patientId) async {
    isLoading = true;

    try {
      await _repository.saveAddConsumableEntry(addConsumableEntryModel);
      CustomMessage.toast("Success");
      await roMachineIssueController.getConsumableList(patientId);
      isLoading = false;
      Get.back();
    } on ApiException {
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

    try {
      final responseBody = await _repository.addEditRoMachineIssueLog(
          addEditMachineIssueLogReq, issueDate, informationDate);
      isLoading = false;
      debugPrint(responseBody);

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
    } on ApiException catch (e) {
      debugPrint(e.body);
      isLoading = false;
      CustomMessage.toast("Save Fail");
    }
    update();
  }

  Future<bool> deleteMachineIssueLog(id, unitId) async {
    isLoading = true;

    try {
      final responseBody = await _repository.deleteMachineIssueLog(id);
      isLoading = false;
      CustomMessage.toast(responseBody);
      update();
      getRoMachineIssueLogAndSearchList(unitId, "");

      return true;
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting captcha');
    }
  }

  getMachineList(unitId) async {
    isLoading = true;

    try {
      getMachineNameModel = await _repository.getMachineList(unitId);
      isLoading = false;
      return getMachineNameModel;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting getMachineNameList');
      }
    }

    update();
  }

  getInstituteList() async {
    isLoading = true;

    try {
      instituteList = await _repository.getInstituteList();
      isLoading = false;
      return instituteList;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting InstituteList');
      }
    }

    update();
  }

  getProblemResolvedList(unitId) async {
    isLoading = true;

    try {
      problemResolvedModel = await _repository.getProblemResolvedList(unitId);
      isLoading = false;
      return getMachineNameModel;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting getMachineNameList');
      }
    }

    update();
  }

  getProductNameList(unitId) async {
    isLoading = true;

    try {
      final list = await _repository.getProductNameList(unitId);
      isLoading = false;

      final uniqueProducts = {
        for (var product in list) product.itemId: product
      }.values.toList();

      productNameListModel = uniqueProducts;
    } on ApiException {
      isLoading = false;
    }

    update();
  }

  getConsumableList(patientId) async {
    isLoading = true;

    try {
      consumableListModel = await _repository.getConsumableList(patientId);
      isLoading = false;
    } on ApiException {
      isLoading = false;
    }

    update();
  }


  getBatchNoList(unitId, itemId) async {
    isLoading = true;

    try {
      batchNoListModel = await _repository.getBatchNoList(unitId, itemId);
      isLoading = false;
    } on ApiException {
      isLoading = false;
    }

    update();
  }

  getExpiryList(unitId, prodCode, itemId) async {
    isLoading = true;

    try {
      expiryDatelst = await _repository.getExpiryList(unitId, prodCode, itemId);
      isLoading = false;
    } on ApiException {
      isLoading = false;
    }

    update();
  }

  getOrderListList(unitId, prodCode, itemId, date) async {
    isLoading = true;

    try {
      orderIdlst =
          await _repository.getOrderListList(unitId, prodCode, itemId, date);
      isLoading = false;
    } on ApiException {
      isLoading = false;
    }

    update();
  }
}
