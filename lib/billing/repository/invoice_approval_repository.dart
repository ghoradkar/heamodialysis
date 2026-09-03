import 'dart:convert';
import 'dart:typed_data';

import 'package:heamodialysis/billing/model/invoice_approval_model.dart';
import 'package:heamodialysis/billing/model/send_for_approval_req.dart';
import 'package:heamodialysis/billing/model/service_certificate_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';

class InvoiceApprovalRepository {
  Future<List<InvoiceApprovalModel>> getInvoiceList(
      int month, int year, int unitId, int userId) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.invoiceView}",
      body: {"month": month, "year": year, "unitId": unitId, "userId": userId},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => InvoiceApprovalModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<String> sendForApproval(SendForApprovalReq req) async {
    final response = await ApiClient().post(
      "${ApiConstants.baseUrl}${ApiNames.sendForApproval}",
      body: req,
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Uint8List> viewInvoiceReport(dynamic body) async {
    final response = await ApiClient()
        .post("${ApiConstants.ip}${ApiNames.invoiceNewReportUrl}", body: body);

    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Uint8List> viewInvoiceSummary(dynamic body) async {
    final response = await ApiClient()
        .post("${ApiConstants.ip}${ApiNames.invoiceSummaryReportUrl}", body: body);

    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Uint8List> viewMavCalculation(dynamic body) async {
    final response = await ApiClient()
        .post("${ApiConstants.ip}${ApiNames.mAVCalculationReport}", body: body);

    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<ServiceCertificateModel>> serviceCertificate(billNo) async {
    final response = await ApiClient().post(
        "${ApiConstants.baseUrl}${ApiNames.showBillApprovalData}?billNo=$billNo&level=LVL2");

    if (response.statusCode == 200) {
      final List<dynamic> respBody = jsonDecode(response.body);
      return respBody.map((json) => ServiceCertificateModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }
}
