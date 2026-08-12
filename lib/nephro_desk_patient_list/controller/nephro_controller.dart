import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_detaisl_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/test_details_model.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/clinical_history.dart';
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
import 'package:heamodialysis/nephro_desk_patient_list/screen/nephro_desk_dropdown.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/clinical_history.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../widgets/status_dialog.dart';

class NephroController extends GetxController {
  bool isLoading = false;
  int lastKnownItemCount = 0;
  IOClient ioClient = IOClient(ByPassCert().httpClient);
  List<NephroList>? nephroList;
  List<ListSubServiceIpdDto>? diagnosticInvestList;
  List<ClinicalConditionProvisionaList>? provisionConfirmationalList;
  List<ClinicalConditionProvisionaList> provisionList = [];
  List<ClinicalConditionProvisionaList> confirmationList = [];
  List<ClinicalHistoryList>? clinicalHistoryList;
  List<PackageListModel>? packageList;
  List<GetDiagonisisList>? icdCode;
  List<GetDiagonisisList>? diagnosisList;

  // ClinicalConditionList? clinicalConditionList;
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
  late List<List<String>> selectedItemsPerRow;
  late List<bool> checkBoxValues;
  TextEditingController imagePath = TextEditingController();
  ClinicalConditionProvisionaList? provisionalItem;
  List<bool> checkboxStates = [];
  List<String> deleteButton = [];
  ClinicalConditionProvisionaList? confirmitem;
  File? uploadedFile;

  // List<DatDiagonosisMasterDtoa>? provisionalList;
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

  // TestNameListModel? testNameModel;

  List<LstService>? testNameList;

  // List<ListSubServiceIpdDto>? testNameList;
  TextEditingController selectedTestsController = TextEditingController();

  TextEditingController clinicalNote = TextEditingController();

  TextEditingController instructions = TextEditingController();

  // List<TestDetailsModel>? allTest;
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

  // List<AddDetailsTable> addDetailsList = [
  //   AddDetailsTable("Diabetes Mellitus", "Diabetes Mellitus", 587, "DM"),
  //   AddDetailsTable("Hypertension", "Hypertension", 588, "HY"),
  //   AddDetailsTable("Dyslipidemia", "Dyslipidemia ", 589, "DY"),
  //   AddDetailsTable(
  //       "Chronic Heart Disease", "Chronic Heart Disease", 590, "CHD"),
  //   AddDetailsTable(
  //       "Chronic Liver Disease", "Chronic Liver Disease", 591, "CLD"),
  //   AddDetailsTable("Stroke", "Stroke", 592, "ST"),
  //   AddDetailsTable("Tuberculosis", "Tuberculosis", 593, "TB"),
  //   AddDetailsTable("HIV", "HIV", 594, "HIV"),
  //   AddDetailsTable("HBV", "HBV", 595, "HBV"),
  //   AddDetailsTable("HCV", "HCV", 596, "HCV"),
  //   AddDetailsTable(
  //       "Mental Health Disorder", "Mental Health Disorder", 597, "MHD"),
  //   AddDetailsTable("Chronic Lung Disease", "Chronic Lung Disease", 598, "CGD"),
  // ];

  // List<RelationListM> relationList = [
  //   RelationListM(12, "SON", "SON", ""),
  //   RelationListM(14, "DAO", "DAUGHTER", ""),
  //   RelationListM(15, "FAO", "FATHER", ""),
  //   RelationListM(16, "DAO", "DAUGHTER", ""),
  //   RelationListM(15, "FAO", "FATHER", ""),
  //   RelationListM(16, "UNC", "UNCLE", ""),
  //   RelationListM(17, "AUN", "AUNTY", ""),
  //   RelationListM(17, "OTH", "OTHER", ""),
  //   RelationListM(423, "HUS", "HUSBAND", ""),
  //   RelationListM(443, "WIO", "WIFE", ""),
  //   RelationListM(485, "BRO", "BROTHER", ""),
  //   RelationListM(486, "SIS", "SISTER", ""),
  //   RelationListM(747, "MAO", "MOTHER", ""),
  //   RelationListM(13, "SELF", "SELF", ""),
  // ];

