import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/upload_document/controller/hd_chart_upload_doc_controller.dart';
import 'package:heamodialysis/upload_document/screen/shared/treatment_document_list_screen.dart';
import 'package:heamodialysis/utils/api_names.dart';

class HdChartUploadDocScreen extends StatelessWidget {
  const HdChartUploadDocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TreatmentDocumentListScreen<HdChartUploadDocController>(
      title: 'HD Chart',
      controller: Get.put(HdChartUploadDocController()),
      uploadApiPath: ApiNames.uploadPatientHdChartDocument,
      documentLabel: 'HD Chart document',
    );
  }
}
