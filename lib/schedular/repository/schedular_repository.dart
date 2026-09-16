import 'dart:convert';

import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/new_registration/model/schema_adopted/schema_adopted_model.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screen/add_edit_ro_desinfec_details.dart';
import 'package:heamodialysis/schedular/model/add_schedular_request.dart';
import 'package:heamodialysis/schedular/model/consultation_model.dart';
import 'package:heamodialysis/schedular/model/coversheet_prescription_det.dart';
import 'package:heamodialysis/schedular/model/diet_details_coversheet.dart';
import 'package:heamodialysis/schedular/model/lab_invest_model.dart';
import 'package:heamodialysis/schedular/model/new_stages_model.dart';
import 'package:heamodialysis/schedular/model/patient_history_upload_doc.dart';
import 'package:heamodialysis/schedular/model/post_dialysis_schedular.dart';
import 'package:heamodialysis/schedular/model/scheduar_chartdata.dart';
import 'package:heamodialysis/schedular/model/schedular_pre_dialysis_history.dart';
import 'package:heamodialysis/schedular/model/slot_for_search.dart';
import 'package:heamodialysis/schedular/model/slot_time_model.dart';
import 'package:heamodialysis/schedular/model/visit_patient_detalis.dart';
import 'package:heamodialysis/schedular/model/visitor_docid_model.dart';
import 'package:heamodialysis/schedular/model/visitor_entry_data.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/get_instructions_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/auth_token_manager.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class SchedularRepository {
  Future<List<ScheduarChartData>> chartData(unitId, fromD, toD, slotId) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl1}${ApiNames.chartData}",
      body: {"unitId": unitId, "fromDate": fromD, "toDate": toD, "slotId": slotId},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ScheduarChartData.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<VisitorEntryData> getVisitorEntryData(
      int patientId, int treatmentId) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.viewPatientDetailsNew,
      body: {"patientId": patientId, "treatmentId": treatmentId},
    );

    if (response.statusCode == 200) {
      return VisitorEntryData.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<NewStagesModel>> getPatientStages(int? patientId) async {
    final response = await ApiClient().post(
      "${ApiConstants.ip}${ApiNames.patientStage}",
      body: {"patientId": patientId},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => NewStagesModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<SchemaAdoptedModel> getSchemaAdoptedList() async {
    final response = await ApiClient()
        .get(ApiConstants.baseUrl + ApiNames.getSchemaAdoptedList);

    if (response.statusCode == 200) {
      return SchemaAdoptedModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<ConsultationModel> getConsultation(treatmentId) async {
    final response = await ApiClient().post(
      "${ApiConstants.ip}${ApiNames.consultationDetails}",
      body: {"treatmentId": treatmentId},
    );

    if (response.statusCode == 200) {
      return ConsultationModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<SchedularPreDialysisHistory> getPreDialysisSchedular(treatmentId) async {
    final response = await ApiClient().post(
      "${ApiConstants.ip}${ApiNames.schedularPreDialysisHistory}",
      body: {"treatmentId": treatmentId},
    );

    if (response.statusCode == 200) {
      return SchedularPreDialysisHistory.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<PostDialysisSchedular> getPostDialysisSchedular(treatmentId) async {
    final response = await ApiClient().post(
      "${ApiConstants.ip}${ApiNames.schedularPostDialysisHistory}",
      body: {"treatmentId": treatmentId},
    );

    if (response.statusCode == 200) {
      return PostDialysisSchedular.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<PatientHistoryUploadDoc>> getUploadedDocList(
      patientId, treatmentId, unitId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getAllOPDDocuments}?patientId=$patientId&treatmentId=$treatmentId&unitId=$unitId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => PatientHistoryUploadDoc.fromJson(item)).toList();
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

  Future<GetInstructionsModel> getInstructions(treatmentId, patientId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.fetchinstruction}?treatmentId=$treatmentId&patientId=$patientId");

    if (response.statusCode == 200) {
      return GetInstructionsModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<dynamic>> getPrePostCoversheet(
      String patientId, String unitId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.getPatientDisHist}?patientId=$patientId&unitId=$unitId");

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: this download was never
  /// routed through the SSL-bypass client, so it keeps using a plain
  /// http.Request.
  Future<List<int>?> getSessionReportBytes({
    required String patientId,
    required int treatmentId,
    required int userId,
    required int unitId,
  }) async {
    final uri = Uri.parse(
      '${ApiConstants.ip + ApiNames.sessionEndReport}?details=no&fromDate=&toDate=&treatmentId=&patientId=$patientId',
    );

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
    request.headers.addAll({'Content-Type': 'application/json'});
    request.headers.addAll(AuthTokenManager().authHeaders);

    final response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.toBytes();
    }
    return null;
  }

  Future<List<dynamic>> getTrendAnalysis(String patientId, String testType) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.getTrendAnalysisData}?patientId=$patientId&testType=$testType");

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<CoversheetPrescriptionDet> getPrescriptionDet(
      String treatmentId, String unitId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getAllPrescriptionsByTreatmentId}?treatmentId=$treatmentId&unitId=$unitId");

    if (response.statusCode == 200) {
      return CoversheetPrescriptionDet.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<LabInvestModel>> getLabInvest(String treatmentId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.getTestReportByPatientId}?patientId=$treatmentId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => LabInvestModel.fromJson(item)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<DietDetailsCoversheet> getDietDetails(String treatmentId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getOPDDietListByTreatmentId}?treatmentId=$treatmentId");

    if (response.statusCode == 200) {
      return DietDetailsCoversheet.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<VisitorDocIdModel>> getDocumentId() async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getDocumentChecklistList}?formShortCode=VEF");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => VisitorDocIdModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<VisitPatientDetalis> visitPatientDetails(PatientData? patientData) async {
    final response = await ApiClient().post(
      ApiConstants.oldBaseUrl + ApiNames.visitPatient,
      body: {"patientId": patientData?.patientId, "treatmentId": patientData?.treatmentId},
    );

    if (response.statusCode == 200) {
      return VisitPatientDetalis.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: builds its own ByPassCert
  /// IOClient for this multipart upload, same as before.
  Future<http.StreamedResponse> uploadVisitorDocuments({
    required String docId,
    required String? patientId,
    required String userId,
    required String unitId,
    required String? treatmentId,
    required String fileFieldKey,
    required String filePath,
  }) async {
    final ioClient = IOClient(ByPassCert().httpClient);
    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiNames.visitDocumentUpload}?files");

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'documentChecklistId': docId,
      'patientId': patientId ?? "",
      'treatmentId': treatmentId ?? '',
      'userId': userId,
      'unitId': unitId,
    });
    request.files.add(await http.MultipartFile.fromPath(fileFieldKey, filePath));
    request.headers.addAll(AuthTokenManager().authHeaders);

    return ioClient.send(request);
  }

  /// Unchanged from the original controller: this multipart request was
  /// never routed through the SSL-bypass client either.
  Future<http.Response> updateVisitorEntry({
    required Map<String, dynamic> dataMap,
    String? fileFieldKey,
    String? filePath,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}${ApiNames.updateTreatmentData}");
    final request = http.MultipartRequest("POST", url);
    request.fields['data'] = jsonEncode(dataMap);
    request.headers.addAll(AuthTokenManager().authHeaders);

    if (filePath != null && fileFieldKey != null) {
      request.files.add(await http.MultipartFile.fromPath(fileFieldKey, filePath));
    }

    final streamedResponse = await request.send();
    return http.Response.fromStream(streamedResponse);
  }

  Future<SearchRegisteredPatientModel> searchByDropDownList() async {
    final response = await ApiClient()
        .post(ApiConstants.baseUrl + ApiNames.searchByDropDownListApi);

    if (response.statusCode == 200) {
      return SearchRegisteredPatientModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<SlotForSearch>> getSlotListSearch(unitId) async {
    final response = await ApiClient().post(
      "${ApiConstants.ip}${ApiNames.slotList}",
      body: {"unitId": unitId},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => SlotForSearch.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> searchSchedularList(String type, String input,
      unitId, String fromD, String toDate, int slotId) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getDailBookings,
      body: {
        "unitId": unitId,
        "type": type,
        "input": input,
        "category": "",
        "sId": 1,
        "fromDate": fromD,
        "toDate": toDate,
        "slotId": slotId
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<http.Response> autoSuggestion(
      String type, String input, unitId, int sId) async {
    return ApiClient().post(
      ApiConstants.baseUrl1 + ApiNames.getSuggestionList,
      body: {
        "searchParam": input,
        "searchType": type,
        "sId": sId.toString(),
        "unitId": unitId
      },
    );
  }

  Future<Map<String, dynamic>> searchRegisteredPatient(
      String type, String input, unitId, String sId) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.searchRegisteredPatientApi,
      body: {
        "unitId": unitId,
        "type": type,
        "input": input,
        "category": "",
        "sId": sId,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> cancelAppointment(
      userId, pId, unitId, tId) async {
    final response = await ApiClient().post(
      ApiConstants.oldBaseUrl + ApiNames.cancelAppointment,
      body: {"unitId": unitId, "userId": userId, "patientId": pId, "treatmentId": tId},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<InstituteList> getInstituteList() async {
    final response = await ApiClient()
        .get(ApiConstants.baseUrl + ApiNames.getInstituteList);

    if (response.statusCode == 200) {
      return InstituteList.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> showSearchBy(userId) async {
    final response = await ApiClient()
        .get("${ApiConstants.baseUrl + ApiNames.getUserAccessFlag}?userId=$userId");

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> getAppointmentAvail(String date, int? pId) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.checkDateAppointmentSchedule,
      body: {"date": date, "pId": pId},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<http.Response> getSlotList(
      String unitId, String date, AddSchedularRequest cardData) async {
    return ApiClient().post(
      ApiConstants.baseUrl1 + ApiNames.getavailableslots,
      body: {"unitId": unitId, "date": date, "patientId": cardData.patientId},
    );
  }

  Future<Map<String, dynamic>> addSchedular(AddSchedularRequest cardData) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl1 + ApiNames.saveSchedular,
      body: [cardData.toJson()],
    );

    if (response.statusCode == 200) {
      return {'raw': json.decode(response.body)};
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: this download was never
  /// routed through the SSL-bypass client, so it keeps using a plain
  /// http.Request.
  Future<List<int>?> printReportBytes(
      String unitId, String patientId, String treatId, String userId) async {
    final request = http.Request(
        'GET',
        Uri.parse(
            '${ApiConstants.ip}${ApiNames.prescriptionReport}?unitId=$unitId&patientId=$patientId&treatId=$treatId&userId=$userId'));
    request.headers.addAll(AuthTokenManager().authHeaders);
    final response = await request.send();

    if (response.statusCode == 200) {
      return response.stream.toBytes();
    }
    return null;
  }
}
