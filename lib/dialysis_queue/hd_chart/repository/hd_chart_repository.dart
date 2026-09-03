import 'dart:convert';

import 'package:heamodialysis/dialysis_queue/hd_chart/model/hd_chart_list_model.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/hd_chart_payload.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/hd_chart_table_data.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';

class HdChartRepository {
  Future<dynamic> saveSecondTableData(HdChartPayload hdChart) async {
    final response = await ApiClient()
        .post(ApiConstants.baseUrl + ApiNames.savePatientHdChartPrm, body: hdChart);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<dynamic> saveFirstTableData(firstTableData) async {
    final response = await ApiClient()
        .post(ApiConstants.baseUrl + ApiNames.savePatientHdChart, body: firstTableData);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<HdChartListModel>> getHdChartList(
      String inputType, String searchType, String unitId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.getDataForHdChartGrid}?inputValue=$inputType&startIndex=0&callFrom=DIS&searchType=$searchType&unitId=$unitId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => HdChartListModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> deleteTableRow(String treatmentHdChartId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.deleteTreatDetById}?treatmentHdChartId=$treatmentHdChartId");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<dynamic> getFirstTableData(String patientId, String treatmentId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.getHdChartSafetyChecksDetails}?patientId=$patientId&treatmentId=$treatmentId");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<HdChartRow>> getSecondTableData(
      String patientId, String treatmentId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.getHdChartTreatmentDetails}?patientId=$patientId&treatmentId=$treatmentId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => HdChartRow.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<SearchRegisteredPatientModel> searchByDropDownList() async {
    final response = await ApiClient()
        .post(ApiConstants.baseUrl + ApiNames.searchByDropDownListApi);

    if (response.statusCode == 200) {
      return SearchRegisteredPatientModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<HdChartTableData> getTableData(
      String patientId, String treatmentId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.getDetailsForHemodialysisChartById}?patientId=$patientId&treatmentId=$treatmentId");

    if (response.statusCode == 200) {
      return HdChartTableData.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }
}
