import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/widget/dash_info_table_admin.dart';
import 'package:heamodialysis/dashboard/widget/dash_info_table_total.dart';
import 'package:heamodialysis/dashboard/controller/dashboard_controller.dart';
import 'package:heamodialysis/dashboard/widget/drawer_screen.dart';
import 'package:heamodialysis/dashboard/widget/functional_center_table.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/bar_chart.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/dash_card.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:heamodialysis/widgets/new_dashcard.dart';
import 'package:heamodialysis/widgets/radila_chart.dart';
import 'package:intl/intl.dart';


class ClusterDistrictWiseDash extends StatefulWidget {
  const ClusterDistrictWiseDash({super.key});

  @override
  State<ClusterDistrictWiseDash> createState() =>
      _ClusterDistrictWiseDashState();
}

class _ClusterDistrictWiseDashState extends State<ClusterDistrictWiseDash>
    with SingleTickerProviderStateMixin {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());

  late TabController tabController;
  bool hasInternet = true;

  var userData;
  String? userType;
  String? userName;
  String? apiDateString;

  @override
  void initState() {
    getUserData();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    checkInternetAndLoadData();
    super.initState();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    hasInternet = connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);

    dashboardController.update();

    if (!hasInternet) return;

    DateTime now = DateTime.now();
    String fromDate = DateFormat('yyyy/MM/dd').format(now);
    String toDate =
        DateFormat('yyyy/MM/dd').format(now.add(const Duration(days: 1)));

    String ui = userData['user_ID'].toString();
    String unitId = userData['unitId'].toString();
    String mulSelunit = userData['mulSelunit'].toString();

    await Future.wait(<Future>[
      dashboardController.getVersionName(),
      dashboardController.getRadialChartCluster(fromDate, toDate, ui),
      dashboardController.getDashCountClusterDistrictWise(fromDate, toDate, ui),
      dashboardController.getChartData(
          fromDate, toDate, ApiConstants.baseUrlCluster),
      dashboardController.getViralStatueList(),
      dashboardController.getChartDataAbhaCluster(fromDate, toDate),
      dashboardController.getPatientRegiCluster(fromDate, toDate, ui),
      dashboardController.getFunctionalUnitListCluster(fromDate, toDate, ui),
      dashboardController.getAbhaPatientCluster(fromDate, toDate, ui),
      dashboardController.getDialysisSessionCluster(
          fromDate, toDate, mulSelunit),
      dashboardController.getDialysisSessionCancelledCluster(
          fromDate, toDate, ui),
      dashboardController.getMachineCountClusterWise(fromDate, toDate, ui),
      dashboardController.getTotalTicketsCluster(fromDate, toDate, ui),
      dashboardController.getComplaintCluster(fromDate, toDate, ui),
      dashboardController.getTestDetClusterWise(fromDate, toDate, ui),
      dashboardController.getEventDetailCluster(fromDate, toDate, ui),
      dashboardController.getBillGenerationDet(unitId, fromDate, toDate),
    ]);

    // Fetch registration data in the background without blocking dashboard load
    Future.wait(<Future>[
      newRegistrationController.getInstituteList(),
    ]);

    dashboardController.isTodaysDate = true;
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);

    userType = userData['user_Type'];
    userName = '${userData['f_name']} ${userData['l_name']}';

    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: context.l10n.dashClusterDistrictDashboard,
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('assets/drawer-icon.png'),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        actions: [
          InkWell(
            onTap: () async {
              DateTime now = DateTime.now();
              String fromDate = DateFormat('yyyy/MM/dd').format(now);
              String toDate = DateFormat('yyyy/MM/dd')
                  .format(now.add(const Duration(days: 1)));
              String toDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

              String ui = userData['user_ID'].toString();
              String unitId = userData['unitId'].toString();
              String mulSelunit = userData['mulSelunit'].toString();

              await Future.wait(<Future>[
                dashboardController.getDashCountClusterDistrictWise(
                    fromDate, toDate, ui),
                dashboardController.getRadialChartCluster(fromDate, toDate, ui),
                dashboardController.getPatientRegiCluster(fromDate, toDate, ui),
                dashboardController.getAbhaPatientCluster(
                    fromDate, toDateTime, ui),
                dashboardController.getFunctionalUnitListCluster(
                    fromDate, toDate, ui),
                dashboardController.getDialysisSessionCluster(
                    fromDate, toDate, mulSelunit),
                dashboardController.getDialysisSessionCancelledCluster(
                    fromDate, toDate, ui),
                dashboardController.getMachineCountClusterWise(
                    fromDate, toDate, ui),
                dashboardController.getTotalTicketsCluster(
                    fromDate, toDate, ui),
                dashboardController.getComplaintCluster(fromDate, toDate, ui),
                dashboardController.getTestDetClusterWise(fromDate, toDate, ui),
                dashboardController.getEventDetailCluster(
                    fromDate, fromDate, ui),
                dashboardController.getChartData(
                    fromDate, toDate, ApiConstants.baseUrlCluster),
                dashboardController.getChartDataAbhaCluster(fromDate, toDate),
                dashboardController.getBillGenerationDet(
                    unitId, fromDate, fromDate),
                newRegistrationController.getInstituteList(),
              ]);

              dashboardController.fDateController.clear();
              dashboardController.tDateController.clear();
              dashboardController.isCustomCalender = false;
              dashboardController.isTodaysDate = true;
              dashboardController.update();
              // DateTime now = DateTime.now();
              // String fromDate = DateFormat('yyyy/MM/dd').format(now);
              // DateTime tomorrow = now.add(const Duration(days: 1));
              // String toDate = DateFormat('yyyy/MM/dd').format(tomorrow);
              //
              // await dashboardController.getDashCountClusterDistrictWise(
              //     fromDate, toDate, userData['user_ID']);
              // await dashboardController.getRadialChartCluster(
              //     fromDate, toDate, userData['user_ID']);
              //
              // String toDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
              // await dashboardController.getPatientRegiCluster(
              //     fromDate, toDate, userData['user_ID']);
              // await dashboardController.getAbhaPatientCluster(
              //     fromDate, toDateTime, userData['user_ID']);
              // await dashboardController.getFunctionalUnitListCluster(
              //     fromDate, toDate, userData['user_ID']);
              // await dashboardController.getDialysisSessionCluster(
              //     fromDate, toDate, userData['user_ID']);
              // await newRegistrationController.getInstituteList();
              //
              // await dashboardController.getDialysisSessionCancelledCluster(
              //     fromDate, toDate, userData['user_ID']);
              // await dashboardController.getMachineCountClusterWise(
              //     fromDate, toDate, userData['user_ID']);
              // await dashboardController.getTotalTicketsCluster(
              //     fromDate, toDate, userData['user_ID']);
              // await dashboardController.getComplaintCluster(
              //     fromDate, toDate, userData['user_ID']);
              // await dashboardController.getTestDetClusterWise(
              //     fromDate, toDate, userData['user_ID']);
              //
              // await dashboardController.getEventDetailCluster(
              //     fromDate, fromDate, userData['user_ID']);
              // await dashboardController.getChartData(
              //     fromDate, toDate, ApiConstants.baseUrlCluster);
              // await dashboardController.getChartDataAbhaCluster(
              //     fromDate, toDate);
              //
              // await dashboardController.getBillGenerationDet(
              //     userData['unitId'].toString(), fromDate, fromDate);
              // dashboardController.fDateController.clear();
              // dashboardController.tDateController.clear();
              // dashboardController.isCustomCalender = false;
              // dashboardController.isTodaysDate = true;
              // dashboardController.update();
            },
            child: CustomText(
                text: context.l10n.dashToday,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                textColor: Colors.black,
                textAlign: TextAlign.start),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              dashboardController.isCustomCalender =
                  !dashboardController.isCustomCalender;
              debugPrint(dashboardController.isCustomCalender.toString());
              dashboardController.update();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset("assets/gradient_calender.png"),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: DrawerScreen(
          userType: userType,
          userName: userName,
          userData: userData,
          packageInfo: dashboardController.packageInfo,
        ),
      ),
      body: GetBuilder<DashboardController>(
          init: DashboardController(),
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ? const ClusterDistrictWiseDashShimmer()
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Visibility(
                              visible: dashboardController.isCustomCalender,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColor.borderColor)),
                                child: Column(
                                  children: [
                                    CustomDateField(
                                      labelText: context.l10n.dashFromDate,
                                      hint: context.l10n.dashSelectDate,
                                      isRequired: false,
                                      callB: () {
                                        selectFromDate();
                                      },
                                      selectedDate:
                                          dashboardController.fDateController,
                                      filledColor: Colors.white,
                                      dontDhowPrefix: false,
                                    ),
                                    CustomDateField(
                                      labelText: context.l10n.dashToDate,
                                      hint: context.l10n.dashSelectDate,
                                      isRequired: false,
                                      callB: () {
                                        selectToDate();
                                      },
                                      selectedDate:
                                          dashboardController.tDateController,
                                      filledColor: Colors.white,
                                      dontDhowPrefix: false,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () async {
                                          String? selectedToDate;
                                          if (controller.tDateController.text
                                              .isNotEmpty) {
                                            DateTime selectedDate =
                                                DateFormat('yyyy/MM/dd').parse(
                                                    controller
                                                        .tDateController.text);
                                            // Add one day to the selected date
                                            DateTime nextDate = selectedDate
                                                .add(const Duration(days: 1));
                                            // Format the new date back to 'yyyy/MM/dd' and update the controller
                                            selectedToDate =
                                                DateFormat('yyyy/MM/dd')
                                                    .format(nextDate);
                                          }

                                          await dashboardController
                                              .getDashCountClusterDistrictWise(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['user_ID']);

                                          await dashboardController.getRadialChartCluster(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['user_ID']);
                                          await dashboardController.getPatientRegiCluster(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['user_ID']);
                                          await dashboardController
                                              .getFunctionalUnitListCluster(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['user_ID']);
                                          await dashboardController.getAbhaPatientCluster(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['user_ID']);
                                          await dashboardController
                                              .getDialysisSessionCluster(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['mulSelunit']);
                                          await dashboardController
                                              .getDialysisSessionCancelledCluster(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['user_ID']);
                                          await dashboardController
                                              .getMachineCountClusterWise(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['user_ID']);
                                          await dashboardController.getTotalTicketsCluster(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['user_ID']);
                                          await dashboardController
                                              .getComplaintCluster(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['user_ID']);
                                          await dashboardController.getTestDetClusterWise(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['user_ID']);

                                          await dashboardController.getEventDetailCluster(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['user_ID']);
                                          dashboardController.isTodaysDate =
                                              false;

                                          await dashboardController
                                              .getChartData(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  ApiConstants.baseUrlCluster);

                                          await dashboardController
                                              .getChartDataAbhaCluster(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);

                                          await dashboardController
                                              .getBillGenerationDet(
                                                  userData['unitId'].toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 20),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppColor
                                                      .primaryBackgroundColor,
                                                  AppColor.secondaryColor
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.search,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  CustomText(
                                                      text: context.l10n.commonSearch,
                                                      fontSize: 16,
                                                      fontFam: "Lato",
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      textColor: Colors.white,
                                                      textAlign: TextAlign.start),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                              ).paddingSymmetric(vertical: 10, horizontal: 10),
                            ),
                            NewDashCard(
                              firstCount: controller
                                  .dashboardCountClusterModel?.totalCentre
                                  .toString(),
                              firstCountText: context.l10n.dashTotalProjectedCenter,
                              secondCount: controller
                                  .dashboardCountClusterModel?.functionalCenter
                                  .toString(),
                              secondCountText: context.l10n.dashFunctionalCenter,
                              iconPath: 'assets/professional-services.png',
                              isInfoVisible: true,
                              onInfoClick: () {
                                Get.to(FunctionalCenterTable(
                                  patients: dashboardController
                                          .dashInfoFunctionalUnitCluster ??
                                      [],
                                  pageTitle: context.l10n.dashTotalFunctionalUnit,
                                ));
                                // showPatientTableDialog(context, dashboardController.dashInfoData);
                              },
                              cardHeight: 140,
                            ),
                            NewDashCard(
                              firstCountText: context.l10n.dashTotalPatientRegistration,
                              firstCount: controller
                                  .dashboardCountClusterModel?.patientAdded
                                  .toString(),
                              secondCount: controller.dashboardCountClusterModel
                                  ?.currentDatePatient
                                  .toString(),
                              secondCountText: dashboardController.isTodaysDate
                                  ? context.l10n.dashCurrentDatePatientRegistered
                                  : context.l10n.dashDateWisePatientRegistered,
                              iconPath: 'assets/total_patient.png',
                              isInfoVisible: true,
                              onInfoClick: () {
                                Get.to(DashInfoTableAdmin(
                                  patients:
                                      dashboardController.dashInfoDataCluster ??
                                          [],
                                  pageTitle: context.l10n.dashTotalDialysisPatient,
                                  // pageTitleSecond: "",
                                  showPopUp: (unitId) async {
                                    DateTime now = DateTime.now();
                                    String fromDate =
                                        DateFormat('yyyy/MM/dd').format(now);
                                    DateTime tomorrow =
                                        now.add(const Duration(days: 1));
                                    String toDate = DateFormat('yyyy/MM/dd')
                                        .format(tomorrow);

                                    String? selectedToDate;
                                    if (controller
                                        .tDateController.text.isNotEmpty) {
                                      DateTime selectedDate =
                                          DateFormat('yyyy/MM/dd').parse(
                                              controller.tDateController.text);
                                      // Add one day to the selected date
                                      DateTime nextDate = selectedDate
                                          .add(const Duration(days: 1));
                                      // Format the new date back to 'yyyy/MM/dd' and update the controller
                                      selectedToDate = DateFormat('yyyy/MM/dd')
                                          .format(nextDate);
                                    }
                                    await controller.getTotalPatientByIdCluster(
                                        controller
                                                .fDateController.text.isNotEmpty
                                            ? controller.fDateController.text
                                            : fromDate,
                                        controller
                                                .tDateController.text.isNotEmpty
                                            ? selectedToDate
                                            : toDate,
                                        unitId.toString());
                                    Get.to(TotalDialysisPatient(
                                      showTreatment: false,
                                      patients: controller
                                              .totalDialysisPatientCluster ??
                                          [],
                                      pageTitle: context.l10n.dashTotalPatient,
                                      pageTitleSecond: context.l10n.dashTotalDialysisPatient,
                                      showAbha: true,
                                    ));
                                  },
                                ));
                                // showPatientTableDialog(context, dashboardController.dashInfoData);
                              },
                              cardHeight: 140,
                            ),
                            NewDashCard(
                              firstCount: controller
                                  .dashboardCountClusterModel?.abhaRegistration
                                  .toString(),
                              firstCountText: context.l10n.dashTotalAbhaRegistration,
                              secondCount: controller.dashboardCountClusterModel
                                  ?.currentDateAbhaReg
                                  .toString(),
                              secondCountText: dashboardController.isTodaysDate
                                  ? context.l10n.dashCurrentDateAbhaRegistration
                                  : context.l10n.dashDateWiseAbhaPatient,
                              iconPath: 'assets/abha_registration.png',
                              isInfoVisible: true,
                              onInfoClick: () {
                                Get.to(DashInfoTableAbha(
                                  patients: dashboardController
                                          .dashInfoDataAbhaCluster ??
                                      [],
                                  pageTitle: context.l10n.dashTotalAbhaPatient,
                                  onClick: (unitId) async {
                                    DateTime now = DateTime.now();
                                    String fromDate =
                                        DateFormat('yyyy/MM/dd').format(now);
                                    DateTime tomorrow =
                                        now.add(const Duration(days: 1));
                                    String toDate = DateFormat('yyyy/MM/dd')
                                        .format(tomorrow);

                                    String? selectedToDate;
                                    if (controller
                                        .tDateController.text.isNotEmpty) {
                                      DateTime selectedDate =
                                          DateFormat('yyyy/MM/dd').parse(
                                              controller.tDateController.text);
                                      // Add one day to the selected date
                                      DateTime nextDate = selectedDate
                                          .add(const Duration(days: 1));
                                      // Format the new date back to 'yyyy/MM/dd' and update the controller
                                      selectedToDate = DateFormat('yyyy/MM/dd')
                                          .format(nextDate);
                                    }
                                    await controller.getAbhaIdSuperCluster(
                                        controller
                                                .fDateController.text.isNotEmpty
                                            ? controller.fDateController.text
                                            : fromDate,
                                        controller
                                                .tDateController.text.isNotEmpty
                                            ? selectedToDate
                                            : toDate,
                                        unitId.toString());
                                    Get.to(AbhaCountIdTable(
                                      patients:
                                          controller.abhaDetIdListCluster ?? [],
                                      pageTitle: context.l10n.dashTotalAbhaPatient,
                                    ));
                                  },
                                ));
                                // showPatientTableDialog(context, dashboardController.dashInfoData);
                              },
                              cardHeight: 140,
                            ),
                            NewDashCard(
                              firstCount: controller.dashboardCountClusterModel
                                  ?.totalDialysisSession
                                  .toString(),
                              firstCountText: context.l10n.dashDialysisSessions,
                              secondCount: controller.dashboardCountClusterModel
                                  ?.currentDateDialysisSession
                                  .toString(),
                              secondCountText: dashboardController.isTodaysDate
                                  ? context.l10n.dashCurrentDateDialysisSession
                                  : context.l10n.dashDateWiseDialysisSession,
                              iconPath: 'assets/dialysis_session.png',
                              isInfoVisible: true,
                              onInfoClick: () {
                                Get.to(DashInfoTableTotal(
                                  isShowButton: true,
                                  dataList: dashboardController
                                          .dialysisSessionCluster ??
                                      [],
                                  pageTitle: context.l10n.dashDialysisSessions,
                                  pageTitleSecond: context.l10n.dashTotalDialysisSessions,
                                  showData: (unitName) async {
                                    DateTime now = DateTime.now();
                                    String fromDate =
                                        DateFormat('yyyy/MM/dd').format(now);
                                    DateTime tomorrow =
                                        now.add(const Duration(days: 1));
                                    String toDate = DateFormat('yyyy/MM/dd')
                                        .format(tomorrow);

                                    String? selectedToDate;
                                    //If custom date selected
                                    if (controller
                                        .tDateController.text.isNotEmpty) {
                                      DateTime selectedDate =
                                          DateFormat('yyyy/MM/dd').parse(
                                              controller.tDateController.text);
                                      // Add one day to the selected date
                                      DateTime nextDate = selectedDate
                                          .add(const Duration(days: 1));
                                      // Format the new date back to 'yyyy/MM/dd' and update the controller
                                      selectedToDate = DateFormat('yyyy/MM/dd')
                                          .format(nextDate);
                                    }

                                    await controller.getDiaSessionIDCluster(
                                        controller
                                                .fDateController.text.isNotEmpty
                                            ? controller.fDateController.text
                                            : fromDate,
                                        controller
                                                .tDateController.text.isNotEmpty
                                            ? selectedToDate
                                            : toDate,
                                        newRegistrationController
                                            .instituteList?.data
                                            ?.firstWhere(
                                                (e) => e.unitName == unitName)
                                            .unitId);

                                    Get.to(TotalDialysisPatient(
                                      showTreatment: true,
                                      patients: controller
                                              .dialysisSessionByIDCluster ??
                                          [],
                                      pageTitle: context.l10n.dashTotalDialysisPatient,
                                      showAbha: true,
                                    ));
                                  },
                                ));
                              },
                              cardHeight: 140,
                            ),
                            NewDashCard(
                              firstCount: controller.dashboardCountClusterModel
                                  ?.totalDialysisCnacel
                                  .toString(),
                              firstCountText: context.l10n.dashTotalDialysisCancelled,
                              secondCount: controller
                                  .dashboardCountClusterModel?.currentdialCancel
                                  .toString(),
                              secondCountText: dashboardController.isTodaysDate
                                  ? context.l10n.dashCurrentDateDialysisCancelled
                                  : context.l10n.dashDateWiseDialysisCancel,
                              iconPath: 'assets/dialysis_cancelled.png',
                              isInfoVisible: true,
                              onInfoClick: () {
                                Get.to(DashInfoTableTotal(
                                  isShowButton: false,
                                  dataList: dashboardController
                                          .dialysisSessionCancelledCluster ??
                                      [],
                                  pageTitle: context.l10n.dashTotalDialysisCancelled,
                                  showData: () {},
                                ));
                              },
                              cardHeight: 140,
                            ),

                            Row(
                              children: [
                                Expanded(
                                    child: DashCard(
                                  firstCount: controller
                                      .dashboardCountClusterModel?.totalMachine
                                      .toString(),
                                  firstCountText: context.l10n.colMachineCount,
                                  secondCount: "",
                                  secondCountText: "",
                                  iconPath: 'assets/machine.png',
                                  isSecondCount: true,
                                  isInfoVisible: true,
                                  onInfoClick: () {
                                    Get.to(DashInfoTableTotal(
                                      isShowButton: false,
                                      dataList: dashboardController
                                              .machineCountInfoCluster ??
                                          [],
                                      pageTitle: context.l10n.dashTotalMachines,
                                      showData: () {},
                                    ));
                                  },
                                  cardHeight: 210,
                                )),
                                Expanded(
                                    child: DashCard(
                                  firstCount: controller
                                      .dashboardCountClusterModel?.ticket
                                      .toString(),
                                  firstCountText: context.l10n.dashTotalTickets,
                                  // secondCount: "61",
                                  // secondCountText: "Working Machine Count",
                                  isVisiableCol: true,
                                  pendingCount: controller
                                      .dashboardCountClusterModel
                                      ?.pendingTickets
                                      .toString(),
                                  complateCount: controller
                                      .dashboardCountClusterModel?.completTicket
                                      .toString(),
                                  iconPath: 'assets/ticket.png',
                                  isSecondCount: false,
                                  isInfoVisible: true,
                                  onInfoClick: () {
                                    Get.to(DashInfoTableSubHeaderTicket(
                                      dataList: dashboardController
                                              .totalTicketsCluster ??
                                          [],
                                      pageTitle: context.l10n.dashTickets,
                                    ));
                                  },
                                  cardHeight: 210,
                                )),
                              ],
                            ),
                            NewDashCard(
                              firstCount: controller
                                  .dashboardCountClusterModel?.totalLbTest
                                  .toString(),
                              firstCountText: context.l10n.dashTotalLabTestAssigned,
                              secondCount: controller.dashboardCountClusterModel
                                  ?.currentDateLabTest
                                  .toString(),
                              secondCountText: dashboardController.isTodaysDate
                                  ? context.l10n.dashCurrentDateLabTest
                                  : context.l10n.dashDateWiseTestAssign,
                              isVisiableRow: true,
                              iconPath: 'assets/leboretory.png',
                              isInfoVisible: true,
                              onInfoClick: () {
                                Get.to(DashInfoTableSubHeaderTestDet(
                                  dataList:
                                      dashboardController.testDetailsCluster ??
                                          [],
                                  pageTitle: context.l10n.dashTotalLabTestAssigned,
                                ));
                              },
                              cardHeight: 140,
                            ),
                            NewDashCard(
                              firstCount: controller
                                  .dashboardCountClusterModel?.totalEvent
                                  .toString(),
                              firstCountText: context.l10n.dashAdverseEvent,
                              secondCount: controller
                                  .dashboardCountClusterModel?.currentDateEvent
                                  .toString(),
                              secondCountText: dashboardController.isTodaysDate
                                  ? context.l10n.dashCurrentDateAdverseEvent
                                  : context.l10n.dashDateWiseAdverseEvent,
                              iconPath: 'assets/event.png',
                              isInfoVisible: true,
                              onInfoClick: () {
                                Get.to(DashInfoTableAdmin(
                                  isEvent: true,
                                  patients:
                                      dashboardController.eventDetCluster ?? [],
                                  pageTitle: context.l10n.dashAdverseEvents,
                                  showPopUp: (unitId) async {
                                    DateTime now = DateTime.now();
                                    String fromDate =
                                        DateFormat('yyyy/MM/dd').format(now);
                                    DateTime tomorrow =
                                        now.add(const Duration(days: 1));
                                    String toDate = DateFormat('yyyy/MM/dd')
                                        .format(tomorrow);

                                    String? selectedToDate;
                                    if (controller
                                        .tDateController.text.isNotEmpty) {
                                      DateTime selectedDate =
                                          DateFormat('yyyy/MM/dd').parse(
                                              controller.tDateController.text);
                                      // Add one day to the selected date
                                      DateTime nextDate = selectedDate
                                          .add(const Duration(days: 1));
                                      // Format the new date back to 'yyyy/MM/dd' and update the controller
                                      selectedToDate = DateFormat('yyyy/MM/dd')
                                          .format(nextDate);
                                    }
                                    await controller.getEventForIdCluster(
                                        controller
                                                .fDateController.text.isNotEmpty
                                            ? controller.fDateController.text
                                            : fromDate,
                                        controller
                                                .tDateController.text.isNotEmpty
                                            ? selectedToDate
                                            : toDate,
                                        unitId.toString());
                                    Get.to(DashInfoTableEvent(
                                      patients:
                                          controller.eventDetIdListCluster ??
                                              [],
                                      pageTitle: context.l10n.dashTotalAdverseEvent,
                                    ));
                                  },
                                ));
                              },
                              cardHeight: 140,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: DashCard(
                                  firstCount: controller
                                      .dashboardCountClusterModel
                                      ?.totalComplaint
                                      .toString(),
                                  firstCountText: context.l10n.dashOnlineComplaints,
                                  pendingCount: controller
                                      .dashboardCountClusterModel
                                      ?.pendingComplaint
                                      .toString(),
                                  complateCount: controller
                                      .dashboardCountClusterModel
                                      ?.completeComplaint
                                      .toString(),
                                  iconPath: 'assets/complaints.png',
                                  isSecondCount: false,
                                  isVisiableCol: true,
                                  isInfoVisible: true,
                                  onInfoClick: () {
                                    Get.to(DashInfoTableSubHeaderComplaints(
                                      dataList: dashboardController
                                              .complaintCluster ??
                                          [],
                                      pageTitle: context.l10n.dashOnlineComplaints,
                                    ));
                                  },
                                  cardHeight: 224,
                                )),
                                Expanded(
                                    child: DashCard(
                                  firstCount: controller
                                      .dashboardCountClusterModel?.feedback
                                      .toString(),
                                  firstCountText: context.l10n.dashTotalFeedback,
                                  secondCount: controller
                                      .dashboardCountClusterModel
                                      ?.currentDateFeedback
                                      .toString(),
                                  secondCountText:
                                      dashboardController.isTodaysDate
                                          ? context.l10n.dashCurrentDateFeedback
                                          : context.l10n.dashDateWiseFeedback,
                                  iconPath: 'assets/feedback.png',
                                  isSecondCount: true,
                                  cardHeight: 224,
                                )),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 8, bottom: 0, right: 8),
                              child: TabBar(
                                tabAlignment: TabAlignment.start,
                                isScrollable: true,
                                controller: tabController,
                                dividerColor: Colors.transparent,
                                indicatorColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                                indicatorPadding: EdgeInsets.zero,
                                labelPadding: EdgeInsets.zero,
                                tabs: [
                                  buildTab(0, context.l10n.dashDialysisPerformance),
                                  buildTab(1, context.l10n.dashAbhaRegistration)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 8, bottom: 8, right: 8),
                              child: Container(
                                height: 340,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.grey.withValues(alpha: 0.4),
                                        // Shadow color
                                        spreadRadius: 1,
                                        // How much the shadow should spread
                                        blurRadius: 4,
                                        // How soft the shadow should appear
                                        offset: const Offset(1,
                                            1), // The position of the shadow (x, y)
                                      ),
                                    ],
                                    color: Colors.white),
                                child: TabBarView(
                                  controller: tabController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    BarChartSample(
                                      barColor: AppColor.primaryBackgroundColor,
                                      barChartModel: controller.barChartModel,
                                      fromPage: '1',
                                    ),
                                    BarChartSample(
                                      barColor: AppColor.secondaryColor,
                                      barChartModel:
                                          controller.barChartModelAbhaCluster,
                                      fromPage: '2',
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 8, bottom: 8, right: 8),
                              child: Container(
                                height: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.grey.withValues(alpha: 0.4),
                                        // Shadow color
                                        spreadRadius: 1,
                                        // How much the shadow should spread
                                        blurRadius: 4,
                                        // How soft the shadow should appear
                                        offset: const Offset(1,
                                            1), // The position of the shadow (x, y)
                                      ),
                                    ],
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                          text: context.l10n.colViralLoadStatus,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                    ).paddingOnly(left: 8, top: 2),
                                    CustomRadialChart(
                                        chartData:
                                            controller.createListCluster()),
                                  ],
                                ),
                              ),
                            ),
                            // const Padding(
                            //   padding: EdgeInsets.only(
                            //       top: 8, left: 8, bottom: 0, right: 8),
                            //   child: CustomText(
                            //       text: "Non MJPJY Bill Generation Details",
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.normal,
                            //       textColor: Colors.black,
                            //       textAlign: TextAlign.start),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       top: 10, left: 8, bottom: 14, right: 8),
                            //   child: TableBillGeneration(
                            //     tableHeader: const ["Generated", "Pending"],
                            //     invoiceData: controller.billGenerationDetails,
                            //     // onButtonPressed: handleButtonPress,
                            //   ),
                            // )
                          ],
                        ).paddingOnly(left: 4, right: 4),
                      )
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }

  handleButtonPress(int index) {
    // Perform action based on the index
    if (index == 0) {
      debugPrint('Button pressed at index: $index');
    } else if (index == 1) {
      debugPrint('Button pressed at index: $index');
    }
  }

  Widget buildTab(int index, String text) {
    bool isSelected = tabController.index == index;
    return Container(
      // Content-sized so bilingual tab labels stay fully visible
      // (TabBar is isScrollable).
      constraints: const BoxConstraints(minWidth: 110),
      height: 40,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
          // color: isSelected ? Colors.blue.shade200 : Colors.transparent,
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColor.primaryBackgroundColor,
                    AppColor.secondaryColor
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                )
              : const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          border: Border.all(color: const Color(0xffE1E1E1))),
      // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: CustomText(
        text: text,
        fontSize: 12.0,
        fontFam: 'Lato',
        fontWeight: FontWeight.normal,
        textColor: isSelected ? Colors.white : const Color(0xff777777),
        textAlign: TextAlign.center,
      ),
    );
  }

  selectFromDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null) {
      // Update the selected date
      dashboardController.selectedFromDate = picked;

      // Format the date as "01-OCT-2024"
      DateFormat formatter = DateFormat('yyyy/MM/dd');
      dashboardController.formattedFromDate =
          formatter.format(dashboardController.selectedFromDate!);

      // Set the formatted date in the text field
      dashboardController.fDateController.text =
          dashboardController.formattedFromDate!;

      // Refresh the UI
      setState(() {});
    }
  }

  selectToDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null) {
      // Update the selected date
      dashboardController.selectedToDate = picked;

      // Format the date for the API as "yyyy-MM-dd HH:mm:ss"
      DateFormat apiFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      apiDateString = apiFormatter.format(dashboardController.selectedToDate!);

      // Pass this string to your API where needed
      // For example:
      // await apiService.sendDate(apiDateString);

      // Format the date for display as "yyyy-MM-dd"
      DateFormat displayFormatter = DateFormat('yyyy/MM/dd');
      dashboardController.formattedToDate =
          displayFormatter.format(dashboardController.selectedToDate!);

      // Set the formatted date in the text field
      dashboardController.tDateController.text =
          dashboardController.formattedToDate!;

      // Refresh the UI
      setState(() {});
    }
  }

// selectToDate() async {
//   final DateTime? picked = await DatePickerHelper.selectDate(context);
//   if (picked != null && picked != dashboardController.selectedToDate) {
//     // Update the selected date
//     dashboardController.selectedToDate = picked;
//
//     // Format the date as "01-OCT-2024"
//     DateFormat formatter = DateFormat('yyyy/MM/dd');
//
//     dashboardController.formattedToDate =
//         formatter.format(dashboardController.selectedToDate!);
//
//     // Set the formatted date in the text field
//     dashboardController.tDateController.text =
//         dashboardController.formattedToDate!;
//
//     // Refresh the UI
//     setState(() {});
//   }
// }
}
