import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/upload_document/controller/feedback_upload_doc_controller.dart';
import 'package:heamodialysis/upload_document/screen/shared/treatment_document_list_screen.dart';
import 'package:heamodialysis/utils/api_names.dart';

class FeedbackUploadDocScreen extends StatelessWidget {
  const FeedbackUploadDocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TreatmentDocumentListScreen<FeedbackUploadDocController>(
      title: context.l10n.uploadFeedback,
      controller: Get.put(FeedbackUploadDocController()),
      uploadApiPath: ApiNames.uploadFeedbackDocument,
      documentLabel: 'Feedback document',
    );
  }
}
