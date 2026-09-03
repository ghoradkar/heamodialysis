import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_detaisl_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/test_details_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/add_test_package_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/choose_package_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/clinical_condition_list.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/clinical_condition_provisiona_list.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/clinical_history_list.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/clinical_history_table_data.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/cover_sheet_nephro.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/default_instruction_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/diagnostic_inv_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/diet_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/get_diagnosis_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/get_instructions_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/medication_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/medicine_data_byId.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/medicine_name_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/package_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/prep_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/prep_unit_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/prescription_instruction_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/prescription_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/route_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/temp_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/test_lis_details.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/uploaded_document_nephro.dart';
import 'package:heamodialysis/nephro_desk_patient_list/repository/nephro_repository.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/nephro_desk_dropdown.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/clinical_history.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../widgets/status_dialog.dart';

class NephroController extends GetxController {
  final NephroRepository _repository = NephroRepository();

  bool isLoading = false;
  int lastKnownItemCount = 0;
  List<NephroList>? nephroList;
  List<ListSubServiceIpdDto>? diagnosticInvestList;
  List<ClinicalConditionProvisionaList>? provisionConfirmationalList;
  List<ClinicalConditionProvisionaList> provisionList = [];
  List<ClinicalConditionProvisionaList> confirmationList = [];
  List<ClinicalHistoryList>? clinicalHistoryList;
  List<PackageListModel>? packageList;
  List<GetDiagonisisList>? icdCode;
  List<GetDiagonisisList>? diagnosisList;

  CoverSheetNephroModel? coverSheetNephro;
  ChoosePackageListModel? choosePackageListModel;
  NephroDeskDropDown? searchByModel;
  TextEditingController valueController = TextEditingController();
  CustomCheckBox urgentEvent = CustomCheckBox("Urgent", false);
  List<Map<String, dynamic>> parsedPrescriptionData = [];
  List<Map<String, dynamic>> parsedLabInvestData = [];
  List<AddTestPackageModel> testPackageList = [];
  List<Pattemplist>? tempList;
  List<LstList>? instructionsList;
  List<ListOpdPrescriptionDtoSp>? prescrriptionList;
  List<GetListOfOpdDietDto>? dietList;
  List<List<String>> selectedItemsPerRow = [];
  List<bool> checkBoxValues = [];
  TextEditingController imagePath = TextEditingController();
  ClinicalConditionProvisionaList? provisionalItem;
  List<bool> checkboxStates = [];
  List<String> deleteButton = [];
  ClinicalConditionProvisionaList? confirmitem;
  File? uploadedFile;

  List<DatDiagonosisMasterDtoa>? confirmedList;

  TextEditingController diagDate = TextEditingController();
  List<dynamic>? treatmentIdModel;
  String? diagType;

  TextEditingController diagComment = TextEditingController();

  TextEditingController diagnosisController = TextEditingController();

  TextEditingController diagnoDes = TextEditingController();
  TextEditingController testNameField = TextEditingController();

  TextEditingController icdCodeTxtField = TextEditingController();

  TestListDetails? testNameModel;

  List<LstService>? testNameList;

  TextEditingController selectedTestsController = TextEditingController();

  TextEditingController clinicalNote = TextEditingController();

  TextEditingController instructions = TextEditingController();

  String? selectedPackage;

  String? selectedTemp;

  String? days;

  String? fromDateDiet;

  String? toDateDiet;

  DietListModel? dietItemDet;

  TextEditingController diabetesMellitusDuration = TextEditingController();

  TextEditingController hypertensionDuration = TextEditingController();

  TextEditingController dyslipidemiaDuration = TextEditingController();

  TextEditingController chronicHeartDiseaseDuration = TextEditingController();

  TextEditingController chronicLiverDiseaseDuratin = TextEditingController();

  TextEditingController strokeDuration = TextEditingController();

  TextEditingController tuberculosisDuration = TextEditingController();

  TextEditingController hIVDuration = TextEditingController();

  TextEditingController hBVDuration = TextEditingController();

  TextEditingController hcvTreatedDuration = TextEditingController();
  TextEditingController hcvUntreatedDuration = TextEditingController();

  TextEditingController mentalHealthDisorderDuration = TextEditingController();

  TextEditingController chronicLungDiseaseDuration = TextEditingController();

  TextEditingController remark = TextEditingController();
  TextEditingController alcoholDuration = TextEditingController();
  TextEditingController smokingDuration = TextEditingController();
  TextEditingController tobaccoDuration = TextEditingController();
  TextEditingController drugDuration = TextEditingController();

  TextEditingController temp = TextEditingController();

  TextEditingController pulse = TextEditingController();

  TextEditingController topBlood = TextEditingController();

  TextEditingController bottomBlood = TextEditingController();

  TextEditingController pasrSurgicalH = TextEditingController();
  TextEditingController bloodGlocuse = TextEditingController();

  TextEditingController allergies = TextEditingController();

  TextEditingController treatmentP = TextEditingController();

  TextEditingController specialInst = TextEditingController();
  TextEditingController medicineNameTxtEdit = TextEditingController();

  List<LstPrescriptionGenericDto>? medicineNameModelList;
  List<ListPrescriptionInstructionDto>? presInstList;
  List<Listroutemasters>? routeList;

  String? selectedInst;

  Listroutemasters? selectedRoute;

  String? selectedUnit;

  String? selectedPrep;
  String? selectedMedication;
  List<String>? prepList;

  String? selectedMedicineName;

