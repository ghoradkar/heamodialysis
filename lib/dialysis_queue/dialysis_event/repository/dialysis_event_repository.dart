import 'dart:convert';

import 'package:heamodialysis/dialysis_queue/dialysis_event/model/add_edit_dialysis_event_req.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_detaisl_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_list_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/incedent_type_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/patient_event_details.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';

class DialysisEventRepository {
  Future<List<IncedentTypeModel>> getIncidentSubType(int? lookupId) async {
    final response = await ApiClient()
        .get("${ApiConstants.baseUrl}${ApiNames.incidentSubType}?value=$lookupId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => IncedentTypeModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<IncedentTypeModel>> getIncidentType() async {
    final response =
        await ApiClient().get("${ApiConstants.baseUrl}${ApiNames.incidentType}");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => IncedentTypeModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<DialysisEventListModel>> getDialysisEventList(String inputValue,
      String startIndex, String callFrom, String unitId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getPreDialysisQueueList}?inputValue=$inputValue&startIndex=$startIndex&callFrom=$callFrom&searchType=&unitId=$unitId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => DialysisEventListModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<DialysisEventDetaislModel>> getEventPatientDetails(
      String treatmentId, String patientId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.patientDetailsbyid}?treatmentId=$treatmentId&patientId=$patientId");

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded is List) {
        return decoded
            .map((json) => DialysisEventDetaislModel.fromJson(json))
            .toList();
      }
      return [];
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<PatientEventDetails>> getEventDetailsList(String patientId) async {
    final response = await ApiClient()
        .post("${ApiConstants.baseUrl}${ApiNames.eventDataTable}?patientId=$patientId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => PatientEventDetails.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> saveDialysisEvent(
      List<AddEditDialysisEventReq> cardList, userId, unitId) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.save}?userId=$userId&unitId=$unitId",
      body: cardList,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }
}
