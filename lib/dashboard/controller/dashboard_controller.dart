import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/widget/dash_info_table_total.dart';
import 'package:heamodialysis/dashboard/model/bar_chart_model.dart';
import 'package:heamodialysis/dashboard/model/dash_info_data.dart';
import 'package:heamodialysis/dashboard/model/dashboard_count_model.dart';
import 'package:heamodialysis/dashboard/model/dashboard_shortcode_model.dart';
import 'package:heamodialysis/dashboard/model/event_details_id.dart';
import 'package:heamodialysis/dashboard/model/mis_count_model.dart';
import 'package:heamodialysis/dashboard/model/new_count_model.dart';
import 'package:heamodialysis/dashboard/model/radial_chart_data.dart';
import 'package:heamodialysis/dashboard/model/total_dialysis_patient_model.dart';
import 'package:heamodialysis/dashboard/screen/nephro_first_level/model/nephro_dash_count.dart';
import 'package:heamodialysis/dashboard/screen/super_admin/total_invoice_amount_model.dart';
import 'package:heamodialysis/new_registration/model/viral_status/viral_data.dart';
import 'package:heamodialysis/new_registration/model/viral_status/viral_status_model.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardController extends GetxController {
  DashboardCountModel? dashboardCountModel;
  DashboardCountModel? dashboardCountClusterModel;
  NewCountModel? newCountModel;
  MisCountModel? misCount;
  NephroDashCount? nephroCounts;
  List<DashInfoData>? dashInfoData;
  List<DashInfoData>? dashInfoDataAdmin;
  List<DashInfoData>? dashInfoDataCluster;
  List<DashInfoData>? nephroEvent;
  List<DashInfoData>? dashInfoDataNephro;
  List<TotalDialysisPatientModel>? totalDialysisPatient;
  List<TotalDialysisPatientModel>? totalDialysisPatientCluster;
  List<EventDetailsId>? nephroEventId;
  List<TotalDialysisPatientModel>? totalPatientByUnit;
  List<TotalDialysisPatientModel>? dialysisCancelId;
  List<TotalDialysisPatientModel>? dialysisSessionId;
  List<EventDetailsId>? eventDetIdList;
  List<EventDetailsId>? eventDetIdListCluster;
  List<EventDetailsId>? eventDetIdListTech;
  List<DashInfoData>? abhaDetIdList;
  List<DashInfoData>? abhaDetIdListCluster;
  List<TotalDialysisPatientModel>? dialysisPatient;
  List<TotalDialysisPatientModel>? dialysisSessionByIDCluster;
  List<TotalDialysisPatientModel>? dialysisPatientIDNephro;
  List<TotalDialysisPatientModel>? dialysisCancelNephro;
  List<DashInfoData>? dashInfoFunctionalUnit;
  List<DashInfoData>? dashInfoFunctionalUnitCluster;
  List<DashInfoData>? dashInfoDataAbhaAdmin;
  List<DashInfoData>? dashInfoDataAbhaCluster;
  List<BarChartModel> barChartModel = [];
  List<BarChartModel> onGoingDiaList = [];
  List<BarChartModel> barChartModelAbha = [];
  List<BarChartModel> barChartModelAbhaCluster = [];
  List<ChartData> schemePerfList = [];
  RadialChartData? radialChartData;
  NewCountModel? countDescript;
  NewCountModel? countDescriptCluster;

  TextEditingController fDateController = TextEditingController();
  TextEditingController tDateController = TextEditingController();

  DateTime? selectedToDate;
  String? formattedToDate;
  DateTime? selectedFromDate;
  String? formattedFromDate;
  bool isCustomCalender = false;
  bool isTodaysDate = true;

  bool isLoading = false;
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  ViralStatusModel? viralStatusModel;

  Future<bool> getDashCount(fromDate, toDate, mulselUnitId) async {
    isLoading = true;
    update();
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getCentralDashboarCount}?fromDate=$fromDate&currentDate=$toDate&unitId=$mulselUnitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("API URL: $uri");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      dashboardCountModel = DashboardCountModel.fromJson(data);
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getDashCount');
    }
  }

  getVersionName() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  Future<bool> getDashCountClusterDistrictWise(fromDate, toDate, userId) async {
    isLoading = true;
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    String fromD = fromDate;
    String toD = toDate;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getCentralDashboarCount}?fromDate=$fromD&currentDate=$toD&unitId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("API URL: $uri");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      dashboardCountClusterModel = DashboardCountModel.fromJson(data);
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getDashCount');
    }
  }

  Future<bool> getDash(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getNewDashboardCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("API URL: $uri");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      newCountModel = NewCountModel.fromJson(data);
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getTotalInvoiceAmount() async {
    isLoading = true;
    update();

    final uri =
        Uri.parse("${ApiConstants.baseUrl4}${ApiNames.getInvoiceAmountDet}");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      // Parse response body correctly
      final List<dynamic> data = json.decode(response.body);

      // Convert list of JSON to list of models
      totalInvoiceAmountModel = data
          .map<TotalInvoiceAmountModel>(
              (json) => TotalInvoiceAmountModel.fromJson(json))
          .toList();

      update();
      return true;
    } else {
      isLoading = false;
      update();
      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDashMis(fromDate, toDate) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlMIS}${ApiNames.misCount}?fromDate=$fromDate&toDate=$toDate");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      misCount = MisCountModel.fromJson(data);
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDashCountNephro(userId, fromDate, toDate, district) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlNeph}${ApiNames.nephroCount}?fromDate=$fromDate&toDate=$toDate&userId=$userId&distId=$district");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("API URL: $uri");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      nephroCounts = NephroDashCount.fromJson(data);
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  getPatientRegTechnician(unitId, fromDate, toDate) async {
    String uId;
    if (unitId == "1") {
      uId = "0";
    } else {
      uId = unitId;
    }
    isLoading = true;
    update();
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.patientList}?fromDate=$fromDate&toDate=$toDate&unitId=$uId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("API URL-->: $uri");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dashInfoData = data.map((json) => DashInfoData.fromJson(json)).toList();

      update();
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getPatientRegSuperAdmin(fromDate, toDate, mulselUnitId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.centralpatientList}?fromDate=$fromDate&toDate=$toDate&callFrom=CEND&unitId=$mulselUnitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dashInfoDataAdmin =
          data.map((json) => DashInfoData.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getPatientRegiCluster(fromDate, toDate, userId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlCluster}${ApiNames.clusterWiseTotalPatientReg}?fromDate=$fromDate&toDate=$toDate&userId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dashInfoDataCluster =
          data.map((json) => DashInfoData.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getPatientRegNephro(fromDate, toDate, district) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlNeph}${ApiNames.nephroPatientUnitWiseCount}?fromDate=$fromDate&toDate=$toDate&distId=$district");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dashInfoDataNephro =
          data.map((json) => DashInfoData.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getTotalDialysisPatientSuperAdmin(
      fromDate, toDate, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getpatientListByunitId}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      totalDialysisPatient =
          data.map((json) => TotalDialysisPatientModel.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getTotalPatientByIdCluster(fromDate, toDate, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlCluster}${ApiNames.getpatientListByunitId}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      totalDialysisPatientCluster =
          data.map((json) => TotalDialysisPatientModel.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getEventNephroId(fromDate, toDate, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getEventDetailsInstituteWise}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      nephroEventId =
          data.map((json) => EventDetailsId.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getPatientByID(fromDate, toDate, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlNeph}${ApiNames.nephroPatientByUnitIdCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      totalPatientByUnit =
          data.map((json) => TotalDialysisPatientModel.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionCancelIdWise(
      fromDate, toDate, unitId, schemeT) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getMjpDailysisCancelpat}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId&schemeType=$schemeT");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dialysisCancelId =
          data.map((json) => TotalDialysisPatientModel.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionIdWise(
      fromDate, toDate, unitId, schemeT) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getDiaSessionSchemeWise}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId&schemeType=$schemeT");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(
        "--------------------- getDialysisSessionIdWise API ---------------------");
    debugPrint("API URL: ${uri.toString()}");

    final response = await ioClient.get(uri, headers: headers);
    debugPrint("API STATUS CODE: ${response.statusCode}");
    debugPrint("API RESPONSE: ${response.body}");
    debugPrint(
        "------------------------------------------------------------------");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dialysisSessionId =
          data.map((json) => TotalDialysisPatientModel.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getEventForIdSuperAdmin(fromDate, toDate, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getEventDetById}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      eventDetIdList =
          data.map((json) => EventDetailsId.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getEventForIdCluster(fromDate, toDate, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlCluster}${ApiNames.getEventDetById}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      eventDetIdListCluster =
          data.map((json) => EventDetailsId.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  getEventForIdTech(fromDate, toDate, unitId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getEventDetailsInstituteWise}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        isLoading = false;

        if (json.decode(response.body) is List) {
          //getDeviceDetails
          List<dynamic> data = json.decode(response.body);

          eventDetIdListTech =
              data.map((json) => EventDetailsId.fromJson(json)).toList();

          update();
        }
      }
    } else {
      eventDetIdListTech = null;
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getAbhaIdSuperAdmin(fromDate, toDate, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.abhaPatientById}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      abhaDetIdList = data.map((json) => DashInfoData.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getAbhaIdSuperAdmin count');
    }
  }

  Future<bool> getAbhaIdSuperCluster(fromDate, toDate, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlCluster}${ApiNames.abhaPatientById}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      abhaDetIdListCluster =
          data.map((json) => DashInfoData.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getAbhaIdSuperCluster count');
    }
  }

  Future<bool> getDiaSessSuperAdmin(fromDate, toDate, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getDialysisSessionDataByID}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId&callFrom=CEND&userType=SUPERADMIN");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dialysisPatient =
          data.map((json) => TotalDialysisPatientModel.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDiaSessionIDCluster(fromDate, toDate, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlCluster}${ApiNames.getDialysisSessionDataByID}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dialysisSessionByIDCluster =
          data.map((json) => TotalDialysisPatientModel.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDiaSessSuperNephro(fromDate, toDate, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlNeph}${ApiNames.nephroDialSessionPatDetailsById}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dialysisPatientIDNephro =
          data.map((json) => TotalDialysisPatientModel.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDiaSessCancelNephro(fromDate, toDate, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlNeph}${ApiNames.nephroDialCancelPatDetailsById}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dialysisCancelNephro =
          data.map((json) => TotalDialysisPatientModel.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getFunctionalUnitList(fromDate, toDate, unitId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getUnitInfo}?fromDate=$fromDate&toDate=$toDate&callFrom=CEND&userType=SUPER ADMIN&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dashInfoFunctionalUnit =
          data.map((json) => DashInfoData.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getFunctionalUnitListCluster(fromDate, toDate, userId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getUnitInfo}?fromDate=$fromDate&toDate=$toDate&callFrom=CEND&userType=SUPER ADMIN&unitId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dashInfoFunctionalUnitCluster =
          data.map((json) => DashInfoData.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getAbhaPatientTechnician(unitId, fromDate, toDate) async {
    // String uId;

    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.abhaPatientList}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("API URL: $uri");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dashInfoDataAdmin =
          data.map((json) => DashInfoData.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getEventNephro(district, fromDate, toDate) async {
    // String uId;

    isLoading = true;

    final uri = Uri.parse(
        "${ApiConstants.baseUrlNeph}${ApiNames.nephroEventDet}?fromDate=$fromDate&toDate=$toDate&distId=$district");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      nephroEvent = data.map((json) => DashInfoData.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getAbhaPatientAdmin(fromDate, toDate, mulselUnitId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.centralAbhaPatientList}?fromDate=$fromDate&toDate=$toDate&unitId=$mulselUnitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dashInfoDataAbhaAdmin =
          data.map((json) => DashInfoData.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed abha table count');
    }
  }

  Future<bool> getAbhaPatientCluster(fromDate, toDate, userId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.centralAbhaPatientList}?fromDate=$fromDate&toDate=$toDate&unitId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);
      dashInfoDataAbhaCluster =
          data.map((json) => DashInfoData.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed abha table count');
    }
  }

  Future<bool> getDialysisSession(unitId, fromDate, toDate) async {
    String uId;
    if (unitId == "1") {
      uId = "0";
    } else {
      uId = unitId;
    }
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getDialSessiondetailsCOunt}?fromDate=$fromDate&toDate=$toDate&unitId=$uId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(
        "--------------------- getDialysisSession API ---------------------");
    debugPrint("API URL: ${uri.toString()}");

    final response = await ioClient.get(uri, headers: headers);
    debugPrint("API STATUS CODE: ${response.statusCode}");
    debugPrint("API RESPONSE: ${response.body}");
    debugPrint(
        "------------------------------------------------------------------");

    if (response.statusCode == 200) {
      isLoading = false;

      dialysisSession = json.decode(response.body);

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionAdmin(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.centralDilSessionCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId&callFrom=CEND");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      List<dynamic> jsonData = jsonDecode(response.body);
      dialysisSessionAdmin =
          jsonData.map((json) => DashInfoTotal.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionCluster(fromDate, toDate, userId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.centralDilSessionCount}?fromDate=$fromDate&toDate=$toDate&unitId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      List<dynamic> jsonData = jsonDecode(response.body);
      dialysisSessionCluster =
          jsonData.map((json) => DashInfoTotal.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionNephro(district, fromDate, toDate) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlNeph}${ApiNames.nephroDialSessionCount}?fromDate=$fromDate&toDate=$toDate&distId=$district");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      List<dynamic> jsonData = jsonDecode(response.body);
      dialysisSessionNephro =
          jsonData.map((json) => DashInfoTotal.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionCancelNephro(
      district, fromDate, toDate) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlNeph}${ApiNames.nephroDialCancelCount}?fromDate=$fromDate&toDate=$toDate&distId=$district");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      List<dynamic> jsonData = jsonDecode(response.body);
      dialysisSessionCancelNephro =
          jsonData.map((json) => DashInfoTotal.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionCancelled(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getcancelDialysisDetails}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      dialysisSessionCancelled = json.decode(response.body);

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionCancelledAdmin(
      unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getCancelDialsisDet}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      List<dynamic> jsonData = jsonDecode(response.body);
      dialysisSessionCancelledAdmin =
          jsonData.map((json) => DashInfoTotal.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionCancelledCluster(
      fromDate, toDate, userId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getCancelDialsisDet}?fromDate=$fromDate&toDate=$toDate&unitId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      List<dynamic> jsonData = jsonDecode(response.body);
      dialysisSessionCancelledCluster =
          jsonData.map((json) => DashInfoTotal.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getMachineCount(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.centralMachineDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      List<dynamic> jsonData = jsonDecode(response.body);
      machineCountInfo =
          jsonData.map((json) => DashInfoTotal.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getMachineCountClusterWise(fromDate, toDate, userId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.centralMachineDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      List<dynamic> jsonData = jsonDecode(response.body);
      machineCountInfoCluster =
          jsonData.map((json) => DashInfoTotal.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getTotalTickets(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.centralTicketDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId&callFrom=CEND");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      List<dynamic> jsonData = jsonDecode(response.body);
      totalTickets =
          jsonData.map((json) => DashInfoSubHeader.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getTotalTickets count');
    }
  }

  Future<bool> getTotalTicketsCluster(fromDate, toDate, userId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.centralTicketDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      List<dynamic> jsonData = jsonDecode(response.body);
      totalTicketsCluster =
          jsonData.map((json) => DashInfoSubHeader.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getTotalTickets count');
    }
  }

  Future<bool> getBillGenerationDet(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getInvoicestatusUnitwise}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      List<dynamic> jsonData = jsonDecode(response.body);
      billGenerationDetails =
          jsonData.map((json) => DashInfoSubHeader.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getTicketTechnician(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getTicketDetails}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      var jsonData = jsonDecode(response.body);
      ticketTechnician = DashInfoSubHeader.fromJson(jsonData);

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getComplaint(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.centralComplaintDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      List<dynamic> jsonData = jsonDecode(response.body);
      complaint =
          jsonData.map((json) => DashInfoSubHeader.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getComplaintCluster(fromDate, toDate, userId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.centralComplaintDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      List<dynamic> jsonData = jsonDecode(response.body);
      complaintCluster =
          jsonData.map((json) => DashInfoSubHeader.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getComplaintTechnician(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getComplaintDetails}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      var jsonData = jsonDecode(response.body);
      complaintTechnician = DashInfoSubHeader.fromJson(jsonData);

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  getTestDet(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.gettestDetailsUnitwise}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      if (response.body.isNotEmpty) {
        List<dynamic> jsonData = jsonDecode(response.body);
        testDetails =
            jsonData.map((json) => DashInfoSubHeader.fromJson(json)).toList();

        update();
      }
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getTestDetClusterWise(fromDate, toDate, userId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.gettestDetailsUnitwise}?fromDate=$fromDate&toDate=$toDate&unitId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      List<dynamic> jsonData = jsonDecode(response.body);
      testDetailsCluster =
          jsonData.map((json) => DashInfoSubHeader.fromJson(json)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  getLaboratoryAss(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getTestDetails}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    try {
      final response = await ioClient.get(uri, headers: headers);

      debugPrint("Status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        labtestDetails ??= [];

        labtestDetails?.add(DashInfoSubHeader.fromJson(jsonData));

        debugPrint("Lab test details updated: ${labtestDetails?.length}");
        update();
      } else {
        throw Exception('Failed to fetch test details: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error occurred: $e");
    } finally {
      isLoading = false;
      update(); // Update UI for loading state
    }
  }

  // Future<bool> getEventDetail(unitId, fromDate, toDate) async {
  //   String uId;
  //   if (unitId == "1") {
  //     uId = "0";
  //   } else {
  //     uId = unitId;
  //   }
  //   isLoading = true;
  //   final uri = Uri.parse(
  //       "${ApiConstants.baseUrl4}${ApiConstants.getEventDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$uId");
  //
  //   // String jsonbody = json.encode(body);
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //   };
  //
  //   debugPrint(uri.path);
  //
  //   final response = await ioClient.get(uri, headers: headers);
  //   debugPrint(response.statusCode.toString());
  //   debugPrint("response.body : ${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     isLoading = false;
  //     //getDeviceDetails
  //     eventOccured = json.decode(response.body);
  //
  //     update();
  //
  //     return true;
  //   } else {
  //     isLoading = false;
  //     update();
  //
  //     throw Exception('Failed getting dash count');
  //   }
  // }

  // Future<bool> getPatientRegSuperAdmin(fromDate, toDate) async {
  //   isLoading = true;
  //   final uri = Uri.parse(
  //       "${ApiConstants.baseUrl4}${ApiConstants
  //           .CentralpatientList}?fromDate=$fromDate&toDate=$toDate&callFrom=CEND");
  //
  //   // String jsonbody = json.encode(body);
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //   };
  //
  //   debugPrint(uri.path);
  //
  //   final response = await ioClient.get(uri, headers: headers);
  //   debugPrint(response.statusCode.toString());
  //   debugPrint("response.body : ${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     isLoading = false;
  //     //getDeviceDetails
  //     List<dynamic> data = json.decode(response.body);
  //     dashInfoDataAdmin =
  //         data.map((json) => DashInfoData.fromJson(json)).toList();
  //
  //     update();
  //
  //     return true;
  //   } else {
  //     isLoading = false;
  //     update();
  //
  //     throw Exception('Failed getting dash count');
  //   }
  // }

  Future<bool> getEventDetailAdmin(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getEventDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId&callFrom=CEND");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      // Decode response
      List<dynamic> jsonData = jsonDecode(response.body);

      // Map response to model list
      // eventDetAdmin =
      //     jsonData.map((item) => AdminEventDetails.fromJson(item)).toList();
      eventDetAdmin =
          jsonData.map((item) => DashInfoData.fromJson(item)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getEventDetailCluster(fromDate, toDate, userId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getEventDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$userId");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      // Decode response
      List<dynamic> jsonData = jsonDecode(response.body);

      // Map response to model list
      // eventDetAdmin =
      //     jsonData.map((item) => AdminEventDetails.fromJson(item)).toList();
      eventDetCluster =
          jsonData.map((item) => DashInfoData.fromJson(item)).toList();

      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getChartData(fromDate, toDate, baseUrl) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "$baseUrl${ApiNames.getTopInstitute}?fromDate=$fromDate&toDate=$toDate");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);

      barChartModel = data.map((item) => BarChartModel.fromJson(item)).toList();
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  getOnGoingDialysisSession(fromDate, toDate, unitId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getOngoingDialysis}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);

      onGoingDiaList =
          data.map((item) => BarChartModel.fromJson(item)).toList();
      update();
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getOnGoingDialysisSession');
    }
  }

  Future<bool> getChartDataAbha(fromDate, toDate, unitId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getTopAbhaInstitute}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body ---: ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);

      barChartModelAbha =
          data.map((item) => BarChartModel.fromJson(item)).toList();
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getChartDataAbha');
    }
  }

  Future<bool> getChartDataAbhaCluster(fromDate, toDate) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlCluster}${ApiNames.getTopAbhaInstitute}?fromDate=$fromDate&toDate=$toDate");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);

      barChartModelAbhaCluster =
          data.map((item) => BarChartModel.fromJson(item)).toList();
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getChartDataAbha');
    }
  }

  Future<bool> getSchemePerformance(fromDate, toDate, unitId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getSchemePreformance}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      List<dynamic> data = json.decode(response.body);

      schemePerfList = data.map((item) => ChartData.fromJson(item)).toList();

      dates = schemePerfList
          .map((entry) => DateFormat("yyyy-MM").parse(entry.month))
          .toList();

      mjpjayCounts = schemePerfList.map((entry) => entry.mjpjayCount).toList();

      nonMjpjayCounts =
          schemePerfList.map((entry) => entry.nonMjpjayCount).toList();
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting schemePerfList');
    }
  }

  final List<Color> color = [
    const Color(0xFF81C784),
    const Color(0xFFFBC02D),
    // Colors.yellow,
    const Color(0xFFE53935),
    const Color(0xFFF48FB1),
    const Color(0xFF387de3),
  ];

  var dialysisSession;

  var dialysisSessionCancelled;

  var eventOccured;

  List<DashInfoTotal>? dialysisSessionAdmin;
  List<DashInfoTotal>? dialysisSessionCluster;
  List<DashInfoTotal>? dialysisSessionNephro;
  List<DashInfoTotal>? dialysisSessionCancelNephro;

  List<DashInfoTotal>? dialysisSessionCancelledAdmin;
  List<DashInfoTotal>? dialysisSessionCancelledCluster;

  List<DashInfoTotal>? machineCountInfo;
  List<DashInfoTotal>? machineCountInfoCluster;

  List<DashInfoSubHeader>? totalTickets;
  List<DashInfoSubHeader>? totalTicketsCluster;

  List<DashInfoSubHeader>? complaint;
  List<DashInfoSubHeader>? complaintCluster;

  List<DashInfoSubHeader>? testDetails;
  List<DashInfoSubHeader>? testDetailsCluster;
  List<DashInfoSubHeader>? labtestDetails = [];

  List<DashInfoData>? eventDetAdmin;
  List<DashInfoData>? eventDetCluster;

  DashInfoSubHeader? complaintTechnician;

  DashInfoSubHeader? ticketTechnician;

  List<DashInfoSubHeader> billGenerationDetails = [];

  List<DateTime>? dates;

  List<int>? mjpjayCounts;

  List<int>? nonMjpjayCounts;

  List<TotalInvoiceAmountModel>? totalInvoiceAmountModel;

  DashboardShortCodeModel? deptList;

  PackageInfo? packageInfo;

  createList() {
    List<ViralData> chartData = [];
    var radialChartData = viralStatusModel?.data ?? [];
    var counts = countDescript;

    for (int i = 0; i < radialChartData.length; i++) {
      if (radialChartData[i].lookupDetDescEn == "Negative") {
        chartData.add(ViralData(
            lookupDetId: radialChartData[i].lookupDetId,
            lookupDetDescEn: radialChartData[i].lookupDetDescEn,
            lookupDetValue: radialChartData[i].lookupDetValue,
            dialColor: color[i],
            count: counts?.negativeCount));
      } else if (radialChartData[i].lookupDetDescEn == "Hepatitis C+") {
        chartData.add(ViralData(
            lookupDetId: radialChartData[i].lookupDetId,
            lookupDetDescEn: radialChartData[i].lookupDetDescEn,
            lookupDetValue: radialChartData[i].lookupDetValue,
            dialColor: color[i],
            count: counts?.hepatiteCpCount));
      } else if (radialChartData[i].lookupDetDescEn == "Hepatitis B+") {
        chartData.add(ViralData(
            lookupDetId: radialChartData[i].lookupDetId,
            lookupDetDescEn: radialChartData[i].lookupDetDescEn,
            lookupDetValue: radialChartData[i].lookupDetValue,
            dialColor: color[i],
            count: counts?.hepatiteBpCount));
      } else if (radialChartData[i].lookupDetDescEn == "HIV+") {
        chartData.add(ViralData(
            lookupDetId: radialChartData[i].lookupDetId,
            lookupDetDescEn: radialChartData[i].lookupDetDescEn,
            lookupDetValue: radialChartData[i].lookupDetValue,
            dialColor: color[i],
            count: counts?.hivCount));
      } else if (radialChartData[i].lookupDetDescEn == "General+") {
        chartData.add(ViralData(
            lookupDetId: radialChartData[i].lookupDetId,
            lookupDetDescEn: radialChartData[i].lookupDetDescEn,
            lookupDetValue: radialChartData[i].lookupDetValue,
            dialColor: color[i],
            count: counts?.generalCount));
      }
    }
    return chartData;
  }

  createListCluster() {
    List<ViralData> chartData = [];
    var radialChartData = viralStatusModel?.data ?? [];
    var counts = countDescriptCluster;

    for (int i = 0; i < radialChartData.length; i++) {
      if (radialChartData[i].lookupDetDescEn == "Negative") {
        chartData.add(ViralData(
            lookupDetId: radialChartData[i].lookupDetId,
            lookupDetDescEn: radialChartData[i].lookupDetDescEn,
            lookupDetValue: radialChartData[i].lookupDetValue,
            dialColor: color[i],
            count: counts?.negativeCount));
      } else if (radialChartData[i].lookupDetDescEn == "Hepatitis C+") {
        chartData.add(ViralData(
            lookupDetId: radialChartData[i].lookupDetId,
            lookupDetDescEn: radialChartData[i].lookupDetDescEn,
            lookupDetValue: radialChartData[i].lookupDetValue,
            dialColor: color[i],
            count: counts?.hepatiteCpCount));
      } else if (radialChartData[i].lookupDetDescEn == "Hepatitis B+") {
        chartData.add(ViralData(
            lookupDetId: radialChartData[i].lookupDetId,
            lookupDetDescEn: radialChartData[i].lookupDetDescEn,
            lookupDetValue: radialChartData[i].lookupDetValue,
            dialColor: color[i],
            count: counts?.hepatiteBpCount));
      } else if (radialChartData[i].lookupDetDescEn == "HIV+") {
        chartData.add(ViralData(
            lookupDetId: radialChartData[i].lookupDetId,
            lookupDetDescEn: radialChartData[i].lookupDetDescEn,
            lookupDetValue: radialChartData[i].lookupDetValue,
            dialColor: color[i],
            count: counts?.hivCount));
      } else if (radialChartData[i].lookupDetDescEn == "General+") {
        chartData.add(ViralData(
            lookupDetId: radialChartData[i].lookupDetId,
            lookupDetDescEn: radialChartData[i].lookupDetDescEn,
            lookupDetValue: radialChartData[i].lookupDetValue,
            dialColor: color[i],
            count: counts?.generalCount));
      }
    }
    return chartData;
  }

  // Future<bool> getRadialChartData() async {
  //   isLoading = true;
  //   final uri =
  //       Uri.parse(ApiConstants.baseUrl3 + ApiConstants.getAllDropDownList);
  //
  //   // String jsonbody = json.encode(body);
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //   };
  //
  //   debugPrint(uri.path);
  //
  //   final response = await http.get(uri, headers: headers);
  //   debugPrint(response.statusCode.toString());
  //   debugPrint("response.body : ${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     isLoading = false;
  //     //getDeviceDetails
  //     final data = json.decode(response.body);
  //
  //     radialChartData = RadialChartData.fromJson(data);
  //     update();
  //
  //     return true;
  //   } else {
  //     isLoading = false;
  //     update();
  //
  //     throw Exception('Failed getting captcha');
  //   }
  // }

  Future<bool> getRadialChart(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getviralStatusCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);

      countDescript = NewCountModel.fromJson(data);
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  Future<bool> getRadialChartCluster(fromDate, toDate, userId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrlCluster}${ApiNames.getviralStatusCount}?fromDate=$fromDate&toDate=$toDate&userId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);

      countDescriptCluster = NewCountModel.fromJson(data);
      update();

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  Future<bool> getViralStatueList() async {
    isLoading = true;
    update();

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getViralStatus);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      viralStatusModel = ViralStatusModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }

  getDashboardShort(String userId) async {
    isLoading = true;
    update();

    final uri = Uri.parse(
        "${ApiConstants.baseUrl4}${ApiNames.getDashboardShortCode}?userId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails

      final List<dynamic> jsonList = jsonDecode(response.body);
      deptList = DashboardShortCodeModel.fromJson(jsonList);

      update();
      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();

      return false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getViralStatueList');
    }
  }
}

class ChartData {
  final String month;
  final int mjpjayCount;
  final int nonMjpjayCount;

  ChartData(
      {required this.month,
      required this.mjpjayCount,
      required this.nonMjpjayCount});

  // Factory method to create ChartData from JSON
  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      month: json['months'] ?? '',
      mjpjayCount: json['mjpjayCount'] ?? 0,
      nonMjpjayCount: json['nonMjpjayCount'] ?? 0,
    );
  }
}