  MedicineDataById? medicineDataById;
  TextEditingController dosage = TextEditingController();
  TextEditingController presDays = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController presQty = TextEditingController();
  TextEditingController presFreqTxt = TextEditingController();
  List<bool>? checkBoxListClinicalHistory;

  List<RelationListM>? dietListClinicalHistory;

  List<RelationListM>? relationList;
  List<RelationListM>? currentStatList;

  List<AddDetailsTable>? addDetailsList;

  String? selectedDiet;
  String? selectedAlcoholCurrentStat;
  String? selectedSmokingCurrentStat;
  String? selectedTobaccoCurrentStat;
  String? selectedDrugCurrentStat;

  String? selectedAlcoholCon;

  String? selectedSmoking;

  String? selectedTobaco;

  String? selectediLLicit;

  TextEditingController uploadComment = TextEditingController();

  List<UploadedDocumentNephro>? uploadedDocList;

  List<ListPreparationMaster>? prepListDropDown;

  List<ListUomMaster>? prepUnitList;

  List<GetListOfOpdInstructionDto>? defaultInstructionList;
  TextEditingController instEnglish = TextEditingController();
  TextEditingController instHindi = TextEditingController();
  TextEditingController instMarathi = TextEditingController();
  TextEditingController instLang3 = TextEditingController();
  TextEditingController instLang2 = TextEditingController();
  TextEditingController instLang1 = TextEditingController();

  List<String> alcoholList = ["Yes", "No"];

  List<String> smokingList = ["Yes", "No"];

  List<String> tobacoList = ["Yes", "No"];

  List<String> illicitList = ["Yes", "No"];

  ClinicalHistoryTableData? clinicalHistoryTableData;

  List<MedicationMethod>? medicationList;

  List<String> clinicalConditionL1 = [];
  List<String> clinicalConditionL2 = [];
  List<String> clinicalConditionL3 = [];
  List<String> clinicalConditionL4 = [];

  List<DialysisEventDetaislModel>? patientDet;

  String? currentStat;

  uploadDocuments(
    patientId,
    treatmentId,
    remark,
    unitId,
    userId,
  ) async {
    isLoading = true;
    update();

    try {
      var obj = jsonEncode({
        "remark": remark,
        "unitId": unitId,
        "userId": userId,
        "deleted": "N"
      });

      final finalResp = await _repository.uploadDocuments(
        obj: obj,
        patientId: patientId,
        treatmentId: treatmentId,
        filePath: uploadedFile?.path,
      );

      if (finalResp.statusCode == 200) {
        isLoading = false;

        imagePath.clear();
        uploadComment.clear();
        var resp = finalResp.body;

        CustomMessage.toast(resp);
        await getUploadedDocNephro(patientId, treatmentId, unitId);

        // Close the dialog after successful upload
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      } else {
        isLoading = false;
        update();
        CustomMessage.toast('Upload failed');
      }
    } catch (error) {
      isLoading = false;
      debugPrint(error.toString());
      CustomMessage.toast('Upload error: $error');
    }
    update();
  }

  getPatientDet(String treatmentId, String patientId) async {
    isLoading = true;

    try {
      final result = await _repository.getPatientDet(treatmentId, patientId);
      isLoading = false;
      if (result != null) {
        patientDet = result;
      }

      update();
    } on ApiException {
      isLoading = false;
      update();
      // throw Exception('Failed getting captcha');
    }
  }

  getClinicalHistoryStat(String patientId) async {
    isLoading = true;

    try {
      currentStat = await _repository.getClinicalHistoryStat(patientId);
      isLoading = false;
      debugPrint(currentStat);

      update();
    } on ApiException {
      isLoading = false;
      update();
      // throw Exception('Failed getting captcha');
    }
  }

  Future<void> getDoctorList(
      String unitId,
      ) async {

    isLoading = true;
    update();

    try {
      nephroList = await _repository.getDoctorList(unitId);
      lastKnownItemCount = nephroList!.length;

      debugPrint('✅ Parsed doctor list: ${nephroList?.length} patients found');
    } catch (e) {
      nephroList = [];
      debugPrint("❌ Error occurred in getDoctorList: $e");
    } finally {
      isLoading = false;
      update();
      debugPrint("🏁 Doctor API call completed");
    }
  }

  Future<void> getNephroList(
      String type,
      String input,
      String unitId,
      String districtId,
      String? status
      ) async {
    isLoading = true;
    update();

    try {
      nephroList = await _repository.getNephroList(type, input, unitId, districtId, status);
      lastKnownItemCount = nephroList!.length;
      debugPrint('Parsed nephroList: ${nephroList?.length}');
    } catch (e) {
      nephroList = [];
      debugPrint("Error occurred in getNephroList: $e");
    } finally {
      isLoading = false;
      update();
      debugPrint("Loading state updated to false");
      debugPrint("API CALL COMPLETED");
    }
  }

  Future<void> getDoctorSearchList(
      String searchType,
      String inputValue,
      String unitId,
      ) async {
    try {
      final result = await _repository.getDoctorSearchList(searchType, inputValue, unitId);
      if (result != null) {
        nephroList = result;
        update();
      } else {
        debugPrint("❌ API Failed");
      }
    } catch (e) {
      debugPrint("❌ Error: $e");
    }
  }


