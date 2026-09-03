import 'dart:convert';

import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';

class RegistrationRepository {
  Future<SearchRegisteredPatientModel> searchByDropDownList() async {
    final response = await ApiClient()
        .post(ApiConstants.baseUrl + ApiNames.searchByDropDownListApi);

    if (response.statusCode == 200) {
      return SearchRegisteredPatientModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> checkScrutinyApproval(patientId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getApprovalStatus}?patientId=$patientId");

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Returns the raw decoded body - the caller decides whether it parses
  /// as a success payload (data['status'] == 'Success') or a status-only
  /// failure payload, same branching the controller did before.
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
}
