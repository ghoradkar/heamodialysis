import 'dart:convert';

import 'package:heamodialysis/machine_status/model/add_machine_counter_list_model.dart';
import 'package:heamodialysis/machine_status/model/machine_count_model.dart';
import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class MachineStatusRepository {
  Future<List<MachineCountModel>> getMachineList(
      String startIndex, unitId, String searchDate) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.getSavedMachineReading}?callfrom=&startIndex=$startIndex&searchdate=$searchDate&unitId=$unitId");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => MachineCountModel.fromJson(item)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: this call was never routed
  /// through the SSL-bypass client, so it keeps using a plain http.Request.
  Future<List<AddMachineCounterListModel>?> getMachineListInAddMachineCounterPage(
      String fromDate, String toDate, String unitId) async {
    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiNames.getMachineListreading}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
    );

    final response = await http.Request('POST', uri).send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final List<dynamic> resp = jsonDecode(responseString);
      return resp
          .map((item) => AddMachineCounterListModel.fromJson(item))
          .toList();
    }
    return null;
  }

  Future<String?> addMachineCounter(
      List<AddMachineCounterListModel> body) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.saveMachineReading}",
      body: body.map((e) => e.toJson()).toList(),
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
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
