import 'dart:convert';

import 'package:heamodialysis/dialysis_queue/consumable_entry/model/add_consumable_entry_model.dart';
import 'package:heamodialysis/dialysis_queue/consumable_entry/model/consumable_list_model.dart';
import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/get_machine_name_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/add_machine_issue_req_model/add_edit_machine_issue_log_req.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/batch_no_list_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/problem_resolve/problem_resolved_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/product_name_list_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/ro_machine_issue_log/ro_machine_issue_log_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';

class RoMachineIssueLogRepository {
  Future<RoMachineIssueLogModel> getRoMachineIssueLogAndSearchList(
      unitId, machineName) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getallROMachineLogBySearch,
      body: {"unitId": unitId, "input": machineName},
    );

    if (response.statusCode == 200) {
      return RoMachineIssueLogModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<void> saveAddConsumableEntry(
      AddConsumableEntryModel addConsumableEntryModel) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.savePhysicalDet,
      body: addConsumableEntryModel,
    );

    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
  }

  Future<String> addEditRoMachineIssueLog(
      AddEditMachineIssueLogReq? req, String? issueDate, String? informationDate) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.saveROMachineIssueLog,
      body: {
        "roMachineIssueLogsId": req?.roMachineIssueLogsId,
        "roMachineMasterId": req?.roMachineMasterId,
        "issueDate": issueDate,
        "issueDescription": req?.issueDescription,
        "informedTo": req?.informedTo,
        "informedBy": req?.informedBy,
        "informationDate": informationDate,
        "callAttendedBy": req?.callAttendedBy,
        "correctiveAction": req?.correctiveAction,
        "lookupDetId": req?.lookupDetId,
        "comments": req?.comments,
        "createdBy": req?.createdBy,
        "unitId": req?.unitId
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.reasonPhrase ?? '');
  }

  Future<String> deleteMachineIssueLog(id) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.roMachineIssueLogDelete}?id=$id");

    if (response.statusCode == 200) {
      return response.body;
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

  Future<InstituteList> getInstituteList() async {
    final response = await ApiClient()
        .get(ApiConstants.baseUrl + ApiNames.getInstituteList);

    if (response.statusCode == 200) {
      return InstituteList.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<ProblemResolvedModel> getProblemResolvedList(unitId) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getProbResolved,
      body: {"unitId": unitId},
    );

    if (response.statusCode == 200) {
      return ProblemResolvedModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<ProductNameListModel>> getProductNameList(unitId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getProdNameList}?unitId=$unitId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProductNameListModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<ConsumableListModel>> getConsumableList(patientId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getAllConsumableItems}?patId=$patientId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ConsumableListModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<BatchNoListModel>> getBatchNoList(unitId, itemId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getBatchNoList}?itemId=$itemId&unitId=$unitId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => BatchNoListModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<BatchNoListModel>> getExpiryList(unitId, prodCode, itemId) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getExpiryDateList}?itemId=$itemId&prodCode=$prodCode&unitId=$unitId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => BatchNoListModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<BatchNoListModel>> getOrderListList(
      unitId, prodCode, itemId, date) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getProductOrderId}?itemId=$itemId&prodCode=$prodCode&date=$date&unitId=$unitId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => BatchNoListModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }
}
