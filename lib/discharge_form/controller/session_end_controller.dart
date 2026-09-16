import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/discharge_form/repository/session_end_repository.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/choose_package.dart';
import 'package:heamodialysis/discharge_form/screen/session_end_list.dart';
import 'package:heamodialysis/discharge_form/model/checkbox_flag_discharge.dart';
import 'package:heamodialysis/discharge_form/model/discharge_list.dart';
import 'package:heamodialysis/discharge_form/model/discharge_patient_details.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class SessionEndController extends GetxController {
  final SessionEndRepository _repository = SessionEndRepository();

  bool isLoading = true;
  List<String> typeList = [
    'Patient Id',
    'Patient Name',
    'Mobile No',
    'ABHA No',
    'Case Number'
  ];

  // 🔹 Selected Type
  String? selectedType;

  // 🔹 Approval Status list
  List<String> approvalStatusList = ['Approved', 'Pending', 'Rejected'];

  // 🔹 Selected Approval Status
  String? selectedApprovalStatus;
  // 🔹 Loader
  bool isLoadingType = false;

  var pageSize = 10;

  // late PagingController<int, DischargeListModel> pagingController;
  bool hasInternet = true;

  List<DischargeListModel> dischargeList = [];
  DischargePatientDetails? dischargePatientDet;
  CheckBoxFlagDischarge? dischargeFlag;

  String dischargeFlagString = '';

  CheckBoxList? predialysis = CheckBoxList(l10n.dqPreDialysis, true);
  CheckBoxList? postDialysis = CheckBoxList(l10n.dqPostDialysis, true);
  CheckBoxList? event = CheckBoxList(l10n.nephroEvent, false);
  CheckBoxList? doctorDesk = CheckBoxList(l10n.drawerDoctorDesk, true);
  CheckBoxList? nephroDesk = CheckBoxList(l10n.drawerNephrologistDesk, true);
  CheckBoxList? dietician = CheckBoxList(l10n.dischDietician, false);
  CheckBoxList? termsCondition = CheckBoxList(l10n.dischTermsVerified, false);

  List<DischargeListModel>? filteredDialysisEventList;

  File? sessionEndReportFile;

  Future<List<DischargeListModel>> fetchDialysisEventListFromAPI(
    String? inputValue,
    int? startIndex,
    String? callFrom,
    String? searchType,
    int? unitId,
  ) async {
    isLoading = true;

    try {
      dischargeList = await _repository.fetchDialysisEventList(
          inputValue, startIndex, callFrom, searchType, unitId);
      isLoading = false;
      update();
      return dischargeList;
    } catch (e) {
      isLoading = false;
      update();
      debugPrint("API Error: $e");
      return dischargeList;
    }
  }

  Future<void> getSessionReport({
    required String patientId,
    required int treatmentId,
    required int userId,
    required int unitId,
  }) async {
    isLoading = true;
    update();

    try {
      final bytes = await _repository.getSessionReportBytes(
        patientId: patientId,
        treatmentId: treatmentId,
        unitId: unitId,
      );

      if (bytes != null) {
        final fileName =
            'session_report_${DateTime.now().millisecondsSinceEpoch}.pdf';

        debugPrint('📄 PDF bytes length: ${bytes.length}');
        // ✅ SAVE TO DOCUMENTS (MOVED FROM DOWNLOADS FOR STABILITY)
        final dir = await getApplicationDocumentsDirectory();
        sessionEndReportFile = File('${dir.path}/$fileName');
        await sessionEndReportFile?.writeAsBytes(bytes);
      }
    } catch (e) {
      debugPrint("❌ Exception: $e");
    }

    isLoading = false;
    update();
  }

  getPatientDetails(
    String? patientId,
  ) async {
    isLoading = true;

    try {
      dischargePatientDet = await _repository.getPatientDetails(patientId);
      isLoading = false;
      debugPrint(dischargePatientDet?.lName ?? "");
      update();
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting getPatientDetails');
    }
  }

  saveDischarge(String? patientId, String? treatmentId, String? unitId,
      String? userId, dynamic userData) async {
    isLoading = true;

    try {
      final data = await _repository.saveDischarge(
          patientId, treatmentId, unitId, userId);

      await getSessionReport(
          patientId: patientId.toString(),
          treatmentId: int.parse(treatmentId!),
          userId: int.parse(userId!),
          unitId: int.parse(unitId!));
      await fetchDialysisEventListFromAPI(
        '',
        0,
        'EVE',
        '',
        int.parse(unitId),
      );
      isLoading = false;
      if (data['patientId'] != null) {
        update();
        CustomPopup.showConfirmationDialog(() {
          Get.off(SessionEndList(
            userData: userData,
          ));
        }, () {
          Get.off(SessionEndList(
            userData: userData,
          ));
        }, () async {
          Get.back();
          Get.back();
          if (sessionEndReportFile != null &&
              await sessionEndReportFile!.exists()) {
            debugPrint('✅ PDF saved at: ${sessionEndReportFile?.path}');
            await OpenFile.open(sessionEndReportFile?.path);
          } else {
            debugPrint('❌ PDF file not found or failed to save.');
            Get.snackbar(
              'Error',
              'Failed to generate report. Please try again.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        }, "Print Report?", '', "assets/success-popup.png");
      }
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting getPatientDetails');
    }
  }

  Future<void> getPostFlag(String patientId, String treatmentId) async {
    final result = await _repository.getPostFlag(patientId, treatmentId);
    if (result != null) {
      dischargeFlagString = result;
      debugPrint(dischargeFlagString);
    }
  }
}
