import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:heamodialysis/capture_photo/model/captured_photo_list_model.dart';
import 'package:heamodialysis/capture_photo/model/delete_photo_model.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:http/http.dart' as http;

/// Moves the raw HTTP calls out of CapturePhotoController.
/// Client choice per call is unchanged from the original controller code.
class CapturePhotoRepository {
  Future<http.StreamedResponse> saveCapturedPhoto({
    required String patientId,
    required String unitId,
    required String userId,
    required String fileFieldKey,
    required String filePath,
  }) async {
    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.saveCapturedPhoto);

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'patientId': patientId,
      'unitId': unitId,
      'userId': userId,
    });
    request.files
        .add(await http.MultipartFile.fromPath(fileFieldKey, filePath));
    request.headers.addAll({'Content-Type': 'multipart/form-data'});

    return request.send();
  }

  Future<CapturedPhotoListModel?> getCapturedPhotoList(patientId) async {
    final url = ApiConstants.baseUrl + ApiNames.getCapturedPhotoList;
    final client = http.Client();
    final request = http.Request('GET', Uri.parse(url));
    request.headers.addAll({'Content-Type': 'application/json'});
    request.body = jsonEncode({"patientId": patientId.toString()});

    final response = await client.send(request);
    try {
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        debugPrint('Response body: $responseBody');
        final data = json.decode(responseBody);
        return CapturedPhotoListModel.fromJson(data);
      }
      debugPrint('Request failed with status: ${response.statusCode}');
      return null;
    } finally {
      client.close();
    }
  }

  Future<DeletePhotoModel?> deletePhoto(String id) async {
    final request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl + ApiNames.deletedPhoto}?id=$id'));
    request.fields[id] = id;

    final response = await request.send();
    if (response.statusCode == 200) {
      final data = json.decode(await response.stream.bytesToString());
      return DeletePhotoModel.fromJson(data);
    }
    debugPrint('Request failed with status code ${response.statusCode}');
    return null;
  }
}
