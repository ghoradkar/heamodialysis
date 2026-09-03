import 'dart:convert';

import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/model/GetRoDetById.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/model/daily_ro_log_sheet_save_model.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/model/daily_ro_logsheet_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';

class DailyRoLogSheetRepository {
  Future<dynamic> addEditDailyRoLogSheet(
      DailyRoLogSheetSaveModel? model) async {
    final response = await ApiClient()
        .post(ApiConstants.baseUrl + ApiNames.saveLogSheet, body: model);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
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

  Future<List<DailyRoLogSheetModel>> getDailyRoLogSheetAndSearchList(
      String date, String unitId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getRoAllData}?date=$date&unitId=$unitId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => DailyRoLogSheetModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<GetRoDetById>> getRoById(int id) async {
    final response = await ApiClient()
        .get("${ApiConstants.baseUrl}${ApiNames.getRoAllDataById}?id=$id");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => GetRoDetById.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }
}