  // List<DietListM> dietListClinicalHistory = [
  //   DietListM(
  //       lookupDetId: 584,
  //       lookupDetValue: "VEG",
  //       lookupDetDescEn: "Veg",
  //       lookupDetParentName: ""),
  //   DietListM(
  //       lookupDetId: 585,
  //       lookupDetValue: "MIX",
  //       lookupDetDescEn: "Mixed",
  //       lookupDetParentName: "")
  // ];

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
      // Create the custom HttpClient from ByPassCert
      HttpClient httpClient = ByPassCert().httpClient;
      IOClient ioClient = IOClient(httpClient);

      Uri uri =
          Uri.parse(ApiConstants.baseUrl + ApiNames.saveDoctorDeskDocument);

      // Create a multipart request
      var request = http.MultipartRequest('POST', uri);

      // Format the JSON data to send with the request
      var obj = jsonEncode({
        "remark": remark,
        "unitId": unitId,
        "userId": userId,
        "deleted": "N"
      });

      request.fields.addAll({'obj': obj});
      request.fields.addAll({'patientId': patientId});
      request.fields.addAll({'treatmentId': treatmentId});

      // Add headers
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

// "com.mahadialysis.technician" if this package name is present in the file path means new file is selected or to edit file user selected new file
      if (uploadedFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'uploadOpdDocs',
          uploadedFile!.path,
        ));
      }

      // Send the request using the custom IOClient
      http.StreamedResponse response = await ioClient.send(request);
      final finalResp = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        isLoading = false;

        imagePath.clear();
        uploadComment.clear();
        var resp = finalResp
            .body; // Use this instead of response.stream.bytesToString()

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
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.patientDetailsbyid}?treatmentId=$treatmentId&patientId=$patientId");

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
      if (json.decode(response.body) is List) {
        List<dynamic> data = json.decode(response.body);

        patientDet = data
            .map((json) => DialysisEventDetaislModel.fromJson(json))
            .toList();
      }

      update();
    } else {
      isLoading = false;
      update();
      // throw Exception('Failed getting captcha');
    }
  }

  getClinicalHistoryStat(String patientId) async {
    isLoading = true;
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getClinicalHistoryFlag}?patientId=$patientId");

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

      currentStat = response.body;
      debugPrint(currentStat);
      // if (json.decode(response.body) is List) {
      //   List<dynamic> data = json.decode(response.body);
      //
      //   patientDet = data
      //       .map((json) => DialysisEventDetaislModel.fromJson(json))
      //       .toList();
      // }

      update();
    } else {
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
   // final uri = Uri.parse("${ApiConstants.ip}${ApiNames.doctorDeskPatientList}");
    final String url =
         "${ApiConstants.ip}${ApiNames.doctorDeskPatientList}"
        // "http://210.89.42.115:9999/Hemodialysis-Apis/api/mobile/getPreDialysisQueueList"
        "?inputValue"
        "&startIndex=0"
        "&callFrom=DOD"
        "&searchType"
        "&unitId=$unitId";

    final uri = Uri.parse(url);

    debugPrint('📤 Sending GET request to Doctor API: $uri');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    try {
      final response = await ioClient.get(uri, headers: headers);

      debugPrint("📥 Response status code: ${response.statusCode}");
      debugPrint("📥 Response body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        nephroList = data.map((json) => NephroList.fromJson(json)).toList();
        lastKnownItemCount = nephroList!.length;

        debugPrint('✅ Parsed doctor list: ${nephroList?.length} patients found');
      } else {
        nephroList = [];
        debugPrint("❌ API failed with status ${response.statusCode}");
      }

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

    final uri = Uri.parse("${ApiConstants.ip}${ApiNames.nephroList}");
         print('----Url : $uri');
    final Map<String, dynamic> body = {
      "searchType": type,
      "inputValue": input,
      "unitId": unitId,
      "pendingFlag": status,
      "districtId": districtId,
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Sending request to: $uri');
    debugPrint('Request body:--- $jsonbody');

    try {
      final response =
          await ioClient.post(uri, headers: headers, body: jsonbody);
      debugPrint("Response status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        nephroList = data.map((json) => NephroList.fromJson(json)).toList();
        lastKnownItemCount = nephroList!.length;
        debugPrint('Parsed nephroList: ${nephroList?.length}');
      } else {
        nephroList = []; // 🔥 VERY IMPORTANT
        debugPrint("API failed with status ${response.statusCode}");
        throw Exception('Failed to load data: ${response.statusCode}');
      }
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
    final uri = Uri.parse(
      "${ApiConstants.ip}${ApiNames.doctorDeskPatientList}",
    ).replace(queryParameters: {
      "inputValue": inputValue,   // 489
      "startIndex": "0",
      "callFrom": "DOD",
      "searchType": searchType,   // PID / PNA / DOD
      "unitId": unitId,           // 23
    });

    debugPrint("📤 Final URL: $uri");

    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'SESSION=ZDkzYTM1ZmMtMzNkYi00MzAxLWFiMjYtYjJjNGQ1NDM0YjQz'
    };

    try {
      final response = await http.get(uri, headers: headers);

      debugPrint("📥 Status Code: ${response.statusCode}");
      debugPrint("📥 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        nephroList = data.map((e) => NephroList.fromJson(e)).toList();
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

    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.saveOPDHistoryNew}");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Sending request to: $uri');
    debugPrint('Sending request to: ${jsonEncode(body)}');

    try {
      final response =
          await ioClient.post(uri, headers: headers, body: jsonEncode(body));
      debugPrint("Response status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        if (response.body == 'Success') {
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
          // checkBoxValues.clear();

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
        // final List<dynamic> data = json.decode(response.body);
        // clinicalConditionProvisionList = data
        //     .map((json) => ClinicalConditionProvisionaList.fromJson(json))
        //     .toList();
        // debugPrint('Parsed nephroList: ${nephroList?.length}');
        update();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
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

    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.getDiseaseDetails}");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      List<dynamic> data = json.decode(response.body);

      addDetailsList =
          data.map((item) => AddDetailsTable.fromJson(item)).toList();
      addDetailsList;
    } else {
      isLoading = false;
      debugPrint('Failed getting getDiseaseList');
    }
    update();
  }

  getRelationAndDietList() async {
    isLoading = true;
    update();

    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.getDropForOPDHistory}");

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
      PatientRelationListM relationModel = PatientRelationListM.fromJson(data);
      relationList = relationModel.relationList;
      dietListClinicalHistory = relationModel.dietList;
      currentStatList = relationModel.currentStatusList;
    } else {
      isLoading = false;
      debugPrint('Failed getting getRelationAndDietList');
    }
    update();
  }

  getTempList() async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getTemplateListByDepartmentId}?departmentId=1");

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
      var data = json.decode(response.body);
      TempListModel tempListModel = TempListModel.fromJson(data);
      tempList = tempListModel.pattemplist;
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  checkDuplicateTest(String patientId, String treatmentId, String subServiceId,
      String unitId, String userId) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.cehckSavedTestUrl}?patienttId=$patientId&treatmentId=$treatmentId&subServiceId=$subServiceId&unitId=$unitId&userId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      if (response.body == "0") {
        return false;
      } else {
        return true;
      }
    } else {
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
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.checkPackgeSavedUrl}?patienttId=$patientId&treatmentId=$treatmentId&packageId=$packageId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      if (response.body == "0") {
        return false;
      } else {
        return true;
      }
    } else {
      isLoading = false;
      debugPrint('Failed getting checkDuplicatePackage');
      return true;
    }
  }

  getPrescriptionList(treatmentId, unitId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getAllPrescriptionsByTreatmentId}?treatmentId=$treatmentId&unitId=$unitId");
    debugPrint("Prescription API URL: $uri");
    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint("uri --:${uri.path}");

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body-- : ${response.body}");
    debugPrint("uri --:${uri.path}");
    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      var data = json.decode(response.body);
      PrescriptionListModel prescriptionListModel =
          PrescriptionListModel.fromJson(data);
      prescrriptionList = prescriptionListModel.listOPDPrescriptionDtoSP;
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getPrepList() async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.fetchpreparationmaster}");

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
      var data = json.decode(response.body);

      PrepListModel prepDropdownModel = PrepListModel.fromJson(data);
      prepListDropDown = prepDropdownModel.listpreparationmaster;
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getMedicationList() async {
    isLoading = true;
    update();

    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.getMedicationMethod}");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final List<dynamic> data = json.decode(response.body);

      medicationList = data
          .map(
              (item) => MedicationMethod.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getUnitList() async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiNames.fetchAllUnits}");

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
      var data = json.decode(response.body);

      PrepUnitModel prepUnitModel = PrepUnitModel.fromJson(data);
      prepUnitList = prepUnitModel.listUomMaster;
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getMedicineNameList(String letter) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getMedicinesWithGeneric}?letter=$letter&genericFlag=N=1");

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
      var data = json.decode(response.body);
      MedicineNameModel medicineNameModel = MedicineNameModel.fromJson(data);
      medicineNameModelList = medicineNameModel.lstPrescriptionGenericDTO;
    } else {
      isLoading = false;
      debugPrint('Failed getting medicine name');
    }
    update();
  }

  getPrescInstruction() async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getIntsructionsForPrescriptions}");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint("url : @ ${uri.path}");

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      var data = json.decode(response.body);
      PrescriptionInstructionModel prescriptionInstructionModel =
          PrescriptionInstructionModel.fromJson(data);
      presInstList =
          prescriptionInstructionModel.listPrescriptionInstructionDto;
    } else {
      isLoading = false;
      debugPrint('Failed getting medicine name');
    }
    update();
  }

  getRouteList(unitId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getAllRoutesForPrescription}?unitId=$unitId");

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
      var data = json.decode(response.body);
      RouteListModel routeListModel = RouteListModel.fromJson(data);
      routeList = routeListModel.listroutemasters;
    } else {
      isLoading = false;
      debugPrint('Failed getting medicine name');
    }
    update();
  }

  Future<void> addPrescription(body, NephroList? patientData, unitId) async {
    isLoading = true;
    update();

    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.saveOPDPrescription}");

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Sending request to--: $uri');
    debugPrint('Request body ##: $jsonbody');

    try {
      final response =
          await ioClient.post(uri, headers: headers, body: jsonbody);
      debugPrint("Response status code--: ${response.statusCode}");
      debugPrint("Response body--#: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
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
          // Get.to(Prescription(patientData: patientData,));
        } else {
          CustomMessage.toast(data['Message']);
          Get.back();
        }
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
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getMedicineById}?productId=$productId");

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
      var data = json.decode(response.body);
      medicineDataById = MedicineDataById.fromJson(data);
    } else {
      isLoading = false;
      debugPrint('Failed getting medicine name');
    }
    update();
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
      // var data = json.decode(response.body);
      // TempListModel tempListModel = TempListModel.fromJson(data);
      // tempList = tempListModel.pattemplist;
    } else {
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
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getOPDDietListByTreatmentId}?treatmentId=$treatmentId");

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
      var data = json.decode(response.body);
      DietListModel dietListModel = DietListModel.fromJson(data);
      dietList = dietListModel.getListOfOPDDietDTO;
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getTreatmentId(patientId) async {
    isLoading = true;
    update();

    final uri = Uri.parse("${ApiConstants.ip}${ApiNames.getTreatmentId}");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    var body = {"patientId": patientId};
    final response =
        await ioClient.post(uri, headers: headers, body: jsonEncode(body));
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      treatmentIdModel = json.decode(response.body);

      // treatmentIdModel = data.map((e) => TreatmentIdModel.fromList(e)).toList();
    } else {
      isLoading = false;
      debugPrint('Failed getting getTreatmentId');
    }
    update();
  }

  getUploadedDocNephro(patientId, treatmentId, unitId) async {
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
      uploadedDocList =
          data.map((json) => UploadedDocumentNephro.fromJson(json)).toList();
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  // viewUploadedDoc(fileName, documentId) async {
  //   isLoading = true;
  //   update();
  //
  //   var request = http.Request(
  //       'GET',
  //       Uri.parse(
  //           "${ApiConstants.baseUrl}${ApiConstants.getAllOPDDocuments}?fileName=$fileName&documentId=$documentId"));
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     isLoading = false;
  //
  //     debugPrint(await response.stream.bytesToString());
  //   } else {
  //     debugPrint(response.reasonPhrase);
  //     isLoading = false;
  //   }
  // }

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

  Future<void> viewCtReoprt(
      String unitId, String patientId, String treatId, String userId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiNames.ctReport}?unitId=$unitId&patientId=$patientId&treatId=$treatId&userId=$userId",
    );

    final request = http.Request('GET', uri);
    final response = await request.send();

    if (response.statusCode == 200) {
      final bytes = await response.stream.toBytes();
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
      debugPrint('Failed to load file: ${response.reasonPhrase}');
    }
  }

  deleteClinicalCondi(id, treatmentid) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.deleteDiagonosis}?id=$id");

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
      await getClinicaConditionProvisionalList(treatmentid.toString());
      // var data = json.decode(response.body);
      CustomMessage.toast('Diagonosis Deleted SuccessFully');
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  deleteDiagnosticIns(labservicelist, userId, treatmentid) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.deleteIpdServicesAdvised}?labservicelist=$labservicelist&userId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      if (response.body == '1') {
        await getDiagnosticInvList(treatmentid);
        // var data = json.decode(response.body);
        CustomMessage.toast('Diagonosis Deleted SuccessFully');
      }
    } else {
      isLoading = false;
      debugPrint('Failed getting deleteDiagnosticIns');
    }
    update();
  }

  deletePrescriptin(unitid, prescripId, userId, treatmentid) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.deleteOPDPrescription}?unitId=$unitid&prescriptionId=$prescripId&userId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      if (response.body.contains("Records Deleted Sucessfully")) {
        await getPrescriptionList(treatmentid.toString(), unitid);
        // var data = json.decode(response.body);
        CustomMessage.toast('Records Deleted Sucessfully');
      }
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  deleteInstruction(userId, instructionId, treatmentid, patientId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.deleteInstruction}?instructionId=$instructionId&userId=$userId");

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
      if (response.body == '1') {
        await getInstructions(treatmentid, patientId);
        // var data = json.decode(response.body);
        CustomMessage.toast('Records Deleted Sucessfully');
      }
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  deleteIndivisualInst(
      userId, instructionId, treatmentid, patientId, unitId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.deleteIndivisualInstruction}?instructionIds=$instructionId&userId=$userId");

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
      var respBody = jsonDecode(response.body);
      if (respBody['Status'] == 'Success') {
        await getDefaultInstruction(unitId.toString(), treatmentid.toString());
        // var data = json.decode(response.body);

        CustomMessage.toast(respBody['Massage']);
      }
    } else {
      isLoading = false;
      debugPrint('Failed getting deleteIndivisualInst');
    }
    update();
  }

  deleteDiet(dietMasterId, userId, treatmentId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.deleteOPDDiet}?dietMasterIds=$dietMasterId&userId=$userId");

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
      var data = json.decode(response.body);
      CustomMessage.toast(data['message']);
      await getDietList(treatmentId);
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  deleteUploadedImage(
      documentId, userId, patientId, treatmentId, unitId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.deleteOPDDocuments}?documentId=$documentId&userId=$userId");

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
      // var data = json.decode(response.body);
      CustomMessage.toast("Document Deleted");

      await getUploadedDocNephro(patientId, treatmentId, unitId);
      Get.back();
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getDietDetailsOnClick(dietMasterId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.editOPDDiet}?dietMasterId=$dietMasterId");

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
      var data = json.decode(response.body);
      dietItemDet = DietListModel.fromJson(data);
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getAllTest(packageId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiNames.pkgTestName}");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response =
        await ioClient.post(uri, headers: headers, body: jsonEncode(packageId));
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      List<TestDetailsModel> testList =
          data.map((json) => TestDetailsModel.fromJson(json)).toList();
      // allTest?.addAll(testList);
      return testList;
    } else {
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

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.lisofDiagonosis}?treatmentId=$treatmentId");

    debugPrint("API URL: $uri");

    var request = http.Request('GET', uri);

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await http.Client().send(request);

      debugPrint("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        List<dynamic> responseVal = jsonDecode(responseBody);

        provisionConfirmationalList = responseVal
            .map((json) => ClinicalConditionProvisionaList.fromJson(json))
            .toList();
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
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');
      }
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

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getClinicalHistoryData}?patientId=$patientId&treatmentId=$treatmentId");

    debugPrint("API URL: $uri");

    var request = http.Request('GET', uri);

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await http.Client().send(request);

      debugPrint("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        List<dynamic> responseVal = jsonDecode(responseBody);

        clinicalHistoryList = responseVal
            .map((json) => ClinicalHistoryList.fromJson(json))
            .toList();

        debugPrint('Parsed clinical condition: ${clinicalHistoryList?.length}');
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');
      }
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
    String unit = unitId.split(',').first;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getIndivisualInstructions}?unitId=$unit&treatmentId=$treatmentId");

    debugPrint("API URL: $uri");

    var request = http.Request('GET', uri);

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await http.Client().send(request);

      debugPrint("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var responseVal = jsonDecode(responseBody);

        DefaultInstructionModel? defaultInstructionModel =
            DefaultInstructionModel.fromJson(responseVal);
        defaultInstructionList =
            defaultInstructionModel.getListOfOPDInstructionDTO;

        debugPrint('${defaultInstructionList?.length}');
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');
      }
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

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getPackageList}?unitId=$unitId");

    debugPrint("API URL: $uri");

    var request = http.Request('GET', uri);

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await http.Client().send(request);

      debugPrint("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        List<dynamic> responseVal = jsonDecode(responseBody);

        packageList =
            responseVal.map((json) => PackageListModel.fromJson(json)).toList();

        debugPrint('Parsed clinical condition: ${packageList?.length}');
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');
      }
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

    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiNames.savediagonosis}");

    final Map<String, dynamic> body = {
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
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Sending request to: $uri');
    debugPrint('Request body: $jsonbody');

    try {
      final response =
          await ioClient.post(uri, headers: headers, body: jsonbody);
      debugPrint("Response status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        // final List<dynamic> data = json.decode(response.body);
        await getClinicaConditionProvisionalList(treatmentId.toString());
        diagnosisController.clear();
        diagnoDes.clear();
        icdCodeTxtField.clear();
        diagComment.clear();
        diagType = null;
        diagDate.clear();
        Get.back();
        CustomMessage.toast(response.body);

        // nephroList = data.map((json) => NephroList.fromJson(json)).toList();
        // debugPrint('Parsed nephroList: ${nephroList?.length}');
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
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

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getDiagNosisList}?callform=diagoname&diagoName&diagoType=1");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    try {
      final response = await ioClient.get(uri, headers: headers);
      debugPrint("Response status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        diagnosisList =
            data.map((json) => GetDiagonisisList.fromJson(json)).toList();
        debugPrint('Parsed nephroList: ${nephroList?.length}');
        return diagnosisList?.map((e) => e.nameL).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
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

    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiNames.digoById}?id=$id");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    try {
      final response = await ioClient.get(uri, headers: headers);
      debugPrint("Response status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        icdCode = data.map((json) => GetDiagonisisList.fromJson(json)).toList();
        debugPrint('Parsed nephroList: ${nephroList?.length}');
        icdCodeTxtField.text = icdCode?.first.icdCodeL;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
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

    final uri = Uri.parse("${ApiConstants.ip}${ApiNames.coverSheetNephro}");

    final Map<String, dynamic> body = {
      "patientId": patientId,
      "unitId": unitId,
      "treatmentId": treatmentId,
      "serviceId": 0,
      "testType": [
        "Weight",
        "Pulse",
        "Oxygen Level",
        "Temperature",
        "Blood Pressure"
      ]
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Sending request to: $uri');
    debugPrint('Request body: $jsonbody');

    try {
      final response =
          await ioClient.post(uri, headers: headers, body: jsonbody);
      debugPrint("Response status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        coverSheetNephro = CoverSheetNephroModel.fromJson(data);

        parsedPrescriptionData = parsePrescriptionData(
            coverSheetNephro?.prescriptionList?.first.prescriptionData ?? "");

        parsedLabInvestData = parseLabData(
            coverSheetNephro?.laboratoryInvestigationList?.first.dtoData ?? "");
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
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

    final uri = Uri.parse("${ApiConstants.ip}${ApiNames.choosePackageList}");

    final Map<String, dynamic> body = {"unitId": unitId};
    String jsonbody = json.encode(body);
    Map<String, String> headers = {"Content-Type": "application/json"};

    debugPrint('Sending request to: $uri');
    debugPrint('Request body: $jsonbody');

    try {
      final response =
          await ioClient.post(uri, headers: headers, body: jsonbody);
      debugPrint("Response status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Parse the main response
        choosePackageListModel = ChoosePackageListModel.fromJson(data);

        List<dynamic> parsedData = json.decode(choosePackageListModel!.data!);
        choosePackageListModel!.parsedData =
            parsedData.map((e) => LabInvestigationPackage.fromJson(e)).toList();
        update();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
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
      // Create the custom HttpClient from ByPassCert
      HttpClient httpClient = ByPassCert().httpClient;
      IOClient ioClient = IOClient(httpClient);

      Uri uri = Uri.parse(ApiConstants.baseUrl + ApiNames.saveIpd);

      // Create a multipart request
      var request = http.MultipartRequest('POST', uri);

      // Convert list to JSON
      String requestBody = jsonEncode({"listBillDetailsIpd": testPackageList});

      // Add request body as a field
      request.fields["serviceDetails"] = requestBody;
      request.fields["queryType"] = 'insert';
      request.fields["callfrom"] = 'N';
      request.fields["module"] = '0';
      request.fields["unitId"] = unitId;
      request.fields["userId"] = userId;
      request.fields["sampleWiseBarcodes"] =
          '{"labSampleWiseMasterDtoList":[]}';
      debugPrint(request.fields.toString());
      // Add headers
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      // Send the request using the custom IOClient
      http.StreamedResponse response = await ioClient.send(request);
      final finalResp = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
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

        debugPrint("Error: ${response.statusCode} - ${finalResp.body}");
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
      // Create the custom HttpClient from ByPassCert
      HttpClient httpClient = ByPassCert().httpClient;
      IOClient ioClient = IOClient(httpClient);

      Uri uri = Uri.parse(ApiConstants.baseUrl + ApiNames.saveIpd);

      // Create a multipart request
      var request = http.MultipartRequest('POST', uri);

      // Convert list to JSON
      String requestBody = jsonEncode({
        "listBillDetailsIpd": [package]
      });

      // Add request body as a field
      request.fields["serviceDetails"] = requestBody;
      request.fields["queryType"] = 'insert';
      request.fields["callfrom"] = 'N';
      request.fields["module"] = '0';
      request.fields["unitId"] = unitId;
      request.fields["userId"] = userId;
      request.fields["sampleWiseBarcodes"] =
          '{"labSampleWiseMasterDtoList":[]}';
      debugPrint(request.fields.length.toString());
      // Add headers
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      // Send the request using the custom IOClient
      http.StreamedResponse response = await ioClient.send(request);
      final finalResp = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(finalResp.body);
        if (responseData == 1) {
          await getDiagnosticInvList(treatmentId);
        }
        debugPrint("Response: $responseData");
      } else {
        CustomMessage.toast("Test Adding Fail");

        debugPrint("Error: ${response.statusCode} - ${finalResp.body}");
      }
    } catch (error) {
      CustomMessage.toast("Test Adding Fail");

      debugPrint("Exception: $error");
    } finally {
      isLoading = false;

      update();
    }
  }

  // Future<void> getTestNameList(String treatmentId) async {
  //   isLoading = true;
  //   update();
  //
  //   final uri = Uri.parse(
  //       "${ApiConstants.baseUrl}${ApiConstants.getPatientSubServiceDetailsOnIPD}");
  //
  //   final Map<String, dynamic> body = {
  //     "treatmentId": treatmentId,
  //     "serviceId": 0
  //   };
  //   String jsonbody = json.encode(body);
  //   Map<String, String> headers = {"Content-Type": "application/json"};
  //
  //   debugPrint('Sending request to: $uri');
  //   debugPrint('Request body: $jsonbody');
  //
  //   try {
  //     final response =
  //         await ioClient.post(uri, headers: headers, body: jsonbody);
  //     debugPrint("Response status code: ${response.statusCode}");
  //     debugPrint("Response body: ${response.body}");
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       //
  //       // // Parse the main response
  //       // testNameModel = TestNameListModel.fromJson(data);
  //       // testNameList = testNameModel?.listSubServiceIpdDto;
  //
  //       update();
  //     } else {
  //       throw Exception('Failed to load data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     debugPrint("Error occurred in getListOfPackage: $e");
  //   } finally {
  //     isLoading = false;
  //     debugPrint("Loading state updated to false");
  //   }
  //
  //   update();
  // }

  getTestNameList(
    String unitId,
    String depdocdeskid,
    String findingName,
    String userId,
  ) async {
    // isLoading = true;
    // update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getallservices}?unit=$unitId&depdocdeskid=$depdocdeskid&findingName=$findingName&unitlist=&querytype=all&serviceid=0&userId=$userId");
    Map<String, String> headers = {"Content-Type": "application/json"};

    debugPrint('Sending request to: $uri');

    try {
      final response = await ioClient.post(uri, headers: headers);
      debugPrint("Response status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        //
        // Parse the main response
        testNameModel = TestListDetails.fromJson(data);
        testNameList = testNameModel?.lstService;
        return testNameList
                ?.where((area) =>
                    area.categoryName
                        ?.toLowerCase()
                        .contains(findingName.toLowerCase()) ??
                    false)
                .toList() ??
            [];
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error occurred in getListOfPackage: $e");
    } finally {
      // isLoading = false;
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
    final uri = Uri.parse("${ApiConstants.ip}${ApiNames.searchByDropDown}");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body = {"districtId": districtId};

    debugPrint('Sending request to: $uri');

    final response =
        await ioClient.post(uri, headers: headers, body: jsonEncode(body));
    debugPrint("Response status code: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      searchByModel = NephroDeskDropDown.fromJson(data);
      update();
      return true;
    } else if (response.statusCode == 401) {
      update();
      return false;
    } else {
      throw Exception('Failed getting search By list');
    }
  }

  saveTemplate(body, treatmentId) async {
    isLoading = true;
    update();

    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiNames.saveOPDiet}");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('==== SAVE DIET REQUEST ====');
    debugPrint('Sending request to: $uri');
    debugPrint('Request body: ${jsonEncode(body)}');
    debugPrint('dietMasterId being sent: ${body['dietMasterId']}');
    debugPrint('========================');

    try {
      final response =
          await ioClient.post(uri, headers: headers, body: jsonEncode(body));
      debugPrint("Response status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
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
      } else if (response.statusCode == 401) {
        CustomMessage.toast('Unauthorized request');
        update();
        return false;
      } else {
        CustomMessage.toast('Failed to save diet');
        throw Exception('Failed saving diet: ${response.statusCode}');
      }
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
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.updateDignosisStatus}?id=$id&userId=$userId&callFrom=$condtion");

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
      if (response.body.contains("Record Updated Sucessfully")) {
        CustomMessage.toast("Record Updated Sucessfully");
        await getClinicaConditionProvisionalList(treatmentId.toString());
      }
      //getDeviceDetails
      // var data = json.decode(response.body);
      // TempListModel tempListModel = TempListModel.fromJson(data);
      // tempList = tempListModel.pattemplist;
    } else {
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
      // if (isView == true) {
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
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.ip}${ApiNames.getOPDHistoryNewData}?patientId=$patientId&treatmentId=$treatmentId&clinicalHistoryId=${clinicalHistory?.clinicalHistoryId}");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isLoading = false;
      clinicalHistoryTableData = ClinicalHistoryTableData.fromJson(data);
      selectedItemsPerRow = List.generate(
          clinicalHistoryTableData!.listCliniComorBean?.length ?? 0,
          (_) => <String>[]);

      setFields(view, clinicalHistory);
      update();
    } else {
      isLoading = false;
      debugPrint('Failed getting tempList');
    }
    update();
  }

  getDiagnosticInvList(treatmentId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getPatientSubServiceDetailsOnIPD}");
    var body = {"treatmentId": treatmentId, "serviceId": 0};
    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint("API URL DD=> $uri");
    debugPrint("Request Body => $jsonbody");

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      DiagnosticInvListModel diagnosticInvListModel =
          DiagnosticInvListModel.fromJson(jsonDecode(response.body));
      diagnosticInvestList = diagnosticInvListModel.listSubServiceIpdDto;
    } else {
      isLoading = false;
      debugPrint('Failed getting getDiagnosticInvList');
    }
    update();
  }

  sendToTechnician(labservicelist, userId, treatId, patientId, unitId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.sendToPhlebotomyFromSave}?labservicelist=$labservicelist&userId=$userId&treatId=$treatId&patientId=$patientId&unitId=$unitId");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      await getDiagnosticInvList(treatId);
      if (response.body == "1") {
        CustomMessage.toast("Assigned To Technician");
      }
    } else {
      isLoading = false;
      debugPrint('Failed getting getDiagnosticInvList');
    }
    update();
  }

  saveInstructions(BuildContext context, body, treatmentId, patientId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.saveIndividualTreatmentInstruction}");

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      var resp = jsonDecode(response.body);
      if (resp['Status'] == "Success") {
        await getInstructions(treatmentId, patientId);
        showCustomSnackBar(
            topTitle: 'Save Instructions',
            context: context,
            title: '${resp['Message']}',
            img: 'assets/check 1.png');
        // CustomMessage.toast(resp['Message']);
      }
    } else {
      isLoading = false;
      debugPrint('Failed getting saveInstructions');
    }
    update();
  }

  saveIndivisualInstructions(
      body, treatmentId, patientId, BuildContext context) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.saveIndivisualInstruction}");

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      var resp = jsonDecode(response.body);
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
        // CustomMessage.toast(resp['Massage']);
        return true;
      }
    } else {
      isLoading = false;
      debugPrint('Failed getting saveIndivisualInstructions');
    }
    update();
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
      instructionsList = getInstructionsModel.lstList;
    } else {
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
