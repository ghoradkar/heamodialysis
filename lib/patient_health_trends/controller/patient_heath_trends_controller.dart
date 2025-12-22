import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/patient_health_trends/model/Investigation_chart_report_model.dart';
import 'package:heamodialysis/patient_health_trends/model/dialysis_invest_patient_list_model.dart';
import 'package:heamodialysis/patient_health_trends/model/dialysis_vital_patient_list_model.dart';
import 'package:heamodialysis/patient_health_trends/model/hemoglobin_tracking_model.dart';
import 'package:heamodialysis/patient_health_trends/model/vital_report_model.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PatientController extends GetxController {
  IOClient ioClient = IOClient(ByPassCert().httpClient);
  final RxBool isLoading = false.obs;

  final RxList<DialysisVitalPatientListModel> allPatientsVital =
      <DialysisVitalPatientListModel>[].obs;

  final RxList<DialysisVitalPatientListModel> displayedPatientsVital =
      <DialysisVitalPatientListModel>[].obs;

  List<DialysisInvestPatientListModel>? displayedPatientsInvest;
  List<DialysisInvestPatientListModel>? allPatientsInvest;
  List<HemoglobinTrackingModel>? allPatientsHemoglobin;

  VitalReportModel? vitalReportModel;
  InvestigationChartReportModel? investReportModel;

  final RxBool isMoreDataAvailableVital = true.obs;
  final RxInt totalRecordsVital = 0.obs;
  final RxBool isSearchingVital = false.obs;

  TextEditingController searchControllerVital = TextEditingController();
  TextEditingController fromDateVital = TextEditingController();
  TextEditingController toDateVital = TextEditingController();

  TextEditingController searchControllerInvest = TextEditingController();
  TextEditingController fromDateInvest = TextEditingController();
  TextEditingController toDateInvest = TextEditingController();

  // Pagination state
  int limit = 10;
  int offset = 0;
  bool isRequestingVital = false;
  int? lastUnitIdVital;
  List<String> cardItemDetailsList = [
    'Patient Id',
    'Patient Name',
    'Division Name',
    'District Name',
    'Institute Name',
    'Gender',
  ];

  Future<void> fetchPatientsVital({
    required int unitId,
    int? offsetParam,
    bool isRefresh = false,
  }) async {
    if (isRequestingVital) return;

    if (!isMoreDataAvailableVital.value && !isRefresh) return;

    isRequestingVital = true;
    isLoading.value = true;
    update();

    try {
      if (isRefresh) {
        offset = 0;
        isMoreDataAvailableVital.value = true;
      } else if (offsetParam != null) {
        offset = offsetParam;
      }

      final uri = Uri.parse(
          "${ApiConstants.baseUrl}${ApiNames.getVitalPatDetails}?unitId=$unitId&limit=$limit&offset=$offset");
      final resp = await ioClient.get(uri).timeout(const Duration(seconds: 30));

      if (resp.statusCode == 200) {
        final Map body = json.decode(resp.body) as Map<String, dynamic>;
        final response = PatientListResponse.fromMap(body);

        totalRecordsVital.value = response.totalRecords;

        if (isRefresh) {
          allPatientsVital.assignAll(response.data);
        } else {
          allPatientsVital.addAll(response.data);
        }

        displayedPatientsVital.value =
            List<DialysisVitalPatientListModel>.from(allPatientsVital);

        if (response.data.length < limit ||
            allPatientsVital.length >= response.totalRecords) {
          isMoreDataAvailableVital.value = false;
        } else {
          isMoreDataAvailableVital.value = true;
        }

        offset = allPatientsVital.length;
        lastUnitIdVital = unitId;
      } else {
        debugPrint('server error ${resp.statusCode}');
      }
    } catch (e) {
      debugPrint('fetchPatients error: $e');
    } finally {
      isLoading.value = false;
      isRequestingVital = false;
      update();
    }
  }

  Future<void> fetchPatientsInvest({
    required int unitId,
  }) async {
    isLoading.value = true;
    update();

    try {
      final uri = Uri.parse(
          "${ApiConstants.baseUrl}${ApiNames.getInvestigationChart}?unitId=$unitId");
      final resp = await ioClient.get(uri).timeout(const Duration(seconds: 30));

      if (resp.statusCode == 200) {
        List<dynamic> response = json.decode(resp.body);

        // Convert to model list
        allPatientsInvest = response
            .map((json) => DialysisInvestPatientListModel.fromJson(json))
            .toList();

        final uniquePatients = <int, DialysisInvestPatientListModel>{};
        if (allPatientsInvest != null) {
          for (var p in allPatientsInvest!) {
            uniquePatients[p.patientId ?? 0] = p;
          }
        }

        // Replace original list with unique ones
        allPatientsInvest = uniquePatients.values.toList();
        displayedPatientsInvest = allPatientsInvest;
      } else {
        debugPrint('server error ${resp.statusCode}');
      }
    } catch (e) {
      debugPrint('fetchPatients error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // Future<void> fetchPatientsInvest({
  //   required int unitId,
  // }) async {
  //   isLoading.value = true;
  //   update();
  //
  //   try {
  //     final uri = Uri.parse(
  //         "${ApiConstants.baseUrl}${ApiNames.getInvestigationChart}?unitId=$unitId");
  //     final resp = await ioClient.get(uri).timeout(const Duration(seconds: 30));
  //
  //     if (resp.statusCode == 200) {
  //       List<dynamic> response = json.decode(resp.body);
  //
  //       allPatientsInvest = response
  //           .map((json) => DialysisInvestPatientListModel.fromJson(json))
  //           .toList();
  //
  //       displayedPatientsInvest = allPatientsInvest;
  //     } else {
  //       debugPrint('server error ${resp.statusCode}');
  //     }
  //   } catch (e) {
  //     debugPrint('fetchPatients error: $e');
  //   } finally {
  //     isLoading.value = false;
  //
  //     update();
  //   }
  // }

  void localSearchInvest(String query) {
    if (query.isEmpty) {
      // Reset to show all patients
      displayedPatientsInvest = allPatientsInvest;
    } else {
      // Filter patients by name or ID
      final filtered = allPatientsInvest?.where((patient) {
        final nameLower = patient.patientName.toLowerCase();
        final idString = patient.patientId.toString();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower) || idString.contains(queryLower);
      }).toList();

      displayedPatientsInvest = filtered;
    }
  }

  Future<void> fetchPatientHemoglobinList({required int unitId}) async {
    isLoading.value = true;
    update();

    try {
      final uri = Uri.parse(
          "${ApiConstants.baseUrl}${ApiNames.getAllUnitDetails}?unitId=$unitId");

      http.Response resp = await _getWithRetry(uri, retries: 2);

      if (resp.statusCode == 200) {
        List<dynamic> response = json.decode(resp.body);
        allPatientsHemoglobin = response
            .map((json) => HemoglobinTrackingModel.fromJson(json))
            .toList();
      } else {
        debugPrint('Server error ${resp.statusCode}');
      }
    } catch (e) {
      debugPrint('fetchPatientHemoglobinList error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<http.Response> _getWithRetry(Uri uri,
      {int retries = 1, Duration timeout = const Duration(seconds: 45)}) async {
    for (int attempt = 0; attempt <= retries; attempt++) {
      try {
        final resp = await ioClient.get(uri).timeout(timeout);
        return resp;
      } on TimeoutException {
        if (attempt == retries) rethrow;
        debugPrint("Retrying... ($attempt/$retries)");
        await Future.delayed(
            const Duration(seconds: 2)); // short wait before retry
      }
    }
    throw TimeoutException("Request timed out after $retries retries");
  }

  /// Convenience: refresh full list for given unitId
  Future<void> refreshPatientsVital({required int unitId}) async {
    await fetchPatientsVital(unitId: unitId, isRefresh: true);
  }

  /// Convenience: load next page (uses lastUnitId)
  Future<void> loadMoreVital() async {
    if (lastUnitIdVital == null) return;
    if (!isMoreDataAvailableVital.value) return;
    await fetchPatientsVital(unitId: lastUnitIdVital!, isRefresh: false);
  }

  /// Local search on client-side dataset
  void localSearchVital(String query) async {
    isLoading.value = true;
    isSearchingVital.value = query.isNotEmpty;

    await Future.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) {
      displayedPatientsVital.assignAll(allPatientsVital);
      isSearchingVital.value = false;
    } else {
      final results = allPatientsVital.where((p) {
        final name = p.patientName?.toLowerCase() ?? '';
        final id = p.patientId?.toString() ?? '';
        return name.contains(query.toLowerCase()) || id.contains(query);
      }).toList();

      displayedPatientsVital.assignAll(results);
    }

    isLoading.value = false;
  }

  void clearSearchVital() {
    searchControllerVital.clear();
    isSearchingVital.value = false;
    displayedPatientsVital.assignAll(allPatientsVital);
  }

  getVitalReportList(unitId, patientId, fromDate, toDate) async {
    isLoading.value = true;
    update();
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiNames.getVitalPatChart}?unitId=$unitId&patientId=$patientId&fromDate=$fromDate&toDate=$toDate');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading.value = false;

      final data = json.decode(response.body);
      vitalReportModel = VitalReportModel.fromJson(data);

      update();
    } else {
      isLoading.value = false;
      update();
    }
  }

  Future<void> getInvestReportList(
      String unitId, String? patientId, String fromDate, String toDate) async {
    isLoading.value = true;
    update();

    final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiNames.getInvestigationResultData}?unitId=$unitId&patientId=$patientId&fromDate=$fromDate&toDate=$toDate');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    try {
      final response = await ioClient.get(uri, headers: headers);
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Response: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        investReportModel = InvestigationChartReportModel.fromJson(data);
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        update();
      }
    } catch (e) {
      debugPrint("Error: $e");
      isLoading.value = false;
      update();
    }
  }

  /// returns the latest non-null/non-empty value for a metric based on the
  /// order of model.dates (dates assumed sorted ascending as in your JSON)
  String? getLatestValue(VitalReportModel model, String metric) {
    final metricMap = model.data[metric];
    if (metricMap == null) return null;

    // walk dates from last to first and return first non-null/non-empty
    for (int i = model.dates.length - 1; i >= 0; i--) {
      final dateKey = model.dates[i];
      final v = metricMap[dateKey];
      if (v != null && v.toString().trim().isNotEmpty) return v.toString();
    }
    return null;
  }

  String? getLatestValueInvest(
      InvestigationChartReportModel model, String metric) {
    final metricMap = model.data[metric];
    if (metricMap == null) return null;

    // walk dates from last to first and return first non-null/non-empty
    for (int i = model.dates.length - 1; i >= 0; i--) {
      final dateKey = model.dates[i];
      final v = metricMap[dateKey];
      if (v != null && v.toString().trim().isNotEmpty) return v.toString();
    }
    return null;
  }

  /// returns a list of doubles (or nulls) matching the model.dates order.
  /// Use this list for plotting. Non-parsable strings become null.
  List<double?> getSeriesForMetric(VitalReportModel model, String metric) {
    final metricMap = model.data[metric];
    if (metricMap == null) {
      return List<double?>.filled(model.dates.length, null);
    }

    List<double?> series = [];
    for (final d in model.dates) {
      final raw = metricMap[d];
      if (raw == null) {
        series.add(null);
        continue;
      }
      final s = raw.toString().trim();
      if (s.isEmpty) {
        series.add(null);
        continue;
      }
      // try parse number (handle ints/floats). If it's a duration like 4:0:0, push null or transform
      final numVal = double.tryParse(s);
      if (numVal != null) {
        series.add(numVal);
      } else {
        // try parse HH:MM:SS to minutes or hours if you want numeric plotting
        if (s.contains(':')) {
          try {
            final parts = s.split(':').map((e) => int.parse(e)).toList();
            final double minutes = parts[0] * 60 +
                parts[1] +
                (parts.length > 2 ? parts[2] / 60 : 0);
            series.add(minutes); // or convert to hours dividing by 60
          } catch (_) {
            series.add(null);
          }
        } else {
          series.add(null);
        }
      }
    }
    return series;
  }

  List<double?> getSeriesForMetricInvest(
      InvestigationChartReportModel model, String metric) {
    final metricMap = model.data[metric];
    if (metricMap == null) {
      return List<double?>.filled(model.dates.length, null);
    }

    List<double?> series = [];
    for (final d in model.dates) {
      final raw = metricMap[d];
      if (raw == null) {
        series.add(null);
        continue;
      }
      final s = raw.toString().trim();
      if (s.isEmpty) {
        series.add(null);
        continue;
      }
      // try parse number (handle ints/floats). If it's a duration like 4:0:0, push null or transform
      final numVal = double.tryParse(s);
      if (numVal != null) {
        series.add(numVal);
      } else {
        // try parse HH:MM:SS to minutes or hours if you want numeric plotting
        if (s.contains(':')) {
          try {
            final parts = s.split(':').map((e) => int.parse(e)).toList();
            final double minutes = parts[0] * 60 +
                parts[1] +
                (parts.length > 2 ? parts[2] / 60 : 0);
            series.add(minutes); // or convert to hours dividing by 60
          } catch (_) {
            series.add(null);
          }
        } else {
          series.add(null);
        }
      }
    }
    return series;
  }

  Future<void> getReport(String fromDate, String toDate, String unitId,
      String patientId, int userId) async {
    try {
      IOClient ioClient = IOClient(ByPassCert().httpClient);

      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST',
          Uri.parse('${ApiConstants.ip}${ApiNames.downloadViralChart}'));

      request.body = json.encode({
        "fromDate": fromDate,
        "toDate": toDate,
        "unitId": unitId,
        "patientId": patientId,
        "userId": userId
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await ioClient.send(request);

      if (response.statusCode == 200) {
        // Get file bytes
        final bytes = await response.stream.toBytes();

        // Check Content-Type to determine file type
        final contentType = response.headers['content-type'] ?? '';

        if (contentType.contains('excel') ||
            contentType.contains('spreadsheet')) {
          await saveExcel(bytes);
        } else if (contentType.contains('pdf')) {
          await savePdf(bytes);
        } else {
          // Default to Excel based on your API response
          await saveExcel(bytes);
        }

        debugPrint('Report generated successfully');
      } else {
        debugPrint('Error: ${response.statusCode} - ${response.reasonPhrase}');
        Get.snackbar(
          'Error',
          'Failed to generate report: ${response.reasonPhrase}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint('Error generating report: $e');
      Get.snackbar(
        'Error',
        'Failed to generate report',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> saveExcel(List<int> bytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
      final file = File('${directory.path}/${timestamp}_Vital_Report.xlsx');

      // Write bytes to file
      await file.writeAsBytes(Uint8List.fromList(bytes));

      // Open Excel file
      final result = await OpenFile.open(file.path);

      if (result.type == ResultType.done) {
        Get.snackbar(
          'Success',
          'Excel report generated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Success',
          'Report saved to: ${file.path}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      debugPrint('Error saving Excel: $e');
      Get.snackbar(
        'Error',
        'Failed to save Excel file',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> savePdf(List<int> bytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
      final file = File('${directory.path}/${timestamp}_Vital_Report.pdf');

      await file.writeAsBytes(Uint8List.fromList(bytes));

      await OpenFile.open(file.path);

      Get.snackbar(
        'Success',
        'PDF report generated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('Error saving PDF: $e');
      Get.snackbar(
        'Error',
        'Failed to save PDF',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getReportInvest(String fromDate, String toDate, String unitId,
      String patientId, int userId) async {
    try {
      IOClient ioClient = IOClient(ByPassCert().httpClient);

      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST',
          Uri.parse('${ApiConstants.ip}${ApiNames.downloadInvetsChart}'));

      request.body = json.encode({
        "fromDate": fromDate,
        "toDate": toDate,
        "unitId": unitId,
        "patientId": patientId,
        "userId": userId
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await ioClient.send(request);

      if (response.statusCode == 200) {
        // Get file bytes
        final bytes = await response.stream.toBytes();

        // Check Content-Type to determine file type
        final contentType = response.headers['content-type'] ?? '';

        if (contentType.contains('excel') ||
            contentType.contains('spreadsheet')) {
          await saveExcelInvest(bytes);
        } else if (contentType.contains('pdf')) {
          await savePdfInvset(bytes);
        } else {
          // Default to Excel based on your API response
          await saveExcelInvest(bytes);
        }

        debugPrint('Report generated successfully');
      } else {
        debugPrint('Error: ${response.statusCode} - ${response.reasonPhrase}');
        Get.snackbar(
          'Error',
          'Failed to generate report: ${response.reasonPhrase}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint('Error generating report: $e');
      Get.snackbar(
        'Error',
        'Failed to generate report',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> saveExcelInvest(List<int> bytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
      final file =
          File('${directory.path}/${timestamp}_Investigation_Report.xlsx');

      // Write bytes to file
      await file.writeAsBytes(Uint8List.fromList(bytes));

      // Open Excel file
      final result = await OpenFile.open(file.path);

      if (result.type == ResultType.done) {
        Get.snackbar(
          'Success',
          'Excel report generated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Success',
          'Report saved to: ${file.path}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      debugPrint('Error saving Excel: $e');
      Get.snackbar(
        'Error',
        'Failed to save Excel file',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> savePdfInvset(List<int> bytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
      final file =
          File('${directory.path}/${timestamp}_Investigation_Report.pdf');

      await file.writeAsBytes(Uint8List.fromList(bytes));

      await OpenFile.open(file.path);

      Get.snackbar(
        'Success',
        'PDF report generated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('Error saving PDF: $e');
      Get.snackbar(
        'Error',
        'Failed to save PDF',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
