import 'dart:convert';
import 'dart:io';

import 'package:heamodialysis/upload_document/model/document_search_request_model.dart';
import 'package:heamodialysis/upload_document/model/patient_document_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/auth_token_manager.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:http/http.dart' as http;

class UploadDocumentRepository {
  /// Unchanged from the original controller: this upload was never routed
  /// through the SSL-bypass client, so it keeps using a plain http.Client.
  Future<http.Response> uploadDocument({
    required File file,
    required int patientId,
    required int treatmentId,
    required String uploadApiPath,
  }) async {
    final userData =
        await SharedPref().read(const SharedPrefConstant().kUserData);
    final uri = Uri.parse(ApiConstants.baseUrl + uploadApiPath);

    final request = http.MultipartRequest('POST', uri)
      ..fields['patientId'] = patientId.toString()
      ..fields['treatmentId'] = treatmentId.toString()
      ..fields['userId'] = userData['user_ID'].toString()
      ..fields['unitId'] = userData['unitId'].toString()
      ..files.add(await http.MultipartFile.fromPath('file', file.path))
      ..headers.addAll(AuthTokenManager().authHeaders);

    final streamedResponse = await request.send();
    return http.Response.fromStream(streamedResponse);
  }

  /// Shared by the feedback and HD-chart document lists - only the API
  /// path differs between the two callers.
  Future<List<PatientDocumentModel>> fetchDocuments(
      String apiPath, DocumentSearchRequestModel request) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + apiPath,
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => PatientDocumentModel.fromJson(e)).toList();
    }
    return [];
  }
}
