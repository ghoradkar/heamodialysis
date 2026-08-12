import 'dart:convert';

import 'package:heamodialysis/upload_document/controller/document_list_controller.dart';
import 'package:heamodialysis/upload_document/model/document_search_request_model.dart';
import 'package:heamodialysis/upload_document/model/patient_document_model.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:http/io_client.dart';

class HdChartUploadDocController extends DocumentListController {
  final IOClient ioClient = IOClient(ByPassCert().httpClient);

  @override
  Future<void> fetchDocumentList(DocumentSearchRequestModel request) async {
    isLoading = true;
    update();

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getPatientHdChartDocuments);

    try {
      final response = await ioClient.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        documentList = data.map((e) => PatientDocumentModel.fromJson(e)).toList();
      } else {
        documentList = [];
      }
    } catch (_) {
      documentList = [];
    } finally {
      isLoading = false;
      update();
    }
  }
}
