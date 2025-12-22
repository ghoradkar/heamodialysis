import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/model/blood_group/blood_data.dart';
import 'package:heamodialysis/new_registration/model/blood_group/blood_group_model.dart';
import 'package:heamodialysis/new_registration/model/common_dropdown_list.dart';
import 'package:heamodialysis/new_registration/model/dialysis_freq_model.dart';
import 'package:heamodialysis/new_registration/model/dialysis_mode/dialysis_data.dart';
import 'package:heamodialysis/new_registration/model/dialysis_mode/dialysis_mode.dart';
import 'package:heamodialysis/new_registration/model/district/district_data.dart';
import 'package:heamodialysis/new_registration/model/district/district_model.dart';
import 'package:heamodialysis/new_registration/model/division/division_data.dart';
import 'package:heamodialysis/new_registration/model/division/division_model.dart';
import 'package:heamodialysis/new_registration/model/doc_upload_list/doc_upload_list_model.dart';
import 'package:heamodialysis/new_registration/model/id_proof/Id_proof_data.dart';
import 'package:heamodialysis/new_registration/model/id_proof/id_proof_list_model.dart';
import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/new_registration/model/marital_status/marital_data.dart';
import 'package:heamodialysis/new_registration/model/marital_status/marital_status_model.dart';
import 'package:heamodialysis/new_registration/model/monthly_income_model.dart';
import 'package:heamodialysis/new_registration/model/patient_profile_photo.dart';
import 'package:heamodialysis/new_registration/model/pincode/pincode_adress_model.dart';
import 'package:heamodialysis/new_registration/model/prefix/predix_list.dart';
import 'package:heamodialysis/new_registration/model/refferedBy/referred_by_model.dart';
import 'package:heamodialysis/new_registration/model/relation/relation_data.dart';
import 'package:heamodialysis/new_registration/model/relation/relation_model.dart';
import 'package:heamodialysis/new_registration/model/relative_info_doc.dart';
import 'package:heamodialysis/new_registration/model/save_patient/save_patient_req_model.dart';
import 'package:heamodialysis/new_registration/model/schema_adopted/schema_adopted_model.dart';
import 'package:heamodialysis/new_registration/model/schema_adopted/schema_data.dart';
import 'package:heamodialysis/new_registration/model/state/state_data.dart';
import 'package:heamodialysis/new_registration/model/state/state_model.dart';
import 'package:heamodialysis/new_registration/model/taluka/taluka_data.dart';
import 'package:heamodialysis/new_registration/model/taluka/taluka_model.dart';
import 'package:heamodialysis/new_registration/model/town/town_data.dart';
import 'package:heamodialysis/new_registration/model/town/town_model.dart';
import 'package:heamodialysis/new_registration/model/view_document/view_document.dart';
import 'package:heamodialysis/new_registration/model/view_patient_model.dart';
import 'package:heamodialysis/new_registration/model/viral_status/viral_data.dart';
import 'package:heamodialysis/new_registration/model/viral_status/viral_status_model.dart';
import 'package:heamodialysis/new_registration/model/scrutiny_response.dart';
import 'package:heamodialysis/new_registration/screens/upload_document_tab.dart';
import 'package:heamodialysis/registered_patient_list/model/patient_history/regis_patient_history.dart';
import 'package:heamodialysis/registered_patient_list/screens/registered_patient_list.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class NewRegistrationController extends GetxController {
  IdProofListModel? idProofListModel;
  ViewDocument? viewDocument;
  DocUploadListModel? docUploadListModel;
  SchemaAdoptedModel? schemaAdoptedModel;
  InstituteList? instituteList;
  PredixList? predixList;
  ViralStatusModel? viralStatusModel;
  StateModel? stateModel;
  DivisionModel? divisionModel;
  DistrictModel? districtModel;
  TalukaModel? talukaModel;
  TownModel? townModel;
  DialysisFreqModel? dialysisFreqModel;
  RelationModel? relationModel;
  ReferredByModel? referredByModel;
  PatientProfilePhoto? patientProfilePhoto;
  List<RelativeInfoDoc> relativeDocList = [];
  MaritalStatusModel? maritalStatusModel;
  BloodGroupModel? bloodGroupModel;
  ViewPatientModel? viewPatientModel;
  DialysisMode? dialysisMode;
  bool isLoading = false;
  bool isChecked = false;
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  FileDetails userProfilePhoto = FileDetails(
      name: 'userProfilePhoto',
      key: 'patientImage',
      isSelected: false,
      isReq: false);

  FileDetails historyOfDialysis = FileDetails(
      name: 'Upload Document',
      key: 'previousHospitalDocument',
      isSelected: false,
      isReq: true);

  FileDetails relativeDoc = FileDetails(
      name: 'Document',
      key: 'relativeDoc',
      isSelected: false,
      isReq: false,
      ids: null,
      patientRelativeContactnoId: null);

  List<FileDetails> items = [
    // FileDetails(
    //     name: 'HHH Test Report',
    //     key: 'hhhTest',
    //     isSelected: false,
    //     isReq: true),
    // FileDetails(
    //     name: 'Consent Form',
    //     key: 'consetForm',
    //     isSelected: false,
    //     isReq: false),
    // FileDetails(
    //     name: 'Blood Test Document',
    //     key: 'bloodTest',
    //     isSelected: false,
    //     isReq: false),
    // FileDetails(
    //     name: 'Dialysis Frequency',
    //     key: 'dailysisFrequency',
    //     isSelected: false,
    //     isReq: true),
    // FileDetails(
    //     name: 'Viral Status Load',
    //     key: 'viralStatusLoad',
    //     isSelected: false,
    //     isReq: true),
  ];

  // FileDetails? uploadedFile;

  SavePatientReqModel savePatientReqModel = SavePatientReqModel();
  TextEditingController abhaNoController = TextEditingController();
  TextEditingController abhaAddressController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  // TextEditingController socEcoStat = TextEditingController();
  String? socEcoStat;

  // TextEditingController religionController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController perAddressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController perPincodeController = TextEditingController();
  TextEditingController identificationNoController = TextEditingController();
  TextEditingController mjpjayEnrollNoController = TextEditingController();

  // TextEditingController nationalityController = TextEditingController();
  TextEditingController heightFeetController = TextEditingController();
  TextEditingController heightCmController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController reffContactNoController = TextEditingController();
  TextEditingController refByNameController = TextEditingController();
  TextEditingController nephrologyController = TextEditingController();
  TextEditingController nephrologyContactNoController = TextEditingController();
  TextEditingController relativeNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController dboController = TextEditingController();

  PincodeAdressModel? pincodeAdressModel;

  RegisPatientHistory? regisPatientHistory;

  List<String> tempFilePaths = [];

  int years = 0;

  int months = 0;

  int days = 0;

  TalukaData? selectedTalukaObject;
  TalukaData? perSelectedTalukaObject;

  TownData? selectedTownObj;
  TownData? perSelectedTownObj;

  DistrictData? selectedDistObj;
  DistrictData? perSelectedDistObj;

  DivisionData? selectedDivisionObj;
  DivisionData? perSelectedDivisionObj;

  StateData? selectedStateObj;
  StateData? perSelectedStateObj;

  MaritalData? selectedMarriedObj;
  LookupItem? selectedRelifionObj;
  MonthlyIncome? selectedMonthlyIncomeObj;
  LookupItem? selectedEduObj;
  LookupItem? selectedOccuObj;

  String? selectedPerCountry;
  CommomDropdownList? commomDropdownList;
  String? selectedTownVal;

  String? selectedTalukaVal;

  String? selectedMaritalVal;
  String? selectedPerTown;

  String? selectedPerTaluka;

  String? selectedPerDist;

  String? selectedPerDivision;

  String? selectedPerState;

  String? selectedDistVal;

  String? selectedDivVal;

  String? selectedStateVal;

  String? selectedCountryVal;
  String? prefixVal;

  String? selectedInstitute;

  String? formattedDateDBO;

  String? selectedGender;

  DateTime? selectedDate;

  File? image;

  List<String> selectedCountry = ['India'];
  List<String> perSelectedCountry = ['India'];

  String? selectedSchema;

  String? selectedViralStat;

  String? selectedDialysisMode;

  String? selectedIdProof;

  String? selectedRefBy;
  String? selectedReferredBy;

  String? selectedDiaModeFreq;

  RelationData? selectedRelationObj;

  BloodData? selectedBloodObj;

  IdProofData? selectedIdProfObj;

  DialysisModeData? selectedDialysisModeObj;

  ViralData? selectedProcedureType;

  SchemaData? selectedSchemeObj;

  String? selectedNationa;

  bool isFeetChanging = false;
  bool isCmChanging = false;

  List<String> nationality = ["Indian"];

  String? selectedBlood;

  String? selectedRelation;

  File? uploadedFile;

  DateTime? selectedDate1;
  DateTime? selectedDate2;

  String? formattedDateDBOHistoryOfD;
  String? formattedDateDBO1;
  CustomRadioButtons groupVal = CustomRadioButtons.yes;

  TextEditingController hospitalName = TextEditingController();

  TextEditingController dialysisDate = TextEditingController();
  TextEditingController lastDialysisDate = TextEditingController();
  TextEditingController imagePath = TextEditingController();

  RelativeInfoDoc? relativedocInfo;

  File? patientReportFile;

  String? selectedReligion;
  String? selectedMonthlyIncome;
  String? selectedEdu;
  String? selectedOccu;

  String? mobileNoCheckMsg;

  PatientDetailsResponse? getMonthyIncomeList;

  ScrutinyResponse? scrutinyResponse;

  bool isScrutinyDefined = false;

  bool? isServiceDefined = false;

  bool isQuestionsDefined = false;

  String prettyPrintJson(Map<String, dynamic> json) {
    var encoder = const JsonEncoder.withIndent('  ');
    var jsonString = encoder.convert(json);

    // Insert newline after opening curly bracket
    // jsonString = jsonString.replaceFirst('{', '{\n');

    // Add newline after each field
    jsonString = jsonString.replaceAllMapped(RegExp(r',\n\s*'), (match) {
      return ',\n';
    });

    return jsonString;
  }

  Future<bool> getPatientHistory(patientId) async {
    isLoading = true;

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getStageByPatientId}?patientId=$patientId");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers, body: null);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      regisPatientHistory = RegisPatientHistory.fromJson(data);
      update();

      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;
      update();

      return false;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getPatientHistory');
    }
  }

  getEduSocOccuReligDropDown() async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.getNewDropdownList}");

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
      commomDropdownList =
          CommomDropdownList.fromJson(jsonDecode(response.body));
    } else {
      isLoading = false;
      debugPrint('Failed getting deleteDiagnosticIns');
    }
    update();
  }

  uploadDocuments(String? patientId, String userId, String unitId) async {
    isLoading = true;
    update();
    HttpClient httpClient = ByPassCert().httpClient;
    IOClient ioClient = IOClient(httpClient);

    Uri uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.savePatientDocuments}?files");

    // Create a multipart request
    var request = http.MultipartRequest('POST', uri);

    List<String?> selectedDocIds = items
        .where((e) =>
            e.isSelected &&
            e.file?.path.contains("com.mahadialysis.technician") == true)
        .map((e) => e.ids)
        .toList();

