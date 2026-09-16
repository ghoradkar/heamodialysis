import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/billing/model/invoice_approval_model.dart';
import 'package:heamodialysis/billing/model/send_for_approval_req.dart';
import 'package:heamodialysis/billing/model/service_certificate_model.dart';
import 'package:heamodialysis/billing/repository/invoice_approval_repository.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';
import 'package:path_provider/path_provider.dart';

class InvoiceApprovalController extends GetxController {
  final InvoiceApprovalRepository _repository = InvoiceApprovalRepository();

  bool isLoading = true;

  List<InvoiceApprovalModel>? invoiceApprovalModel;
  SendForApprovalReq sendForApprovalReq =
      SendForApprovalReq(ttInvoiceStatewiseBean: []);

  List<ServiceCertificateModel>? serviceCertificateModel;
  List<ServiceCertificateModel> filteredCertificates = [];
  TextEditingController searchController = TextEditingController();

  getInvoiceList(
    int month,
    int year,
    int unitId,
    int userId,
  ) async {
    isLoading = true;

    try {
      invoiceApprovalModel =
          await _repository.getInvoiceList(month, year, unitId, userId);
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  sendForApproval(month, year, unitId, userId) async {
    isLoading = true;

    try {
      final responseBody = await _repository.sendForApproval(sendForApprovalReq);
      isLoading = false;
      CustomMessage.toast(responseBody);
      await getInvoiceList(month, year, unitId, userId);
      update();
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  viewInvoiceReport(body, appbar) async {
    isLoading = true;
    update();

    try {
      final pdfBytes = await _repository.viewInvoiceReport(body);
      isLoading = false;
      File pdfFile = await savePdf(pdfBytes, "invoiceReport.pdf");
      Get.to(Scaffold(
        appBar: AppBar(
          title: CustomText(
              text: appbar,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              textColor: Colors.black,
              textAlign: TextAlign.start),
        ),
        body: PdfViewer(
          fileUrl: pdfFile.path,
        ),
      ));

      update();
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  viewInvoiceSummary(body, appbar) async {
    isLoading = true;
    update();

    try {
      final pdfBytes = await _repository.viewInvoiceSummary(body);
      isLoading = false;
      File pdfFile = await savePdf(pdfBytes, "invoiceSummary.pdf");
      Get.to(Scaffold(
        appBar: AppBar(
          title: CustomText(
              text: appbar,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              textColor: Colors.black,
              textAlign: TextAlign.start),
        ),
        body: PdfViewer(
          fileUrl: pdfFile.path,
        ),
      ));

      update();
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  viewMavCalculation(body, appbar) async {
    isLoading = true;
    update();

    try {
      final pdfBytes = await _repository.viewMavCalculation(body);
      isLoading = false;
      File pdfFile = await savePdf(pdfBytes, "MAVCalculations.pdf");
      Get.to(Scaffold(
        appBar: AppBar(
          title: CustomText(
              text: appbar,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              textColor: Colors.black,
              textAlign: TextAlign.start),
        ),
        body: PdfViewer(
          fileUrl: pdfFile.path,
        ),
      ));

      update();
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  serviceCertificate(billNo, appbar) async {
    isLoading = true;
    update();

    try {
      serviceCertificateModel = await _repository.serviceCertificate(billNo);
      isLoading = false;
      if (serviceCertificateModel != null &&
          serviceCertificateModel!.isNotEmpty) {
        filteredCertificates.addAll(serviceCertificateModel!.toList());
      }
      update();
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  Future<File> savePdf(Uint8List pdfBytes, String fileName) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(pdfBytes);
    return file;
  }
}
