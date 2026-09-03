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
import 'package:heamodialysis/dashboard/model/nephro_dash_count.dart';
import 'package:heamodialysis/dashboard/screen/super_admin/total_invoice_amount_model.dart';
import 'package:heamodialysis/new_registration/model/viral_status/viral_data.dart';
import 'package:heamodialysis/new_registration/model/viral_status/viral_status_model.dart';
import 'package:heamodialysis/dashboard/repository/dashboard_repository.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardController extends GetxController {
  final DashboardRepository _repository = DashboardRepository();

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

  ViralStatusModel? viralStatusModel;

  Future<bool> getDashCount(fromDate, toDate, mulselUnitId) async {
    isLoading = true;
    update();

    try {
      dashboardCountModel = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getCentralDashboarCount}?fromDate=$fromDate&currentDate=$toDate&unitId=$mulselUnitId",
          DashboardCountModel.fromJson);
      isLoading = false;
      update();

      return true;
    } on ApiException {
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

    String fromD = fromDate;
    String toD = toDate;

    try {
      dashboardCountClusterModel = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getCentralDashboarCount}?fromDate=$fromD&currentDate=$toD&unitId=$userId",
          DashboardCountModel.fromJson);
      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting getDashCount');
    }
  }

  Future<bool> getDash(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      newCountModel = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getNewDashboardCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          NewCountModel.fromJson);
      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getTotalInvoiceAmount() async {
    isLoading = true;
    update();

    try {
      totalInvoiceAmountModel = await _repository.getTotalInvoiceAmount(
          "${ApiConstants.baseUrl4}${ApiNames.getInvoiceAmountDet}");
      isLoading = false;

      update();
      return true;
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDashMis(fromDate, toDate) async {
    isLoading = true;

    try {
      misCount = await _repository.fetchAndParse(
          "${ApiConstants.baseUrlMIS}${ApiNames.misCount}?fromDate=$fromDate&toDate=$toDate",
          MisCountModel.fromJson);
      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDashCountNephro(userId, fromDate, toDate, district) async {
    isLoading = true;

    try {
      nephroCounts = await _repository.fetchAndParse(
          "${ApiConstants.baseUrlNeph}${ApiNames.nephroCount}?fromDate=$fromDate&toDate=$toDate&userId=$userId&distId=$district",
          NephroDashCount.fromJson);
      isLoading = false;
      update();

      return true;
    } on ApiException {
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

    try {
      dashInfoData = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrl4}${ApiNames.patientList}?fromDate=$fromDate&toDate=$toDate&unitId=$uId");

      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getPatientRegSuperAdmin(fromDate, toDate, mulselUnitId) async {
    isLoading = true;
    update();

    try {
      dashInfoDataAdmin = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrl4}${ApiNames.centralpatientList}?fromDate=$fromDate&toDate=$toDate&callFrom=CEND&unitId=$mulselUnitId");

      update();

      isLoading = false;
      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getPatientRegiCluster(fromDate, toDate, userId) async {
    isLoading = true;

    try {
      dashInfoDataCluster = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrlCluster}${ApiNames.clusterWiseTotalPatientReg}?fromDate=$fromDate&toDate=$toDate&userId=$userId");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getPatientRegNephro(fromDate, toDate, district) async {
    isLoading = true;

    try {
      dashInfoDataNephro = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrlNeph}${ApiNames.nephroPatientUnitWiseCount}?fromDate=$fromDate&toDate=$toDate&distId=$district");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getTotalDialysisPatientSuperAdmin(
      fromDate, toDate, unitId) async {
    isLoading = true;

    try {
      totalDialysisPatient = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getpatientListByunitId}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => TotalDialysisPatientModel.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getTotalPatientByIdCluster(fromDate, toDate, unitId) async {
    isLoading = true;

    try {
      totalDialysisPatientCluster = await _repository.fetchAndParse(
          "${ApiConstants.baseUrlCluster}${ApiNames.getpatientListByunitId}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => TotalDialysisPatientModel.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getEventNephroId(fromDate, toDate, unitId) async {
    isLoading = true;

    try {
      nephroEventId = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getEventDetailsInstituteWise}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => EventDetailsId.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getPatientByID(fromDate, toDate, unitId) async {
    isLoading = true;

    try {
      totalPatientByUnit = await _repository.fetchAndParse(
          "${ApiConstants.baseUrlNeph}${ApiNames.nephroPatientByUnitIdCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => TotalDialysisPatientModel.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionCancelIdWise(
      fromDate, toDate, unitId, schemeT) async {
    isLoading = true;
    update();

    try {
      dialysisCancelId = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getMjpDailysisCancelpat}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId&schemeType=$schemeT",
          (data) => (data as List).map((json) => TotalDialysisPatientModel.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionIdWise(
      fromDate, toDate, unitId, schemeT) async {
    isLoading = true;
    update();

    try {
      dialysisSessionId = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getDiaSessionSchemeWise}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId&schemeType=$schemeT",
          (data) => (data as List).map((json) => TotalDialysisPatientModel.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getEventForIdSuperAdmin(fromDate, toDate, unitId) async {
    isLoading = true;

    try {
      eventDetIdList = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getEventDetById}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => EventDetailsId.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getEventForIdCluster(fromDate, toDate, unitId) async {
    isLoading = true;

    try {
      eventDetIdListCluster = await _repository.fetchAndParse(
          "${ApiConstants.baseUrlCluster}${ApiNames.getEventDetById}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => EventDetailsId.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  getEventForIdTech(fromDate, toDate, unitId) async {
    isLoading = true;
    update();

    try {
      final result = await _repository.getEventForIdTech(
          "${ApiConstants.baseUrl4}${ApiNames.getEventDetailsInstituteWise}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

      isLoading = false;
      if (result != null) {
        eventDetIdListTech = result;
        update();
      }
    } on ApiException {
      eventDetIdListTech = null;
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getAbhaIdSuperAdmin(fromDate, toDate, unitId) async {
    isLoading = true;

    try {
      abhaDetIdList = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrl4}${ApiNames.abhaPatientById}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting getAbhaIdSuperAdmin count');
    }
  }

  Future<bool> getAbhaIdSuperCluster(fromDate, toDate, unitId) async {
    isLoading = true;

    try {
      abhaDetIdListCluster = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrlCluster}${ApiNames.abhaPatientById}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting getAbhaIdSuperCluster count');
    }
  }

  Future<bool> getDiaSessSuperAdmin(fromDate, toDate, unitId) async {
    isLoading = true;

    try {
      dialysisPatient = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getDialysisSessionDataByID}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId&callFrom=CEND&userType=SUPERADMIN",
          (data) => (data as List).map((json) => TotalDialysisPatientModel.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDiaSessionIDCluster(fromDate, toDate, unitId) async {
    isLoading = true;

    try {
      dialysisSessionByIDCluster = await _repository.fetchAndParse(
          "${ApiConstants.baseUrlCluster}${ApiNames.getDialysisSessionDataByID}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => TotalDialysisPatientModel.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDiaSessSuperNephro(fromDate, toDate, unitId) async {
    isLoading = true;

    try {
      dialysisPatientIDNephro = await _repository.fetchAndParse(
          "${ApiConstants.baseUrlNeph}${ApiNames.nephroDialSessionPatDetailsById}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => TotalDialysisPatientModel.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDiaSessCancelNephro(fromDate, toDate, unitId) async {
    isLoading = true;

    try {
      dialysisCancelNephro = await _repository.fetchAndParse(
          "${ApiConstants.baseUrlNeph}${ApiNames.nephroDialCancelPatDetailsById}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => TotalDialysisPatientModel.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getFunctionalUnitList(fromDate, toDate, unitId) async {
    isLoading = true;
    update();

    try {
      dashInfoFunctionalUnit = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrl4}${ApiNames.getUnitInfo}?fromDate=$fromDate&toDate=$toDate&callFrom=CEND&userType=SUPER ADMIN&unitId=$unitId");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getFunctionalUnitListCluster(fromDate, toDate, userId) async {
    isLoading = true;

    try {
      dashInfoFunctionalUnitCluster = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrl4}${ApiNames.getUnitInfo}?fromDate=$fromDate&toDate=$toDate&callFrom=CEND&userType=SUPER ADMIN&unitId=$userId");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getAbhaPatientTechnician(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      dashInfoDataAdmin = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrl4}${ApiNames.abhaPatientList}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getEventNephro(district, fromDate, toDate) async {
    isLoading = true;

    try {
      nephroEvent = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrlNeph}${ApiNames.nephroEventDet}?fromDate=$fromDate&toDate=$toDate&distId=$district");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getAbhaPatientAdmin(fromDate, toDate, mulselUnitId) async {
    isLoading = true;
    update();

    try {
      dashInfoDataAbhaAdmin = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrl4}${ApiNames.centralAbhaPatientList}?fromDate=$fromDate&toDate=$toDate&unitId=$mulselUnitId");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed abha table count');
    }
  }

  Future<bool> getAbhaPatientCluster(fromDate, toDate, userId) async {
    isLoading = true;

    try {
      dashInfoDataAbhaCluster = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrl4}${ApiNames.centralAbhaPatientList}?fromDate=$fromDate&toDate=$toDate&unitId=$userId");

      isLoading = false;
      update();

      return true;
    } on ApiException {
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

    try {
      dialysisSession = await _repository.fetchRawJson(
          "${ApiConstants.baseUrl4}${ApiNames.getDialSessiondetailsCOunt}?fromDate=$fromDate&toDate=$toDate&unitId=$uId");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionAdmin(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      dialysisSessionAdmin = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.centralDilSessionCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId&callFrom=CEND",
          (data) => (data as List).map((json) => DashInfoTotal.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionCluster(fromDate, toDate, userId) async {
    isLoading = true;

    try {
      dialysisSessionCluster = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.centralDilSessionCount}?fromDate=$fromDate&toDate=$toDate&unitId=$userId",
          (data) => (data as List).map((json) => DashInfoTotal.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionNephro(district, fromDate, toDate) async {
    isLoading = true;

    try {
      dialysisSessionNephro = await _repository.fetchAndParse(
          "${ApiConstants.baseUrlNeph}${ApiNames.nephroDialSessionCount}?fromDate=$fromDate&toDate=$toDate&distId=$district",
          (data) => (data as List).map((json) => DashInfoTotal.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionCancelNephro(
      district, fromDate, toDate) async {
    isLoading = true;

    try {
      dialysisSessionCancelNephro = await _repository.fetchAndParse(
          "${ApiConstants.baseUrlNeph}${ApiNames.nephroDialCancelCount}?fromDate=$fromDate&toDate=$toDate&distId=$district",
          (data) => (data as List).map((json) => DashInfoTotal.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionCancelled(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      dialysisSessionCancelled = await _repository.fetchRawJson(
          "${ApiConstants.baseUrl4}${ApiNames.getcancelDialysisDetails}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionCancelledAdmin(
      unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      dialysisSessionCancelledAdmin = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getCancelDialsisDet}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => DashInfoTotal.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getDialysisSessionCancelledCluster(
      fromDate, toDate, userId) async {
    isLoading = true;

    try {
      dialysisSessionCancelledCluster = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getCancelDialsisDet}?fromDate=$fromDate&toDate=$toDate&unitId=$userId",
          (data) => (data as List).map((json) => DashInfoTotal.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getMachineCount(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      machineCountInfo = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.centralMachineDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => DashInfoTotal.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getMachineCountClusterWise(fromDate, toDate, userId) async {
    isLoading = true;

    try {
      machineCountInfoCluster = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.centralMachineDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$userId",
          (data) => (data as List).map((json) => DashInfoTotal.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getTotalTickets(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      totalTickets = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.centralTicketDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId&callFrom=CEND",
          (data) => (data as List).map((json) => DashInfoSubHeader.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting getTotalTickets count');
    }
  }

  Future<bool> getTotalTicketsCluster(fromDate, toDate, userId) async {
    isLoading = true;

    try {
      totalTicketsCluster = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.centralTicketDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$userId",
          (data) => (data as List).map((json) => DashInfoSubHeader.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting getTotalTickets count');
    }
  }

  Future<bool> getBillGenerationDet(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      billGenerationDetails = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getInvoicestatusUnitwise}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => DashInfoSubHeader.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getTicketTechnician(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      ticketTechnician = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getTicketDetails}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => DashInfoSubHeader.fromJson(data));

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getComplaint(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      complaint = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.centralComplaintDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((json) => DashInfoSubHeader.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getComplaintCluster(fromDate, toDate, userId) async {
    isLoading = true;

    try {
      complaintCluster = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.centralComplaintDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$userId",
          (data) => (data as List).map((json) => DashInfoSubHeader.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getComplaintTechnician(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      complaintTechnician = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getComplaintDetails}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => DashInfoSubHeader.fromJson(data));

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  getTestDet(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      final result = await _repository.getTestDet(
          "${ApiConstants.baseUrl4}${ApiNames.gettestDetailsUnitwise}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId");

      isLoading = false;
      if (result != null) {
        testDetails = result;
        update();
      }
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getTestDetClusterWise(fromDate, toDate, userId) async {
    isLoading = true;

    try {
      testDetailsCluster = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.gettestDetailsUnitwise}?fromDate=$fromDate&toDate=$toDate&unitId=$userId",
          (data) => (data as List).map((json) => DashInfoSubHeader.fromJson(json)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  getLaboratoryAss(unitId, fromDate, toDate) async {
    isLoading = true;
    update();

    try {
      final result = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getTestDetails}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => DashInfoSubHeader.fromJson(data));

      labtestDetails ??= [];
      labtestDetails?.add(result);

      debugPrint("Lab test details updated: ${labtestDetails?.length}");
      update();
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

    try {
      eventDetAdmin = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrl4}${ApiNames.getEventDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId&callFrom=CEND");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getEventDetailCluster(fromDate, toDate, userId) async {
    isLoading = true;

    try {
      eventDetCluster = await _repository.getPatientRegTechnician(
          "${ApiConstants.baseUrl4}${ApiNames.getEventDetailsCount}?fromDate=$fromDate&toDate=$toDate&unitId=$userId");

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting dash count');
    }
  }

  Future<bool> getChartData(fromDate, toDate, baseUrl) async {
    isLoading = true;
    update();

    try {
      barChartModel = await _repository.fetchAndParse(
          "$baseUrl${ApiNames.getTopInstitute}?fromDate=$fromDate&toDate=$toDate",
          (data) => (data as List).map((item) => BarChartModel.fromJson(item)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  getOnGoingDialysisSession(fromDate, toDate, unitId) async {
    isLoading = true;
    update();

    try {
      onGoingDiaList = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getOngoingDialysis}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((item) => BarChartModel.fromJson(item)).toList());

      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting getOnGoingDialysisSession');
    }
  }

  Future<bool> getChartDataAbha(fromDate, toDate, unitId) async {
    isLoading = true;
    update();

    try {
      barChartModelAbha = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getTopAbhaInstitute}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((item) => BarChartModel.fromJson(item)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting getChartDataAbha');
    }
  }

  Future<bool> getChartDataAbhaCluster(fromDate, toDate) async {
    isLoading = true;

    try {
      barChartModelAbhaCluster = await _repository.fetchAndParse(
          "${ApiConstants.baseUrlCluster}${ApiNames.getTopAbhaInstitute}?fromDate=$fromDate&toDate=$toDate",
          (data) => (data as List).map((item) => BarChartModel.fromJson(item)).toList());

      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting getChartDataAbha');
    }
  }

  Future<bool> getSchemePerformance(fromDate, toDate, unitId) async {
    isLoading = true;
    update();

    try {
      schemePerfList = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getSchemePreformance}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          (data) => (data as List).map((item) => ChartData.fromJson(item)).toList());

      isLoading = false;

      dates = schemePerfList
          .map((entry) => DateFormat("yyyy-MM").parse(entry.month))
          .toList();

      mjpjayCounts = schemePerfList.map((entry) => entry.mjpjayCount).toList();

      nonMjpjayCounts =
          schemePerfList.map((entry) => entry.nonMjpjayCount).toList();
      update();

      return true;
    } on ApiException {
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

    try {
      countDescript = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getviralStatusCount}?fromDate=$fromDate&toDate=$toDate&unitId=$unitId",
          NewCountModel.fromJson);
      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  Future<bool> getRadialChartCluster(fromDate, toDate, userId) async {
    isLoading = true;

    try {
      countDescriptCluster = await _repository.fetchAndParse(
          "${ApiConstants.baseUrlCluster}${ApiNames.getviralStatusCount}?fromDate=$fromDate&toDate=$toDate&userId=$userId",
          NewCountModel.fromJson);
      isLoading = false;
      update();

      return true;
    } on ApiException {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  Future<bool> getViralStatueList() async {
    isLoading = true;
    update();

    try {
      viralStatusModel = await _repository.fetchAndParse(
          ApiConstants.baseUrl + ApiNames.getViralStatus, ViralStatusModel.fromJson);

      isLoading = false;
      update();
      return true;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode == 401) {
        update();
        return false;
      }
      throw Exception('Failed getting getViralStatueList');
    }
  }

  getDashboardShort(String userId) async {
    isLoading = true;
    update();

    try {
      deptList = await _repository.fetchAndParse(
          "${ApiConstants.baseUrl4}${ApiNames.getDashboardShortCode}?userId=$userId",
          (data) => DashboardShortCodeModel.fromJson(data));

      isLoading = false;
      update();
      return true;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode == 401) {
        update();
        return false;
      }
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