  Future<void> saveClinicalHistory(
      body, patientId, treatmentId, List<AddDetailsTable> checkBoxList) async {
    isLoading = true;
    update();

    try {
      final responseBody = await _repository.saveClinicalHistory(body);

      if (responseBody == 'Success') {
        selectedDiet = null;
        selectedAlcoholCon = null;
        selectedSmoking = null;
        selectedTobaco = null;
        selectediLLicit = null;
        remark.text = '';
        temp.text = '';
        pulse.text = '';
        topBlood.text = '';
        bottomBlood.text = '';
        bloodGlocuse.text = '';
        pasrSurgicalH.text = '';
        allergies.text = '';
        specialInst.text = '';
        treatmentP.text = '';
        diabetesMellitusDuration.text = '';
        hypertensionDuration.text = '';
        dyslipidemiaDuration.text = '';
        chronicHeartDiseaseDuration.text = '';
        chronicLiverDiseaseDuratin.text = '';
        strokeDuration.text = '';
        tuberculosisDuration.text = '';
        hIVDuration.text = '';
        hBVDuration.text = '';
        hcvTreatedDuration.text = '';
        mentalHealthDisorderDuration.text = '';
        chronicLungDiseaseDuration.text = '';

        await getClinicalHistoryList(
            patientId.toString(), treatmentId.toString());
        checkBoxListClinicalHistory =
            List.generate(addDetailsList?.length ?? 0 + 1, (_) => false);
        CustomMessage.toast("Clinical Condition Saved");
        CustomPopup.showAlertDialog(
            () {
              Get.back();
            },
            () {
              //ok callback
              Get.back();
            },
            "Success",
            "Clinical Condition Saved",
            "assets/info.png",
            false,
            "",
            () {
              Get.back();
            });
      }
      update();
    } catch (e) {
      debugPrint("Error occurred in getNephroList: $e");
    } finally {
      isLoading = false;
      update();
      debugPrint("Loading state updated to false");
    }
  }

  getDiseaseList() async {
    isLoading = true;
    update();

    try {
      addDetailsList = await _repository.getDiseaseList();
      isLoading = false;
      addDetailsList;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting getDiseaseList');
    }
    update();
  }

  getRelationAndDietList() async {
    isLoading = true;
    update();

    try {
      final relationModel = await _repository.getRelationAndDietList();
      isLoading = false;
      relationList = relationModel.relationList;
      dietListClinicalHistory = relationModel.dietList;
      currentStatList = relationModel.currentStatusList;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting getRelationAndDietList');
    }
    update();
  }

