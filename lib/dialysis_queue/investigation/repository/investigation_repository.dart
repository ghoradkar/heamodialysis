import 'dart:convert';

import 'package:heamodialysis/dialysis_queue/investigation/model/invest_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/investigation_que_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/save_barcode_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/test_details_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';

class InvestigationRepository {
  Future<List<InvestigationQueModel>> getInvestList(unitId, callFrom) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getInvestigationData}?inputValue=0&startIndex=0&callFrom=$callFrom&unitId=$unitId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => InvestigationQueModel.fromJson(e)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<TestDetailsModel>> getAllTest(
      unitId, InvestigationQueModel? patientData) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getAlltest}?patientId=${patientData?.patientId}&treatId=${patientData?.treatmentId}&packageId=${patientData?.packageId}&unitId=$unitId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => TestDetailsModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> checkDuplicateBarcode(unitId, String? barcodeNo) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.chechSavedBarcode}?barcodeNo=$barcodeNo&unitId=$unitId");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<void> saveDateTime(List<InvestModel> investList, unitId) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.saveInvestQWithTest}",
      body: investList,
    );

    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
  }

  Future<String> saveBarcode(List<SaveBarcodeModel> investList, unitId) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.saveBarcodeNew}",
      body: investList,
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<void> updateStatus(
      patientId, treatmentId, packageId, userId, unitId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.updateTestStatus}?patientId=$patientId&treatId=$treatmentId&packageId=$packageId&userId=$userId&unitId=$unitId");

    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
  }
}
