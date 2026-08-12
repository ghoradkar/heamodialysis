import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/billing/model/invoice_approval_model.dart';
import 'package:heamodialysis/billing/model/send_for_approval_req.dart';
import 'package:heamodialysis/billing/model/service_certificate_model.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';

class InvoiceApprovalController extends GetxController {
  bool isLoading = true;
  IOClient ioClient = IOClient(ByPassCert().httpClient);

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

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiNames.invoiceView}",
    );

    var body = {
      "month": month,
      "year": year,
      "unitId": unitId,
      "userId": userId,
    };

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Request URI: ${uri.path}');
    debugPrint('Request Body: ${jsonEncode(body)}');

    try {
      final response = await ioClient.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      debugPrint('Response Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading = false;
        List<dynamic> data = json.decode(response.body);

        invoiceApprovalModel =
            data.map((json) => InvoiceApprovalModel.fromJson(json)).toList();
        update();
      } else {
        isLoading = false;
        throw Exception('Failed to get getInvoiceList');
      }
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  sendForApproval(month, year, unitId, userId) async {
    isLoading = true;

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiNames.sendForApproval}",
    );

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Request URI: ${uri.path}');
    debugPrint('Request Body: ${jsonEncode(sendForApprovalReq)}');

    try {
      final response = await ioClient.post(
        uri,
        headers: headers,
        body: jsonEncode(sendForApprovalReq),
      );

      debugPrint('Response Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading = false;
        CustomMessage.toast(response.body);
        await getInvoiceList(month, year, unitId, userId);
        update();
      } else {
        isLoading = false;
        throw Exception('Failed to get getInvoiceList');
      }
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  viewInvoiceReport(body, appbar) async {
    isLoading = true;
    update();
    final uri = Uri.parse(
      "${ApiConstants.ip}${ApiNames.invoiceNewReportUrl}",
    );

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Request URI: ${uri.path}');
    debugPrint('Request Body: ${jsonEncode(body)}');

    try {
      final response = await ioClient.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      debugPrint('Response Code: ${response.statusCode}');
      // debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading = false;
        Uint8List pdfBytes = response.bodyBytes;
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
      } else {
        isLoading = false;
        throw Exception('Failed to get viewInvoiceReport');
      }
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  viewInvoiceSummary(body, appbar) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
      "${ApiConstants.ip}${ApiNames.invoiceSummaryReportUrl}",
    );

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Request URI: ${uri.path}');
    debugPrint('Request Body: ${jsonEncode(body)}');

    try {
      final response = await ioClient.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      debugPrint('Response Code: ${response.statusCode}');
      // debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading = false;
        Uint8List pdfBytes = response.bodyBytes;
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
      } else {
        isLoading = false;
        throw Exception('Failed to get viewInvoiceSummary');
      }
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  viewMavCalculation(body, appbar) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
      "${ApiConstants.ip}${ApiNames.mAVCalculationReport}",
    );

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Request URI: ${uri.path}');
    debugPrint('Request Body: ${jsonEncode(body)}');

    try {
      final response = await ioClient.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      debugPrint('Response Code: ${response.statusCode}');
      // debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading = false;
        Uint8List pdfBytes = response.bodyBytes;
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
      } else {
        isLoading = false;
        throw Exception('Failed to get viewMavCalculation');
      }
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      update();
    }
  }

  serviceCertificate(billNo, appbar) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiNames.showBillApprovalData}?billNo=$billNo&level=LVL2",
    );

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint('Request URI: ${uri.path}');
    // debugPrint('Request Body: ${jsonEncode(body)}');

    try {
      final response = await ioClient.post(uri, headers: headers);

      debugPrint('Response Code: ${response.statusCode}');
      // debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        isLoading = false;
        List<dynamic> respBody = jsonDecode(response.body);

        serviceCertificateModel = respBody
            .map((json) => ServiceCertificateModel.fromJson(json))
            .toList();
        if (serviceCertificateModel != null &&
            serviceCertificateModel!.isNotEmpty) {
          filteredCertificates.addAll(serviceCertificateModel!.toList());
        }
        update();
      } else {
        isLoading = false;
        throw Exception('Failed to get serviceCertificate');
      }
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
