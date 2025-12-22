import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/investigation/investigation_queue.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/invest_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/investigation_que_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/save_barcode_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/test_details_model.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:http/io_client.dart';

class InvestigationController extends GetxController {
  bool isLoading = false;
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  TextEditingController searchController = TextEditingController();
  TextEditingController barCodeController = TextEditingController();

  List<InvestigationQueModel>? investList;
  List<InvestigationQueModel>? filteredList;
  List<TestDetailsModel>? testList;

  TextEditingController date = TextEditingController();

  TextEditingController time = TextEditingController();

  String? message;

  // Future<bool> getInvestList(unitId, callFrom) async {
  //   isLoading = true;
  //
  //   final uri = Uri.parse(
  //       "${ApiConstants.baseUrl}${ApiNames.getInvestigationData}?inputValue=0&startIndex=0&callFrom=$callFrom&unitId=$unitId");
  //
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //   };
  //
  //   debugPrint(uri.path);
  //
  //   final response = await ioClient.get(uri, headers: headers);
  //   debugPrint(response.statusCode.toString());
  //   debugPrint("response.body : ${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     isLoading = false;
  //
  //     List<dynamic> data = json.decode(response.body);
  //     investList =
  //         data.map((json) => InvestigationQueModel.fromJson(json)).toList();
  //
  //     update();
  //
  //     return true;
  //   } else {
  //     isLoading = false;
  //     update();
  //
  //     throw Exception('Failed getting getInvestList');
  //   }
  // }

  Future<bool> getInvestList(unitId, callFrom) async {
    isLoading = true;
    update(); // show loader immediately

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiNames.getInvestigationData}"
      "?inputValue=0&startIndex=0&callFrom=$callFrom&unitId=$unitId",
    );

    final headers = {"Content-Type": "application/json"};

    final response = await ioClient.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // parse fresh data
      final List<dynamic> data = json.decode(response.body);
      investList = data.map((e) => InvestigationQueModel.fromJson(e)).toList();

      // 👇 keep filteredList in sync (reset filter if no query)
      if (searchController.text.trim().isEmpty) {
        filteredList = investList;
      } else {
        applySearchFilter();
      }

      isLoading = false;
      update();
      return true;
    } else {
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
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getAlltest}?patientId=${patientData?.patientId}&treatId=${patientData?.treatmentId}&packageId=${patientData?.packageId}&unitId=$unitId");

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
      update();

      List<dynamic> data = json.decode(response.body);
      testList = data.map((json) => TestDetailsModel.fromJson(json)).toList();
    } else {
      isLoading = false;
      update();

      debugPrint('Failed getting captcha');
    }
    update();
  }

  checkDuplicateBarcode(unitId, String? barcodeNo) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.chechSavedBarcode}?barcodeNo=$barcodeNo&unitId=$unitId");

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
      update();
      message = response.body;
    } else {
      isLoading = false;
      update();

      debugPrint('Failed getting barcode');
    }
    update();
  }

  saveDateTime(List<InvestModel> investList, unitId) async {
    isLoading = true;
    update();

    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.saveInvestQWithTest}");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri,
        headers: headers, body: jsonEncode(investList));
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      await getInvestList(unitId, "PRD");
    } else {
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
    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiNames.saveBarcodeNew}");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri,
        headers: headers, body: jsonEncode(investList));
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      update();

      CustomMessage.toast(response.body);
      await updateStatus(
          patientData?.patientId.toString(),
          patientData?.treatmentId.toString(),
          patientData?.packageId.toString(),
          userId,
          unitId);
    } else {
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

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.updateTestStatus}?patientId=$patientId&treatId=$treatmentId&packageId=$packageId&userId=$userId&unitId=$unitId");

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
      update();

      // List<dynamic> data = json.decode(response.body);
      // testList = data.map((json) => TestDetailsModel.fromJson(json)).toList();

      await getInvestList(unitId, "PRD");
    } else {
      isLoading = false;
      update();

      debugPrint('Failed getting captcha');
    }
    update();
  }
}
