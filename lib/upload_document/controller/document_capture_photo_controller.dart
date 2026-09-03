import 'dart:io';

import 'package:get/get.dart';
import 'package:heamodialysis/upload_document/repository/upload_document_repository.dart';

class DocumentUploadResult {
  final bool success;
  final String message;

  const DocumentUploadResult({required this.success, required this.message});
}

class DocumentCapturePhotoController extends GetxController {
  final UploadDocumentRepository _repository = UploadDocumentRepository();

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
      final response = await _repository.uploadDocument(
        file: file,
        patientId: patientId,
        treatmentId: treatmentId,
        uploadApiPath: uploadApiPath,
      );
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
