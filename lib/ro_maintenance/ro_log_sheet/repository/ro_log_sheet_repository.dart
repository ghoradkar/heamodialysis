import 'dart:convert';

import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_by_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/get_machine_name_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/add_ro_log_sheet_request_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/befor_after_hardness_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/get_back_wash_and_rinse_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/initial_value_edit_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/post_carbon_chlorid_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/raw_water_tds_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/return_loop_range_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/ro_log_sheet_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/ro_water_conductivity_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/ro_water_tds_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/sand_filter_pre_post_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/softner_available_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';

class RoLogSheetRepository {
  Future<RoLogSheetModel> getRoMachineIssueLogAndSearchList(
      unitId, fromDate, toDate) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getallROMachineLogSheetBySearch,
      body: {"unitId": unitId, "fromDate": fromDate, "toDate": toDate},
    );

    if (response.statusCode == 200) {
      return RoLogSheetModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> deleteLogSheet(id) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.roMachineLogSheetDelete}?id=$id");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<InitialValueEditModel> getInitialValueForEdit(id) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getROMachineLogNewById}?machId=$id");

    if (response.statusCode == 200) {
      return InitialValueEditModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<GetMachineNameModel> getMachineList(unitId) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getMachineNameList,
      body: {"unitId": unitId},
    );

    if (response.statusCode == 200) {
      return GetMachineNameModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<SandFilterPrePostModel> getSandPrePost() async {
    final response = await ApiClient()
        .get(ApiConstants.baseUrl + ApiNames.getSandFilterPrePost);

    if (response.statusCode == 200) {
      return SandFilterPrePostModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<SoftnerAvailableModel> getSoftnerAvailable() async {
    final response =
        await ApiClient().get(ApiConstants.baseUrl + ApiNames.getSoftnerAvl);

    if (response.statusCode == 200) {
      return SoftnerAvailableModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<RawWaterTdsModel> getRawWaterTds() async {
    final response =
        await ApiClient().get(ApiConstants.baseUrl + ApiNames.getRawWaterTDS);

    if (response.statusCode == 200) {
      return RawWaterTdsModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<RoWaterTdsModel> getRoWaterTds() async {
    final response =
        await ApiClient().get(ApiConstants.baseUrl + ApiNames.getROWaterTDS);

    if (response.statusCode == 200) {
      return RoWaterTdsModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<PostCarbonChloridModel> getPostCarbonChloride() async {
    final response =
        await ApiClient().get(ApiConstants.baseUrl + ApiNames.getPostCarbonCl);

    if (response.statusCode == 200) {
      return PostCarbonChloridModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<RoWaterConductivityModel> getRoWaterConduct() async {
    final response =
        await ApiClient().get(ApiConstants.baseUrl + ApiNames.getROWaterCond);

    if (response.statusCode == 200) {
      return RoWaterConductivityModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<ReturnLoopRangeModel> getReturnLoopRange() async {
    final response =
        await ApiClient().get(ApiConstants.oldBaseUrl + ApiNames.getReturnLoopP);

    if (response.statusCode == 200) {
      return ReturnLoopRangeModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<BeforAfterHardnessModel> getBeforeAfterHardness() async {
    final response = await ApiClient()
        .get(ApiConstants.baseUrl + ApiNames.getBeforeAfterRegHard);

    if (response.statusCode == 200) {
      return BeforAfterHardnessModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<GetBackWashAndRinseModel> getBackwashRinse() async {
    final response = await ApiClient()
        .get(ApiConstants.baseUrl + ApiNames.getBackWashRinse);

    if (response.statusCode == 200) {
      return GetBackWashAndRinseModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<DoneByModel> getDoneByList(unitId) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getUsersByUnit,
      body: {"unitId": unitId},
    );

    if (response.statusCode == 200) {
      return DoneByModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> addEditROLogSheet(
      AddRoLogSheetRequestModel addRoLogSheetRequestModel) async {
    final response = await ApiClient().post(
      ApiConstants.oldBaseUrl + ApiNames.saveMachineLogsNew,
      body: addRoLogSheetRequestModel,
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.reasonPhrase ?? '');
  }

  Future<InstituteList> getInstituteList() async {
    final response = await ApiClient()
        .get(ApiConstants.baseUrl + ApiNames.getInstituteList);

    if (response.statusCode == 200) {
      return InstituteList.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }
}
