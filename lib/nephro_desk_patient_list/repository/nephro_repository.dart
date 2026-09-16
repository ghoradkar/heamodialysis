import 'dart:convert';

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
import 'package:heamodialysis/nephro_desk_patient_list/screen/nephro_desk_dropdown.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/clinical_history.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/auth_token_manager.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class NephroRepository {
  Future<http.Response> uploadDocuments({
    required String obj,
    required String patientId,
    required String treatmentId,
    String? filePath,
  }) async {
    final ioClient = IOClient(ByPassCert().httpClient);
    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.saveDoctorDeskDocument);

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll({'obj': obj});
    request.fields.addAll({'patientId': patientId});
    request.fields.addAll({'treatmentId': treatmentId});
    request.headers.addAll({'Content-Type': 'multipart/form-data'});
    request.headers.addAll(AuthTokenManager().authHeaders);

    if (filePath != null) {
      request.files.add(await http.MultipartFile.fromPath('uploadOpdDocs', filePath));
    }

    final response = await ioClient.send(request);
    return http.Response.fromStream(response);
  }

  Future<List<DialysisEventDetaislModel>?> getPatientDet(
      String treatmentId, String patientId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.patientDetailsbyid}?treatmentId=$treatmentId&patientId=$patientId");

    if (response.statusCode == 200) {
      if (json.decode(response.body) is List) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => DialysisEventDetaislModel.fromJson(json)).toList();
      }
      return null;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> getClinicalHistoryStat(String patientId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getClinicalHistoryFlag}?patientId=$patientId");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<NephroList>> getDoctorList(String unitId) async {
    final url = "${ApiConstants.ip}${ApiNames.doctorDeskPatientList}"
        "?inputValue"
        "&startIndex=0"
        "&callFrom=DOD"
        "&searchType"
        "&unitId=$unitId";
    final response = await ApiClient().get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => NephroList.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<NephroList>> getNephroList(String type, String input,
      String unitId, String districtId, String? status) async {
    final response = await ApiClient().post(
      "${ApiConstants.ip}${ApiNames.nephroList}",
      body: {
        "searchType": type,
        "inputValue": input,
        "unitId": unitId,
        "pendingFlag": status,
        "districtId": districtId,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => NephroList.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: this call was never routed
  /// through the SSL-bypass client, so it keeps using plain http.get
  /// with the same hardcoded Cookie header.
  Future<List<NephroList>?> getDoctorSearchList(
      String searchType, String inputValue, String unitId) async {
    final uri = Uri.parse("${ApiConstants.ip}${ApiNames.doctorDeskPatientList}")
        .replace(queryParameters: {
      "inputValue": inputValue,
      "startIndex": "0",
      "callFrom": "DOD",
      "searchType": searchType,
      "unitId": unitId,
    });

    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Cookie': 'SESSION=ZDkzYTM1ZmMtMzNkYi00MzAxLWFiMjYtYjJjNGQ1NDM0YjQz',
      ...AuthTokenManager().authHeaders,
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => NephroList.fromJson(e)).toList();
    }
    return null;
  }

  Future<String> saveClinicalHistory(body) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.saveOPDHistoryNew}",
      body: body,
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<AddDetailsTable>> getDiseaseList() async {
    final response =
        await ApiClient().get("${ApiConstants.baseUrl}${ApiNames.getDiseaseDetails}");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => AddDetailsTable.fromJson(item)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<PatientRelationListM> getRelationAndDietList() async {
    final response =
        await ApiClient().get("${ApiConstants.baseUrl}${ApiNames.getDropForOPDHistory}");

    if (response.statusCode == 200) {
      return PatientRelationListM.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<TempListModel> getTempList() async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getTemplateListByDepartmentId}?departmentId=1");

    if (response.statusCode == 200) {
      return TempListModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> checkDuplicateTest(String patientId, String treatmentId,
      String subServiceId, String unitId, String userId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.cehckSavedTestUrl}?patienttId=$patientId&treatmentId=$treatmentId&subServiceId=$subServiceId&unitId=$unitId&userId=$userId");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> checkDuplicatePackage(
      String patientId, String treatmentId, String packageId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.checkPackgeSavedUrl}?patienttId=$patientId&treatmentId=$treatmentId&packageId=$packageId");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<PrescriptionListModel> getPrescriptionList(treatmentId, unitId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getAllPrescriptionsByTreatmentId}?treatmentId=$treatmentId&unitId=$unitId");

    if (response.statusCode == 200) {
      return PrescriptionListModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<PrepListModel> getPrepList() async {
    final response =
        await ApiClient().get("${ApiConstants.baseUrl}${ApiNames.fetchpreparationmaster}");

    if (response.statusCode == 200) {
      return PrepListModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<MedicationMethod>> getMedicationList() async {
    final response =
        await ApiClient().get("${ApiConstants.baseUrl}${ApiNames.getMedicationMethod}");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => MedicationMethod.fromJson(item as Map<String, dynamic>)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<PrepUnitModel> getUnitList() async {
    final response = await ApiClient().get("${ApiConstants.baseUrl}${ApiNames.fetchAllUnits}");

    if (response.statusCode == 200) {
      return PrepUnitModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<MedicineNameModel> getMedicineNameList(String letter) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getMedicinesWithGeneric}?letter=$letter&genericFlag=N=1");

    if (response.statusCode == 200) {
      return MedicineNameModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<PrescriptionInstructionModel> getPrescInstruction() async {
    final response = await ApiClient()
        .get("${ApiConstants.baseUrl}${ApiNames.getIntsructionsForPrescriptions}");

    if (response.statusCode == 200) {
      return PrescriptionInstructionModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<RouteListModel> getRouteList(unitId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getAllRoutesForPrescription}?unitId=$unitId");

    if (response.statusCode == 200) {
      return RouteListModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> addPrescription(body) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.saveOPDPrescription}",
      body: body,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<MedicineDataById> getMedicineDataById(String productId) async {
    final response = await ApiClient()
        .get("${ApiConstants.baseUrl}${ApiNames.getMedicineById}?productId=$productId");

    if (response.statusCode == 200) {
      return MedicineDataById.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// This endpoint's response was never parsed in the original controller
  /// (dead assignment) - preserved as-is, just moved.
  Future<int> getUploadedDocList(patientId, treatmentId, unitId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getAllOPDDocuments}?patientId=$patientId&treatmentId=$treatmentId&unitId=$unitId");
    return response.statusCode;
  }

  Future<DietListModel> getDietList(treatmentId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getOPDDietListByTreatmentId}?treatmentId=$treatmentId");

    if (response.statusCode == 200) {
      return DietListModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<dynamic> getTreatmentId(patientId) async {
    final response = await ApiClient().post(
      "${ApiConstants.ip}${ApiNames.getTreatmentId}",
      body: {"patientId": patientId},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<UploadedDocumentNephro>> getUploadedDocNephro(
      patientId, treatmentId, unitId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getAllOPDDocuments}?patientId=$patientId&treatmentId=$treatmentId&unitId=$unitId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => UploadedDocumentNephro.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: this download was never
  /// routed through the SSL-bypass client, so it keeps using a plain
  /// http.Request.
  Future<List<int>?> viewUploadedDocBytes(String fileName, String documentId) async {
    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiNames.viewOpdDocuments}?fileName=$fileName&documentId=$documentId",
    );
    final response = await (http.Request('GET', uri)
          ..headers.addAll(AuthTokenManager().authHeaders))
        .send();

    if (response.statusCode == 200) {
      return response.stream.toBytes();
    }
    return null;
  }

  /// Unchanged from the original controller: this download was never
  /// routed through the SSL-bypass client, so it keeps using a plain
  /// http.Request.
  Future<List<int>?> viewCtReoprtBytes(
      String unitId, String patientId, String treatId, String userId) async {
    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiNames.ctReport}?unitId=$unitId&patientId=$patientId&treatId=$treatId&userId=$userId",
    );
    final response = await (http.Request('GET', uri)
          ..headers.addAll(AuthTokenManager().authHeaders))
        .send();

    if (response.statusCode == 200) {
      return response.stream.toBytes();
    }
    return null;
  }

  Future<String> deleteClinicalCondi(id) async {
    final response = await ApiClient()
        .get("${ApiConstants.baseUrl}${ApiNames.deleteDiagonosis}?id=$id");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> deleteDiagnosticIns(labservicelist, userId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.deleteIpdServicesAdvised}?labservicelist=$labservicelist&userId=$userId");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> deletePrescriptin(unitid, prescripId, userId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.deleteOPDPrescription}?unitId=$unitid&prescriptionId=$prescripId&userId=$userId");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> deleteInstruction(userId, instructionId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.deleteInstruction}?instructionId=$instructionId&userId=$userId");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> deleteIndivisualInst(userId, instructionId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.deleteIndivisualInstruction}?instructionIds=$instructionId&userId=$userId");

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> deleteDiet(dietMasterId, userId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.deleteOPDDiet}?dietMasterIds=$dietMasterId&userId=$userId");

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<void> deleteUploadedImage(documentId, userId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.deleteOPDDocuments}?documentId=$documentId&userId=$userId");

    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
  }

  Future<DietListModel> getDietDetailsOnClick(dietMasterId) async {
    final response = await ApiClient()
        .get("${ApiConstants.baseUrl}${ApiNames.editOPDDiet}?dietMasterId=$dietMasterId");

    if (response.statusCode == 200) {
      return DietListModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<TestDetailsModel>> getAllTest(packageId) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.pkgTestName}",
      body: packageId,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => TestDetailsModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: this call was never routed
  /// through the SSL-bypass client, so it keeps using a plain http.Client.
  Future<List<ClinicalConditionProvisionaList>> getClinicaConditionProvisionalList(
      String treatmentId) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.lisofDiagonosis}?treatmentId=$treatmentId");
    final request = http.Request('GET', uri);
    request.headers.addAll({'Content-Type': 'application/json'});
    request.headers.addAll(AuthTokenManager().authHeaders);

    final response = await http.Client().send(request);
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final List<dynamic> responseVal = jsonDecode(responseBody);
      return responseVal.map((json) => ClinicalConditionProvisionaList.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.reasonPhrase ?? '');
  }

  /// Unchanged from the original controller: this call was never routed
  /// through the SSL-bypass client, so it keeps using a plain http.Client.
  Future<List<ClinicalHistoryList>> getClinicalHistoryList(
      String? patientId, String? treatmentId) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getClinicalHistoryData}?patientId=$patientId&treatmentId=$treatmentId");
    final request = http.Request('GET', uri);
    request.headers.addAll({'Content-Type': 'application/json'});
    request.headers.addAll(AuthTokenManager().authHeaders);

    final response = await http.Client().send(request);
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final List<dynamic> responseVal = jsonDecode(responseBody);
      return responseVal.map((json) => ClinicalHistoryList.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.reasonPhrase ?? '');
  }

  /// Unchanged from the original controller: this call was never routed
  /// through the SSL-bypass client, so it keeps using a plain http.Client.
  Future<DefaultInstructionModel> getDefaultInstruction(
      String unitId, String? treatmentId) async {
    final unit = unitId.split(',').first;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getIndivisualInstructions}?unitId=$unit&treatmentId=$treatmentId");
    final request = http.Request('GET', uri);
    request.headers.addAll({'Content-Type': 'application/json'});
    request.headers.addAll(AuthTokenManager().authHeaders);

    final response = await http.Client().send(request);
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return DefaultInstructionModel.fromJson(jsonDecode(responseBody));
    }
    throw ApiException(response.statusCode, response.reasonPhrase ?? '');
  }

  /// Unchanged from the original controller: this call was never routed
  /// through the SSL-bypass client, so it keeps using a plain http.Client.
  Future<List<PackageListModel>> getPackageList(String? unitId) async {
    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.getPackageList}?unitId=$unitId");
    final request = http.Request('GET', uri);
    request.headers.addAll({'Content-Type': 'application/json'});
    request.headers.addAll(AuthTokenManager().authHeaders);

    final response = await http.Client().send(request);
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final List<dynamic> responseVal = jsonDecode(responseBody);
      return responseVal.map((json) => PackageListModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.reasonPhrase ?? '');
  }

  Future<String> addClinicalCondition(Map<String, dynamic> body) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.savediagonosis}",
      body: body,
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<GetDiagonisisList>> getDiagNosisList() async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getDiagNosisList}?callform=diagoname&diagoName&diagoType=1");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => GetDiagonisisList.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<GetDiagonisisList>> getICDCode(String id) async {
    final response =
        await ApiClient().get("${ApiConstants.baseUrl}${ApiNames.digoById}?id=$id");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => GetDiagonisisList.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<CoverSheetNephroModel> getCoverSheetNephro(
      String? patientId, String? treatmentId, String unitId) async {
    final response = await ApiClient().post(
      "${ApiConstants.ip}${ApiNames.coverSheetNephro}",
      body: {
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
      },
    );

    if (response.statusCode == 200) {
      return CoverSheetNephroModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<ChoosePackageListModel> getListOfPackage(String? unitId) async {
    final response = await ApiClient().post(
      "${ApiConstants.ip}${ApiNames.choosePackageList}",
      body: {"unitId": unitId},
    );

    if (response.statusCode == 200) {
      return ChoosePackageListModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: builds its own ByPassCert
  /// IOClient for this multipart upload, same as before.
  Future<http.Response> saveTestPackage({
    required List<AddTestPackageModel> testPackageList,
    required String unitId,
    required String userId,
  }) async {
    final ioClient = IOClient(ByPassCert().httpClient);
    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.saveIpd);

    final request = http.MultipartRequest('POST', uri);
    request.fields["serviceDetails"] =
        jsonEncode({"listBillDetailsIpd": testPackageList});
    request.fields["queryType"] = 'insert';
    request.fields["callfrom"] = 'N';
    request.fields["module"] = '0';
    request.fields["unitId"] = unitId;
    request.fields["userId"] = userId;
    request.fields["sampleWiseBarcodes"] = '{"labSampleWiseMasterDtoList":[]}';
    request.headers.addAll({'Content-Type': 'multipart/form-data'});
    request.headers.addAll(AuthTokenManager().authHeaders);

    final response = await ioClient.send(request);
    return http.Response.fromStream(response);
  }

  /// Unchanged from the original controller: builds its own ByPassCert
  /// IOClient for this multipart upload, same as before.
  Future<http.Response> savePackage({
    required AddTestPackageModel package,
    required String unitId,
    required String userId,
  }) async {
    final ioClient = IOClient(ByPassCert().httpClient);
    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.saveIpd);

    final request = http.MultipartRequest('POST', uri);
    request.fields["serviceDetails"] = jsonEncode({
      "listBillDetailsIpd": [package]
    });
    request.fields["queryType"] = 'insert';
    request.fields["callfrom"] = 'N';
    request.fields["module"] = '0';
    request.fields["unitId"] = unitId;
    request.fields["userId"] = userId;
    request.fields["sampleWiseBarcodes"] = '{"labSampleWiseMasterDtoList":[]}';
    request.headers.addAll({'Content-Type': 'multipart/form-data'});
    request.headers.addAll(AuthTokenManager().authHeaders);

    final response = await ioClient.send(request);
    return http.Response.fromStream(response);
  }

  Future<List<LstService>?> getTestNameList(
      String unitId, String depdocdeskid, String findingName, String userId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.getallservices}?unit=$unitId&depdocdeskid=$depdocdeskid&findingName=$findingName&unitlist=&querytype=all&serviceid=0&userId=$userId");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final testNameModel = TestListDetails.fromJson(data);
      return testNameModel.lstService;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<NephroDeskDropDown> searchByDropDownList(districtId) async {
    final response = await ApiClient().post(
      "${ApiConstants.ip}${ApiNames.searchByDropDown}",
      body: {"districtId": districtId},
    );

    if (response.statusCode == 200) {
      return NephroDeskDropDown.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> saveTemplate(body) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.saveOPDiet}",
      body: body,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> updateCondtion(id, userId, condtion) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.updateDignosisStatus}?id=$id&userId=$userId&callFrom=$condtion");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<DiagnosticInvListModel> getDiagnosticInvList(treatmentId) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.getPatientSubServiceDetailsOnIPD}",
      body: {"treatmentId": treatmentId, "serviceId": 0},
    );

    if (response.statusCode == 200) {
      return DiagnosticInvListModel.fromJson(jsonDecode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> sendToTechnician(
      labservicelist, userId, treatId, patientId, unitId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.sendToPhlebotomyFromSave}?labservicelist=$labservicelist&userId=$userId&treatId=$treatId&patientId=$patientId&unitId=$unitId");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> saveInstructions(body) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.saveIndividualTreatmentInstruction}",
      body: body,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> saveIndivisualInstructions(body) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.saveIndivisualInstruction}",
      body: body,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> getClinicalHistoryTableData(
      patientId, treatmentId, clinicalHistoryId) async {
    final response = await ApiClient().get(
        "${ApiConstants.ip}${ApiNames.getOPDHistoryNewData}?patientId=$patientId&treatmentId=$treatmentId&clinicalHistoryId=$clinicalHistoryId");

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<GetInstructionsModel> getInstructions(treatmentId, patientId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.fetchinstruction}?treatmentId=$treatmentId&patientId=$patientId");

    if (response.statusCode == 200) {
      return GetInstructionsModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }
}
