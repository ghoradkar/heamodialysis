import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:heamodialysis/discharge_form/model/discharge_list.dart';
import 'package:heamodialysis/discharge_form/model/discharge_patient_details.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class SessionEndRepository {
  Future<List<DischargeListModel>> fetchDialysisEventList(
    String? inputValue,
    int? startIndex,
    String? callFrom,
    String? searchType,
    int? unitId,
  ) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getPreDialysisQueueList}?inputValue=$inputValue&startIndex=$startIndex&callFrom=$callFrom&searchType=$searchType&unitId=$unitId");

    if (response.statusCode == 200) {
      try {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => DischargeListModel.fromJson(item)).toList();
      } catch (e) {
        debugPrint("JSON Decode Error: $e");
        return [];
      }
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: this download was never
  /// routed through the SSL-bypass client, so it keeps using a plain
  /// http.Request.
  Future<Uint8List?> getSessionReportBytes({
    required String patientId,
    required int treatmentId,
    required int unitId,
  }) async {
    final uri = Uri.parse(
      '${ApiConstants.ip + ApiNames.sessionEndReport}?details=no&fromDate=&toDate=&treatmentId=$treatmentId&patientId=$patientId',
    );

    final request = http.Request('POST', uri);
    request.body = jsonEncode({
      "patientId": int.parse(patientId),
      "details": "no",
      "fromDate": "",
      "toDate": "",
      "treatmentId": treatmentId,
      "unitId": unitId,
    });
    request.headers.addAll({'Content-Type': 'application/json'});

    final response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.toBytes();
    }
    debugPrint("Failed: ${response.reasonPhrase}");
    return null;
  }

  Future<DischargePatientDetails> getPatientDetails(String? patientId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.getPatientRecordsbypatientId}?patientId=$patientId");

    if (response.statusCode == 200) {
      return DischargePatientDetails.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> saveDischarge(
      String? patientId, String? treatmentId, String? unitId, String? userId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.saveDischarge}?patientId=$patientId&treatmentId=$treatmentId&unitId=$unitId&userId=$userId");

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: this call was never routed
  /// through the SSL-bypass client, so it keeps using a plain http.Request.
  Future<String?> getPostFlag(String patientId, String treatmentId) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getPostFlag}?patientId=$patientId&treatmentId=$treatmentId");

    final request = http.Request('POST', uri);
    final response = await request.send();

    if (response.statusCode == 200) {
      return response.stream.bytesToString();
    }
    debugPrint(response.reasonPhrase);
    return null;
  }
}
