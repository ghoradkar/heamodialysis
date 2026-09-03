import 'dart:convert';
import 'dart:io';

import 'package:heamodialysis/new_registration/model/common_dropdown_list.dart';
import 'package:heamodialysis/new_registration/model/patient_profile_photo.dart';
import 'package:heamodialysis/new_registration/model/pincode/pincode_adress_model.dart';
import 'package:heamodialysis/new_registration/model/relative_info_doc.dart';
import 'package:heamodialysis/new_registration/model/save_patient/save_patient_req_model.dart';
import 'package:heamodialysis/new_registration/model/scrutiny_response.dart';
import 'package:heamodialysis/new_registration/model/view_document/view_document.dart';
import 'package:heamodialysis/registered_patient_list/model/patient_history/regis_patient_history.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class NewRegistrationRepository {
  /// Shared by every "GET url, parse model, true/false" dropdown-list
  /// call in the controller - they only differ by URL and model.
  Future<T?> fetchModel<T>(String url, T Function(dynamic) fromJson) async {
    final response = await ApiClient().get(url);
    if (response.statusCode == 200) {
      return fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<Map<String, dynamic>> getPatientHistory(patientId) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.getStageByPatientId}?patientId=$patientId",
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<CommomDropdownList?> getEduSocOccuReligDropDown() async {
    final response = await ApiClient()
        .post("${ApiConstants.baseUrl}${ApiNames.getNewDropdownList}");

    if (response.statusCode == 200) {
      return CommomDropdownList.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Unchanged from the original controller: builds its own ByPassCert
  /// IOClient for this multipart upload, same as before.
  Future<http.StreamedResponse> uploadDocuments({
    required String docIdString,
    required String? patientId,
    required String userId,
    required String unitId,
    required List<http.MultipartFile> files,
  }) async {
    final ioClient = IOClient(ByPassCert().httpClient);
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.savePatientDocuments}?files");

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'documentChecklistId': docIdString,
      'patientId': patientId ?? "",
      'userId': userId,
      'unitId': unitId
    });
    request.files.addAll(files);

    return ioClient.send(request);
  }

  Future<http.Response> savePatient({
    required SavePatientReqModel savePatientReqModel,
    required String formattedJson,
    required List<http.MultipartFile> files,
  }) async {
    final ioClient = IOClient(ByPassCert().httpClient);
    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.savePatientRegDetails);

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll({'data': formattedJson});
    request.headers.addAll({'Content-Type': 'multipart/form-data'});
    request.files.addAll(files);

    final response = await ioClient.send(request);
    return http.Response.fromStream(response);
  }

  Future<Map<String, dynamic>> checkDuplicateMobileNo(String mobNo) async {
    final response = await ApiClient()
        .post("${ApiConstants.baseUrl}${ApiNames.checkMobileNo}?mobile=$mobNo");

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Unchanged from the original controller: this download was never
  /// routed through the SSL-bypass client, so it keeps using a plain
  /// http.Request.
  Future<List<int>?> getPatientReportBytes(String patientId, String userId) async {
    final uri = Uri.parse(
      '${ApiConstants.ip + ApiNames.generateAckReport}?patientId=$patientId&userId=$userId',
    );
    final response = await http.Request('GET', uri).send();

    if (response.statusCode == 200) {
      return response.stream.toBytes();
    }
    return null;
  }

  /// Unchanged from the original controller: this call was never routed
  /// through the SSL-bypass client either.
  Future<ScrutinyResponse?> checkScrutinyDefinedOrNot(String unitId) async {
    final uri = Uri.parse(
      '${ApiConstants.ip + ApiNames.checkScrutinyDefinedOrNot}?unitId=$unitId&serviceCode=NPV',
    );
    final response = await http.Request('GET', uri).send();

    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      return ScrutinyResponse.fromJson(jsonDecode(data));
    }
    return null;
  }

  Future<Map<String, dynamic>?> getDocumentList(patientId) async {
    final response = await ApiClient().get(
        '${ApiConstants.oldBaseUrl}${ApiNames.getDocumentList}?patientId=$patientId');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is Map && data['status'] == 'Success') {
        return data as Map<String, dynamic>;
      }
    }
    return null;
  }

  /// Unchanged from the original controller: plain http.get (no
  /// SSL-bypass client) for downloading each document.
  Future<http.Response> downloadFile(String url) {
    return http.get(Uri.parse(url));
  }

  Future<Map<String, dynamic>?> getDocList() async {
    final response =
        await ApiClient().get(ApiConstants.oldBaseUrl + ApiNames.getDocCheckLIst);

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    return null;
  }

  Future<PincodeAdressModel?> getAddressDataFromPinCode(pincode) async {
    final response = await ApiClient().get(
        '${ApiConstants.baseUrl}${ApiNames.getPincodeData}?pinCode=$pincode');

    if (response.statusCode == 200) {
      return PincodeAdressModel.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<Map<String, dynamic>?> getMonthlyIncome() async {
    final response =
        await ApiClient().get("${ApiConstants.ip}${ApiNames.getAllDropDownList}");
    final decodedBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      return json.decode(decodedBody) as Map<String, dynamic>;
    }
    return null;
  }

  /// Unchanged from the original controller: raw GET-with-body via the
  /// SSL-bypass client's send().
  Future<PatientProfilePhoto?> getProfilePhoto(patientId) async {
    final request = http.Request(
        'GET', Uri.parse(ApiConstants.baseUrl + ApiNames.capturePhoto));
    request.body = json.encode({"patientId": patientId});
    request.headers.addAll({'Content-Type': 'application/json'});

    final response = await ApiClient().sendRaw(request);
    if (response.statusCode == 200) {
      final data = json.decode(await response.stream.bytesToString());
      return PatientProfilePhoto.fromJson(data);
    }
    return null;
  }

  /// Unchanged from the original controller: raw POST via the
  /// SSL-bypass client's send().
  Future<List<RelativeInfoDoc>?> getRelativeInfoDoc(patientId) async {
    final request = http.Request(
        'POST',
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiNames.viewRelativeDoc}?patientId=$patientId'));
    request.headers.addAll({'Content-Type': 'application/json'});

    final response = await ApiClient().sendRaw(request);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(await response.stream.bytesToString());
      return data.map((json) => RelativeInfoDoc.fromJson(json)).toList();
    }
    return null;
  }

  Future<Map<String, dynamic>?> viewPatientData(patientId) async {
    final response = await ApiClient().get(
        '${ApiConstants.oldBaseUrl}${ApiNames.viewPatientDetails}?patientId=$patientId');

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    return null;
  }
}
