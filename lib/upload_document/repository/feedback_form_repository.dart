import 'dart:convert';
import 'dart:io';

import 'package:heamodialysis/upload_document/model/pending_feedback_treatment_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/auth_token_manager.dart';
import 'package:http/http.dart' as http;

class FeedbackFormRepository {
  Future<List<PendingFeedbackTreatment>> getPendingFeedbackTreatments({
    required int patientId,
    required int month,
    required int year,
  }) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getPendingFeedbackTreatments,
      body: {
        "patientId": patientId,
        "month": month,
        "year": year,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((e) => PendingFeedbackTreatment.fromJson(e))
          .toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// One PDF covers every pending treatment returned by
  /// [getPendingFeedbackTreatments] - [treatmentIds] is sent as a single
  /// comma-separated field, per the API doc's sample request.
  Future<bool> uploadFeedbackForm({
    required int patientId,
    required List<int> treatmentIds,
    required int userId,
    required int unitId,
    required File file,
  }) async {
    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.uploadFeedbackDocument);

    final request = http.MultipartRequest('POST', uri)
      ..fields['patientId'] = patientId.toString()
      ..fields['treatmentIds'] = treatmentIds.join(',')
      ..fields['userId'] = userId.toString()
      ..fields['unitId'] = unitId.toString()
      ..files.add(await http.MultipartFile.fromPath('file', file.path))
      ..headers.addAll(AuthTokenManager().authHeaders);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return response.statusCode == 200 &&
        response.body.toLowerCase().contains('successfully');
  }
}
