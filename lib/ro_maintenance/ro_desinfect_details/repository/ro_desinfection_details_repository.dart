import 'dart:convert';

import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/add_ro_disinfect_req_model/add_ro_disinfect_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/disinfect_type/disinfect_type_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_by_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/get_machine_name_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/ro_disinfection_doc.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/ro_maint_details/ro_maintenance_details_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screen/add_edit_ro_desinfec_details.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class RoDesinfectionDetailsRepository {
  Future<InstituteList> getInstituteList() async {
    final response = await ApiClient()
        .get(ApiConstants.baseUrl + ApiNames.getInstituteList);

    if (response.statusCode == 200) {
      return InstituteList.fromJson(json.decode(response.body));
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

  Future<String> deleteDesinfectionDet(id) async {
    final response = await ApiClient().get(
        "${ApiConstants.baseUrl}${ApiNames.roMachineDisinfectionDelete}?id=$id");

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: builds its own ByPassCert
  /// IOClient for this multipart upload, same as before.
  Future<http.Response> addEditRoDisinfectDetails({
    required Map<String, dynamic> data,
    required String docIdString,
    required String docNameString,
    required List<ROFileDetails> selectedFiles,
  }) async {
    final ioClient = IOClient(ByPassCert().httpClient);
    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.saveRODisDet);

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll({'data': json.encode(data)});
    request.fields.addAll({'documentNames': docNameString});
    request.fields.addAll({'docId': docIdString});
    request.headers.addAll({'Content-Type': 'multipart/form-data'});

    for (final file in selectedFiles) {
      request.files
          .add(await http.MultipartFile.fromPath(file.key, file.file!.path));
    }

    final response = await ioClient.send(request);
    return http.Response.fromStream(response);
  }

  Future<DisinfectTypeModel> getDisinfecUsed() async {
    final response = await ApiClient()
        .get(ApiConstants.baseUrl + ApiNames.getDisinfectionDet);

    if (response.statusCode == 200) {
      return DisinfectTypeModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: this call used the same
  /// ByPassCert IOClient but via a plain http.Request/send.
  Future<List<RoDisinfectionDoc>> getRODisinfectionDoc(roMachineId) async {
    final ioClient = IOClient(ByPassCert().httpClient);
    final request = http.Request('POST',
        Uri.parse('${ApiConstants.baseUrl}${ApiNames.getRoDisDocById}?Id=$roMachineId'));
    request.headers.addAll({'Content-Type': 'application/json'});

    final response = await ioClient.send(request);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(await response.stream.bytesToString());
      return data.map((json) => RoDisinfectionDoc.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.reasonPhrase ?? '');
  }

  Future<RoMaintenanceDetailsModel> getRoMaintenanceDetAndSearchList(
      unitId, machineName) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getallROMachineDisBySearch,
      body: {"unitId": unitId, "input": machineName},
    );

    if (response.statusCode == 200) {
      return RoMaintenanceDetailsModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }
}
