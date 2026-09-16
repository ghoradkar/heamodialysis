import 'dart:convert';

import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/access_type_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/access_type_site_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/dialysis_type_mode.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/dialyzer_type_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/edit_req_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/get_pre_dialysis_details_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/inter_dialytic_weight.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/special_dialysis_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/model/fiber_bundle_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/model/pre_dialysis/edit_history/history_model.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/model/pre_dialysis/pre_dialysis_data.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/model/pre_dialysis/pre_dialysis_list_model.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/auth_token_manager.dart';
import 'package:http/http.dart' as http;

class PreDialysisRepository {
  Future<Map<String, dynamic>> editPreDialysis(EditReqModel editReqModel) async {
    final response = await ApiClient()
        .post(ApiConstants.ip + ApiNames.savePreDailysis, body: editReqModel);

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<SearchRegisteredPatientModel> searchByDropDownList() async {
    final response = await ApiClient()
        .post(ApiConstants.baseUrl + ApiNames.searchByDropDownListApi);

    if (response.statusCode == 200) {
      return SearchRegisteredPatientModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> searchPreDialysisPatient(
      String type, String input, unitId) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getPreDiaList,
      body: {"unitId": unitId, "type": type, "input": input, "category": ""},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<DialysisTypeModel> getDialysisType() async {
    final response =
        await ApiClient().get(ApiConstants.baseUrl + ApiNames.getDialysisType);

    if (response.statusCode == 200) {
      return DialysisTypeModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<SpecialDialysisModel> getSpecialDialysis() async {
    final response = await ApiClient()
        .get(ApiConstants.baseUrl + ApiNames.getSpecialDailysis);

    if (response.statusCode == 200) {
      return SpecialDialysisModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<AccessTypeModel> getAccessType() async {
    final response =
        await ApiClient().get(ApiConstants.baseUrl + ApiNames.getAccessType);

    if (response.statusCode == 200) {
      return AccessTypeModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<AccessTypeSiteModel> getAccessTypeSite(lookUpId) async {
    final response = await ApiClient().get(
        '${ApiConstants.baseUrl}${ApiNames.getAccessSite}?lookUpId=$lookUpId');

    if (response.statusCode == 200) {
      return AccessTypeSiteModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<DialyzerTypeModel> getDialyzerType() async {
    final response =
        await ApiClient().get(ApiConstants.baseUrl + ApiNames.getDialyserType);

    if (response.statusCode == 200) {
      return DialyzerTypeModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> getInterDialyticWeight(
      String patientId, String treatmentId) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getIntermediateWait,
      body: {"patientId": patientId, "treatmentId": treatmentId},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<FiberBundleModel>> getFiberBundle(String lookupId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getFibreBundle}?lookUpId=$lookupId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => FiberBundleModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: this call was never routed
  /// through the SSL-bypass client, so it keeps using a plain http.Request.
  Future<HistoryModel?> getViewHistory(int patientId) async {
    final request = http.Request(
        'GET', Uri.parse('${ApiConstants.baseUrl}${ApiNames.getPreHistory}'));
    request.body = json.encode({"patientId": patientId});
    request.headers.addAll({'Content-Type': 'application/json'});
    request.headers.addAll(AuthTokenManager().authHeaders);

    final response = await request.send();
    if (response.statusCode == 200) {
      final data = json.decode(await response.stream.bytesToString());
      return HistoryModel.fromJson(data);
    }
    return null;
  }

  Future<GetPreDialysisDetailsModel?> getDialyzerDetails(
      PreDialysisData preDialysis) async {
    final request = http.Request(
        'GET', Uri.parse(ApiConstants.baseUrl + ApiNames.getDialysisDetails));
    request.body = json.encode({
      'patientId': preDialysis.patientId.toString(),
      'treatmentId': preDialysis.treatmentId.toString(),
    });
    request.headers.addAll({'Content-Type': 'application/json'});

    final response = await ApiClient().sendRaw(request);
    if (response.statusCode == 200) {
      final data = json.decode(await response.stream.bytesToString());
      return GetPreDialysisDetailsModel.fromJson(data);
    }
    return null;
  }
}
