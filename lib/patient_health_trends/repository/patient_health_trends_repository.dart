import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:heamodialysis/patient_health_trends/model/Investigation_chart_report_model.dart';
import 'package:heamodialysis/patient_health_trends/model/dialysis_invest_patient_list_model.dart';
import 'package:heamodialysis/patient_health_trends/model/dialysis_vital_patient_list_model.dart';
import 'package:heamodialysis/patient_health_trends/model/hemoglobin_tracking_model.dart';
import 'package:heamodialysis/patient_health_trends/model/vital_report_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/auth_token_manager.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class PatientHealthTrendsRepository {
  Future<PatientListResponse> fetchPatientsVital({
    required int unitId,
    required int limit,
    required int offset,
  }) async {
    final response = await ApiClient()
        .get("${ApiConstants.baseUrl}${ApiNames.getVitalPatDetails}?unitId=$unitId&limit=$limit&offset=$offset")
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      final Map body = json.decode(response.body) as Map<String, dynamic>;
      return PatientListResponse.fromMap(body);
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<DialysisInvestPatientListModel>> fetchPatientsInvest(
      {required int unitId}) async {
    final response = await ApiClient()
        .get("${ApiConstants.baseUrl}${ApiNames.getInvestigationChart}?unitId=$unitId")
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => DialysisInvestPatientListModel.fromJson(json))
          .toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<HemoglobinTrackingModel>> fetchPatientHemoglobinList({
    required int unitId,
    int retries = 2,
  }) async {
    final response = await _getWithRetry(
        "${ApiConstants.baseUrl}${ApiNames.getAllUnitDetails}?unitId=$unitId",
        retries: retries);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => HemoglobinTrackingModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<http.Response> _getWithRetry(String url,
      {int retries = 1, Duration timeout = const Duration(seconds: 45)}) async {
    for (int attempt = 0; attempt <= retries; attempt++) {
      try {
        return await ApiClient().get(url).timeout(timeout);
      } on TimeoutException {
        if (attempt == retries) rethrow;
        debugPrint("Retrying... ($attempt/$retries)");
        await Future.delayed(const Duration(seconds: 2));
      }
    }
    throw TimeoutException("Request timed out after $retries retries");
  }

  Future<VitalReportModel> getVitalReportList(
      unitId, patientId, fromDate, toDate) async {
    final response = await ApiClient().get(
        '${ApiConstants.baseUrl}${ApiNames.getVitalPatChart}?unitId=$unitId&patientId=$patientId&fromDate=$fromDate&toDate=$toDate');

    if (response.statusCode == 200) {
      return VitalReportModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<InvestigationChartReportModel> getInvestReportList(
      String unitId, String? patientId, String fromDate, String toDate) async {
    final response = await ApiClient().get(
        '${ApiConstants.baseUrl}${ApiNames.getInvestigationResultData}?unitId=$unitId&patientId=$patientId&fromDate=$fromDate&toDate=$toDate');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return InvestigationChartReportModel.fromJson(data);
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: a fresh IOClient built the
  /// same way (ByPassCert), used only for these two streamed downloads.
  Future<http.StreamedResponse> downloadViralChart(String fromDate,
      String toDate, String unitId, String patientId, int userId) async {
    final ioClient = IOClient(ByPassCert().httpClient);
    final request = http.Request(
        'POST', Uri.parse('${ApiConstants.ip}${ApiNames.downloadViralChart}'));
    request.body = json.encode({
      "fromDate": fromDate,
      "toDate": toDate,
      "unitId": unitId,
      "patientId": patientId,
      "userId": userId
    });
    request.headers.addAll({'Content-Type': 'application/json'});
    request.headers.addAll(AuthTokenManager().authHeaders);

    return ioClient.send(request);
  }

  Future<http.StreamedResponse> downloadInvestChart(String fromDate,
      String toDate, String unitId, String patientId, int userId) async {
    final ioClient = IOClient(ByPassCert().httpClient);
    final request = http.Request(
        'POST', Uri.parse('${ApiConstants.ip}${ApiNames.downloadInvetsChart}'));
    request.body = json.encode({
      "fromDate": fromDate,
      "toDate": toDate,
      "unitId": unitId,
      "patientId": patientId,
      "userId": userId
    });
    request.headers.addAll({'Content-Type': 'application/json'});
    request.headers.addAll(AuthTokenManager().authHeaders);

    return ioClient.send(request);
  }
}
