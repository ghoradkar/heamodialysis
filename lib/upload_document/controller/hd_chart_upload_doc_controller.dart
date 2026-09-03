import 'package:heamodialysis/upload_document/controller/document_list_controller.dart';
import 'package:heamodialysis/upload_document/model/document_search_request_model.dart';
import 'package:heamodialysis/upload_document/repository/upload_document_repository.dart';
import 'package:heamodialysis/utils/api_names.dart';

class HdChartUploadDocController extends DocumentListController {
  final UploadDocumentRepository _repository = UploadDocumentRepository();

  @override
  Future<void> fetchDocumentList(DocumentSearchRequestModel request) async {
    isLoading = true;
    update();

    try {
      documentList = await _repository.fetchDocuments(
          ApiNames.getPatientHdChartDocuments, request);
    } catch (_) {
      documentList = [];
    } finally {
      isLoading = false;
      update();
    }
  }
}
