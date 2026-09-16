import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
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
import 'package:heamodialysis/new_registration/model/gender/gender_list.dart';
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
import 'package:heamodialysis/new_registration/repository/new_registration_repository.dart';
import 'package:heamodialysis/new_registration/screen/upload_document_tab.dart';
import 'package:heamodialysis/registered_patient_list/model/patient_history/regis_patient_history.dart';
import 'package:heamodialysis/registered_patient_list/screen/registered_patient_list.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class NewRegistrationController extends GetxController {
  final NewRegistrationRepository _repository = NewRegistrationRepository();

  IdProofListModel? idProofListModel;
  ViewDocument? viewDocument;
  DocUploadListModel? docUploadListModel;
  SchemaAdoptedModel? schemaAdoptedModel;
  InstituteList? instituteList;
  PredixList? predixList;
  GenderList? genderList;
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

  List<FileDetails> items = [];

  SavePatientReqModel savePatientReqModel = SavePatientReqModel();
  TextEditingController abhaNoController = TextEditingController();
  TextEditingController abhaAddressController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  String? socEcoStat;

  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController perAddressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController perPincodeController = TextEditingController();
  TextEditingController identificationNoController = TextEditingController();
  TextEditingController mjpjayEnrollNoController = TextEditingController();

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

    jsonString = jsonString.replaceAllMapped(RegExp(r',\n\s*'), (match) {
      return ',\n';
    });

    return jsonString;
  }

  void clearAllFields() {
    debugPrint("🔴 Clearing all registration fields...");
    abhaNoController.clear();
    abhaAddressController.clear();
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    mobileController.clear();
    emailController.clear();
    addressController.clear();
    perAddressController.clear();
    pincodeController.clear();
    perPincodeController.clear();
    identificationNoController.clear();
    mjpjayEnrollNoController.clear();
    heightFeetController.clear();
    heightCmController.clear();
    weightController.clear();
    reffContactNoController.clear();
    refByNameController.clear();
    nephrologyController.clear();
    nephrologyContactNoController.clear();
    relativeNameController.clear();
    contactNoController.clear();
    dboController.clear();
    hospitalName.clear();
    dialysisDate.clear();
    lastDialysisDate.clear();

    socEcoStat = null;
    selectedMonthlyIncome = null;
    selectedMonthlyIncomeObj = null;
    selectedEdu = null;
    selectedEduObj = null;
    selectedOccu = null;
    selectedOccuObj = null;
    selectedReligion = null;
    selectedRelifionObj = null;
    prefixVal = null;
    selectedGender = null;
    selectedMaritalVal = null;
    selectedMarriedObj = null;
    selectedDate = null;
    formattedDateDBO = null;
    image = null;
    selectedSchema = null;
    selectedSchemeObj = null;
    selectedViralStat = null;
    selectedProcedureType = null;
    selectedDialysisMode = null;
    selectedDialysisModeObj = null;
    selectedIdProof = null;
    selectedIdProfObj = null;
    selectedReferredBy = null;
    selectedDiaModeFreq = null;
    selectedRelationObj = null;
    selectedBloodObj = null;
    selectedBlood = null;
    selectedRelation = null;
    selectedTownVal = null;
    selectedTownObj = null;
    selectedTalukaVal = null;
    selectedTalukaObject = null;
    selectedDistVal = null;
    selectedDistObj = null;
    selectedDivVal = null;
    selectedDivisionObj = null;
    selectedStateVal = null;
    selectedStateObj = null;
    selectedCountryVal = 'India';
    selectedPerCountry = 'India';

    userProfilePhoto.isSelected = false;
    userProfilePhoto.file = null;
    historyOfDialysis.isSelected = false;
    historyOfDialysis.file = null;
    relativeDoc.isSelected = false;
    relativeDoc.file = null;
    relativeDoc.ids = null;
    relativeDoc.patientRelativeContactnoId = null;

    for (var item in items) {
      item.isSelected = false;
      item.file = null;
    }

    years = 0;
    months = 0;
    days = 0;
    isChecked = false;
    isLoading = false;
    groupVal = CustomRadioButtons.yes;

    update();
  }

  Future<bool> getPatientHistory(patientId) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.getPatientHistory(patientId);
      isLoading = false;
      regisPatientHistory = RegisPatientHistory.fromJson(data);
      update();
      return true;
    } on ApiException catch (e) {
      isLoading = false;
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getting getPatientHistory');
    }
  }

  getEduSocOccuReligDropDown() async {
    isLoading = true;
    update();

    final result = await _repository.getEduSocOccuReligDropDown();
    if (result != null) {
      isLoading = false;
      commomDropdownList = result;
    } else {
      isLoading = false;
      debugPrint('Failed getting dropdowns');
    }
    update();
  }

  uploadDocuments(String? patientId, String userId, String unitId) async {
    isLoading = true;
    update();

    List<String?> selectedDocIds = items
        .where((e) =>
            e.isSelected &&
            e.file?.path.contains("com.mahadialysis.technician") == true)
        .map((e) => e.ids)
        .toList();

    String docIdString = selectedDocIds.whereType<String>().join(',');

    try {
      final files = <http.MultipartFile>[];
      for (int i = 0; i < items.length; i++) {
        if (items[i].isSelected &&
            items[i].file!.path.contains("com.mahadialysis.technician")) {
          files.add(await http.MultipartFile.fromPath(
            items[i].key,
            items[i].file!.path,
          ));
        }
      }

      final response = await _repository.uploadDocuments(
        docIdString: docIdString,
        patientId: patientId,
        userId: userId,
        unitId: unitId,
        files: files,
      );

      if (response.statusCode == 200) {
        debugPrint('Documents uploaded successfully');
      } else {
        debugPrint('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Exception occurred: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  savePatient(String? pageTitle, String userId) async {
    isLoading = true;
    update();

    try {
      var formattedJson = prettyPrintJson(savePatientReqModel.toJson());

      final files = <http.MultipartFile>[];
      if (userProfilePhoto.isSelected && userProfilePhoto.file != null) {
        files.add(await http.MultipartFile.fromPath(
          userProfilePhoto.key,
          userProfilePhoto.file!.path,
        ));
      }

      if (historyOfDialysis.file != null &&
          historyOfDialysis.isSelected &&
          historyOfDialysis.file!.path
              .contains("com.mahadialysis.technician")) {
        files.add(await http.MultipartFile.fromPath(
          historyOfDialysis.key,
          historyOfDialysis.file!.path,
        ));
      }

      if (relativeDoc.file != null &&
          relativeDoc.isSelected &&
          relativeDoc.file!.path.contains("com.mahadialysis.technician")) {
        files.add(await http.MultipartFile.fromPath(
          relativeDoc.key,
          relativeDoc.file!.path,
        ));
      }

      final finalResp = await _repository.savePatient(
        savePatientReqModel: savePatientReqModel,
        formattedJson: formattedJson,
        files: files,
      );

      if (finalResp.statusCode == 200) {
        final responseData = jsonDecode(finalResp.body);
        int patientId = responseData['patid'];

        await uploadDocuments(
          patientId.toString(),
          userId,
          savePatientReqModel.unitId.toString(),
        );

        await getPatientReport(patientId.toString(), userId);

        if (pageTitle == "Edit Patient Details") {
          CustomMessage.toast(l10n.regUpdatedSuccessfully);
          CustomPopup.showSuccessDialog(() {
            clearAllFields();
            Get.off(const RegisteredPatientList());
          }, l10n.regUpdatedSuccessfully,
              l10n.regPleaseNotePatientId(patientId.toString()));
        } else {
          CustomPopup.showSuccessDialog(() {
            CustomPopup.showConfirmationDialog(() {
              clearAllFields();
              Get.off(const RegisteredPatientList());
            }, () {
              clearAllFields();
              Get.off(const RegisteredPatientList());
            }, () async {
              clearAllFields();
              Get.off(const RegisteredPatientList());
              if (patientReportFile != null && patientReportFile!.existsSync()) {
                await OpenFile.open(patientReportFile?.path);
              }
            }, l10n.regPrintReport, '', "assets/success-popup.png");
          }, l10n.regRegistrationCompleted,
              l10n.regPleaseNotePatientId(patientId.toString()));
        }
      } else {
        CustomMessage.toast(l10n.regUploadFailed);
      }
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  checkDuplicateMobileNo(String mobNo) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.checkDuplicateMobileNo(mobNo);
      isLoading = false;
      update();
      return mobileNoCheckMsg = data['message'];
    } catch (e) {
      isLoading = false;
      update();
      rethrow;
    }
  }

  Future<void> getPatientReport(String patientId, String userId) async {
    isLoading = true;
    update();

    try {
      final bytes = await _repository.getPatientReportBytes(patientId, userId);
      if (bytes != null) {
        final fileName =
            'patient_report_${DateTime.now().millisecondsSinceEpoch}.pdf';

        final dir = await getExternalStorageDirectory();
        patientReportFile = File('${dir!.path}/$fileName');
        await patientReportFile?.writeAsBytes(bytes);
        debugPrint('📄 Patient report saved: ${patientReportFile?.path}');
      } else {
        debugPrint('❌ Download failed');
      }
    } catch (e) {
      debugPrint('❌ Exception: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  checkScrutinyDefinedOrNot(String unitId) async {
    isLoading = true;
    update();

    try {
      final result = await _repository.checkScrutinyDefinedOrNot(unitId);
      if (result != null) {
        scrutinyResponse = result;
        if (scrutinyResponse?.status == '1' &&
            scrutinyResponse?.details != null) {
          isServiceDefined =
              scrutinyResponse?.details?.isServiceDefineOrNot == 'true';
          isScrutinyDefined =
              scrutinyResponse?.details?.isScrutinyDefineOrNot == 'true';
          isQuestionsDefined =
              scrutinyResponse?.details?.isQuestionsDefineOrNot == 'true';
        }
      }
    } catch (e) {
      debugPrint('❌ Exception: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<bool> getIdProofList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getIdProofList, IdProofListModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        idProofListModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  getDocumentList(patientId) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.getDocumentList(patientId);
      isLoading = false;
      if (data != null) {
        viewDocument = ViewDocument.fromJson(data);
        tempFilePaths.clear();
        if (viewDocument?.obj != null && viewDocument!.obj!.isNotEmpty) {
          await downloadAndSaveFilesTemporarily(viewDocument?.obj ?? []);
        }
        update();
        return true;
      }
      update();
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  Future<void> downloadAndSaveFilesTemporarily(List<dynamic> urls) async {
    try {
      Directory directory = await getTemporaryDirectory();

      for (int i = 0; i < urls.length; i++) {
        String url = urls[i][0];
        String fileName = urls[i][0].split('/').last;
        String filePath = '${directory.path}/$fileName';
        File file = File(filePath);

        var response =
            await _repository.downloadFile(ApiConstants.imageBaseUrl + url);

        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);
          tempFilePaths.add(filePath);
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  getDocList(isViewPatient, isEdit, int? patientId) async {
    isLoading = true;
    update();

    items.clear();

    historyOfDialysis = FileDetails(
        name: 'Upload Document',
        key: 'previousHospitalDocument',
        isSelected: false,
        isReq: false);

    relativeDoc = FileDetails(
        name: 'Document', key: 'relativeDoc', isSelected: false, isReq: false);

    try {
      final data = await _repository.getDocList();

      if (data != null) {
        await getDocumentList(patientId);
        docUploadListModel = DocUploadListModel.fromJson(data);

        if (isViewPatient) {
          for (int i = 0; i < docUploadListModel!.data!.length; i++) {
            List<dynamic>? obj = viewDocument?.obj?.firstWhereOrNull(
                (e) => e[1] == docUploadListModel!.data?[i].docId);

            items.add(FileDetails(
              name: docUploadListModel!.data![i].docDescdetEn ?? '',
              key: "files",
              ids: obj?[1].toString(),
              isSelected: obj != null ? true : false,
              isReq: docUploadListModel!.data![i].requiredFlag == "Y" ? true : false,
              file: obj == null ? null : File(ApiConstants.imageBaseUrl + obj[0]),
            ));
          }

          if (viewDocument?.obj != null) {
            for (int i = 0; i < viewDocument!.obj!.length; i++) {
              if (viewDocument!.obj![i][0].contains("Previous_Hospital_Document")) {
                historyOfDialysis.file = File(ApiConstants.imageBaseUrl + viewDocument!.obj![i][0]);
                historyOfDialysis.isSelected = true;
                break;
              }
            }
          }
        } else {
          if (viewDocument?.obj != null && viewDocument!.obj!.isNotEmpty) {
            for (int i = 0; i < docUploadListModel!.data!.length; i++) {
              List<dynamic>? obj = viewDocument!.obj?.firstWhereOrNull(
                  (e) => e[1] == docUploadListModel!.data?[i].docId);

              if (obj != null) {
                for (int j = 0; j < tempFilePaths.length; j++) {
                  String tempFileN = tempFilePaths[j].split('/').last;
                  String? fileFromApi = obj[0].split('/').last;
                  if (tempFileN == fileFromApi) {
                    obj[0] = tempFilePaths[j];
                  }
                }
              }

              items.add(FileDetails(
                name: docUploadListModel!.data![i].docDescdetEn ?? '',
                key: "files",
                ids: docUploadListModel!.data![i].docId.toString(),
                isSelected: obj != null ? true : false,
                isReq: docUploadListModel!.data![i].requiredFlag == "Y" ? true : false,
                file: obj == null ? null : File(obj[0]),
              ));
            }

            for (int i = 0; i < viewDocument!.obj!.length; i++) {
              if (viewDocument!.obj![i][0].contains("Previous_Hospital_Document")) {
                historyOfDialysis.file = File(ApiConstants.imageBaseUrl + viewDocument!.obj![i][0]);
                historyOfDialysis.isSelected = true;
                break;
              }
            }
          } else {
            for (int i = 0; i < docUploadListModel!.data!.length; i++) {
              items.add(FileDetails(
                name: docUploadListModel!.data![i].docDescdetEn ?? '',
                key: "files",
                ids: docUploadListModel!.data![i].docId.toString(),
                isSelected: false,
                isReq: docUploadListModel!.data![i].requiredFlag == "Y" ? true : false,
                file: null,
              ));
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error in getDocList: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<bool> getAddressDataFromPinCode(pincode) async {
    try {
      final result = await _repository.getAddressDataFromPinCode(pincode);
      if (result != null) {
        pincodeAdressModel = result;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getSchemaAdoptedList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getSchemaAdoptedList,
          SchemaAdoptedModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        schemaAdoptedModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  getInstituteList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getInstituteList, InstituteList.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        instituteList = result;
        return instituteList;
      }
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  Future<bool> getPrefixList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getPrefixList, PredixList.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        predixList = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> getGenderList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getGenderList, GenderList.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        genderList = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> getViralStatueList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getViralStatus, ViralStatusModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        viralStatusModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> getDialysisModeList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getDialysisList, DialysisMode.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        dialysisMode = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> getStateList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getStateList, StateModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        stateModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> getDivisionList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getDivisionList, DivisionModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        divisionModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> getDistrictList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getDistrictList, DistrictModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        districtModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> getTalukaList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getTalukaList, TalukaModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        talukaModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> getTownList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getTownList, TownModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        townModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> getMonthlyIncome() async {
    isLoading = true;
    update();

    try {
      final data = await _repository.getMonthlyIncome();
      if (data != null) {
        getMonthyIncomeList = PatientDetailsResponse.fromJson(data);
        isLoading = false;
        update();
        return true;
      } else {
        isLoading = false;
        update();
        return false;
      }
    } catch (e) {
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
    if (educationText == null ||
        occupationText == null ||
        monthlyIncomeText == null) {
      return '';
    }

    int monthlyInt = 0;
    int educationInt = 0;
    int occupationInt = 0;

    switch (monthlyIncomeText) {
      case "₹1,59,586 and above": monthlyInt = 12; break;
      case "₹79,756 – ₹1,59,585": monthlyInt = 10; break;
      case "₹59,795 – ₹79,755": monthlyInt = 6; break;
      case "₹39,830 – ₹59,794": monthlyInt = 4; break;
      case "₹23,870 – ₹39,829": monthlyInt = 3; break;
      case "₹7989 – ₹23,869": monthlyInt = 2; break;
      default: monthlyInt = 1;
    }

    switch (educationText) {
      case "Profession or Honours Degree": educationInt = 7; break;
      case "Graduate": educationInt = 6; break;
      case "Intermediate or Diploma": educationInt = 5; break;
      case "High School Certificate": educationInt = 4; break;
      case "Middle School Certificate": educationInt = 3; break;
      case "Primary School Certificate": educationInt = 2; break;
      default: educationInt = 1;
    }

    switch (occupationText) {
      case "Legislators, Senior Officials, Managers": occupationInt = 10; break;
      case "Professionals": occupationInt = 9; break;
      case "Technicians, Associate Professionals": occupationInt = 8; break;
      case "Skilled Workers, Shop Owners": occupationInt = 6; break;
      case "Skilled Agricultural, Fishery Workers": occupationInt = 5; break;
      case "Craft, Trade-related Workers": occupationInt = 4; break;
      case "Plant, Machine Operators": occupationInt = 3; break;
      case "Elementary Occupations": occupationInt = 2; break;
      case "Unemployed": occupationInt = 1; break;
      default: occupationInt = 7;
    }

    final totalScore = monthlyInt + educationInt + occupationInt;

    if (totalScore >= 26 && totalScore <= 29) return "Upper (I)";
    if (totalScore >= 16 && totalScore <= 25) return "Upper Middle (II)";
    if (totalScore >= 11 && totalScore <= 15) return "Lower Middle (III)";
    if (totalScore >= 5 && totalScore <= 10) return "Upper Lower (IV)";
    return "Lower (V)";
  }

  Future<bool> getDialysisFreq() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.ip + ApiNames.getAllDropDownList, DialysisFreqModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        dialysisFreqModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> getRelationList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getRelation, RelationModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        relationModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> getRefferedBy() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getRefferedBy, ReferredByModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        referredByModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  getProfilePhoto(patientId) async {
    isLoading = true;
    update();

    try {
      final result = await _repository.getProfilePhoto(patientId);
      if (result != null) {
        patientProfilePhoto = result;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  getRelativeInfoDoc(patientId) async {
    isLoading = true;
    update();

    try {
      final result = await _repository.getRelativeInfoDoc(patientId);
      if (result != null) {
        relativeDocList = result;

        if (relativeDocList.isNotEmpty) {
          relativedocInfo = relativeDocList.length == 1
              ? relativeDocList.first
              : relativeDocList.last;

          relativeDoc.ids = relativedocInfo?.realtiveId.toString();
          if (relativedocInfo?.docpath != null) {
            relativeDoc.isSelected = true;
            relativeDoc.file = File(ApiConstants.imageBaseUrl + relativedocInfo!.docpath!);
            relativeDoc.patientRelativeContactnoId = relativedocInfo?.realtionId;
          } else {
            relativeDoc.isSelected = false;
            relativeDoc.file = null;
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<bool> getMaritalStatus() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getMaritalStatus, MaritalStatusModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        maritalStatusModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  viewPatientData(patientId) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.viewPatientData(patientId);
      isLoading = false;
      if (data != null) {
        viewPatientModel = ViewPatientModel.fromJson(data);
      }
      update();
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  Future<bool> getBloodGroupList() async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchModel(
          ApiConstants.baseUrl + ApiNames.getBloodGroup, BloodGroupModel.fromJson);
      isLoading = false;
      update();
      if (result != null) {
        bloodGroupModel = result;
        return true;
      }
      return false;
    } catch (e) {
      isLoading = false;
      update();
      return false;
    }
  }

  refreshUi() {
    update();
  }
}
