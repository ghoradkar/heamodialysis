import 'dart:io';

import 'package:get/get.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:http/http.dart' as http;

class DocumentUploadResult {
  final bool success;
  final String message;

  const DocumentUploadResult({required this.success, required this.message});
}

class DocumentCapturePhotoController extends GetxController {
  bool isUploading = false;

  Future<DocumentUploadResult> uploadDocument({
    required File file,
    required int patientId,
    required int treatmentId,
    required String uploadApiPath,
  }) async {
    isUploading = true;
    update();

    try {
      final userData =
          await SharedPref().read(const SharedPrefConstant().kUserData);
      final uri = Uri.parse(ApiConstants.baseUrl + uploadApiPath);

      final request = http.MultipartRequest('POST', uri)
        ..fields['patientId'] = patientId.toString()
        ..fields['treatmentId'] = treatmentId.toString()
        ..fields['userId'] = userData['user_ID'].toString()
        ..fields['unitId'] = userData['unitId'].toString()
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final message = response.body.trim();

      return DocumentUploadResult(
        success: message.toLowerCase().contains('successfully'),
        message: message,
      );
    } catch (_) {
      return const DocumentUploadResult(success: false, message: '');
    } finally {
      isUploading = false;
      update();
    }
  }
}