// Convert to comma-separated string, ignoring null ids
    String docIdString = selectedDocIds.whereType<String>().join(',');

    // Add fields
    request.fields.addAll({
      'documentChecklistId': docIdString,
      'patientId': patientId ?? "",
      'userId': userId,
      'unitId': unitId
    });

    try {
      for (int i = 0; i < items.length; i++) {
        if (items[i].isSelected &&
            items[i].file!.path.contains("com.mahadialysis.technician")) {
          request.files.add(await http.MultipartFile.fromPath(
            items[i].key,
            items[i].file!.path,
          ));
        }
      }
      // Send request
      http.StreamedResponse response = await ioClient.send(request);

      if (response.statusCode == 200) {
        isLoading = false;
        update();
        debugPrint(await response.stream.bytesToString());
      } else {
        isLoading = false;
        update();

        debugPrint('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      isLoading = false;
      update();

      debugPrint('Exception occurred: $e');
    }
  }

  savePatient(String? pageTitle, String userId) async {
    isLoading = true;
    update();

    try {
      HttpClient httpClient = ByPassCert().httpClient;
      IOClient ioClient = IOClient(httpClient);

      Uri uri =
          Uri.parse(ApiConstants.baseUrl + ApiNames.savePatientRegDetails);

      var request = http.MultipartRequest('POST', uri);
      var formattedJson = prettyPrintJson(savePatientReqModel.toJson());
      request.fields.addAll({'data': formattedJson});

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      if (userProfilePhoto.isSelected) {
        request.files.add(await http.MultipartFile.fromPath(
          userProfilePhoto.key,
          userProfilePhoto.file!.path,
        ));
      }

      if (historyOfDialysis.file != null &&
          historyOfDialysis.isSelected &&
          historyOfDialysis.file!.path
              .contains("com.mahadialysis.technician")) {
        request.files.add(await http.MultipartFile.fromPath(
          historyOfDialysis.key,
          historyOfDialysis.file!.path,
        ));
      }

      if (relativeDoc.file != null &&
          relativeDoc.isSelected &&
          relativeDoc.file!.path.contains("com.mahadialysis.technician")) {
        request.files.add(await http.MultipartFile.fromPath(
          relativeDoc.key,
          relativeDoc.file!.path,
        ));
      }

      http.StreamedResponse response = await ioClient.send(request);
      final finalResp = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(finalResp.body);
        int patientId = responseData['patid'];

        // Upload documents safely
        try {
          await uploadDocuments(
            patientId.toString(),
            userId,
            savePatientReqModel.unitId.toString(),
          );
          isLoading = false;
          update();
        } catch (e) {
          isLoading = false;
          update();

          debugPrint('uploadDocuments failed: $e');
        }

        // Get patient report safely
        try {
          await getPatientReport(patientId.toString(), userId);
        } catch (e) {
          debugPrint('getPatientReport failed: $e');
        }

        isLoading = false;
        update();
        // Continue with success UI
        if (pageTitle == "Edit Patient Details") {
          CustomMessage.toast('Updated Successfully');

          CustomPopup.showSuccessDialog(() {
            Get.off(const RegisteredPatientList());
          }, "Updated Successfully", "Please Note Patient Id $patientId");
        } else {
          CustomPopup.showSuccessDialog(() {
            CustomPopup.showConfirmationDialog(() {
              Get.off(const RegisteredPatientList());
            }, () {
              Get.off(const RegisteredPatientList());
            }, () async {
              Get.off(const RegisteredPatientList());

              final result = await OpenFile.open(patientReportFile?.path);
              debugPrint('📂 Open result: ${result.message}');
            }, "Print Report?", '', "assets/success-popup.png");
          }, "Registration Completed\nSuccessfully",
              "Please Note Patient Id $patientId");
        }
      } else {
        CustomMessage.toast('Upload failed');
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    isLoading = false;
    update();
  }

  checkDuplicateMobileNo(String mobNo) async {
    isLoading = true;
    update();
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.checkMobileNo}?mobile=$mobNo");

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
      isLoading = false;
      update();
      final data = json.decode(response.body);
      return mobileNoCheckMsg = data['message'];
    } else {
      isLoading = false;
      update();
      throw Exception('Failed getting checkDuplicateMobileNo');
    }
  }

  Future<void> getPatientReport(String patientId, String userId) async {
    isLoading = true;
    update();

    try {
      final uri = Uri.parse(
        '${ApiConstants.ip + ApiNames.generateAckReport}?patientId=$patientId&userId=$userId',
      );

      final request = http.Request('GET', uri);
      final response = await request.send();
      debugPrint(uri.path);
      if (response.statusCode == 200) {
        isLoading = false;
        update();

        final bytes = await response.stream.toBytes();
        final fileName =
            'patient_report_${DateTime.now().millisecondsSinceEpoch}.pdf';

        final dir = await getExternalStorageDirectory();
        patientReportFile = File('${dir!.path}/$fileName');
        await patientReportFile?.writeAsBytes(bytes);

        debugPrint('📄 Patient report saved: ${patientReportFile?.path}');
      } else {
        isLoading = false;

        debugPrint('❌ Download failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      isLoading = false;

      CustomMessage.toast('Download failed:');

      debugPrint('❌ Exception: $e');
    }

    isLoading = false;
    update();
  }

  checkScrutinyDefinedOrNot(String unitId) async {
    isLoading = true;
    update();

    try {
      final uri = Uri.parse(
        '${ApiConstants.ip + ApiNames.checkScrutinyDefinedOrNot}?unitId=$unitId&serviceCode=NPV',
      );

      final request = http.Request('GET', uri);
      final response = await request.send();

      if (response.statusCode == 200) {
        isLoading = false;
        update();
        var data = await response.stream.bytesToString();
        scrutinyResponse = ScrutinyResponse.fromJson(jsonDecode(data));
        if (scrutinyResponse?.status == '1' &&
            scrutinyResponse?.details != null) {
          isServiceDefined =
              scrutinyResponse?.details?.isServiceDefineOrNot == 'true';
          isScrutinyDefined =
              scrutinyResponse?.details?.isScrutinyDefineOrNot == 'true';
          isQuestionsDefined =
              scrutinyResponse?.details?.isQuestionsDefineOrNot == 'true';
        }
      } else {
        isLoading = false;
        update();

        debugPrint('${response.reasonPhrase}');
      }
    } catch (e) {
      isLoading = false;
      update();

      debugPrint('❌ Exception: $e');
    }

    isLoading = false;
    update();
  }

  Future<bool> getIdProofList() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getIdProofList);

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
      idProofListModel = IdProofListModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting id proof');
    }
  }

  getDocumentList(patientId) async {
    isLoading = true;

    final uri = Uri.parse(
        '${ApiConstants.oldBaseUrl}${ApiNames.getDocumentList}?patientId=$patientId');

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
      var data = json.decode(response.body);
      if (data is Map && data['status'] == 'Success') {
        viewDocument = ViewDocument.fromJson(data);

        ///To
        tempFilePaths.clear();
        if (viewDocument?.obj != null) {
          if (viewDocument!.obj!.isNotEmpty) {
            await downloadAndSaveFilesTemporarily(viewDocument?.obj ?? []);
          }
        }

        return true;
      }
    } else {
      isLoading = false;
      debugPrint('Failed view document');
      // throw Exception('Failed view document');
    }
    update();
  }

  Future<void> downloadAndSaveFilesTemporarily(List<dynamic> urls) async {
    try {
      // Step 1: Get the temporary directory
      Directory directory = await getTemporaryDirectory();

      for (int i = 0; i < urls.length; i++) {
        String url = urls[i][0];
        String fileName = urls[i][0].split('/').last;
        String filePath = '${directory.path}/$fileName';
        File file = File(filePath);

        // Step 2: Download each file from the list of URLs
        var response =
            await http.get(Uri.parse(ApiConstants.imageBaseUrl + url));

        // Step 3: Check if the request was successful
        if (response.statusCode == 200) {
          // Step 4: Save the file locally in the temporary directory
          await file.writeAsBytes(response.bodyBytes);
          tempFilePaths.add(filePath); //
          debugPrint('File downloaded and saved temporarily: $filePath');
        } else {
          debugPrint(
              'Failed to download file: $url, Status Code: ${response.statusCode}');
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  getDocList(isViewPatient, isEdit, int? patientId) async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.oldBaseUrl + ApiNames.getDocCheckLIst);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");
    items.clear();

    historyOfDialysis = FileDetails(
        name: 'Upload Document',
        key: 'previousHospitalDocument',
        isSelected: false,
        isReq: false);

    relativeDoc = FileDetails(
        name: 'Document', key: 'relativeDoc', isSelected: false, isReq: false);

    if (response.statusCode == 200) {
      isLoading = false;

      await getDocumentList(patientId);

      final data = json.decode(response.body);
      docUploadListModel = DocUploadListModel.fromJson(data);

      if (isViewPatient) {
        //view
        for (int i = 0; i < docUploadListModel!.data!.length; i++) {
          List<dynamic>? obj = viewDocument!.obj?.firstWhereOrNull(
              (e) => e[1] == docUploadListModel!.data?[i].docId);

          items.add(FileDetails(
            name: docUploadListModel!.data![i].docDescdetEn ?? '',
            key: "files",
            ids: obj?[1].toString(),
            // key: assignKey(docUploadListModel!.data![i].docDescdetEn) ?? '',
            isSelected: obj != null ? true : false,
            isReq:
                docUploadListModel!.data![i].requiredFlag == "Y" ? true : false,
            file: obj == null ? null : File(ApiConstants.imageBaseUrl + obj[0]),
          ));

          for (int i = 0; i < viewDocument!.obj!.length; i++) {
            if (viewDocument!.obj![i][0]
                .contains("Previous_Hospital_Document")) {
              historyOfDialysis.file =
                  File(ApiConstants.imageBaseUrl + viewDocument!.obj![i][0]);
              historyOfDialysis.isSelected = true;
              break;
            }
          }
        }
      } else {
        //edit
        if (viewDocument?.obj != null) {
          if (viewDocument!.obj!.isNotEmpty) {
            for (int i = 0; i < docUploadListModel!.data!.length; i++) {
              List<dynamic>? obj = viewDocument!.obj?.firstWhereOrNull(
                  (e) => e[1] == docUploadListModel!.data?[i].docId);
              for (int j = 0; j < tempFilePaths.length; j++) {
                String tempFileN = tempFilePaths[j].split('/').last;
                String? fileFromApi = obj?[0].split('/').last;
                bool isMatch = tempFileN == fileFromApi;
                if (isMatch) {
                  obj?[0] = tempFilePaths[j];
                }
              }

              items.add(FileDetails(
                name: docUploadListModel!.data![i].docDescdetEn ?? '',
                key: "files",
                ids: docUploadListModel!.data![i].docId.toString(),
                // key: assignKey(docUploadListModel!.data![i].docDescdetEn) ?? '',
                isSelected: obj != null ? true : false,
                isReq: docUploadListModel!.data![i].requiredFlag == "Y"
                    ? true
                    : false,
                file: obj == null ? null : File(obj[0]),
                // : File(ApiConstants.imageBaseUrl + obj[0]),
              ));
            }

            for (int i = 0; i < viewDocument!.obj!.length; i++) {
              if (viewDocument!.obj![i][0]
                  .contains("Previous_Hospital_Document")) {
                historyOfDialysis.file =
                    File(ApiConstants.imageBaseUrl + viewDocument!.obj![i][0]);
                historyOfDialysis.isSelected = true;
                break;
              }
            }
          } else {
            // if user doc not available
            for (int i = 0; i < docUploadListModel!.data!.length; i++) {
              items.add(FileDetails(
                name: docUploadListModel!.data![i].docDescdetEn ?? '',
                key: "files",
                // key: assignKey(docUploadListModel!.data![i].docDescdetEn) ?? '',
                ids: docUploadListModel!.data![i].docId.toString(),
                isSelected: false,
                isReq: docUploadListModel!.data![i].requiredFlag == "Y"
                    ? true
                    : false,
                file: null,
              ));
            }
          }
        } else {
          // new registration
          for (int i = 0; i < docUploadListModel!.data!.length; i++) {
            items.add(FileDetails(
              name: docUploadListModel!.data![i].docDescdetEn ?? '',
              key: "files",
              // key: assignKey(docUploadListModel!.data![i].docDescdetEn) ?? '',
              ids: docUploadListModel!.data![i].docId.toString(),
              isSelected: false,
              isReq: docUploadListModel!.data![i].requiredFlag == "Y"
                  ? true
                  : false,
              file: null,
            ));
          }
        }
      }

      update();
      return true;
    } else {
      isLoading = false;
      update();

      // throw Exception('Failed getting doc list');
    }
  }

  // assignKey(key) {
  //   if (key == "HHH") {
  //     return "hhhTest";
  //   } else if (key == "Consent form") {
  //     return "consetForm";
  //   } else if (key == "Blood Test Document") {
  //     return "bloodTestDoucment";
  //   } else if (key == "Dialysis Frequency") {
  //     return "dailysisFrequency";
  //   } else if (key == "Viral Load Status") {
  //     return "viralStatusLoad";
  //   }
  // }

  Future<bool> getAddressDataFromPinCode(pincode) async {
    // isLoading = true;

    final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiNames.getPincodeData}?pinCode=$pincode');

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
      // isLoading = false;

      final data = json.decode(response.body);
      pincodeAdressModel = PincodeAdressModel.fromJson(data);

      // update();
      return true;
    } else if (response.statusCode == 401) {
      // isLoading = false;
      //
      // update();

      return false;
    } else {
      // isLoading = false;
      debugPrint("Failed getting town");
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

  getInstituteList() async {
    isLoading = true;
    update();

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
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      instituteList = InstituteList.fromJson(data);

      return instituteList;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  Future<bool> getPrefixList() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getPrefixList);

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
      predixList = PredixList.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getPrefixList');
    }
  }

  Future<bool> getViralStatueList() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getViralStatus);

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
      viralStatusModel = ViralStatusModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }

  Future<bool> getDialysisModeList() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getDialysisList);

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
      dialysisMode = DialysisMode.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getDialysisModeList');
    }
  }

  Future<bool> getStateList() async {
    isLoading = true;
    update();

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getStateList);

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
      stateModel = StateModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }

  Future<bool> getDivisionList() async {
    isLoading = true;
    update();

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getDivisionList);

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
      divisionModel = DivisionModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }

  Future<bool> getDistrictList() async {
    isLoading = true;
    update();

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getDistrictList);

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

      final data = json.decode(response.body);
      districtModel = DistrictModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }

  Future<bool> getTalukaList() async {
    isLoading = true;
    update();

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getTalukaList);

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
      talukaModel = TalukaModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }

  Future<bool> getTownList() async {
    isLoading = true;
    update();

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getTownList);

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
      townModel = TownModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }

  Future<bool> getMonthlyIncome() async {
    isLoading = true;
    update(); // Notify UI about loading state

    final uri = Uri.parse("${ApiConstants.ip}${ApiNames.getAllDropDownList}");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint("API URL: $uri");

    try {
      final response = await ioClient.get(uri, headers: headers);
      debugPrint("Status Code: ${response.statusCode}");

      // Ensure proper UTF-8 decoding
      final decodedBody = utf8.decode(response.bodyBytes);
      debugPrint("Response Body: $decodedBody");

      if (response.statusCode == 200) {
        final data = json.decode(decodedBody);
        getMonthyIncomeList = PatientDetailsResponse.fromJson(data);
        isLoading = false;
        update();
        return true;
      } else {
        throw Exception('Failed to fetch Monthly Income');
      }
    } catch (e) {
      debugPrint("Error in getMonthlyIncome: $e");
      isLoading = false;
      update();
      return false;
    }
  }

  String? getEconomicStatus({
    String? educationText,
    String? occupationText,
    String? monthlyIncomeText,
  }) {
    // Check for null or "Select" values
    if (educationText == null ||
        occupationText == null ||
        monthlyIncomeText == null) {
      return '';
    }

    int monthlyInt = 0;
    int educationInt = 0;
    int occupationInt = 0;

    // Monthly Income
    switch (monthlyIncomeText) {
      case "₹1,59,586 and above":
        monthlyInt = 12;
        break;
      case "₹79,756 – ₹1,59,585":
        monthlyInt = 10;
        break;
      case "₹59,795 – ₹79,755":
        monthlyInt = 6;
        break;
      case "₹39,830 – ₹59,794":
        monthlyInt = 4;
        break;
      case "₹23,870 – ₹39,829":
        monthlyInt = 3;
        break;
      case "₹7989 – ₹23,869":
        monthlyInt = 2;
        break;
      default:
        monthlyInt = 1;
    }

    // Education
    switch (educationText) {
      case "Profession or Honours Degree":
        educationInt = 7;
        break;
      case "Graduate":
        educationInt = 6;
        break;
      case "Intermediate or Diploma":
        educationInt = 5;
        break;
      case "High School Certificate":
        educationInt = 4;
        break;
      case "Middle School Certificate":
        educationInt = 3;
        break;
      case "Primary School Certificate":
        educationInt = 2;
        break;
      default:
        educationInt = 1;
    }

    // Occupation
    switch (occupationText) {
      case "Legislators, Senior Officials, Managers":
        occupationInt = 10;
        break;
      case "Professionals":
        occupationInt = 9;
        break;
      case "Technicians, Associate Professionals":
        occupationInt = 8;
        break;
      case "Skilled Workers, Shop Owners":
        occupationInt = 6;
        break;
      case "Skilled Agricultural, Fishery Workers":
        occupationInt = 5;
        break;
      case "Craft, Trade-related Workers":
        occupationInt = 4;
        break;
      case "Plant, Machine Operators":
        occupationInt = 3;
        break;
      case "Elementary Occupations":
        occupationInt = 2;
        break;
      case "Unemployed":
        occupationInt = 1;
        break;
      default:
        occupationInt = 7;
    }

    final totalScore = monthlyInt + educationInt + occupationInt;

    // Socioeconomic status
    if (totalScore >= 26 && totalScore <= 29) return "Upper (I)";
    if (totalScore >= 16 && totalScore <= 25) return "Upper Middle (II)";
    if (totalScore >= 11 && totalScore <= 15) return "Lower Middle (III)";
    if (totalScore >= 5 && totalScore <= 10) return "Upper Lower (IV)";
    return "Lower (V)";
  }

  // String? getEconomicStatus({
  //   String? educationText,
  //   String? occupationText,
  //   String? monthlyIncomeText,
  // }) {
  //   int monthlyInt = 0;
  //   int educationInt = 0;
  //   int occupationInt = 0;
  //
  //   if (educationText == null ||
  //       occupationText == null ||
  //       monthlyIncomeText == null) {
  //     return '';
  //   }
  //
  //   // Monthly Income
  //   switch (monthlyIncomeText) {
  //     case "₹1,59,586 and above":
  //       monthlyInt = 12;
  //       break;
  //     case "₹79,756 – ₹1,59,585":
  //       monthlyInt = 10;
  //       break;
  //     case "₹59,795 – ₹79,755":
  //       monthlyInt = 6;
  //       break;
  //     case "₹39,830 – ₹59,794":
  //       monthlyInt = 4;
  //       break;
  //     case "₹23,870 – ₹39,829":
  //       monthlyInt = 3;
  //       break;
  //     case "₹7989 – ₹23,869":
  //       monthlyInt = 2;
  //       break;
  //     default:
  //       monthlyInt = 1;
  //   }
  //
  //   // Education
  //   switch (educationText) {
  //     case "Profession or Honours Degree":
  //       educationInt = 7;
  //       break;
  //     case "Graduate":
  //       educationInt = 6;
  //       break;
  //     case "Intermediate or Diploma":
  //       educationInt = 5;
  //       break;
  //     case "High School Certificate":
  //       educationInt = 4;
  //       break;
  //     case "Middle School Certificate":
  //       educationInt = 3;
  //       break;
  //     case "Primary School Certificate":
  //       educationInt = 2;
  //       break;
  //     default:
  //       educationInt = 1;
  //   }
  //
  //   // Occupation
  //   switch (occupationText) {
  //     case "Legislators, Senior Officials, Managers":
  //       occupationInt = 10;
  //       break;
  //     case "Professionals":
  //       occupationInt = 9;
  //       break;
  //     case "Technicians, Associate Professionals":
  //       occupationInt = 8;
  //       break;
  //     case "Skilled Workers, Shop Owners":
  //       occupationInt = 6;
  //       break;
  //     case "Skilled Agricultural, Fishery Workers":
  //       occupationInt = 5;
  //       break;
  //     case "Craft, Trade-related Workers":
  //       occupationInt = 4;
  //       break;
  //     case "Plant, Machine Operators":
  //       occupationInt = 3;
  //       break;
  //     case "Elementary Occupations":
  //       occupationInt = 2;
  //       break;
  //     case "Unemployed":
  //       occupationInt = 1;
  //       break;
  //     default:
  //       occupationInt = 7;
  //   }
  //
  //   final totalScore = monthlyInt + educationInt + occupationInt;
  //
  //   // Socioeconomic status
  //   if (totalScore >= 26 && totalScore <= 29) return "Upper (I)";
  //   if (totalScore >= 16 && totalScore <= 25) return "Upper Middle (II)";
  //   if (totalScore >= 11 && totalScore <= 15) return "Lower Middle (III)";
  //   if (totalScore >= 5 && totalScore <= 10) return "Upper Lower (IV)";
  //   return "Lower (V)";
  // }

  Future<bool> getDialysisFreq() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.ip + ApiNames.getAllDropDownList);

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
      dialysisFreqModel = DialysisFreqModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }

  Future<bool> getRelationList() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getRelation);

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
      relationModel = RelationModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }

  Future<bool> getRefferedBy() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getRefferedBy);

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
      referredByModel = ReferredByModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }

  getProfilePhoto(patientId) async {
    isLoading = true;

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'GET', Uri.parse(ApiConstants.baseUrl + ApiNames.capturePhoto));
    request.body = json.encode({"patientId": patientId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await ioClient.send(request);

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(await response.stream.bytesToString());
      patientProfilePhoto = PatientProfilePhoto.fromJson(data);
      // debugPrint(patientProfilePhoto?.data?.first.filePath);
    } else {
      isLoading = false;

      debugPrint(response.reasonPhrase);
    }
    update();
  }

  getRelativeInfoDoc(patientId) async {
    isLoading = true;

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiNames.viewRelativeDoc}?patientId=$patientId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await ioClient.send(request);

    if (response.statusCode == 200) {
      isLoading = false;

      List<dynamic> data = json.decode(await response.stream.bytesToString());
      relativeDocList =
          data.map((json) => RelativeInfoDoc.fromJson(json)).toList();

      if (relativeDocList.isNotEmpty) {
        relativedocInfo = relativeDocList.length == 1
            ? relativeDocList.first
            : relativeDocList.last;

        relativeDoc.ids = relativedocInfo?.realtiveId.toString();
        if (relativedocInfo?.docpath != null) {
          relativeDoc.isSelected = true;
          relativeDoc.file = relativedocInfo!.docpath != null
              ? File(ApiConstants.imageBaseUrl + relativedocInfo!.docpath!)
              : null;
          relativeDoc.patientRelativeContactnoId = relativedocInfo?.realtionId;
        } else {
          relativeDoc.isSelected = false;
          relativeDoc.file = null;
        }
      }
    } else {
      isLoading = false;
      debugPrint(response.reasonPhrase);
    }
    update();
  }

  Future<bool> getMaritalStatus() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getMaritalStatus);

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
      maritalStatusModel = MaritalStatusModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }

  viewPatientData(patientId) async {
    isLoading = true;
    update();
    final uri = Uri.parse(
        '${ApiConstants.oldBaseUrl}${ApiNames.viewPatientDetails}?patientId=$patientId');

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
      viewPatientModel = ViewPatientModel.fromJson(data);

      update();
    } else {
      isLoading = false;
      update();

      // throw Exception('Failed getting viewPatientData');
    }
  }

  Future<bool> getBloodGroupList() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getBloodGroup);

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
      bloodGroupModel = BloodGroupModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }

  refreshUi() {
    update();
  }
}