  getTempList() async {
    isLoading = true;
    update();

    try {
      final tempListModel = await _repository.getTempList();
      isLoading = false;
      tempList = tempListModel.pattemplist;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  checkDuplicateTest(String patientId, String treatmentId, String subServiceId,
      String unitId, String userId) async {
    try {
      final body = await _repository.checkDuplicateTest(
          patientId, treatmentId, subServiceId, unitId, userId);
      if (body == "0") {
        return false;
      } else {
        return true;
      }
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting checkDuplicateTest');
      return true;
    }
  }

  checkDuplicatePackage(
    String patientId,
    String treatmentId,
    String packageId,
  ) async {
    try {
      final body = await _repository.checkDuplicatePackage(patientId, treatmentId, packageId);
      if (body == "0") {
        return false;
      } else {
        return true;
      }
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting checkDuplicatePackage');
      return true;
    }
  }

  getPrescriptionList(treatmentId, unitId) async {
    isLoading = true;
    update();

    try {
      final prescriptionListModel = await _repository.getPrescriptionList(treatmentId, unitId);
      isLoading = false;
      prescrriptionList = prescriptionListModel.listOPDPrescriptionDtoSP;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getPrepList() async {
    isLoading = true;
    update();

    try {
      final prepDropdownModel = await _repository.getPrepList();
      isLoading = false;
      prepListDropDown = prepDropdownModel.listpreparationmaster;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getMedicationList() async {
    isLoading = true;
    update();

    try {
      medicationList = await _repository.getMedicationList();
      isLoading = false;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getUnitList() async {
    isLoading = true;
    update();

    try {
      final prepUnitModel = await _repository.getUnitList();
      isLoading = false;
      prepUnitList = prepUnitModel.listUomMaster;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getMedicineNameList(String letter) async {
    isLoading = true;
    update();

    try {
      final medicineNameModel = await _repository.getMedicineNameList(letter);
      isLoading = false;
      medicineNameModelList = medicineNameModel.lstPrescriptionGenericDTO;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting medicine name');
    }
    update();
  }

  getPrescInstruction() async {
    isLoading = true;
    update();

    try {
      final prescriptionInstructionModel = await _repository.getPrescInstruction();
      isLoading = false;
      presInstList = prescriptionInstructionModel.listPrescriptionInstructionDto;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting medicine name');
    }
    update();
  }

  getRouteList(unitId) async {
    isLoading = true;
    update();

    try {
      final routeListModel = await _repository.getRouteList(unitId);
      isLoading = false;
      routeList = routeListModel.listroutemasters;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting medicine name');
    }
    update();
  }

  Future<void> addPrescription(body, NephroList? patientData, unitId) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.addPrescription(body);

      if (data['Status'] == 'Success') {
        Get.back();
        await getPrescriptionList(patientData?.treatmentId, unitId);
        medicineNameTxtEdit.text = '';
        selectedPrep = null;
        dosage.text = '';
        selectedUnit = null;
        presFreqTxt.text = '';
        selectedRoute = null;
        selectedInst = null;
        presDays.text = '';
        presQty.text = '';
        CustomMessage.toast(data['Message']);
      } else {
        CustomMessage.toast(data['Message']);
        Get.back();
      }
    } catch (e) {
      debugPrint("Error occurred: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  getMedicineDataById(String productId) async {
    isLoading = true;
    update();

    try {
      medicineDataById = await _repository.getMedicineDataById(productId);
      isLoading = false;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting medicine name');
    }
    update();
  }

  getUploadedDocList(patientId, treatmentId, unitId) async {
    isLoading = true;
    update();

    try {
      await _repository.getUploadedDocList(patientId, treatmentId, unitId);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  List<String> getSelectedItems(l1) {
    List<String> selected = [];
    for (int i = 0; i < checkBoxValues.length; i++) {
      if (checkBoxValues[i]) {
        selected.add(l1[i]);
      }
    }
    return selected;
  }

  getDietList(treatmentId) async {
    isLoading = true;
    update();

    try {
      final dietListModel = await _repository.getDietList(treatmentId);
      isLoading = false;
      dietList = dietListModel.getListOfOPDDietDTO;
    } on ApiException {
      isLoading = false;
      // Clear stale/previous data on failure (e.g. 400) so the UI shows an
      // empty state instead of rendering leftover data from a prior call.
      dietList = [];
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getTreatmentId(patientId) async {
    isLoading = true;
    update();

    try {
      treatmentIdModel = await _repository.getTreatmentId(patientId);
      isLoading = false;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting getTreatmentId');
    }
    update();
  }

  getUploadedDocNephro(patientId, treatmentId, unitId) async {
    isLoading = true;
    update();

    try {
      uploadedDocList = await _repository.getUploadedDocNephro(patientId, treatmentId, unitId);
      isLoading = false;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  Future<void> viewUploadedDoc(String fileName, String documentId) async {
    isLoading = true;
    update();

    final bytes = await _repository.viewUploadedDocBytes(fileName, documentId);

    if (bytes != null) {
      // Get temp directory
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/$fileName';

      // Write to file
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      isLoading = false;
      update();

      Get.to(CustomViewer(
        fileUrl: file.path,
      ));
    } else {
      isLoading = false;
      update();
      debugPrint('Failed to load file');
    }
  }

  Future<void> viewCtReoprt(
      String unitId, String patientId, String treatId, String userId) async {
    isLoading = true;
    update();

    final bytes = await _repository.viewCtReoprtBytes(unitId, patientId, treatId, userId);

    if (bytes != null) {
      final fileName = 'ct_report_${DateTime.now().millisecondsSinceEpoch}.pdf';

      // Get temp directory
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/$fileName';

      // Write to file
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      isLoading = false;
      update();

      Get.to(CustomViewer(
        fileUrl: file.path,
      ));
    } else {
      isLoading = false;
      update();
      debugPrint('Failed to load file');
    }
  }

  deleteClinicalCondi(id, treatmentid) async {
    isLoading = true;
    update();

    try {
      await _repository.deleteClinicalCondi(id);
      isLoading = false;
      await getClinicaConditionProvisionalList(treatmentid.toString());
      CustomMessage.toast('Diagonosis Deleted SuccessFully');
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  deleteDiagnosticIns(labservicelist, userId, treatmentid) async {
    isLoading = true;
    update();

    try {
      final responseBody = await _repository.deleteDiagnosticIns(labservicelist, userId);
      isLoading = false;
      if (responseBody == '1') {
        await getDiagnosticInvList(treatmentid);
        CustomMessage.toast('Diagonosis Deleted SuccessFully');
      }
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting deleteDiagnosticIns');
    }
    update();
  }

  deletePrescriptin(unitid, prescripId, userId, treatmentid) async {
    isLoading = true;
    update();

    try {
      final responseBody = await _repository.deletePrescriptin(unitid, prescripId, userId);
      isLoading = false;
      if (responseBody.contains("Records Deleted Sucessfully")) {
        await getPrescriptionList(treatmentid.toString(), unitid);
        CustomMessage.toast('Records Deleted Sucessfully');
      }
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  deleteInstruction(userId, instructionId, treatmentid, patientId) async {
    isLoading = true;
    update();

    try {
      final responseBody = await _repository.deleteInstruction(userId, instructionId);
      isLoading = false;
      if (responseBody == '1') {
        await getInstructions(treatmentid, patientId);
        CustomMessage.toast('Records Deleted Sucessfully');
      }
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  deleteIndivisualInst(
      userId, instructionId, treatmentid, patientId, unitId) async {
    isLoading = true;
    update();

    try {
      final respBody = await _repository.deleteIndivisualInst(userId, instructionId);
      isLoading = false;
      if (respBody['Status'] == 'Success') {
        await getDefaultInstruction(unitId.toString(), treatmentid.toString());
        CustomMessage.toast(respBody['Massage']);
      }
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting deleteIndivisualInst');
    }
    update();
  }

  deleteDiet(dietMasterId, userId, treatmentId) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.deleteDiet(dietMasterId, userId);
      isLoading = false;
      CustomMessage.toast(data['message']);
      await getDietList(treatmentId);
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  deleteUploadedImage(
      documentId, userId, patientId, treatmentId, unitId) async {
    isLoading = true;
    update();

    try {
      await _repository.deleteUploadedImage(documentId, userId);
      isLoading = false;
      CustomMessage.toast("Document Deleted");

      await getUploadedDocNephro(patientId, treatmentId, unitId);
      Get.back();
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getDietDetailsOnClick(dietMasterId) async {
    isLoading = true;
    update();

    try {
      dietItemDet = await _repository.getDietDetailsOnClick(dietMasterId);
      isLoading = false;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getAllTest(packageId) async {
    isLoading = true;
    update();

    try {
      final testList = await _repository.getAllTest(packageId);
      isLoading = false;
      return testList;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting captcha');
    }
    update();
  }

  Future<void> getClinicaConditionProvisionalList(String? treatmentId) async {
    provisionList.clear();
    confirmationList.clear();
    if (treatmentId == null || treatmentId.isEmpty) {
      debugPrint("Treatment ID is null or empty");
      return;
    }

    isLoading = true;
    update();

    try {
      provisionConfirmationalList =
          await _repository.getClinicaConditionProvisionalList(treatmentId);

      for (int i = 0; i < provisionConfirmationalList!.length; i++) {
        if (provisionConfirmationalList![i].diagnoType == "Provisional") {
          provisionList.add(provisionConfirmationalList![i]);
        } else if (provisionConfirmationalList![i].diagnoType ==
            "Confirmed") {
          confirmationList.add(provisionConfirmationalList![i]);
        }
      }

      clinicalConditionL1 = List.generate(provisionConfirmationalList!.length,
          (index) => (index + 1).toString()); // srNo
      clinicalConditionL2 = provisionConfirmationalList
              ?.map((item) => item.diagoName ?? '-')
              .toList() ??
          []; // Particulars
      clinicalConditionL3 = provisionConfirmationalList
              ?.map((item) => item.createdDateTime != null
                  ? getDate(item.createdDateTime!)
                  : '-')
              .toList() ??
          []; //
      clinicalConditionL4 = provisionConfirmationalList
              ?.map((item) => item.diagnoType.toString())
              .toList() ??
          [];

      debugPrint(
          'Parsed clinical condition: ${provisionConfirmationalList?.length}');
    } catch (e) {
      debugPrint("Error occurred in getClinicaConditionProvisionalList: $e");
    } finally {
      isLoading = false;
      update();
      debugPrint("Loading state updated to false");
    }
  }

  String getDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
    return formattedDate;
  }

  Future<void> getClinicalHistoryList(
      String? patientId, String? treatmentId) async {
    isLoading = true;
    update();

    try {
      clinicalHistoryList = await _repository.getClinicalHistoryList(patientId, treatmentId);

      debugPrint('Parsed clinical condition: ${clinicalHistoryList?.length}');
    } catch (e) {
      debugPrint("Error occurred in getClinicalHistoryList: $e");
    } finally {
      isLoading = false;
      update();
      debugPrint("Loading state updated to false");
    }
  }

  Future<void> getDefaultInstruction(String unitId, String? treatmentId) async {
    isLoading = true;
    update();

    try {
      final defaultInstructionModel = await _repository.getDefaultInstruction(unitId, treatmentId);
      defaultInstructionList = defaultInstructionModel.getListOfOPDInstructionDTO;

      debugPrint('${defaultInstructionList?.length}');
    } catch (e) {
      debugPrint("Error occurred in defaultInstructionList: $e");
    } finally {
      isLoading = false;
      update();
      debugPrint("Loading state updated to false");
    }
  }

  Future<void> getPackageList(String? unitId) async {
    isLoading = true;
    update();

    try {
      packageList = await _repository.getPackageList(unitId);

      debugPrint('Parsed clinical condition: ${packageList?.length}');
    } catch (e) {
      debugPrint("Error occurred in getPackageList: $e");
    } finally {
      isLoading = false;
      update();
      debugPrint("Loading state updated to false");
    }
  }

  Future<void> addClinicalCondition(
      int id,
      String date,
      String diagndesc,
      String diagoName,
      String icd10_code,
      String? diagnoType,
      String? comment,
      int? userId,
      int? patientId,
      int? treatmentId,
      int? unitId,
      String? dignosisBy) async {
    isLoading = true;
    update();

    try {
      final responseBody = await _repository.addClinicalCondition({
        "id": id,
        "date": date,
        "diagndesc": diagndesc,
        "diagoName": diagoName,
        "icd10_code": icd10_code,
        "diagnoType": diagnoType,
        "comment": comment,
        "userId": userId,
        "patientId": patientId,
        "treatmentId": treatmentId,
        "unitId": unitId,
        "dignosisBy": dignosisBy
      });

      await getClinicaConditionProvisionalList(treatmentId.toString());
      diagnosisController.clear();
      diagnoDes.clear();
      icdCodeTxtField.clear();
      diagComment.clear();
      diagType = null;
      diagDate.clear();
      Get.back();
      CustomMessage.toast(responseBody);
    } catch (e) {
      debugPrint("Error occurred in getNephroList: $e");
    } finally {
      isLoading = false;
      update();
      debugPrint("Loading state updated to false");
    }
  }

  getDiagNosisList() async {
    isLoading = true;
    update();

    try {
      diagnosisList = await _repository.getDiagNosisList();
      debugPrint('Parsed nephroList: ${nephroList?.length}');
      return diagnosisList?.map((e) => e.nameL).toList();
    } catch (e) {
      debugPrint("Error occurred in getNephroList: $e");
    } finally {
      isLoading = false;
      update();
      debugPrint("Loading state updated to false");
    }
  }

  getICDCode(String id) async {
    isLoading = true;
    update();

    try {
      icdCode = await _repository.getICDCode(id);
      debugPrint('Parsed nephroList: ${nephroList?.length}');
      icdCodeTxtField.text = icdCode?.first.icdCodeL;
    } catch (e) {
      debugPrint("Error occurred in getNephroList: $e");
    } finally {
      isLoading = false;
      update();
      debugPrint("Loading state updated to false");
    }
  }

  Future<void> getCoverSheetNephro(
      String? patientId, String? treatmentId, String unitId) async {
    isLoading = true;
    update();

    try {
      coverSheetNephro = await _repository.getCoverSheetNephro(patientId, treatmentId, unitId);

      parsedPrescriptionData = parsePrescriptionData(
          coverSheetNephro?.prescriptionList?.first.prescriptionData ?? "");

      parsedLabInvestData = parseLabData(
          coverSheetNephro?.laboratoryInvestigationList?.first.dtoData ?? "");
    } catch (e) {
      debugPrint("Error occurred in getNephroList: $e");
    } finally {
      isLoading = false;

      debugPrint("Loading state updated to false");
    }

    update();
  }

  Future<void> getListOfPackage(String? unitId) async {
    isLoading = true;
    update();

    try {
      choosePackageListModel = await _repository.getListOfPackage(unitId);

      List<dynamic> parsedData = json.decode(choosePackageListModel!.data!);
      choosePackageListModel!.parsedData =
          parsedData.map((e) => LabInvestigationPackage.fromJson(e)).toList();
      update();
    } catch (e) {
      debugPrint("Error occurred in getListOfPackage: $e");
    } finally {
      isLoading = false;
      debugPrint("Loading state updated to false");
    }

    update();
  }

  saveTestPackage(List<AddTestPackageModel> testPackageList, String unitId,
      String userId, String? treatmentId) async {
    isLoading = true;
    update();

    try {
      final finalResp = await _repository.saveTestPackage(
        testPackageList: testPackageList,
        unitId: unitId,
        userId: userId,
      );

      if (finalResp.statusCode == 200) {
        testPackageList.clear();
        final responseData = jsonDecode(finalResp.body);
        if (responseData == 1) {
          await getDiagnosticInvList(treatmentId);
          CustomMessage.toast("Test Added");
          Get.back();
        }
        debugPrint("Response: $responseData");
      } else {
        CustomMessage.toast("Test Adding Fail");

        debugPrint("Error: ${finalResp.statusCode} - ${finalResp.body}");
      }
    } catch (error) {
      CustomMessage.toast("Test Adding Fail");

      debugPrint("Exception: $error");
      testPackageList.clear();
    } finally {
      isLoading = false;
      testPackageList.clear();
      update();
    }
  }

  savePackage(AddTestPackageModel package, String unitId, String userId,
      String? treatmentId) async {
    isLoading = true;
    update();

    try {
      final finalResp = await _repository.savePackage(
        package: package,
        unitId: unitId,
        userId: userId,
      );

      if (finalResp.statusCode == 200) {
        final responseData = jsonDecode(finalResp.body);
        if (responseData == 1) {
          await getDiagnosticInvList(treatmentId);
        }
        debugPrint("Response: $responseData");
      } else {
        CustomMessage.toast("Test Adding Fail");

        debugPrint("Error: ${finalResp.statusCode} - ${finalResp.body}");
      }
    } catch (error) {
      CustomMessage.toast("Test Adding Fail");

      debugPrint("Exception: $error");
    } finally {
      isLoading = false;

      update();
    }
  }

  getTestNameList(
    String unitId,
    String depdocdeskid,
    String findingName,
    String userId,
  ) async {
    try {
      testNameList = await _repository.getTestNameList(unitId, depdocdeskid, findingName, userId);
      return testNameList
              ?.where((area) =>
                  area.categoryName
                      ?.toLowerCase()
                      .contains(findingName.toLowerCase()) ??
                  false)
              .toList() ??
          [];
    } catch (e) {
      debugPrint("Error occurred in getListOfPackage: $e");
    } finally {
      update();

      debugPrint("Loading state updated to false");
    }

    update();
  }

  List<Map<String, dynamic>> parsePrescriptionData(String data) {
    // Return an empty list if the input data is empty
    if (data.isEmpty) return [];

    // Clean the string and standardize the format
    data = data
        .replaceAll('OPDPrescriptionDtoSP [', '{')
        .replaceAll(']', '}')
        .replaceAll('=', ':');

    // Extract individual prescriptions
    List<String> prescriptions = data.split('}, {');
    prescriptions =
        prescriptions.map((e) => e.replaceAll(RegExp(r'[\[\]]'), '')).toList();

    // Convert each prescription to a map and filter out empty maps
    List<Map<String, dynamic>> result = prescriptions.map((prescription) {
      Map<String, dynamic> prescriptionMap = {};
      prescription.split(', ').forEach((entry) {
        var keyValue = entry.split(':');
        if (keyValue.length == 2) {
          prescriptionMap[keyValue[0].trim()] = keyValue[1].trim();
        }
      });
      return prescriptionMap;
    }).toList();

    // Return an empty list if no valid maps exist
    return result.where((map) => map.isNotEmpty).toList();
  }

  List<Map<String, dynamic>> parseLabData(String dtoData) {
    // Return an empty list if the input dtoData is empty
    if (dtoData.isEmpty) return [];

    // Extract the listSubServiceIpdDto part from the dtoData string
    RegExp regExp = RegExp(r'listSubServiceIpdDto:\[(.*?)\]');
    Match? match = regExp.firstMatch(dtoData);

    // If no listSubServiceIpdDto found, return empty list
    if (match == null) return [];

    // Get the content inside listSubServiceIpdDto
    String listSubServiceIpdDtoData = match.group(1) ?? '';

    // If the list is empty, return an empty list
    if (listSubServiceIpdDtoData.isEmpty ||
        listSubServiceIpdDtoData == 'null') {
      return [];
    }

    // Clean and standardize the string format
    listSubServiceIpdDtoData = listSubServiceIpdDtoData
        .replaceAll('PatientSubServiceDetailsDto [', '{')
        .replaceAll(']', '}')
        .replaceAll('=', ':');

    // Extract individual services using a regular expression to match the valid data within curly braces
    List<String> services = RegExp(r'\{[^{}]*\}')
        .allMatches(listSubServiceIpdDtoData)
        .map((match) => match.group(0) ?? '')
        .toList();

    // Map each service and ensure empty maps are excluded
    List<Map<String, dynamic>> result = services.map((service) {
      Map<String, dynamic> serviceMap = {};
      service.replaceAll(RegExp(r'[\{\}]'), '').split(', ').forEach((entry) {
        var keyValue = entry.split(':');
        if (keyValue.length == 2) {
          serviceMap[keyValue[0].trim()] = keyValue[1].trim();
        }
      });
      return serviceMap;
    }).toList();

    // Return the filtered result, excluding any empty maps
    return result.where((map) => map.isNotEmpty).toList();
  }

  Future<bool> searchByDropDownList(districtId) async {
    try {
      searchByModel = await _repository.searchByDropDownList(districtId);
      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getting search By list');
    }
  }

  saveTemplate(body, treatmentId) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.saveTemplate(body);
      debugPrint("Parsed response data: $data");

      if (data['status'] == "success") {
        await getDietList(treatmentId);
        CustomMessage.toast(data['message']);
        Get.back();
      } else {
        CustomMessage.toast(data['message'] ?? 'Failed to save diet');
      }

      update();
      return true;
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        CustomMessage.toast('Unauthorized request');
        update();
        return false;
      }
      CustomMessage.toast('Failed to save diet');
      throw Exception('Failed saving diet: ${e.statusCode}');
    } catch (e) {
      debugPrint("Error in saveTemplate: $e");
      CustomMessage.toast('Error saving diet');
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  updateCondtion(id, userId, condtion, treatmentId) async {
    isLoading = true;
    update();

    try {
      final responseBody = await _repository.updateCondtion(id, userId, condtion);
      isLoading = false;
      if (responseBody.contains("Record Updated Sucessfully")) {
        CustomMessage.toast("Record Updated Sucessfully");
        await getClinicaConditionProvisionalList(treatmentId.toString());
      }
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  void setFields(bool isView, ClinicalHistoryList? clinicalHistoryItem) {
    if (isView == true) {
      selectedDiet = dietListClinicalHistory?.firstWhere(
          (e) => e.lookupDetId == clinicalHistoryItem?.lookupDetIdDiet,
          orElse: () {
        return RelationListM();
      }).lookupDetDescEn;
      selectedAlcoholCon =
          clinicalHistoryItem?.alcoholConsumption == "Y" ? "Yes" : "No";
      selectedSmoking = clinicalHistoryItem?.smoking == "N" ? "No" : "Yes";
      selectedTobaco =
          clinicalHistoryItem?.tobaccoConsumption == "Y" ? "Yes" : "No";
      selectediLLicit = clinicalHistoryItem?.illicitDrug == "Y" ? "Yes" : "No";
      remark.text = clinicalHistoryItem?.remark ?? "";
      temp.text = clinicalHistoryItem?.temperature != null
          ? clinicalHistoryItem!.temperature.toString()
          : "";
      pulse.text = clinicalHistoryItem?.pulse != null
          ? clinicalHistoryItem!.pulse.toString()
          : "";
      topBlood.text = clinicalHistoryItem?.bloodPressureH.toString() ?? '';
      bottomBlood.text = clinicalHistoryItem?.bloodPressureL.toString() ?? '';
      bloodGlocuse.text = clinicalHistoryItem?.bloodGlucose.toString() ?? '';
      pasrSurgicalH.text = clinicalHistoryItem?.pastSurgicalHistory ?? '';
      allergies.text = clinicalHistoryItem?.allergiesReactions ?? '';
      specialInst.text = clinicalHistoryItem?.specialInstructions ?? '';
      treatmentP.text = clinicalHistoryItem?.treatmentPlan ?? '';
      checkBoxListClinicalHistory = List.generate(
          clinicalHistoryTableData!.listCliniComorBean?.length ?? 0,
          (index) =>
              clinicalHistoryTableData!.listCliniComorBean?[index].comorFlag ==
              "Y");

      // Populate selectedItemsPerRow with matched relations
      for (int i = 0;
          i < clinicalHistoryTableData!.listCliniComorBean!.length;
          i++) {
        // Clear existing data for this row (since we initialized it already)
        selectedItemsPerRow[i].clear();

        // Get multiRelaId list for current comorbidity
        List<int>? multiRelaIds =
            clinicalHistoryTableData!.listCliniComorBean![i].multiRelaId;

        if (multiRelaIds != null && multiRelaIds.isNotEmpty) {
          for (int j = 0; j < multiRelaIds.length; j++) {
            try {
              // Find the relation name by matching ID
              String? relationName = relationList
                  ?.firstWhere((e) => e.lookupDetId == multiRelaIds[j],
                      orElse: () => RelationListM())
                  .lookupDetDescEn;

              // Add to selectedItemsPerRow if found
              if (relationName != null && relationName.isNotEmpty) {
                selectedItemsPerRow[i].add(relationName);
                debugPrint('Row $i - Added relation: $relationName');
              }
            } catch (e) {
              debugPrint(
                  'Error finding relation for ID ${multiRelaIds[j]}: $e');
            }
          }
        }

        debugPrint('Row $i - Final selected items: ${selectedItemsPerRow[i]}');
      }

      debugPrint('selectedItemsPerRow: $selectedItemsPerRow');

      debugPrint(checkBoxListClinicalHistory?.length.toString());

      assignDuration('Diabetes Mellitus', diabetesMellitusDuration);
      assignDuration('Hypertension', hypertensionDuration);
      assignDuration('Dyslipidemia', dyslipidemiaDuration);
      assignDuration('Chronic Heart Disease', chronicHeartDiseaseDuration);
      assignDuration('Chronic Liver Disease', chronicLiverDiseaseDuratin);
      assignDuration('Stroke', strokeDuration);
      assignDuration('Tuberculosis', tuberculosisDuration);
      assignDuration('HIV', hIVDuration);
      assignDuration('HBV', hBVDuration);
      assignDuration('HCV Treated', hcvTreatedDuration);
      assignDuration('Mental Health Disorder', mentalHealthDisorderDuration);
      assignDuration('Chronic Lung Disease', chronicLungDiseaseDuration);
      assignDuration('HCV Untreated', hcvUntreatedDuration);
    } else {
      selectedDiet = null;
      selectedAlcoholCon = null;
      selectedSmoking = null;
      selectedTobaco = null;
      selectediLLicit = null;
      remark.text = '';
      temp.text = "";
      pulse.text = "";
      topBlood.text = '';
      bottomBlood.text = '';
      bloodGlocuse.text = '';
      pasrSurgicalH.text = clinicalHistoryItem?.pastSurgicalHistory ?? '';
      allergies.text = '';
      specialInst.text = '';
      treatmentP.text = '';
      diabetesMellitusDuration.text = '';
      hypertensionDuration.text = '';
      dyslipidemiaDuration.text = '';
      chronicHeartDiseaseDuration.text = '';
      chronicLiverDiseaseDuratin.text = '';
      strokeDuration.text = '';
      tuberculosisDuration.text = '';
      hIVDuration.text = '';
      hBVDuration.text = '';
      hcvTreatedDuration.text = '';
      hcvUntreatedDuration.text = '';
      mentalHealthDisorderDuration.text = '';
      chronicLungDiseaseDuration.text = '';
    }
  }

  void assignDuration(String comorbidity, TextEditingController controller) {
    final item = clinicalHistoryTableData?.listCliniComorBean
                ?.any((e) => e.comorbidities == comorbidity) ==
            true
        ? clinicalHistoryTableData?.listCliniComorBean
            ?.firstWhere((e) => e.comorbidities == comorbidity)
        : null;
    controller.text = item?.durationYear?.toString() ?? '';
  }

  getClinicalHistoryTableData(patientId, treatmentId,
      ClinicalHistoryList? clinicalHistory, view) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.getClinicalHistoryTableData(
          patientId, treatmentId, clinicalHistory?.clinicalHistoryId);
      isLoading = false;
      clinicalHistoryTableData = ClinicalHistoryTableData.fromJson(data);
      selectedItemsPerRow = List.generate(
          clinicalHistoryTableData!.listCliniComorBean?.length ?? 0,
          (_) => <String>[]);

      setFields(view, clinicalHistory);
      update();
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getDiagnosticInvList(treatmentId) async {
    isLoading = true;
    update();

    try {
      final diagnosticInvListModel = await _repository.getDiagnosticInvList(treatmentId);
      isLoading = false;
      diagnosticInvestList = diagnosticInvListModel.listSubServiceIpdDto;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting getDiagnosticInvList');
    }
    update();
  }

  sendToTechnician(labservicelist, userId, treatId, patientId, unitId) async {
    isLoading = true;
    update();

    try {
      final responseBody = await _repository.sendToTechnician(labservicelist, userId, treatId, patientId, unitId);
      isLoading = false;
      await getDiagnosticInvList(treatId);
      if (responseBody == "1") {
        CustomMessage.toast("Assigned To Technician");
      }
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting getDiagnosticInvList');
    }
    update();
  }

  saveInstructions(BuildContext context, body, treatmentId, patientId) async {
    isLoading = true;
    update();

    try {
      final resp = await _repository.saveInstructions(body);
      isLoading = false;
      if (resp['Status'] == "Success") {
        await getInstructions(treatmentId, patientId);
        showCustomSnackBar(
            topTitle: 'Save Instructions',
            context: context,
            title: '${resp['Message']}',
            img: 'assets/check 1.png');
      }
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting saveInstructions');
    }
    update();
  }

  saveIndivisualInstructions(
      body, treatmentId, patientId, BuildContext context) async {
    isLoading = true;
    update();

    try {
      final resp = await _repository.saveIndivisualInstructions(body);
      isLoading = false;
      if (resp['Status'] == "Success") {
        await getInstructions(treatmentId, patientId);

        showCustomSnackBar(
          title: resp['Massage'],
          topTitle: 'Instructions Saved',
          img: 'assets/check 1.png',
          context: context,
        );
        clearInstructionForm();
        update();
        return true;
      }
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting saveIndivisualInstructions');
    }
    update();
  }

  getInstructions(treatmentId, patientId) async {
    isLoading = true;
    update();

    try {
      final getInstructionsModel = await _repository.getInstructions(treatmentId, patientId);
      isLoading = false;
      instructionsList = getInstructionsModel.lstList;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting getInstructions');
    }
    update();
  }

  void clearInstructionForm() {
    instEnglish.clear();
    instHindi.clear();
    instMarathi.clear();
    instLang1.clear();
    instLang2.clear();
    instLang3.clear();

    update(); // UI refresh
  }
}

class CustomCheckBox {
  String checkTitle;
  bool isSelected;

  CustomCheckBox(this.checkTitle, this.isSelected);
}
