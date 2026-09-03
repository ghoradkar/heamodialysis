import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/investigation/screen/investigation_queue.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/invest_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/investigation_que_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/save_barcode_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/test_details_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/repository/investigation_repository.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';

class InvestigationController extends GetxController {
  final InvestigationRepository _repository = InvestigationRepository();

  bool isLoading = false;

  TextEditingController searchController = TextEditingController();
  TextEditingController barCodeController = TextEditingController();

  List<InvestigationQueModel>? investList;
  List<InvestigationQueModel>? filteredList;
  List<TestDetailsModel>? testList;

  TextEditingController date = TextEditingController();

  TextEditingController time = TextEditingController();

  String? message;

  Future<bool> getInvestList(unitId, callFrom) async {
    isLoading = true;
    update(); // show loader immediately

    try {
      investList = await _repository.getInvestList(unitId, callFrom);

      // 👇 keep filteredList in sync (reset filter if no query)
      if (searchController.text.trim().isEmpty) {
        filteredList = investList;
      } else {
        applySearchFilter();
      }

      isLoading = false;
      update();
      return true;
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting getInvestList');
    }
  }

  void applySearchFilter() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      filteredList = investList;
      return;
    }
    filteredList = investList?.where((p) {
      final q = query;
      return p.patientId?.toString().contains(q) == true ||
          p.patName?.toLowerCase().contains(q) == true ||
          p.gender?.toLowerCase().contains(q) == true ||
          p.age?.toString().contains(q) == true ||
          p.packageName?.toLowerCase().contains(q) == true;
    }).toList();
  }

  getAllTest(unitId, InvestigationQueModel? patientData) async {
    isLoading = true;
    update();

    try {
      testList = await _repository.getAllTest(unitId, patientData);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();
      debugPrint('Failed getting captcha');
    }
    update();
  }

  checkDuplicateBarcode(unitId, String? barcodeNo) async {
    isLoading = true;
    update();

    try {
      message = await _repository.checkDuplicateBarcode(unitId, barcodeNo);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();
      debugPrint('Failed getting barcode');
    }
    update();
  }

  saveDateTime(List<InvestModel> investList, unitId) async {
    isLoading = true;
    update();

    try {
      await _repository.saveDateTime(investList, unitId);
      isLoading = false;
      update();
      await getInvestList(unitId, "PRD");
    } on ApiException {
      CustomMessage.toast("Fail to saving machine reading");
      Get.to(const InvestigationQueue());
      isLoading = false;
      update();
      debugPrint('Failed getting captcha');
    }
  }

  saveBarcode(List<SaveBarcodeModel> investList, unitId, userId,
      InvestigationQueModel? patientData) async {
    isLoading = true;
    update();

    try {
      final responseBody = await _repository.saveBarcode(investList, unitId);
      isLoading = false;
      update();

      CustomMessage.toast(responseBody);
      await updateStatus(
          patientData?.patientId.toString(),
          patientData?.treatmentId.toString(),
          patientData?.packageId.toString(),
          userId,
          unitId);
    } on ApiException {
      CustomMessage.toast("Fail to saving machine reading");
      Get.to(const InvestigationQueue());
      isLoading = false;
      update();
      debugPrint('Failed getting captcha');
    }
  }

  updateStatus(patientId, treatmentId, packageId, userId, unitId) async {
    isLoading = true;
    update();

    try {
      await _repository.updateStatus(
          patientId, treatmentId, packageId, userId, unitId);
      isLoading = false;
      update();

      await getInvestList(unitId, "PRD");
    } on ApiException {
      isLoading = false;
      update();
      debugPrint('Failed getting captcha');
    }
    update();
  }
}
