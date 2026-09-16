import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/upload_document/model/pending_feedback_treatment_model.dart';
import 'package:heamodialysis/upload_document/repository/feedback_form_repository.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/feedback_form_pdf_generator.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';

class FeedbackFormController extends GetxController {
  final FeedbackFormRepository _repository = FeedbackFormRepository();
  final NewRegistrationController _registrationController =
      Get.put(NewRegistrationController());

  bool isSearching = false;
  bool isSearched = false;
  bool isDownloading = false;
  bool isUploading = false;

  int? patientId;
  List<PendingFeedbackTreatment> treatments = [];

  /// Where the user saved the PDF via the native "Save As" dialog - set
  /// once [downloadPdf] succeeds, so the "Download"/"Upload" button knows
  /// which state to show. Not used to reopen the file: the upload step
  /// re-picks it via FilePicker.pickFiles so the user can pick from
  /// wherever they actually saved it.
  String? downloadedPath;

  String get patientName {
    final data = _registrationController.viewPatientModel?.data;
    if (data == null) return '';
    return '${data.fName ?? ''} ${data.lName ?? ''}'.trim();
  }

  String get patientAge =>
      _registrationController.viewPatientModel?.data?.age?.toString() ?? '';

  String get patientBloodGroup {
    final id = _registrationController.viewPatientModel?.data?.bloodGroupId;
    if (id == null) return '';
    final match = _registrationController.bloodGroupModel?.data
        ?.where((e) => e.bloodGroupId == id);
    return (match != null && match.isNotEmpty)
        ? (match.first.bloodGrouptName ?? '')
        : '';
  }

  Future<void> search({
    required int patientId,
    required int year,
    required int month,
  }) async {
    isSearching = true;
    downloadedPath = null;
    update();

    try {
      this.patientId = patientId;
      await _registrationController.viewPatientData(patientId);
      if (_registrationController.bloodGroupModel == null) {
        await _registrationController.getBloodGroupList();
      }
      treatments = await _repository.getPendingFeedbackTreatments(
        patientId: patientId,
        month: month,
        year: year,
      );
    } catch (_) {
      treatments = [];
    } finally {
      isSearching = false;
      isSearched = true;
      update();
    }
  }

  /// Builds the PDF, then hands the bytes to the OS "Save As" dialog
  /// (FilePicker.saveFile) so the user picks a visible location - e.g.
  /// Downloads - instead of it landing silently in an app-private folder
  /// nobody can find afterward.
  Future<bool> downloadPdf() async {
    isDownloading = true;
    update();
    try {
      final bytes = await FeedbackFormPdfGenerator.generateBytes();
      final safeName =
          patientName.isNotEmpty ? patientName.replaceAll(RegExp(r'[^A-Za-z0-9]'), '') : 'patient';
      final path = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Feedback Form',
        fileName: 'feedbackform_$safeName.pdf',
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        bytes: bytes,
      );
      if (path == null) return false;
      downloadedPath = path;
      return true;
    } catch (_) {
      return false;
    } finally {
      isDownloading = false;
      update();
    }
  }

  Future<bool> uploadFeedbackForm(File file) async {
    if (patientId == null || treatments.isEmpty) return false;
    isUploading = true;
    update();

    try {
      final userData =
          await SharedPref().read(const SharedPrefConstant().kUserData);
      final result = await _repository.uploadFeedbackForm(
        patientId: patientId!,
        treatmentIds: treatments.map((t) => t.treatmentId).toList(),
        userId: userData['user_ID'] as int,
        unitId: userData['unitId'] as int,
        file: file,
      );
      return result;
    } on ApiException {
      return false;
    } finally {
      isUploading = false;
      update();
    }
  }
}
