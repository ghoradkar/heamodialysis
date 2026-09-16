import 'dart:io';

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
  File? generatedPdf;

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
    generatedPdf = null;
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

  Future<bool> downloadPdf() async {
    isDownloading = true;
    update();
    try {
      generatedPdf = await FeedbackFormPdfGenerator.generate(
        patientName: patientName.isNotEmpty ? patientName : 'patient',
      );
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
