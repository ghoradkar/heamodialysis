import 'dart:convert';

import 'package:heamodialysis/dialysis_queue/post_dialysis/model/common_dropdown_post_dialysis_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/current_weight_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/post_dialysis_list_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/save_request_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/start_date_and_time.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class PostDialysisRepository {
  Future<SearchRegisteredPatientModel> searchByDropDownList() async {
    final response = await ApiClient()
        .post(ApiConstants.baseUrl + ApiNames.searchByDropDownListApi);

    if (response.statusCode == 200) {
      return SearchRegisteredPatientModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> getValueToSetInHeprinUsedField(patientId, treatmentId) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl + ApiNames.getSpecialDialysis}?patientId=$patientId&treatmentId=$treatmentId");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> getPostDialysisList(
      String type, String input, unitId) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getPostDiaList,
      body: {"unitId": unitId, "type": type, "input2": 0, "category": ""},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> saveEditPostDialysis(
      SaveRequestModel saveRequestModel) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.savePostDai,
      body: saveRequestModel,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: neither of these two calls
  /// were routed through the SSL-bypass client, so they keep using plain
  /// http.Request.
  Future<String?> getStartTime(String patientId, String treatmentId) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getPostFlag}?patientId=$patientId&treatmentId=$treatmentId");
    final response = await http.Request('POST', uri).send();

    if (response.statusCode == 200) {
      return response.stream.bytesToString();
    }
    return null;
  }

  Future<Map<String, dynamic>?> getStopDateAndTimeAndWeight(
      String patientId, String treatmentId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiNames.getPostFlag}');
    final request = http.Request('GET', url);
    request.headers.addAll({'Content-Type': 'application/json'});
    request.body = json.encode({"patientId": patientId, "treatmentId": treatmentId});

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      return json.decode(responseString) as Map<String, dynamic>;
    }
    return null;
  }

  Future<Map<String, dynamic>> getCurrentWeight(
      String patientId, String treatmentId) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getPreWeight,
      body: {"patientId": patientId, "treatmentId": treatmentId},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Shared by every "get <field> dropdown list" call in the controller -
  /// they all hit the same endpoint, differing only by shortCode.
  Future<List<CommonDropDownPostDialysisModel>> getDropdownList(
      String shortCode) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();
    }
    throw ApiException(response.statusCode, response.body);
  }
}
