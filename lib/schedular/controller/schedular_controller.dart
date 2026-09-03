import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/dialysis_type_mode.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/get_instructions_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/choose_package.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/new_registration/model/schema_adopted/schema_adopted_model.dart';
import 'package:heamodialysis/new_registration/model/schema_adopted/schema_data.dart';
import 'package:heamodialysis/registered_patient_list/controller/registration_controller.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/already_registered_patient.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/registered_patient_list/model/pre_post_coversheet.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screen/add_edit_ro_desinfec_details.dart';
import 'package:heamodialysis/schedular/model/lab_invest_model.dart';
import 'package:heamodialysis/schedular/model/patient_history_upload_doc.dart';
import 'package:heamodialysis/schedular/model/visitor_entry_data.dart';
import 'package:heamodialysis/schedular/model/add_schedular_request.dart';
import 'package:heamodialysis/schedular/model/add_schedular_response.dart';
import 'package:heamodialysis/schedular/model/consultation_model.dart';
import 'package:heamodialysis/schedular/model/coversheet_prescription_det.dart';
import 'package:heamodialysis/schedular/model/diet_details_coversheet.dart';
import 'package:heamodialysis/schedular/model/new_stages_model.dart';
import 'package:heamodialysis/schedular/model/post_dialysis_schedular.dart';
import 'package:heamodialysis/schedular/model/scheduar_chartdata.dart';
import 'package:heamodialysis/schedular/model/schedular_patient_list.dart';
import 'package:heamodialysis/schedular/model/schedular_pre_dialysis_history.dart';
import 'package:heamodialysis/schedular/model/slot_for_search.dart';
import 'package:heamodialysis/schedular/model/slot_time_model.dart';
import 'package:heamodialysis/schedular/model/visit_patient_detalis.dart';
import 'package:heamodialysis/schedular/model/visitor_docid_model.dart';
import 'package:heamodialysis/schedular/model/auto_suggestion_search.dart';
import 'package:heamodialysis/schedular/repository/schedular_repository.dart';
import 'package:heamodialysis/schedular/screen/schedular_list.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/file_viewer.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class SchedularController extends GetxController {
  final SchedularRepository _repository = SchedularRepository();

  String? msg;
  SchemaData? selectedSchemeObj;

  String? status;

  SchedularPatientList? schedularPatientList;
  List<AutoSuggestionSearch>? autoSuggestionSearch;
  SearchRegisteredPatientModel? searchByModel;
  SlotForSearch? slotForSearch;
  VisitPatientDetalis? visitPatientDetalis;
  DialysisTypeModel? checkAppointment;

  AddSchedularResponse? addSchedularResponse;
  String? dropDownValue;
  TextEditingController addSchedularValueController = TextEditingController();
  TextEditingController instituteController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  TextEditingController preAuthApprovalDateController = TextEditingController();
  TextEditingController visitDateController = TextEditingController();

  TextEditingController visitTimeController = TextEditingController();
  String? visitorTime;

  TextEditingController lastDiaSession = TextEditingController();
  TextEditingController enrollNo = TextEditingController();
  TextEditingController caseNumber = TextEditingController();
  TextEditingController claimNumber = TextEditingController();
  TextEditingController ipNumber = TextEditingController();
  TextEditingController sessionCount = TextEditingController();
  TextEditingController currentDiaSession = TextEditingController();
  TextEditingController abhaId = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController preAuthNumber = TextEditingController();
  bool isLoading = false;
  SchemaAdoptedModel? schemaAdoptedModel;
  ConsultationModel? consultationModel;
  SchedularPreDialysisHistory? schedularPreDialysisHistory;
  PostDialysisSchedular? postDialysisSchedular;

  AlreadyRegisteredPatient? alreadyRegisteredPatient;
  AlreadyRegisteredPatient? cancelAppoint;

  InstituteList? instituteList;
  AutoSuggestionSearch? selectedSearchedData;

  InstituteDataModel? inst;
  List<NewStagesModel>? patientStagesModel;

  List<SlotForSearch>? searchSlotList;
  List<ScheduarChartData> chartDataList = [];
  SearchedData? dropDownValue1;

  List<SlotTimeModel> slotTimeList = [];

  CheckBoxList? oxygenSupply =
  CheckBoxList('Enough Oxygen Supply Available At The Bed', false);
  CheckBoxList? fuelAvailable =
  CheckBoxList('Enough Fuel Available for GenSet at the Hospital', false);
  CheckBoxList? ironSucrose = CheckBoxList('Iron Sucrose', false);

  CheckBoxList? eop = CheckBoxList('EPO Administered', false);

  ROFileDetails uploadImage = ROFileDetails(
      name: 'Choose File', key: 'patientImage', isSelected: false, isReq: false);

  List<PrePostCoversheet>? records;

  List<String> prePostCoversheetl1 = []; // for srNo
  List<String> prePostCoversheetl2 = []; // for Particulars
  List<String> prePostCoversheetl3 = []; // for Date
  List<Widget> prePostCoversheetlastColumnWidgets = [];

  List<String> uploadDocCoversheetl1 = []; // for srNo
  List<String> uploadDocCoversheetl2 = []; // for Particulars
  List<String> uploadDocCoversheetl3 = []; // for Date
  List<Widget> uploadDocCoversheetlastColumnWidgets = [];

  List<String> prescriptionCoversheetl1 = []; // for srNo
  List<String> prescriptionCoversheetl2 = []; // for Particulars
  List<String> prescriptionCoversheetl3 = []; // for Date
  List<String> prescriptionCoversheetl4 = []; // for Date
  List<Widget> prescriptionlastColumnWidgets = [];

  List<String> labCoversheetl1 = []; // for srNo
  List<String> labCoversheetl2 = []; // for Particulars
  List<String> labCoversheetl3 = []; // for Date
  List<String> labCoversheetl4 = [];
  List<Widget> lablastColumnWidgets = [];

  List<String> dietCoversheetl1 = []; // for srNo
  List<String> dietCoversheetl2 = []; // for Particulars
  List<String> dietCoversheetl3 = []; // for Date
  List<String> dietCoversheetl4 = [];

  List<String> instructionCoversheetl1 = []; // for srNo
  List<String> instructionCoversheetl2 = []; // for Particulars

  CoversheetPrescriptionDet? coversheetPrescriptionDet;

  List<LabInvestModel>? labInvestigationCoversheet;
  DietDetailsCoversheet? dietDetailsCoversheet;

  List<VisitorDocIdModel>? visitorDocId;

  File? sessionEndReportFile;
  File? prescriptionReport;

  VisitorEntryData? visitorEntryData;

  int? mjpjayPackageMasterId;

  Future<bool> chartData(unitId, fromD, toD, slotId) async {
    try {
      chartDataList = await _repository.chartData(unitId, fromD, toD, slotId);
      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getting search By list');
    }
  }

  getVisitorEntryData(int patientId, int treatmentId) async {
    isLoading = true;

    try {
      visitorEntryData = await _repository.getVisitorEntryData(patientId, treatmentId);
      isLoading = false;
    } on ApiException {
      isLoading = false;
      throw Exception('Failed search');
    }
    update();
  }

  Future<bool> getPatientStages(int? patientId) async {
    isLoading = true;

    try {
      final data = await _repository.getPatientStages(patientId);

      if (data.isNotEmpty) {
        patientStagesModel = data;
        debugPrint("Patient stages loaded successfully.");
      } else {
        debugPrint("Empty data received.");
      }

      isLoading = false;
      update();
      return true;
    } on ApiException catch (e) {
      isLoading = false;
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getting patient stages');
    } catch (e, stacktrace) {
      debugPrint('Error: $e');
      debugPrint('Stacktrace: $stacktrace');
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> getSchemaAdoptedList() async {
    isLoading = true;

    try {
      schemaAdoptedModel = await _repository.getSchemaAdoptedList();
      isLoading = false;
      update();
      return true;
    } on ApiException catch (e) {
      isLoading = false;
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  Future<bool> getConsultation(treatmentId) async {
    isLoading = true;

    try {
      consultationModel = await _repository.getConsultation(treatmentId);
      isLoading = false;
      update();
      return true;
    } on ApiException catch (e) {
      isLoading = false;
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  getPreDialysisSchedular(treatmentId) async {
    isLoading = true;

    try {
      schedularPreDialysisHistory =
          await _repository.getPreDialysisSchedular(treatmentId);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  Future<bool> getPostDialysisSchedular(treatmentId) async {
    isLoading = true;

    try {
      postDialysisSchedular = await _repository.getPostDialysisSchedular(treatmentId);
      isLoading = false;
      update();
      return true;
    } on ApiException catch (e) {
      isLoading = false;
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  getUploadedDocList(patientId, treatmentId, unitId) async {
    isLoading = true;
    update();

    try {
      final patientHistoryUplodDoc =
          await _repository.getUploadedDocList(patientId, treatmentId, unitId);

      isLoading = false;

      uploadDocCoversheetl1 = List.generate(patientHistoryUplodDoc.length,
              (index) => (index + 1).toString()); // srNo
      uploadDocCoversheetl2 = patientHistoryUplodDoc
          .map((item) => item.doctorDeskFile ?? '-')
          .toList(); // Particulars
      uploadDocCoversheetl3 = patientHistoryUplodDoc
          .map((item) =>
      item.createdDate != null ? formatDate(item.createdDate!) : '-')
          .toList(); // Date

      uploadDocCoversheetlastColumnWidgets = patientHistoryUplodDoc.map((item) {
        return CustomButtonWithoutIcon(
          buttonText: 'View',
          callB: () async {
            await viewUploadedDoc(
                item.doctorDeskFile!, item.documentId.toString());
          },
          buttonWidth: 70,
          primColor: AppColor.primaryBackgroundColor,
          secColor: AppColor.secondaryColor,
          textColor: Colors.white,
        );
      }).toList();
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

  getInstructions(treatmentId, patientId) async {
    isLoading = true;
    update();

    try {
      GetInstructionsModel getInstructionsModel =
          await _repository.getInstructions(treatmentId, patientId);

      isLoading = false;

      instructionCoversheetl1 = List.generate(
          getInstructionsModel.lstList?.length ?? 0,
              (index) => (index + 1).toString());

      instructionCoversheetl2 = getInstructionsModel.lstList
          ?.map((item) => item.reportInstruction ?? '-')
          .toList() ??
          [];
      instructionCoversheetl2;
    } on ApiException {
      isLoading = false;
      debugPrint('Failed getting getInstructions');
    }
    update();
  }

  String formatDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<bool> getPrePostCoversheet(
      String patientId, String unitId, int treatmentId, int userId) async {
    isLoading = true;

    try {
      List<dynamic> data =
          await _repository.getPrePostCoversheet(patientId, unitId);

      isLoading = false;

      prePostCoversheetl1 =
          List.generate(data.length, (index) => (index + 1).toString()); // srNo
      prePostCoversheetl2 =
          data.map((item) => item[4].toString()).toList(); // Particulars
      prePostCoversheetl3 =
          data.map((item) => item[2].toString()).toList(); // Date

      prePostCoversheetlastColumnWidgets = data.map((item) {
        return CustomButtonWithoutIcon(
          buttonText: 'Session End Report',
          callB: () async {
            debugPrint('Tapped on item with ID: ${item[1]}');

            await getSessionReport(
                patientId: patientId.toString(),
                treatmentId: treatmentId,
                userId: userId,
                unitId: int.parse(unitId));
          },
          buttonWidth: 70,
          primColor: AppColor.primaryBackgroundColor,
          secColor: AppColor.secondaryColor,
          textColor: Colors.white,
        );
      }).toList();

      update();
      return true;
    } on ApiException catch (e) {
      isLoading = false;
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getSchemaAdoptedList');
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
        userId: userId,
        unitId: unitId,
      );

      if (bytes != null) {
        final fileName =
            'session_report_${DateTime.now().millisecondsSinceEpoch}.pdf';

        final dir = await getExternalStorageDirectory();
        sessionEndReportFile = File('${dir!.path}/$fileName');
        await sessionEndReportFile?.writeAsBytes(bytes);
        await OpenFile.open(sessionEndReportFile!.path);
      } else {
        debugPrint("❌ Failed to download session report");
      }
    } catch (e) {
      debugPrint("❌ Exception: $e");
    }

    isLoading = false;
    update();
  }

  Future<bool> getTrendAnalysis(String patientId, String testType) async {
    isLoading = true;

    try {
      List<dynamic> data = await _repository.getTrendAnalysis(patientId, testType);

      isLoading = false;

      prePostCoversheetl1 =
          List.generate(data.length, (index) => (index + 1).toString()); // srNo
      prePostCoversheetl2 =
          data.map((item) => item[4].toString()).toList(); // Particulars
      prePostCoversheetl3 =
          data.map((item) => item[2].toString()).toList(); // Date

      prePostCoversheetlastColumnWidgets = data.map((item) {
        return CustomButtonWithoutIcon(
          buttonText: 'Discharge Summary',
          callB: () {
            debugPrint('Tapped on item with ID: ${item[1]}');
          },
          buttonWidth: 70,
          primColor: AppColor.primaryBackgroundColor,
          secColor: AppColor.secondaryColor,
          textColor: Colors.white,
        );
      }).toList();

      update();
      return true;
    } on ApiException catch (e) {
      isLoading = false;
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  Future<bool> getPrescriptionDet(String treatmentId, String unitId,
      String patientId, String userId) async {
    isLoading = true;

    try {
      coversheetPrescriptionDet =
          await _repository.getPrescriptionDet(treatmentId, unitId);

      isLoading = false;

      if (coversheetPrescriptionDet?.listOPDPrescriptionDtoSP != null) {
        prescriptionCoversheetl1 = List.generate(
            coversheetPrescriptionDet!.listOPDPrescriptionDtoSP!.length,
                (index) => (index + 1).toString()); // srNo
        prescriptionCoversheetl2 = coversheetPrescriptionDet!
            .listOPDPrescriptionDtoSP!
            .map((item) => item.drugName!)
            .toList(); // Particulars
        prescriptionCoversheetl3 = coversheetPrescriptionDet!
            .listOPDPrescriptionDtoSP!
            .map((item) => item.frequency.toString())
            .toList(); //
        prescriptionCoversheetl4 = coversheetPrescriptionDet!
            .listOPDPrescriptionDtoSP!
            .map((item) => item.days.toString())
            .toList(); //
        prescriptionlastColumnWidgets =
            coversheetPrescriptionDet!.listOPDPrescriptionDtoSP!.map((item) {
              return CustomButtonWithoutIcon(
                buttonText: 'Print',
                callB: () async {
                  await printReport(unitId, patientId, treatmentId, userId);
                },
                buttonWidth: 70,
                primColor: AppColor.primaryBackgroundColor,
                secColor: AppColor.secondaryColor,
                textColor: Colors.white,
              );
            }).toList();
      }

      update();
      return true;
    } on ApiException catch (e) {
      isLoading = false;
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  getLabInvest(String treatmentId) async {
    isLoading = true;

    try {
      labInvestigationCoversheet = await _repository.getLabInvest(treatmentId);

      isLoading = false;

      if (labInvestigationCoversheet != null &&
          labInvestigationCoversheet!.isNotEmpty) {
        labCoversheetl1 = List.generate(labInvestigationCoversheet!.length,
                (index) => (index + 1).toString()); // srNo
        labCoversheetl2 =
            labInvestigationCoversheet!.map((item) => item.testNames!).toList();
        labCoversheetl3 = labInvestigationCoversheet!.map((item) {
          return item.sampleCollDate ?? '';
        }).toList();

        labCoversheetl4 = labInvestigationCoversheet!
            .map((item) => item.testPackageName ?? '')
            .toList();

        lablastColumnWidgets = labInvestigationCoversheet!.map((item) {
          return (item.testReportLink != null &&
              item.testReportLink!.isNotEmpty)
              ? InkWell(
            onTap: () {
              Get.to(FileViewer(
                fileUrl: item.testReportLink!,
                patientName: 'View Lab Invest',
              ));
            },
            child: Icon(
              Icons.remove_red_eye_outlined,
              color: AppColor.primaryBackgroundColor,
            ),
          )
              : CustomText(
              text: "Processing",
              fontSize: 8,
              fontWeight: FontWeight.normal,
              textColor: AppColor.red,
              textAlign: TextAlign.center);
        }).toList();
      } else {
        isLoading = false;
      }
    } on ApiException {
      // no-op, matches original behavior (no throw on failure)
    }
    update();
  }

  Future<bool> getDietDetails(String treatmentId) async {
    isLoading = true;

    try {
      dietDetailsCoversheet = await _repository.getDietDetails(treatmentId);

      isLoading = false;
      if (dietDetailsCoversheet?.getListOfOPDDietDTO != null) {
        dietCoversheetl1 = List.generate(
            dietDetailsCoversheet!.getListOfOPDDietDTO!.length,
                (index) => (index + 1).toString()); // srNo
        dietCoversheetl2 = dietDetailsCoversheet!.getListOfOPDDietDTO!
            .map((item) => item.templateName!)
            .toList(); // Particulars
        dietCoversheetl3 = dietDetailsCoversheet!.getListOfOPDDietDTO!
            .map((item) => item.fromDate.toString())
            .toList(); //
        dietCoversheetl4 = dietDetailsCoversheet!.getListOfOPDDietDTO!
            .map((item) => item.toDate.toString())
            .toList(); //
      }

      update();
      return true;
    } on ApiException {
      isLoading = false;
      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  getDocumentId() async {
    isLoading = true;

    try {
      visitorDocId = await _repository.getDocumentId();
      isLoading = false;
      update();
      return true;
    } on ApiException {
      isLoading = false;
      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  Future<bool> visitPatientDetails(PatientData? patientData) async {
    try {
      visitPatientDetalis = await _repository.visitPatientDetails(patientData);
      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getting search By list');
    }
  }

  String convertDateFormat(String inputDate) {
    // Parse the input date (dd/MM/yyyy format)
    String formattedDate;
    if (inputDate.isEmpty) {
      formattedDate = '';
    } else {
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(inputDate);

      // Format the date to (yyyy-MM-dd format)
      formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
    }

    return formattedDate;
  }

  uploadDocuments(String? patientId, String userId, String unitId,
      String? treatmentId) async {
    String? docId;
    if (visitorDocId != null) {
      docId = visitorDocId![0].docId.toString();
    }

    try {
      final response = await _repository.uploadVisitorDocuments(
        docId: docId ?? '',
        patientId: patientId,
        userId: userId,
        unitId: unitId,
        treatmentId: treatmentId,
        fileFieldKey: uploadImage.key,
        filePath: uploadImage.file!.path,
      );

      if (response.statusCode == 200) {
        debugPrint(await response.stream.bytesToString());
      } else {
        debugPrint('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Exception occurred: $e');
    }
  }

  Future<bool> updateVisitorEntry(
      PatientData? patientData,
      int? lookupDetIdShemeAdopt,
      String? mjpjaycaseNumber,
      String? mjpjayclaimNumber,
      String? mjpjayIPNumber,
      String? enrollNo,
      String? preAuthpdate,
      String? visitTime,
      String? visitDate,
      int userId,
      String unitId,
      String fromDate,
      String toDate,
      bool? iron,
      bool? epo) async {
    try {
      final preAuthAppDate = convertDateFormat(preAuthpdate ?? "");

      final effectiveDate = (visitDate == null || visitDate.isEmpty)
          ? ""
          : DateFormat("dd/MM/yyyy")
              .format(DateFormat("yyyy-MM-dd").parse(visitDate));

      final Map<String, dynamic> dataMap = {
        "treatmentId": patientData?.treatmentId?.toString() ?? "",
        "patientId": patientData?.patientId?.toString() ?? "",
        "tFlag": "N",
        "patientIdDb":null,
        "departmentId":0,
        "doctorIdList":null,
        "centerPatientId":null,
        "token":0,
        "unitId": unitId,
        "deleted": "N",
        "refDocId": 0,
        "refDocName": null,
        "caseType": 1,
        "weight": 0.0,
        "height": 0.0,
        "mheight": 0.0,
        "fheight": 0.0,
        "notes": "-",
        "empid": null,
        "count": 1,
        "trcount": "0",
        "opdipdno": "0",
        "tpaid": "-",
        "cancelNarration": "-",
        "admCancelFlag": "N",
        "ivfPayFlag": "N",
        "narration": null,
        "patientType": "N",
        "patientStage": null,
        "ivfTreatID": null,
        "preAuthapdate": preAuthAppDate,
        "mjpjaycaseNumber": mjpjaycaseNumber ?? "",
        "mjpjayclaimNumber": mjpjayclaimNumber ?? "",
        "mjpjayIPNumber": mjpjayIPNumber ?? "",
        "mjpjayPackageMasterId": mjpjayPackageMasterId ?? 0,
        "nonMjpjayReson": reason.text,
        "enrollNo": enrollNo ?? "",
        "mjpjayMasterId": null,
        "userId": userId.toString(),
        "visitDate": visitDate ?? "",
        "visitTime": visitTime ?? "",
        "oxygenAvailable": "Y",
        "fuelAvailable": "Y",
        "ironSucroseAvailable": iron == true ? "Y" : "N",
        "ePOAdministerdAvailable": epo == true ? "Y" : "N",
        "mjpjayFlag": null,
        "effectiveDate": effectiveDate,
        "lookupDetIdShemeAdopt": lookupDetIdShemeAdopt,
        "HCIM":0.0,
        "BSA":0.0,
        "BMI":0.0,
        "TARGET_HEIGHT":0.0
      };

      final response = await _repository.updateVisitorEntry(
        dataMap: dataMap,
        fileFieldKey: uploadImage.file != null ? uploadImage.key : null,
        filePath: uploadImage.file?.path,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['code'] == 0) {
          CustomMessage.toast("Data Saved Successfully");
          return true;
        } else {
          CustomMessage.toast("Data Save Failed");
          return false;
        }
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      return false;
    }
  }

  Future<bool> searchByDropDownList() async {
    try {
      searchByModel = await _repository.searchByDropDownList();
      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getting search By list');
    }
  }

  Future<bool> getSlotListSearch(unitId) async {
    try {
      searchSlotList = await _repository.getSlotListSearch(unitId);
      update();
      return true;
    } on ApiException {
      throw Exception('Failed getting search By list');
    }
  }

  Future<void> searchSchedularList(String type, String input, unitId,
      String fromD, String toDate, int slotId, int sId) async {
    isLoading = true;

    try {
      final data = await _repository.searchSchedularList(
          type, input, unitId, fromD, toDate, slotId);

      isLoading = false;

      if (data['status'] == "No Data Found") {
        schedularPatientList = null;
        update();
      } else {
        schedularPatientList = SchedularPatientList.fromJson(data);
        update();
      }
    } on ApiException {
      isLoading = false;
      schedularPatientList = null;
      update();

      throw Exception('Failed search');
    }
    update();
  }

  autoSuggestion(String type, String input, unitId, int sId) async {
    isLoading = true;

    final response = await _repository.autoSuggestion(type, input, unitId, sId);

    if (response.statusCode == 200) {
      isLoading = false;

      if (response.body.contains('Patient Details Not found')) {
        return Future.value([AutoSuggestionSearch(searchParam: response.body)]);
      } else {
        final data = json.decode(response.body);

        if (data is List) {
          // Ensure it's a list before mapping
          autoSuggestionSearch = data
              .map((dynamic item) => AutoSuggestionSearch.fromJson(item))
              .toList();
          update();

          return autoSuggestionSearch;
        } else {
          isLoading = false;
          debugPrint("Data is not a list");
          update();

          return Future.value(
              [AutoSuggestionSearch(searchParam: response.body)]);
        }
      }
    } else {
      isLoading = false;
      update();

      return [];
    }
  }

  searchRegisteredPatient(String type, String input, unitId, String sId) async {
    isLoading = true;

    try {
      final data =
          await _repository.searchRegisteredPatient(type, input, unitId, sId);
      isLoading = false;
      addSchedularValueController.text = "";

      if (data['status'] == 'Success') {
        alreadyRegisteredPatient = AlreadyRegisteredPatient.fromJson(data);
      } else {
        isLoading = false;

        status = data['status'];
      }
    } on ApiException catch (e) {
      isLoading = false;

      if (e.statusCode == 401) {
        status = "Something went wrong";
      } else {
        throw Exception('Failed search');
      }
    }
    update();
  }

  searchAddSchedularPage(
      String type,
      String input,
      unitId,
      String sId,
      NewRegistrationController newRegistrationController,
      RegistrationController registrationController) async {
    isLoading = true;

    try {
      final data =
          await _repository.searchRegisteredPatient(type, input, unitId, sId);
      isLoading = false;

      if (data['status'] == 'Success') {
        AlreadyRegisteredPatient patientDet =
        AlreadyRegisteredPatient.fromJson(data);

        await registrationController
            .checkScrutinyApproval(patientDet.data?.first.patientId);
        if (registrationController.scrutinyType == null ||
            registrationController.scrutinyType == "NEPHROLOGIST" ||
            registrationController.approvalStat == "Approved") {
          alreadyRegisteredPatient = patientDet;
          await newRegistrationController
              .viewPatientData(alreadyRegisteredPatient?.data?.first.patientId);
        } else {
          registrationController.scrutinyType ??= "Undefined ";

          CustomPopup.showSuccessDialog(() {
            Get.back();
          }, "",
              "Approval From ${registrationController.scrutinyType} Is In Process");
        }
      } else {
        isLoading = false;

        status = data['status'];
      }
    } on ApiException catch (e) {
      isLoading = false;

      if (e.statusCode == 401) {
        status = "Something went wrong";
      } else {
        throw Exception('Failed search');
      }
    }
    update();
  }

  cancelAppointment(userId, pId, unitId, tId) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.cancelAppointment(userId, pId, unitId, tId);

      if (data['status'] == 'Success') {
        isLoading = false;

        await searchSchedularList('', '', unitId, fromDateController.text,
            toDateController.text, 0, 1);
        update();

        return true;
      } else {
        isLoading = false;

        status = data['status'];
        update();

        return false;
      }
    } on ApiException {
      isLoading = false;
      update();

      return false;
    }
  }

  getInstituteList(unitId) async {
    isLoading = true;

    try {
      instituteList = await _repository.getInstituteList();
      isLoading = false;
      inst = instituteList?.data?.firstWhere((e) => e.unitId == unitId);
      instituteController.text = inst?.unitName ?? '';
      return instituteList;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting InstituteList');
      }
    }

    update();
  }

  showSearchBy(userId) async {
    isLoading = true;

    try {
      final data = await _repository.showSearchBy(userId);
      return data['flag'].toString();
    } on ApiException {
      isLoading = false;

      debugPrint('Failed getting showSearchBy');
    }

    update();
  }

  getAppointmentAvail(
      String date, int? pId, AddSchedularRequest cardData) async {
    isLoading = true;

    try {
      final data = await _repository.getAppointmentAvail(date, pId);

      isLoading = false;

      checkAppointment = DialysisTypeModel.fromJson(data);
      if (checkAppointment?.status == "false") {
        cardData.bedAllocationDate = date;
      } else {
        CustomPopup.showAlertDialog(() {
          Get.back();
        }, () {
          Get.back();
        }, "Already Booked", "Appointment already given on $date",
            "assets/info.png", false, 'OK', () {});
        cardData.bedAllocationDate = '';
      }
      return checkAppointment?.status ?? "true";
    } on ApiException {
      isLoading = false;
      throw Exception('Failed getting getAppointmentAvail');
    }
  }

  getSlotList(String unitId, String date, AddSchedularRequest cardData,
      patientId) async {
    isLoading = true;

    final response = await _repository.getSlotList(unitId, date, cardData);

    if (response.statusCode == 200) {
      isLoading = false;

      if (response.body != "An error occurred") {
        List<dynamic> data = json.decode(response.body);

        slotTimeList =
            data.map((item) => SlotTimeModel.fromJson(item)).toList();

        if (slotTimeList.isEmpty) {
          CustomPopup.showAlertDialog(() {
            Get.back();
          }, () {
            Get.back();
          }, "Slot Not Available", "On this date $date", "assets/info.png",
              false, "OK", () {});
          cardData.bedAllocationDate = '';
        }
      } else {
        CustomPopup.showAlertDialog(() {
          Get.back();
        }, () {
          Get.back();
        }, "Slot Not Available", "On this date $date", "assets/info.png", false,
            "OK", () {});
        cardData.bedAllocationDate = '';
      }

      update();
    } else {
      isLoading = false;
      throw Exception('Failed getting getDialysisType');
    }
  }

  Future<void> addSchedular(AddSchedularRequest cardData) async {
    isLoading = true;
    update();

    try {
      // --- Normalize bedAllocationDate -> dd-MM-yyyy ---
      if (cardData.bedAllocationDate != null &&
          cardData.bedAllocationDate!.trim().isNotEmpty) {
        final raw = cardData.bedAllocationDate!.trim();

        DateTime parsed;
        try {
          // input like dd/MM/yyyy
          parsed = DateFormat('dd/MM/yyyy').parse(raw.replaceAll('-', '/'));
        } catch (_) {
          // fallback dd-MM-yyyy
          parsed = DateFormat('dd-MM-yyyy').parse(raw);
        }

        cardData.bedAllocationDate = DateFormat('dd-MM-yyyy').format(parsed);
      }

      final result = await _repository.addSchedular(cardData);
      final data = result['raw'];

      // Check if server returns the created object or list; handle both
      Map<String, dynamic>? obj;
      if (data is Map<String, dynamic>) {
        obj = data;
      } else if (data is List &&
          data.isNotEmpty &&
          data.first is Map<String, dynamic>) {
        obj = data.first as Map<String, dynamic>;
      }

      final hasDate = obj != null &&
          (obj["bedAllocationDate"]?.toString().trim().isNotEmpty ?? false);

      if (hasDate) {
        addSchedularResponse = AddSchedularResponse.fromJson(obj);

        alreadyRegisteredPatient = null;
        selectedSearchedData = null;

        CustomPopup.showSuccessDialog(
              () => Get.to(const SchedularListScreen()),
          "Schedule Confirmed",
          "Your schedule has been successfully confirmed.",
        );
      } else {
        CustomPopup.showAlertDialog(
              () => Get.to(const SchedularListScreen()),
              () => Get.to(const SchedularListScreen()),
          "Add Schedular Failed",
          "",
          'assets/consultation.png',
          false,
          "",
              () => Get.to(const SchedularListScreen()),
        );
      }
    } catch (e, st) {
      debugPrint('addSchedular error: $e\n$st');
      CustomPopup.showAlertDialog(
            () => Get.back(),
            () => Get.back(),
        "Add Schedular Failed",
        e.toString(),
        'assets/consultation.png',
        false,
        "",
            () => Get.back(),
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> printReport(
      String unitId, String patientId, String treatId, String userId) async {
    isLoading = true;

    final bytes =
        await _repository.printReportBytes(unitId, patientId, treatId, userId);

    if (bytes != null) {
      isLoading = false;

      final fileName =
          'prescription_details_report${DateTime.now().millisecondsSinceEpoch}.pdf';

      final dir = await getExternalStorageDirectory();
      prescriptionReport = File('${dir!.path}/$fileName');
      await prescriptionReport?.writeAsBytes(Uint8List.fromList(bytes));
      await OpenFile.open(prescriptionReport!.path);
    } else {
      debugPrint("❌ Failed to download prescription report");
    }

    isLoading = false;
    update();
  }

  refreshUi() {
    update();
  }
}
