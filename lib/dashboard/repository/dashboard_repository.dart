import 'dart:convert';

import 'package:heamodialysis/dashboard/model/dash_info_data.dart';
import 'package:heamodialysis/dashboard/model/event_details_id.dart';
import 'package:heamodialysis/dashboard/widget/dash_info_table_total.dart';
import 'package:heamodialysis/dashboard/screen/super_admin/total_invoice_amount_model.dart';
import 'package:heamodialysis/utils/api_client.dart';

class DashboardRepository {
  /// Shared by every "GET url, parse a model/list, throw on non-200" call
  /// in the controller - they only differ by URL and target type.
  Future<T> fetchAndParse<T>(String url, T Function(dynamic) fromJson) async {
    final response = await ApiClient().get(url);
    if (response.statusCode == 200) {
      return fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// Same as [fetchAndParse] but returns the raw decoded json (no model) -
  /// used by the two counters that assign the decoded body directly to a
  /// `var` field with no fromJson call.
  Future<dynamic> fetchRawJson(String url) async {
    final response = await ApiClient().get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// getEventForIdTech: only parses when the body is non-empty and decodes
  /// to a List - otherwise returns null, matching the original controller's
  /// silent no-op on an empty/non-list 200 body.
  Future<List<EventDetailsId>?> getEventForIdTech(String url) async {
    final response = await ApiClient().get(url);
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty && json.decode(response.body) is List) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => EventDetailsId.fromJson(json)).toList();
      }
      return null;
    }
    throw ApiException(response.statusCode, response.body);
  }

  /// getTestDet: only parses when the body is non-empty - otherwise leaves
  /// the field untouched, matching the original controller.
  Future<List<DashInfoSubHeader>?> getTestDet(String url) async {
    final response = await ApiClient().get(url);
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((json) => DashInfoSubHeader.fromJson(json)).toList();
      }
      return null;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<DashInfoData>> getPatientRegTechnician(String url) async {
    final response = await ApiClient().get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => DashInfoData.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<TotalInvoiceAmountModel>> getTotalInvoiceAmount(String url) async {
    final response = await ApiClient().get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map<TotalInvoiceAmountModel>((json) => TotalInvoiceAmountModel.fromJson(json)).toList();
    }
    throw ApiException(response.statusCode, response.body);
  }
}
