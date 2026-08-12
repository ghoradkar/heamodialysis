import 'package:get/get.dart';
import 'package:heamodialysis/upload_document/model/document_search_request_model.dart';
import 'package:heamodialysis/upload_document/model/patient_document_model.dart';

abstract class DocumentListController extends GetxController {
  bool isLoading = false;
  List<PatientDocumentModel> documentList = [];

  Future<void> fetchDocumentList(DocumentSearchRequestModel request);
}
