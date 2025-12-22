import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/dialysis_type_mode.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/choose_package.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/get_instructions_model.dart';
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
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screens/add_edit_ro_desinfec_details.dart';
import 'package:heamodialysis/schedular/model/lab_invest_model.dart';
import 'package:heamodialysis/schedular/model/patient_history_upload_doc.dart';
import 'package:heamodialysis/schedular/model/visitor_entry_data.dart';
import 'package:heamodialysis/schedular/model/add_schedular_request.dart';
import 'package:heamodialysis/schedular/model/add_schedular_response.dart';
import 'package:heamodialysis/schedular/model/consultation_model.dart';
import 'package:heamodialysis/schedular/model/coversheet_prescription_det.dart';
import 'package:heamodialysis/schedular/model/diet_details_coversheet.dart';
import 'package:heamodialysis/schedular/model/lab_investigation_coversheet.dart';
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
import 'package:heamodialysis/schedular/screens/schedular_list.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/file_viewer.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SchedularController extends GetxController {
  String? msg;
  SchemaData? selectedSchemeObj;

  String? status;

  // PreDialysisListModel? preDialysisListModel;
  SchedularPatientList? schedularPatientList;
  List<AutoSuggestionSearch>? autoSuggestionSearch;
  SearchRegisteredPatientModel? searchByModel;
  SlotForSearch? slotForSearch;
  VisitPatientDetalis? visitPatientDetalis;
  DialysisTypeModel? checkAppointment;

  // SlotListModel? slotListModel;
  AddSchedularResponse? addSchedularResponse;
  String? dropDownValue;
  TextEditingController addSchedularValueController = TextEditingController();
  TextEditingController instituteController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  // TextEditingController fDateController = TextEditingController();
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
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  AlreadyRegisteredPatient? alreadyRegisteredPatient;
  AlreadyRegisteredPatient? cancelAppoint;

  InstituteList? instituteList;
  AutoSuggestionSearch? selectedSearchedData;

  InstituteDataModel? inst;
  List<NewStagesModel>? patientStagesModel;

  // List<PatientStagesModel> patientStagesModel = [];
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
      name: 'Choose File', key: 'files', isSelected: false, isReq: false);

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

  // LabInvestigationCoversheet? labInvestigationCoversheet;
  List<LabInvestModel>? labInvestigationCoversheet;
  DietDetailsCoversheet? dietDetailsCoversheet;

  List<VisitorDocIdModel>? visitorDocId;

  File? sessionEndReportFile;
  File? prescriptionReport;

  VisitorEntryData? visitorEntryData;

  int? mjpjayPackageMasterId;

  Future<bool> chartData(unitId, fromD, toD, slotId) async {
    final uri = Uri.parse("${ApiConstants.baseUrl1}${ApiNames.chartData}");
    var body = {
      "unitId": unitId,
      "fromDate": fromD,
      "toDate": toD,
      "slotId": slotId
    };
    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      chartDataList =
          data.map((json) => ScheduarChartData.fromJson(json)).toList();

      update();

      return true;
    } else if (response.statusCode == 401) {
      update();
      return false;
    } else {
      throw Exception('Failed getting search By list');
    }
  }

  getVisitorEntryData(int patientId, int treatmentId) async {
    isLoading = true;
    final uri = Uri.parse(
        // ApiConstants.baseUrl + ApiConstants.searchRegisteredPatientApi
        ApiConstants.baseUrl + ApiNames.viewPatientDetailsNew);

    final Map<String, dynamic> body = {
      "patientId": patientId,
      "treatmentId": treatmentId,
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      //getDeviceDetails
      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      visitorEntryData = VisitorEntryData.fromJson(data);
      // }
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  Future<bool> getPatientStages(int? patientId) async {
    isLoading = true;

    final uri = Uri.parse(
      "${ApiConstants.ip}${ApiNames.patientStage}",
    );

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    var body = jsonEncode({"patientId": patientId});

    try {
      final response = await ioClient.post(uri, headers: headers, body: body);
      debugPrint(response.statusCode.toString());
      debugPrint("response.body : ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          // Ensure it's a list of PatientStagesModel

          patientStagesModel =
              data.map((json) => NewStagesModel.fromJson(json)).toList();

          debugPrint("Patient stages loaded successfully.");
        } else {
          debugPrint("Empty data received.");
        }

        isLoading = false;
        update();
        return true;
      } else if (response.statusCode == 401) {
        isLoading = false;
        update();
        return false;
      } else {
        isLoading = false;
        update();
        throw Exception('Failed getting patient stages');
      }
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

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getSchemaAdoptedList);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      schemaAdoptedModel = SchemaAdoptedModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  Future<bool> getConsultation(treatmentId) async {
    isLoading = true;

    final uri = Uri.parse("${ApiConstants.ip}${ApiNames.consultationDetails}");
    var body = {"treatmentId": treatmentId};
    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      consultationModel = ConsultationModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  getPreDialysisSchedular(treatmentId) async {
    isLoading = true;

    final uri =
        Uri.parse("${ApiConstants.ip}${ApiNames.schedularPreDialysisHistory}");
    var body = {"treatmentId": treatmentId};
    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      schedularPreDialysisHistory = SchedularPreDialysisHistory.fromJson(data);

      update();
    } else {
      isLoading = false;

      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  Future<bool> getPostDialysisSchedular(treatmentId) async {
    isLoading = true;

    final uri =
        Uri.parse("${ApiConstants.ip}${ApiNames.schedularPostDialysisHistory}");
    var body = {"treatmentId": treatmentId};
    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      postDialysisSchedular = PostDialysisSchedular.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  getUploadedDocList(patientId, treatmentId, unitId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getAllOPDDocuments}?patientId=$patientId&treatmentId=$treatmentId&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);

      List<PatientHistoryUploadDoc> patientHistoryUplodDoc =
          data.map((item) => PatientHistoryUploadDoc.fromJson(item)).toList();

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
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  Future<void> viewUploadedDoc(String fileName, String documentId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiNames.viewOpdDocuments}?fileName=$fileName&documentId=$documentId",
    );

    final request = http.Request('GET', uri);
    final response = await request.send();

    if (response.statusCode == 200) {
      final bytes = await response.stream.toBytes();

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
      debugPrint('Failed to load file: ${response.reasonPhrase}');
    }
  }

  getInstructions(treatmentId, patientId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.fetchinstruction}?treatmentId=$treatmentId&patientId=$patientId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      var data = json.decode(response.body);
      GetInstructionsModel getInstructionsModel =
          GetInstructionsModel.fromJson(data);

      instructionCoversheetl1 = List.generate(
          getInstructionsModel.lstList?.length ?? 0,
          (index) => (index + 1).toString());

      instructionCoversheetl2 = getInstructionsModel.lstList
              ?.map((item) => item.reportInstruction ?? '-')
              .toList() ??
          [];
      instructionCoversheetl2;
    } else {
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

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getPatientDisHist}?patientId=$patientId&unitId=$unitId");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
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
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

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
      final uri = Uri.parse(
        '${ApiConstants.ip + ApiNames.sessionEndReport}?details=no&fromDate=&toDate=&treatmentId=&patientId=$patientId',
      );

      final headers = {'Content-Type': 'application/json'};

      final request = http.Request('POST', uri);
      request.body = jsonEncode({
        "patientId": int.parse(patientId),
        "details": "no",
        "fromDate": "",
        "toDate": "",
        "treatmentId": treatmentId,
        "userId": userId,
        "unitId": unitId
      });
      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final bytes = await response.stream.toBytes();
        final fileName =
            'session_report_${DateTime.now().millisecondsSinceEpoch}.pdf';

        final dir = await getExternalStorageDirectory();
        sessionEndReportFile = File('${dir!.path}/$fileName');
        await sessionEndReportFile?.writeAsBytes(bytes);
        await OpenFile.open(sessionEndReportFile!.path);
      } else {
        debugPrint("❌ Failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      debugPrint("❌ Exception: $e");
    }

    isLoading = false;
    update();
  }

  Future<bool> getTrendAnalysis(String patientId, String testType) async {
    isLoading = true;

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getTrendAnalysisData}?patientId=$patientId&testType=$testType");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    ///todo
    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
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
      // records = data.asMap().entries.map((entry) {
      //   int index = entry.key + 1; // Calculate srNo (1-based index)
      //   List<dynamic> item = entry.value;
      //   return PrePostCoversheet(
      //       id1: item[0],
      //       id2: item[1],
      //       date1: item[2],
      //       date2: item[3],
      //       name: item[4],
      //       srNo: index);
      // }).toList();

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  Future<bool> getPrescriptionDet(String treatmentId, String unitId,
      String patientId, String userId) async {
    isLoading = true;

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getAllPrescriptionsByTreatmentId}?treatmentId=$treatmentId&unitId=$unitId");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      coversheetPrescriptionDet = CoversheetPrescriptionDet.fromJson(data);
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
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  // Future<bool> getLabInvest(String treatmentId) async {
  //   isLoading = true;
  //   var body = {
  //     "treatmentId": treatmentId,
  //     "billDetailsId": null,
  //     "serviceId": 0,
  //     "subServiceId": null,
  //     "chargesSlaveId": null,
  //     "unitId": null,
  //     "categoryName": null,
  //     "bedHall": null,
  //     "bedDate": null,
  //     "hallID": null,
  //     "specialityId": null,
  //     "docId": null,
  //     "docName": null,
  //     "isCombination": null,
  //     "iscombination": null,
  //     "rate": 0.0,
  //     "charges": 0.0,
  //     "otherRate": 0.0,
  //     "otherAmount": 0.0,
  //     "otherPay": 0.0,
  //     "otherConcession": 0.0,
  //     "otherCoPay": 0.0,
  //     "amount": 0.0,
  //     "concessionOnPerc": 0.0,
  //     "concessionPer": 0.0,
  //     "drdeskflag": null,
  //     "quantity": 0.0,
  //     "paidFlag": "N",
  //     "sndtolabflag": null,
  //     "paidByCashFlag": null,
  //     "sampleTypeId": 0,
  //     "barCode": null,
  //     "inOutHouse": 0,
  //     "histopathLab": "N",
  //     "sampleCount": 0,
  //     "collectionDate": "",
  //     "collectionTime": "",
  //     "regRefDocId": 0,
  //     "templateWise": "N",
  //     "invName": null,
  //     "pay": 0.0,
  //     "coPay": 0.0,
  //     "concession": 0.0,
  //     "cancle": "N",
  //     "isModify": null,
  //     "cghsCode": null,
  //     "createdDateTime": null,
  //     "createdDate": null,
  //     "emrPer": 0.0,
  //     "sndtorisflag": null,
  //     "serviceName": null,
  //     "otFlag": null,
  //     "OName": null,
  //     "template_wise": null,
  //     "clinical_notes": null,
  //     "instructions": null,
  //     "count_ot": null,
  //     "investigation_event": null,
  //     "investigation_event_desc": null
  //   };
  //   final uri = Uri.parse(
  //       "${ApiConstants.baseUrl}${ApiNames.getPatientSubServiceDetailsOnIPD}?treatmentId=$treatmentId");
  //
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //   };
  //
  //   debugPrint(uri.path);
  //   // print(body);
  //
  //   final response =
  //   await ioClient.post(uri, headers: headers, body: jsonEncode(body));
  //   debugPrint(response.statusCode.toString());
  //   debugPrint("response.body : ${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     isLoading = false;
  //
  //     final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  //     final DateFormat timeFormat = DateFormat('HH:mm');
  //     //getDeviceDetails
  //     final data = json.decode(response.body);
  //     labInvestigationCoversheet = LabInvestigationCoversheet.fromJson(data);
  //     if (labInvestigationCoversheet?.listSubServiceIpdDto != null) {
  //       labCoversheetl1 = List.generate(
  //           labInvestigationCoversheet!.listSubServiceIpdDto!.length,
  //               (index) => (index + 1).toString()); // srNo
  //       labCoversheetl2 = labInvestigationCoversheet!.listSubServiceIpdDto!
  //           .map((item) => item.categoryName!)
  //           .toList(); // Particulars
  //       labCoversheetl3 =
  //           labInvestigationCoversheet!.listSubServiceIpdDto!.map((item) {
  //             DateTime parsedDate = DateTime.parse(item.createdDate.toString());
  //             return dateFormat.format(parsedDate); // Extracted date
  //           }).toList();
  //
  //       labCoversheetl4 = labInvestigationCoversheet!.listSubServiceIpdDto!
  //           .map((item) => item.investigationEventDesc ?? '')
  //           .toList();
  //     }
  //
  //     update();
  //     return true;
  //   } else {
  //     isLoading = false;
  //
  //     throw Exception('Failed getLabInvest');
  //   }
  // }

  getLabInvest(String treatmentId) async {
    isLoading = true;

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getTestReportByPatientId}?patientId=$treatmentId");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      // final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      // final DateFormat timeFormat = DateFormat('HH:mm');
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      labInvestigationCoversheet =
          data.map((item) => LabInvestModel.fromJson(item)).toList();

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

        // throw Exception('Failed getLabInvest');
      }
    }
    update();
  }

  Future<bool> getDietDetails(String treatmentId) async {
    isLoading = true;

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getOPDDietListByTreatmentId}?treatmentId=$treatmentId");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      dietDetailsCoversheet = DietDetailsCoversheet.fromJson(data);
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
    } else {
      isLoading = false;

      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  getDocumentId() async {
    isLoading = true;

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getDocumentChecklistList}?formShortCode=VEF");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);

      visitorDocId =
          data.map((json) => VisitorDocIdModel.fromJson(json)).toList();

      update();
      return true;
    } else {
      isLoading = false;

      throw Exception('Failed getSchemaAdoptedList');
    }
  }

  Future<bool> visitPatientDetails(PatientData? patientData) async {
    final Map<String, dynamic> body = {
      "patientId": patientData?.patientId,
      "treatmentId": patientData?.treatmentId
    };

    String jsonbody = json.encode(body);
    final uri = Uri.parse(ApiConstants.oldBaseUrl + ApiNames.visitPatient);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      visitPatientDetalis = VisitPatientDetalis.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      update();

      return false;
    } else {
      throw Exception('Failed getting search By list');
    }
  }

  // String convertDateFormat(String inputDate) {
  //   // Parse the input date (dd/MM/yyyy format)
  //   String formattedDate;
  //   if (inputDate == "") {
  //     formattedDate = '';
  //   } else {
  //     DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(inputDate);
  //
  //     // Format the date to (yyyy/MM/dd format)
  //     formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
  //   }
  //
  //   return formattedDate;
  // }

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
    HttpClient httpClient = ByPassCert().httpClient;
    IOClient ioClient = IOClient(httpClient);

    Uri uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.visitDocumentUpload}?files");

    // Create a multipart request
    var request = http.MultipartRequest('POST', uri);
    String? docId;
    if (visitorDocId != null) {
      docId = visitorDocId![0].docId.toString();
    }
    // Add fields
    request.fields.addAll({
      'documentChecklistId': docId ?? '',
      'patientId': patientId ?? "",
      'treatmentId': treatmentId ?? '',
      'userId': userId,
      'unitId': unitId,
    });

    try {
      request.files.add(await http.MultipartFile.fromPath(
        uploadImage.key,
        uploadImage.file!.path,
      ));

      // Send request
      http.StreamedResponse response = await ioClient.send(request);

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
      final url =
          Uri.parse("${ApiConstants.baseUrl}${ApiNames.updateTreatmentData}");

      final preAuthAppDate = convertDateFormat(preAuthpdate ?? "");

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
        // "preAuthAppDate": preAuthAppDate,
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
        "effectiveDate": "",
        "lookupDetIdShemeAdopt": lookupDetIdShemeAdopt,
        "HCIM":0.0,
        "BSA":0.0,
        "BMI":0.0,
        "TARGET_HEIGHT":0.0
      };

      var request = http.MultipartRequest("POST", url);
      request.fields['data'] =
          jsonEncode(dataMap); // key is "data" just like in Postman

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (uploadImage.file != null) {
          await uploadDocuments(
            patientData?.patientId.toString(),
            userId.toString(),
            unitId,
            patientData?.treatmentId.toString(),
          );
        }

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

  // Future<bool> updateVisitorEntry(
  //   PatientData? patientData,
  //   int? lookupDetIdShemeAdopt,
  //   String? mjpjaycaseNumber,
  //   String? mjpjayclaimNumber,
  //   String? mjpjayIPNumber,
  //   String? enrollNo,
  //   String? preAuthpdate,
  //   String? visitTime,
  //   String? visitDate,
  //   int userId,
  //   String unitId,
  //   String fromDate,
  //   String toDate,
  // ) async {
  //   // Create the inner body as a map with all values (except numbers) as strings
  //   var preAuthapdate = convertDateFormat(preAuthpdate ?? "");
  //   // var visitD = convertDateFormat(visitDate!);
  //   final Map<String, dynamic> innerBody = {
  //     "patientId": patientData?.patientId?.toString() ?? "",
  //     "treatmentId": patientData?.treatmentId?.toString() ?? "",
  //     "lookupDetailIdSchemeAdopt": lookupDetIdShemeAdopt,
  //     "mjpjayCaseNumber": mjpjaycaseNumber ?? "",
  //     "mjpjayClaimNumber": mjpjayclaimNumber ?? "",
  //     "mjpjayIPNumber": mjpjayIPNumber ?? "",
  //     "enrollNo": enrollNo ?? "",
  //     "preAuthAppDate": preAuthapdate,
  //     "visitTime": visitTime ?? "",
  //     "visitDate": visitDate,
  //     "fuelAvailable": "Y",
  //     "oxygenAvailable": "Y",
  //     "userId": userId
  //   };
  //
  //   String innerJsonBody = json.encode(innerBody);
  //
  //   final uri =
  //       Uri.parse(ApiConstants.baseUrl + ApiConstants.updateTreatmentData);
  //
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //   };
  //
  //   debugPrint(uri.path);
  //
  //   // Send the request
  //   final response =
  //       await ioClient.post(uri, headers: headers, body: innerJsonBody);
  //   debugPrint(response.statusCode.toString());
  //   debugPrint("response.body : ${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     // Process response
  //     final data = json.decode(response.body);
  //     if (uploadImage.file != null) {
  //       await uploadDocuments(patientData?.patientId.toString(),
  //           userId.toString(), unitId, patientData?.treatmentId.toString());
  //     }
  //
  //     if (data['code'] == 0) {
  //       CustomMessage.toast("Data Saved Successfully");
  //
  //       return true;
  //     } else {
  //       CustomMessage.toast("Data Saved Failed");
  //       return false;
  //     }
  //   } else {
  //     throw Exception('Failed to update data');
  //   }
  // }

  Future<bool> searchByDropDownList() async {
    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiNames.searchByDropDownListApi);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      searchByModel = SearchRegisteredPatientModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      update();

      return false;
    } else {
      throw Exception('Failed getting search By list');
    }
  }

  Future<bool> getSlotListSearch(unitId) async {
    // final uri = Uri.parse(
    //     "${ApiConstants.ipPort}/${ApiConstants.commonPath1}${ApiConstants.slotList}");

    final uri = Uri.parse("${ApiConstants.ip}${ApiNames.slotList}");
    var body = {"unitId": unitId};
    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      searchSlotList =
          data.map((json) => SlotForSearch.fromJson(json)).toList();

      update();

      return true;
    } else {
      throw Exception('Failed getting search By list');
    }
  }

  Future<void> searchSchedularList(String type, String input, unitId,
      String fromD, String toDate, int slotId, int sId) async {
    isLoading = true;
    final uri = Uri.parse(
        // ApiConstants.oldBaseUrl + ApiConstants.getDailBookings
        ApiConstants.baseUrl + ApiNames.getDailBookings);

    final Map<String, dynamic> body = {
      "unitId": unitId,
      "type": type,
      "input": input,
      "category": "",
      "sId": 1,
      "fromDate": fromD,
      "toDate": toDate,
      "slotId": slotId
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      //getDeviceDetails
      final data = json.decode(response.body);
      if (data['status'] == "No Data Found") {
        schedularPatientList = null;
        update();
      } else {
        schedularPatientList = SchedularPatientList.fromJson(data);
        update();
      }
    } else {
      isLoading = false;
      schedularPatientList = null;
      update();

      throw Exception('Failed search');
    }
    update();
  }

  autoSuggestion(String type, String input, unitId, int sId) async {
    isLoading = true;
    // final uri = Uri.parse(
    //     // ApiConstants.baseUrl + ApiConstants.searchRegisteredPatientApi
    //     ApiConstants.baseUrl1 + ApiConstants.getSuggestionList);

    final uri = Uri.parse(
        // ApiConstants.baseUrl + ApiConstants.searchRegisteredPatientApi
        ApiConstants.baseUrl1 + ApiNames.getSuggestionList);

    final Map<String, dynamic> body = {
      "searchParam": input,
      "searchType": type,
      "sId": sId.toString(),
      "unitId": unitId
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

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
    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiNames.searchRegisteredPatientApi);

    final Map<String, dynamic> body = {
      "unitId": unitId,
      "type": type,
      "input": input,
      "category": "",
      "sId": sId,
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      addSchedularValueController.text = "";
      //getDeviceDetails
      final data = json.decode(response.body);
      if (data['status'] == 'Success') {
        alreadyRegisteredPatient = AlreadyRegisteredPatient.fromJson(data);
      } else {
        isLoading = false;

        status = data['status'];
      }
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
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
    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiNames.searchRegisteredPatientApi);

    final Map<String, dynamic> body = {
      "unitId": unitId,
      "type": type,
      "input": input,
      "category": "",
      "sId": sId,
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      // addSchedularValueController.text = "";
      //getDeviceDetails
      final data = json.decode(response.body);
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
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  cancelAppointment(userId, pId, unitId, tId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(ApiConstants.oldBaseUrl + ApiNames.cancelAppointment);

    final Map<String, dynamic> body = {
      "unitId": unitId,
      "userId": userId,
      "patientId": pId,
      "treatmentId": tId,
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // cancelAppoint = AlreadyRegisteredPatient.fromJson(data);

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
    } else {
      isLoading = false;
      update();

      return false;
    }
  }

  getInstituteList(unitId) async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getInstituteList);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      instituteList = InstituteList.fromJson(data);
      isLoading = false;
      inst = instituteList?.data?.firstWhere((e) => e.unitId == unitId);
      instituteController.text = inst?.unitName ?? '';
      return instituteList;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  showSearchBy(userId) async {
    isLoading = true;

    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getUserAccessFlag}?userId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      return data['flag'].toString();
    } else {
      isLoading = false;

      debugPrint('Failed getting showSearchBy');
    }

    update();
  }

  getAppointmentAvail(
      String date, int? pId, AddSchedularRequest cardData) async {
    isLoading = true;
    final Map<String, dynamic> queryParams = {"date": date, "pId": pId};

    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiNames.checkDateAppointmentSchedule);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri,
        headers: headers, body: jsonEncode(queryParams));
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      //getDeviceDetails
      final data = json.decode(response.body);
      checkAppointment = DialysisTypeModel.fromJson(data);
      if (checkAppointment?.status == "false") {
        cardData.bedAllocationDate = date;
      } else {
        // CustomMessage.toast("Can't book on this date");
        CustomPopup.showAlertDialog(() {
          Get.back();
        }, () {
          Get.back();
        }, "Already Booked", "Appointment already given on $date",
            "assets/info.png", false, 'OK', () {});
        cardData.bedAllocationDate = '';
      }
      // update();
      return checkAppointment?.status ?? "true";
    } else {
      isLoading = false;
      // update();
      throw Exception('Failed getting getAppointmentAvail');
    }
  }

  getSlotList(String unitId, String date, AddSchedularRequest cardData,
      patientId) async {
    isLoading = true;
    final Map<String, dynamic> queryParams = {
      "unitId": unitId,
      "date": date,
      "patientId": cardData.patientId
    };

    // final uri =
    //     Uri.parse(ApiConstants.baseUrl + ApiConstants.getSlotListForscheduler);

    final uri = Uri.parse(ApiConstants.baseUrl1 + ApiNames.getavailableslots);

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri,
        headers: headers, body: jsonEncode(queryParams));
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      if (response.body != "An error occurred") {
        List<dynamic> data = json.decode(response.body);
        // slotListModel = SlotListModel.fromJson(data);

        slotTimeList =
            data.map((item) => SlotTimeModel.fromJson(item)).toList();

        // if (slotListModel?.status == "Failure") {
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

      final uri = Uri.parse(ApiConstants.baseUrl1 + ApiNames.saveSchedular);
      final headers = {"Content-Type": "application/json"};

      // <<< THIS is now a List<Map<String, dynamic>>> with a single element >>>
      final List<Map<String, dynamic>> bodyJson = [cardData.toJson()];

      debugPrint(uri.path);

      final response = await ioClient.post(
        uri,
        headers: headers,
        body: jsonEncode(bodyJson), // encode the list
      );

      debugPrint(response.statusCode.toString());
      debugPrint("response.body : ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

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
      } else {
        throw Exception('Failed to add schedular');
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

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${ApiConstants.ip}${ApiNames.prescriptionReport}?unitId=$unitId&patientId=$patientId&treatId=$treatId&userId=$userId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      isLoading = false;

      final bytes = await response.stream.toBytes();
      final fileName =
          'prescription_details_report${DateTime.now().millisecondsSinceEpoch}.pdf';

      final dir = await getExternalStorageDirectory();
      prescriptionReport = File('${dir!.path}/$fileName');
      await prescriptionReport?.writeAsBytes(bytes);
      await OpenFile.open(prescriptionReport!.path);
    } else {
      debugPrint("❌ Failed: ${response.reasonPhrase}");
    }

    isLoading = false;
    update();
  }

  // Future<void> addSchedular(List<AddSchedularRequest> cardDataList) async {
  //   isLoading = true;
  //   update();
  //   // Format the 'bedAllocationDate' field for all items in the list
  //   for (var cardData in cardDataList) {
  //     if (cardData.bedAllocationDate != null) {
  //       DateTime parsedDate = DateFormat('dd/MM/yyyy')
  //           .parse(cardData.bedAllocationDate!.replaceAll('-', '/'));
  //
  //       cardData.bedAllocationDate =
  //           DateFormat('dd-MM-yyyy').format(parsedDate);
  //     }
  //   }
  //
  //   // Convert the list of objects to JSON
  //   List<Map<String, dynamic>> queryParamsList =
  //       cardDataList.map((item) => item.toJson()).toList();
  //
  //   // Even if sending a single object, ensure it's wrapped in an array
  //   final uri = Uri.parse(ApiConstants.baseUrl1 + ApiNames.saveSchedular);
  //
  //   // Set up the request headers
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //   };
  //
  //   debugPrint(uri.path);
  //
  //   final response = await ioClient.post(uri,
  //       headers: headers, body: jsonEncode(queryParamsList));
  //
  //   debugPrint(response.statusCode.toString());
  //   debugPrint("response.body : ${response.body}");
  //
  //   // Check if the response is successful
  //   if (response.statusCode == 200) {
  //     isLoading = false;
  //
  //     // Parse the response
  //     final data = json.decode(response.body);
  //     if (data["bedAllocationDate"] != null &&
  //         data["bedAllocationDate"] != "") {
  //       addSchedularResponse = AddSchedularResponse.fromJson(data);
  //
  //       // Show success message and navigate to the SchedularListScreen
  //       alreadyRegisteredPatient = null;
  //       selectedSearchedData = null;
  //       CustomPopup.showSuccessDialog(() {
  //         Get.to(const SchedularListScreen());
  //       }, "Schedule Confirmed",
  //           "Your schedule has been successfully confirmed.");
  //
  //       update();
  //     } else {
  //       CustomPopup.showAlertDialog(
  //           () {
  //             Get.to(const SchedularListScreen());
  //           },
  //           () {
  //             Get.to(const SchedularListScreen());
  //           },
  //           "Add Schedular Failed",
  //           "",
  //           'assets/consultation.png',
  //           false,
  //           "",
  //           () {
  //             Get.to(const SchedularListScreen());
  //           });
  //     }
  //   } else {
  //     isLoading = false;
  //     throw Exception('Failed to add schedular');
  //   }
  // }

  refreshUi() {
    update();
  }
}
