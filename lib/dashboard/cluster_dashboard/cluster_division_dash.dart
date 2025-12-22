import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/dash_info_table_admin.dart';
import 'package:heamodialysis/dashboard/dash_info_table_total.dart';
import 'package:heamodialysis/dashboard/dashboard_controller.dart';
import 'package:heamodialysis/dashboard/drawer_screen.dart';
import 'package:heamodialysis/dashboard/functional_center_table.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/dash_card.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:heamodialysis/widgets/new_dashcard.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';

class ClusterDivisionWiseDash extends StatefulWidget {
  const ClusterDivisionWiseDash({super.key});

  @override
  State<ClusterDivisionWiseDash> createState() =>
      _ClusterDivisionWiseDashState();
}

class _ClusterDivisionWiseDashState extends State<ClusterDivisionWiseDash>
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

    String mulSelUnit = userData['mulSelunit'].toString();
    String unitId = userData['unitId'].toString();

    await Future.wait([
      dashboardController.getDashboardShort(unitId),
      dashboardController.getVersionName(),
      dashboardController.getDashCountClusterDistrictWise(
          fromDate, toDate, mulSelUnit),
      newRegistrationController.getInstituteList(),
      newRegistrationController.getStateList(),
      newRegistrationController.getDivisionList(),
      newRegistrationController.getDistrictList(),
      newRegistrationController.getTalukaList(),
      newRegistrationController.getTownList(),
      dashboardController.getPatientRegSuperAdmin(fromDate, toDate, mulSelUnit),
      dashboardController.getFunctionalUnitListCluster(
          fromDate, toDate, mulSelUnit),
      dashboardController.getAbhaPatientCluster(fromDate, toDate, mulSelUnit),
      // dashboardController.getDialysisSessionCluster(fromDate, toDate, mulSelUnit),
      dashboardController.getDialysisSessionCancelledCluster(
          fromDate, toDate, mulSelUnit),
      // dashboardController.getTotalTicketsCluster(fromDate, toDate, mulSelUnit),
      dashboardController.getComplaintCluster(fromDate, toDate, mulSelUnit),
      // dashboardController.getTestDetClusterWise(fromDate, toDate, mulSelUnit),
      // dashboardController.getEventDetailCluster(fromDate, toDate, mulSelUnit),
      // dashboardController.getMachineCountClusterWise(fromDate, toDate, mulSelUnit),
    ] as Iterable<Future>);

    dashboardController.isTodaysDate = true;
  }

  // checkInternetAndLoadData() async {
  //   List<ConnectivityResult> connectivityResult =
  //       await Connectivity().checkConnectivity();
  //   // setState(() {
  //   hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
  //       connectivityResult.contains(ConnectivityResult.wifi));
  //   // });
  //   dashboardController.update();
  //   if (hasInternet) {
  //     DateTime now = DateTime.now();
  //     String fromDate = DateFormat('yyyy/MM/dd').format(now);
  //
  //     DateTime tomorrow = now.add(const Duration(days: 1));
  //     String toDate = DateFormat('yyyy/MM/dd').format(tomorrow);
  //
  //     await dashboardController.getDashCountClusterDistrictWise(
  //         fromDate, toDate, userData['mulSelunit']);
  //
  //     await newRegistrationController.getInstituteList();
  //
  //     ///Called patient registration api on dashbard to load page fast
  //     await newRegistrationController.getStateList();
  //     await newRegistrationController.getDivisionList();
  //     await newRegistrationController.getDistrictList();
  //     await newRegistrationController.getTalukaList();
  //     await newRegistrationController.getTownList();
  //
  //
  //
  //     await dashboardController.getPatientRegSuperAdmin(
  //         fromDate, toDate, userData['mulSelunit'].toString());
  //
  //     await dashboardController.getFunctionalUnitListCluster(
  //         fromDate, toDate, userData['mulSelunit'].toString());
  //
  //     await dashboardController.getAbhaPatientCluster(
  //         fromDate, toDate, userData['mulSelunit'].toString());
  //     // await dashboardController.getDialysisSessionCluster(
  //     //     fromDate, toDate, userData['mulSelunit']);
  //     await dashboardController.getDialysisSessionCancelledCluster(
  //         fromDate, toDate, userData['mulSelunit'].toString());
  //
  //     // await dashboardController.getTotalTicketsCluster(
  //     //     fromDate, toDate, userData['mulSelunit']);
  //     await dashboardController.getComplaintCluster(
  //         fromDate, toDate, userData['mulSelunit'].toString());
  //
  //     // await dashboardController.getTestDetClusterWise(
  //     //     fromDate, toDate, userData['mulSelunit'].toString());
  //
  //     // await dashboardController.getEventDetailCluster(
  //     //     fromDate, toDate, userData['mulSelunit'].toString());
  //     //
  //     // await dashboardController.getMachineCountClusterWise(
  //     //     fromDate, toDate, userData['mulSelunit'].toString());
  //
  //     dashboardController.isTodaysDate = true;
  //   }
  // }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);

    userType = userData['ut'];
    userName = '${userData['fname']} ${userData['lname']}';

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
        title: const CustomText(
          text: 'Dashboard',
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

              String ui = userData['ui'].toString();
              String mulSelUnit = userData['mulSelunit'].toString();

              await Future.wait([
                dashboardController.getDashCountClusterDistrictWise(
                    fromDate, toDate, ui),
                dashboardController.getPatientRegSuperAdmin(
                    fromDate, toDate, ui),
                dashboardController.getAbhaPatientCluster(
                    fromDate, toDateTime, ui),
                dashboardController.getFunctionalUnitListCluster(
                    fromDate, toDate, ui),
                dashboardController.getDialysisSessionCluster(
                    fromDate, toDate, mulSelUnit),
                newRegistrationController.getInstituteList(),
                dashboardController.getDialysisSessionCancelledCluster(
                    fromDate, toDate, ui),
                dashboardController.getTotalTicketsCluster(
                    fromDate, toDate, ui),
                dashboardController.getComplaintCluster(fromDate, toDate, ui),
                dashboardController.getTestDetClusterWise(fromDate, toDate, ui),
                dashboardController.getEventDetailCluster(
                    fromDate, fromDate, ui),
                dashboardController.getMachineCountClusterWise(
                    fromDate, toDate, mulSelUnit),

                // Optional APIs (uncomment when needed)
                // dashboardController.getChartData(fromDate, toDate, ApiConstants.baseUrlCluster),
                // dashboardController.getChartDataAbhaCluster(fromDate, toDate),
                // dashboardController.getBillGenerationDet(userData['unitId'].toString(), fromDate, fromDate),
              ] as Iterable<Future>);

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
              //     fromDate, toDate, userData['ui']);
              //
              //
              // String toDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
              // await dashboardController.getPatientRegSuperAdmin(
              //     fromDate, toDate, userData['ui']);
              // await dashboardController.getAbhaPatientCluster(
              //     fromDate, toDateTime, userData['ui']);
              // await dashboardController.getFunctionalUnitListCluster(
              //     fromDate, toDate, userData['ui']);
              // await dashboardController.getDialysisSessionCluster(
              //     fromDate, toDate, userData['ui']);
              // await newRegistrationController.getInstituteList();
              //
              // await dashboardController.getDialysisSessionCancelledCluster(
              //     fromDate, toDate, userData['ui']);
              //
              // await dashboardController.getTotalTicketsCluster(
              //     fromDate, toDate, userData['ui']);
              // await dashboardController.getComplaintCluster(
              //     fromDate, toDate, userData['ui']);
              // await dashboardController.getTestDetClusterWise(
              //     fromDate, toDate, userData['ui']);
              //
              // await dashboardController.getEventDetailCluster(
              //     fromDate, fromDate, userData['ui']);
              //
              // await dashboardController.getMachineCountClusterWise(
              //     fromDate, toDate, userData['mulSelunit']);
              // // await dashboardController.getChartData(
              // //     fromDate, toDate, ApiConstants.baseUrlCluster);
              // // await dashboardController.getChartDataAbhaCluster(
              // //     fromDate, toDate);
              //
              // // await dashboardController.getBillGenerationDet(
              // //     userData['unitId'].toString(), fromDate, fromDate);
              // dashboardController.fDateController.clear();
              // dashboardController.tDateController.clear();
              // dashboardController.isCustomCalender = false;
              // dashboardController.isTodaysDate = true;
              // dashboardController.update();
            },
            child: const CustomText(
                text: "Today",
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
            bool? isDPC  = controller.deptList?.departments.contains("DPC");
            bool? isDPR = controller.deptList?.departments.contains("DPR");
            bool? isDAR = controller.deptList?.departments.contains("DAR");
            bool? isDCS = controller.deptList?.departments.contains("DCS");
            bool? isDDC = controller.deptList?.departments.contains("DDC");
            bool? isDLT = controller.deptList?.departments.contains("DLT");
            bool? isDAE = controller.deptList?.departments.contains("DAE");
            bool? isDMC = controller.deptList?.departments.contains("DMC");
            bool? isDFC = controller.deptList?.departments.contains("DFC");
            bool? isDCC = controller.deptList?.departments.contains("DCC");
            bool? isDTS = controller.deptList?.departments.contains("DTS");
            return hasInternet
                ? controller.isLoading
                    ?  Center(child: buildShimmerLoader())
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
                                      labelText: 'From Date',
                                      hint: 'Select Date',
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
                                      labelText: 'To Date',
                                      hint: 'Select Date',
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
                                                  userData['ui']);


                                          await dashboardController
                                              .getPatientRegSuperAdmin(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['ui']);
                                          await dashboardController
                                              .getFunctionalUnitListCluster(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['ui']);
                                          await dashboardController.getAbhaPatientCluster(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['ui']);
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
                                                  userData['ui']);

                                          await dashboardController.getTotalTicketsCluster(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['ui']);
                                          await dashboardController
                                              .getComplaintCluster(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['ui']);
                                          await dashboardController.getTestDetClusterWise(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['ui']);

                                          await dashboardController.getEventDetailCluster(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['ui']);
                                          dashboardController.isTodaysDate =
                                              false;
                                          await dashboardController
                                              .getMachineCountClusterWise(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['mulSelunit']);
                                          // await dashboardController
                                          //     .getChartData(
                                          //         dashboardController
                                          //             .fDateController.text,
                                          //         selectedToDate,
                                          //         ApiConstants.baseUrlCluster);

                                          // await dashboardController
                                          //     .getChartDataAbhaCluster(
                                          //         dashboardController
                                          //             .fDateController.text,
                                          //         selectedToDate);

                                          // await dashboardController
                                          //     .getBillGenerationDet(
                                          //         userData['unitId']
                                          //             .toString(),
                                          //         dashboardController
                                          //             .fDateController.text,
                                          //         selectedToDate);
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            alignment: Alignment.center,
                                            width: 100,
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
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.search,
                                                  color: Colors.white,
                                                ),
                                                CustomText(
                                                    text: "Search",
                                                    fontSize: 16,
                                                    fontFam: "Lato",
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    textColor: Colors.white,
                                                    textAlign: TextAlign.start),
                                              ],
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
                            Visibility(
                              visible: isDPC == true,

                              child: NewDashCard(
                                firstCount: controller
                                    .dashboardCountClusterModel?.totalCentre
                                    .toString(),
                                firstCountText: "Total Projected\nCenter",
                                secondCount: controller
                                    .dashboardCountClusterModel?.functionalCenter
                                    .toString(),
                                secondCountText: "Functional\nCenter",
                                iconPath: 'assets/professional-services.png',
                                isInfoVisible: true,
                                onInfoClick: () {
                                  Get.to(FunctionalCenterTable(
                                    patients: dashboardController
                                            .dashInfoFunctionalUnitCluster ??
                                        [],
                                    pageTitle: 'Total Functional Unit',
                                  ));
                                  // showPatientTableDialog(context, dashboardController.dashInfoData);
                                },
                                cardHeight: 140,
                              ),
                            ),
                            Visibility(
                              visible: isDPR == true,
                              child: NewDashCard(
                                firstCountText: "Total Patient\nRegistration",
                                firstCount: controller
                                    .dashboardCountClusterModel?.patientAdded
                                    .toString(),
                                secondCount: controller.dashboardCountClusterModel
                                    ?.currentDatePatient
                                    .toString(),
                                secondCountText: dashboardController.isTodaysDate
                                    ? "Current Date Patient \nRegistered"
                                    : "Date Wise Patient\nRegistered Count",
                                iconPath: 'assets/total_patient.png',
                                isInfoVisible: true,
                                onInfoClick: () {
                                  Get.to(DashInfoTableAdmin(
                                    patients:
                                        dashboardController.dashInfoDataAdmin ??
                                            [],
                                    pageTitle: 'Total Dialysis Patient',
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
                                        pageTitle: 'Total Patient',
                                        pageTitleSecond: "Total Dialysis Patient",
                                        showAbha: true,
                                      ));
                                    },
                                  ));
                                  // showPatientTableDialog(context, dashboardController.dashInfoData);
                                },
                                cardHeight: 140,
                              ),
                            ),
                            Visibility(
                              visible: isDAR == true,
                              child: NewDashCard(
                                firstCount: controller
                                    .dashboardCountClusterModel?.abhaRegistration
                                    .toString(),
                                firstCountText: "Total ABHA\nRegistration",
                                secondCount: controller.dashboardCountClusterModel
                                    ?.currentDateAbhaReg
                                    .toString(),
                                secondCountText: dashboardController.isTodaysDate
                                    ? "Current Date ABHA\nRegistration"
                                    : "Date Wise Abha\nPatient Count",
                                iconPath: 'assets/abha_registration.png',
                                isInfoVisible: true,
                                onInfoClick: () {
                                  Get.to(DashInfoTableAbha(
                                    patients: dashboardController
                                            .dashInfoDataAbhaCluster ??
                                        [],
                                    pageTitle: 'Total ABHA Patient',
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
                                        pageTitle: 'Total ABHA Patient',
                                      ));
                                    },
                                  ));
                                  // showPatientTableDialog(context, dashboardController.dashInfoData);
                                },
                                cardHeight: 140,
                              ),
                            ),
                            Visibility(
                              visible: isDCS == true,
                              child: NewDashCard(
                                firstCount: controller.dashboardCountClusterModel
                                    ?.totalDialysisSession
                                    .toString(),
                                firstCountText: "Dialysis\nSessions",
                                secondCount: controller.dashboardCountClusterModel
                                    ?.currentDateDialysisSession
                                    .toString(),
                                secondCountText: dashboardController.isTodaysDate
                                    ? "Current Date\nDialysis Session"
                                    : "Date Wise Dialysis\nSession Count",
                                iconPath: 'assets/dialysis_session.png',
                                isInfoVisible: true,
                                onInfoClick: () {
                                  Get.to(DashInfoTableTotal(
                                    isShowButton: true,
                                    dataList: dashboardController
                                            .dialysisSessionCluster ??
                                        [],
                                    pageTitle: 'Dialysis Sessions',
                                    pageTitleSecond: "Total Dialysis Sessions",
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
                                        pageTitle: 'Total Dialysis Patient',
                                        showAbha: true,
                                      ));
                                    },
                                  ));
                                },
                                cardHeight: 140,
                              ),
                            ),
                            Visibility(
                              visible: isDDC == true,
                              child: NewDashCard(
                                firstCount: controller.dashboardCountClusterModel
                                    ?.totalDialysisCnacel
                                    .toString(),
                                firstCountText: "Total Dialysis\nCancelled",
                                secondCount: controller
                                    .dashboardCountClusterModel?.currentdialCancel
                                    .toString(),
                                secondCountText: dashboardController.isTodaysDate
                                    ? "Current Date\nDialysis Cancelled"
                                    : "Date Wise\nDialysis Cancel Count",
                                iconPath: 'assets/dialysis_cancelled.png',
                                isInfoVisible: true,
                                onInfoClick: () {
                                  Get.to(DashInfoTableTotal(
                                    isShowButton: false,
                                    dataList: dashboardController
                                            .dialysisSessionCancelledCluster ??
                                        [],
                                    pageTitle: 'Total Dialysis Cancelled',
                                    showData: () {},
                                  ));
                                },
                                cardHeight: 140,
                              ),
                            ),

                            Row(
                              children: [
                                Visibility(
                                  visible: isDMC == true,
                                  child: Expanded(
                                      child: DashCard(
                                    firstCount: controller
                                        .dashboardCountClusterModel?.totalMachine
                                        .toString(),
                                    firstCountText: "Machine Count",
                                    secondCount: "",
                                    secondCountText: "",
                                    iconPath: 'assets/machine.png',
                                    isSecondCount: true,
                                    isInfoVisible: false,
                                    onInfoClick: () {
                                      Get.to(DashInfoTableTotal(
                                        isShowButton: false,
                                        dataList: dashboardController
                                                .machineCountInfoCluster ??
                                            [],
                                        pageTitle: 'Total Machines',
                                        showData: () {},
                                      ));
                                    },
                                    cardHeight: 210,
                                  )),
                                ),
                                Visibility(
                                  visible: isDTS == true,
                                  child: Expanded(
                                      child: DashCard(
                                    firstCount: controller
                                        .dashboardCountClusterModel?.ticket
                                        .toString(),
                                    firstCountText: "Total Tickets",
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
                                        pageTitle: 'Tickets',
                                      ));
                                    },
                                    cardHeight: 210,
                                  )),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: isDLT == true,
                              child: NewDashCard(
                                firstCount: controller
                                    .dashboardCountClusterModel?.totalLbTest
                                    .toString(),
                                firstCountText: "Total Laboratory\nTest Assigned",
                                secondCount: controller.dashboardCountClusterModel
                                    ?.currentDateLabTest
                                    .toString(),
                                secondCountText: dashboardController.isTodaysDate
                                    ? "Current Date Laboratory\nTest Assigned"
                                    : "Date Wise Test\nAssign Count",
                                isVisiableRow: true,
                                iconPath: 'assets/leboretory.png',
                                isInfoVisible: true,
                                onInfoClick: () {
                                  Get.to(DashInfoTableSubHeaderTestDet(
                                    dataList:
                                        dashboardController.testDetailsCluster ??
                                            [],
                                    pageTitle: 'Total Laboratory Test Assigned',
                                  ));
                                },
                                cardHeight: 140,
                              ),
                            ),
                            Visibility(
                              visible: isDAE == true,
                              child: NewDashCard(
                                firstCount: controller
                                    .dashboardCountClusterModel?.totalEvent
                                    .toString(),
                                firstCountText: "Adverse Event",
                                secondCount: controller
                                    .dashboardCountClusterModel?.currentDateEvent
                                    .toString(),
                                secondCountText: dashboardController.isTodaysDate
                                    ? "Current Date\nAdverse Event"
                                    : "Date Wise\nAdverse Event Count",
                                iconPath: 'assets/event.png',
                                isInfoVisible: true,
                                onInfoClick: () {
                                  Get.to(DashInfoTableAdmin(
                                    isEvent: true,
                                    patients:
                                        dashboardController.eventDetCluster ?? [],
                                    pageTitle: 'Adverse Events',
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
                                        pageTitle: 'Total Adverse Event',
                                      ));
                                    },
                                  ));
                                },
                                cardHeight: 140,
                              ),
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: isDCC == true,
                                  child: Expanded(
                                      child: DashCard(
                                    firstCount: controller
                                        .dashboardCountClusterModel
                                        ?.totalComplaint
                                        .toString(),
                                    firstCountText: "Online Complaints",
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
                                        pageTitle: 'Online Complaints',
                                      ));
                                    },
                                    cardHeight: 210,
                                  )),
                                ),
                                Visibility(
                                  visible: isDFC == true,

                                  child: Expanded(
                                      child: DashCard(
                                    firstCount: controller
                                        .dashboardCountClusterModel?.feedback
                                        .toString(),
                                    firstCountText: "Total Feedback",
                                    secondCount: controller
                                        .dashboardCountClusterModel
                                        ?.currentDateFeedback
                                        .toString(),
                                    secondCountText:
                                        dashboardController.isTodaysDate
                                            ? "Current Date Feedback"
                                            : "Date Wise Feedback Count",
                                    iconPath: 'assets/feedback.png',
                                    isSecondCount: true,
                                    cardHeight: 210,
                                  )),
                                ),
                              ],
                            ),


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
      width: 130,
      height: 40,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 0.8, vertical: 6),
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
