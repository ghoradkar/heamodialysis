import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/widget/dash_info_table_admin.dart';
import 'package:heamodialysis/dashboard/widget/dash_info_table_total.dart';
import 'package:heamodialysis/dashboard/controller/dashboard_controller.dart';
import 'package:heamodialysis/dashboard/widget/drawer_screen.dart';
import 'package:heamodialysis/dashboard/widget/functional_center_table.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
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
import 'package:heamodialysis/widgets/radila_chart.dart';
import 'package:intl/intl.dart';
import '../../../widgets/custom _dottedline.dart';

class SuperAdminDashScreen extends StatefulWidget {
  const SuperAdminDashScreen({super.key});

  @override
  State<SuperAdminDashScreen> createState() => _SuperAdminDashScreenState();
}

class _SuperAdminDashScreenState extends State<SuperAdminDashScreen>
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

    String unitId = userData['unitId'].toString();
    String mulSelUnit = userData['mulSelunit'].toString();

    await Future.wait(<Future>[
      dashboardController.getDashboardShort(unitId),
      dashboardController.getVersionName(),
      dashboardController.getDashCount(fromDate, toDate, mulSelUnit),
      dashboardController.getRadialChart(unitId, fromDate, toDate),
      dashboardController.getChartData(fromDate, toDate, ApiConstants.baseUrl4),
      dashboardController.getViralStatueList(),
      dashboardController.getChartDataAbha(fromDate, toDate, unitId),
      dashboardController.getPatientRegSuperAdmin(fromDate, toDate, mulSelUnit),
      dashboardController.getFunctionalUnitList(fromDate, toDate, mulSelUnit),
      dashboardController.getTotalInvoiceAmount(),
      dashboardController.getAbhaPatientAdmin(fromDate, toDate, mulSelUnit),
      dashboardController.getDialysisSessionAdmin(mulSelUnit, fromDate, toDate),
      dashboardController.getDialysisSessionCancelledAdmin(
          mulSelUnit, fromDate, toDate),
      dashboardController.getMachineCount(mulSelUnit, fromDate, toDate),
      dashboardController.getTotalTickets(unitId, fromDate, toDate),
      dashboardController.getComplaint(unitId, fromDate, toDate),
      dashboardController.getTestDet(unitId, fromDate, toDate),
      dashboardController.getEventDetailAdmin(mulSelUnit, fromDate, toDate),
      dashboardController.getBillGenerationDet(unitId, fromDate, toDate),
    ]);

    // Fetch registration data in the background without blocking dashboard load
    Future.wait(<Future>[
      newRegistrationController.getInstituteList(),
      newRegistrationController.getTownList(),
      newRegistrationController.getStateList(),
      newRegistrationController.getDivisionList(),
      newRegistrationController.getDistrictList(),
      newRegistrationController.getTalukaList(),
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
        backgroundColor: AppColor.primaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30), // adjust as needed
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 8.w),
          child: CustomText(
            text: 'Central Dashboard',
            fontSize: 18.sp,
            fontFam: 'Lato',
            fontWeight: FontWeight.w400,
            textColor: Colors.white,
            textAlign: TextAlign.start,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.w),
              child: IconButton(
                icon: Image.asset('assets/menu-fill.png'),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
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

              String unitId = userData['unitId'].toString();
              String mulSelUnit = userData['mulSelunit'].toString();

              await Future.wait(<Future>[
                dashboardController.getDashCount(fromDate, toDate, mulSelUnit),
                dashboardController.getRadialChart(unitId, fromDate, toDate),
                dashboardController.getPatientRegSuperAdmin(
                    fromDate, toDate, mulSelUnit),
                dashboardController.getAbhaPatientAdmin(
                    fromDate, toDateTime, mulSelUnit),
                dashboardController.getFunctionalUnitList(
                    fromDate, toDate, mulSelUnit),
                dashboardController.getDialysisSessionAdmin(
                    mulSelUnit, fromDate, toDate),
                newRegistrationController.getInstituteList(),
                dashboardController.getDialysisSessionCancelledAdmin(
                    mulSelUnit, fromDate, toDate),
                dashboardController.getMachineCount(
                    mulSelUnit, fromDate, fromDate),
                dashboardController.getTotalTickets(unitId, fromDate, fromDate),
                dashboardController.getComplaint(unitId, fromDate, fromDate),
                dashboardController.getTestDet(unitId, fromDate, fromDate),
                dashboardController.getEventDetailAdmin(
                    mulSelUnit, fromDate, fromDate),
                dashboardController.getChartData(
                    fromDate, toDate, ApiConstants.baseUrl4),
                dashboardController.getChartDataAbha(fromDate, toDate, unitId),
                dashboardController.getBillGenerationDet(
                    unitId, fromDate, fromDate),
              ]);

              dashboardController.fDateController.clear();
              dashboardController.tDateController.clear();
              dashboardController.isCustomCalender = false;
              dashboardController.isTodaysDate = true;
              dashboardController.update();
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.w),
              child: CustomText(
                  text: "Today",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white,
                  textAlign: TextAlign.start),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          InkWell(
            onTap: () {
              dashboardController.isCustomCalender =
                  !dashboardController.isCustomCalender;
              debugPrint(dashboardController.isCustomCalender.toString());
              dashboardController.update();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.w, bottom: 8.w),
              child: Image.asset(
                "assets/gradient_calender.png",
                color: Colors.white,
              ),
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
            bool? isDPC = controller.deptList?.departments.contains("DPC");
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
            bool? isDIA = controller.deptList?.departments.contains("DIA");
            bool? isDPA = controller.deptList?.departments.contains("DPA");

            return hasInternet
                ? controller.isLoading
                    ? const SuperAdminDashboardShimmer()
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Visibility(
                              visible: dashboardController.isCustomCalender,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 8.w),
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
                                    SizedBox(
                                      height: 4.h,
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
                                              .getDashCount(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['mulSelunit']
                                                      .toString());

                                          await dashboardController
                                              .getRadialChart(
                                                  userData['unitId'],
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);
                                          await dashboardController
                                              .getPatientRegSuperAdmin(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['mulSelunit']
                                                      .toString());
                                          await dashboardController
                                              .getFunctionalUnitList(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['mulSelunit']
                                                      .toString());
                                          await dashboardController
                                              .getAbhaPatientAdmin(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['mulSelunit']
                                                      .toString());
                                          await dashboardController
                                              .getDialysisSessionAdmin(
                                                  userData['mulSelunit']
                                                      .toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);
                                          await dashboardController
                                              .getDialysisSessionCancelledAdmin(
                                                  userData['mulSelunit']
                                                      .toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);
                                          await dashboardController
                                              .getMachineCount(
                                                  userData['mulSelunit']
                                                      .toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);
                                          await dashboardController
                                              .getTotalTickets(
                                                  userData['unitId'].toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);
                                          await dashboardController
                                              .getComplaint(
                                                  userData['unitId'].toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);
                                          await dashboardController.getTestDet(
                                              userData['unitId'].toString(),
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate);

                                          await dashboardController
                                              .getEventDetailAdmin(
                                                  userData['mulSelunit']
                                                      .toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);
                                          dashboardController.isTodaysDate =
                                              false;

                                          await dashboardController
                                              .getChartData(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  ApiConstants.baseUrl4);

                                          await dashboardController
                                              .getChartDataAbha(
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate,
                                                  userData['unitId']
                                                      .toString());

                                          await dashboardController
                                              .getBillGenerationDet(
                                                  userData['unitId'].toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            alignment: Alignment.center,
                                            width: 100.w,
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.search,
                                                  color: Colors.white,
                                                ),
                                                CustomText(
                                                    text: "Search",
                                                    fontSize: 16.sp,
                                                    fontFam: "Lato",
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    textColor: Colors.white,
                                                    textAlign: TextAlign.start),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                  ],
                                ),
                              ).paddingSymmetric(
                                  vertical: 10.h, horizontal: 10.w),
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: isDPC == true,
                                  child: Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Get.to(FunctionalCenterTable(
                                        patients: dashboardController
                                                .dashInfoFunctionalUnit ??
                                            [],
                                        pageTitle: 'Total Functional Unit',
                                      ));
                                    },
                                    child: DashCard(
                                      firstCount: controller
                                          .dashboardCountModel?.totalCentre
                                          .toString(),
                                      firstCountText: "Total Projected Center",
                                      secondCount: controller
                                          .dashboardCountModel?.functionalCenter
                                          .toString(),
                                      secondCountText: "Functional Center",
                                      iconPath:
                                          'assets/professional-services.png',
                                      isSecondCount: true,
                                      isInfoVisible: true,
                                      //                                     onInfoClick: () {
                                      // Get.to(FunctionalCenterTable(
                                      //   patients: dashboardController
                                      //           .dashInfoFunctionalUnit ??
                                      //       [],
                                      //   pageTitle: 'Total Functional Unit',
                                      // ));
                                      //
                                      //                                     },
                                      cardHeight: 80.h,
                                    ),
                                  )),
                                ),
                                if (isDPC == true && isDPR == true)
                                  VerticalDottedDivider(
                                    height: 150.h,
                                    color: Colors.black26,
                                    dashHeight: 4,
                                    dashWidth: 1,
                                  ),
                                Visibility(
                                  visible: isDPR == true,
                                  child: Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Get.to(DashInfoTableAdmin(
                                        patients: dashboardController
                                                .dashInfoDataAdmin ??
                                            [],
                                        pageTitle: 'Total Dialysis Patient',
                                        // pageTitleSecond: "",
                                        showPopUp: (unitId) async {
                                          DateTime now = DateTime.now();
                                          String fromDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(now);
                                          DateTime tomorrow =
                                              now.add(const Duration(days: 1));
                                          String toDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(tomorrow);

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
                                          await controller
                                              .getTotalDialysisPatientSuperAdmin(
                                                  controller.fDateController
                                                          .text.isNotEmpty
                                                      ? controller
                                                          .fDateController.text
                                                      : fromDate,
                                                  controller.tDateController
                                                          .text.isNotEmpty
                                                      ? selectedToDate
                                                      : toDate,
                                                  unitId.toString());
                                          Get.to(TotalDialysisPatient(
                                            showTreatment: true,
                                            showAbha: false,
                                            patients: controller
                                                    .totalDialysisPatient ??
                                                [],
                                            pageTitle: 'Total Patient',
                                            pageTitleSecond:
                                                "Total Dialysis Patient",
                                          ));
                                        },
                                      ));
                                    },
                                    child: DashCard(
                                      title: 'Total Patient Registration',
                                      firstCountText: "Till Date",
                                      firstCount: controller
                                          .dashboardCountModel?.patientAdded
                                          .toString(),
                                      secondCount: controller
                                          .dashboardCountModel
                                          ?.currentDatePatient
                                          .toString(),
                                      secondCountText: dashboardController
                                              .isTodaysDate
                                          ? "Current Date"
                                          // ? "Current Date Patient Registered"
                                          : "Date Wise",
                                      // : "Date Wise Patient Registered Count",
                                      iconPath: 'assets/total_patient.png',
                                      isSecondCount: true,
                                      isInfoVisible: true,
                                      // onInfoClick: () {
                                      //   Get.to(DashInfoTableAdmin(
                                      //     patients: dashboardController
                                      //             .dashInfoDataAdmin ??
                                      //         [],
                                      //     pageTitle: 'Total Dialysis Patient',
                                      //     // pageTitleSecond: "",
                                      //     showPopUp: (unitId) async {
                                      //       DateTime now = DateTime.now();
                                      //       String fromDate =
                                      //           DateFormat('yyyy/MM/dd')
                                      //               .format(now);
                                      //       DateTime tomorrow =
                                      //           now.add(const Duration(days: 1));
                                      //       String toDate = DateFormat('yyyy/MM/dd')
                                      //           .format(tomorrow);
                                      //
                                      //       String? selectedToDate;
                                      //       if (controller
                                      //           .tDateController.text.isNotEmpty) {
                                      //         DateTime selectedDate =
                                      //             DateFormat('yyyy/MM/dd').parse(
                                      //                 controller
                                      //                     .tDateController.text);
                                      //         // Add one day to the selected date
                                      //         DateTime nextDate = selectedDate
                                      //             .add(const Duration(days: 1));
                                      //         // Format the new date back to 'yyyy/MM/dd' and update the controller
                                      //         selectedToDate =
                                      //             DateFormat('yyyy/MM/dd')
                                      //                 .format(nextDate);
                                      //       }
                                      //       await controller
                                      //           .getTotalDialysisPatientSuperAdmin(
                                      //               controller.fDateController.text
                                      //                       .isNotEmpty
                                      //                   ? controller
                                      //                       .fDateController.text
                                      //                   : fromDate,
                                      //               controller.tDateController.text
                                      //                       .isNotEmpty
                                      //                   ? selectedToDate
                                      //                   : toDate,
                                      //               unitId.toString());
                                      //       Get.to(TotalDialysisPatient(
                                      //         showTreatment: true,
                                      //         showAbha: false,
                                      //         patients:
                                      //             controller.totalDialysisPatient ??
                                      //                 [],
                                      //         pageTitle: 'Total Patient',
                                      //         pageTitleSecond:
                                      //             "Total Dialysis Patient",
                                      //       ));
                                      //     },
                                      //   ));
                                      //
                                      // },
                                      cardHeight: 80.h,
                                    ),
                                  )),
                                ),
                              ],
                            ),
                            HorizontalDottedDivider(
                              width: double.infinity,
                              dashHeight: 4,
                              dashWidth: 1,
                              color: Colors.black26,
                            ),
                            if ((isDPC == true || isDPR == true) && (isDAR == true || isDCS == true))
                              HorizontalDottedDivider(
                                width: double.infinity,
                                dashHeight: 4,
                                dashWidth: 1,
                                color: Colors.black26,
                              ),
                            Row(
                              children: [
                                Visibility(
                                  visible: isDAR == true,
                                  child: Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Get.to(DashInfoTableAbha(
                                        patients: dashboardController
                                                .dashInfoDataAbhaAdmin ??
                                            [],
                                        pageTitle: 'Total ABHA Patient',
                                        onClick: (unitId) async {
                                          DateTime now = DateTime.now();
                                          String fromDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(now);
                                          DateTime tomorrow =
                                              now.add(const Duration(days: 1));
                                          String toDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(tomorrow);

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
                                          await controller.getAbhaIdSuperAdmin(
                                              controller.fDateController.text
                                                      .isNotEmpty
                                                  ? controller
                                                      .fDateController.text
                                                  : fromDate,
                                              controller.tDateController.text
                                                      .isNotEmpty
                                                  ? selectedToDate
                                                  : toDate,
                                              unitId.toString());
                                          Get.to(AbhaCountIdTable(
                                            patients:
                                                controller.abhaDetIdList ?? [],
                                            pageTitle: 'Total ABHA Patient',
                                          ));
                                        },
                                      ));
                                    },
                                    child: DashCard(
                                      title: 'Total ABHA Registration',
                                      firstCount: controller
                                          .dashboardCountModel?.abhaRegistration
                                          .toString(),
                                      firstCountText: "Till Date",
                                      secondCount: controller
                                          .dashboardCountModel
                                          ?.currentDateAbhaReg
                                          .toString(),
                                      secondCountText:
                                          dashboardController.isTodaysDate
                                              ? "Current Date"
                                              // ? "Current Date"
                                              : "Date Wise",
                                      // : "Date Wise Abha Patient Count",
                                      iconPath: 'assets/abha_registration.png',
                                      isSecondCount: true,
                                      isInfoVisible: true,
                                      // onInfoClick: () {
                                      //   Get.to(DashInfoTableAbha(
                                      //     patients: dashboardController
                                      //             .dashInfoDataAbhaAdmin ??
                                      //         [],
                                      //     pageTitle: 'Total ABHA Patient',
                                      //     onClick: (unitId) async {
                                      //       DateTime now = DateTime.now();
                                      //       String fromDate =
                                      //           DateFormat('yyyy/MM/dd')
                                      //               .format(now);
                                      //       DateTime tomorrow =
                                      //           now.add(const Duration(days: 1));
                                      //       String toDate = DateFormat('yyyy/MM/dd')
                                      //           .format(tomorrow);
                                      //
                                      //       String? selectedToDate;
                                      //       if (controller
                                      //           .tDateController.text.isNotEmpty) {
                                      //         DateTime selectedDate =
                                      //             DateFormat('yyyy/MM/dd').parse(
                                      //                 controller
                                      //                     .tDateController.text);
                                      //         // Add one day to the selected date
                                      //         DateTime nextDate = selectedDate
                                      //             .add(const Duration(days: 1));
                                      //         // Format the new date back to 'yyyy/MM/dd' and update the controller
                                      //         selectedToDate =
                                      //             DateFormat('yyyy/MM/dd')
                                      //                 .format(nextDate);
                                      //       }
                                      //       await controller.getAbhaIdSuperAdmin(
                                      //           controller.fDateController.text
                                      //                   .isNotEmpty
                                      //               ? controller
                                      //                   .fDateController.text
                                      //               : fromDate,
                                      //           controller.tDateController.text
                                      //                   .isNotEmpty
                                      //               ? selectedToDate
                                      //               : toDate,
                                      //           unitId.toString());
                                      //       Get.to(AbhaCountIdTable(
                                      //         patients:
                                      //             controller.abhaDetIdList ?? [],
                                      //         pageTitle: 'Total ABHA Patient',
                                      //       ));
                                      //     },
                                      //   ));
                                      //
                                      // },
                                      cardHeight: 80.h,
                                    ),
                                  )),
                                ),
                                if (isDAR == true && isDCS == true)
                                  VerticalDottedDivider(
                                    height: 150.h,
                                    color: Colors.black26,
                                    dashHeight: 4,
                                    dashWidth: 1,
                                  ),
                                Visibility(
                                  visible: isDCS == true,
                                  child: Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Get.to(DashInfoTableTotal(
                                        isShowButton: true,
                                        dataList: dashboardController
                                                .dialysisSessionAdmin ??
                                            [],
                                        pageTitle: 'Dialysis Sessions',
                                        pageTitleSecond:
                                            "Total Dialysis Sessions",
                                        showData: (unitName) async {
                                          DateTime now = DateTime.now();
                                          String fromDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(now);
                                          DateTime tomorrow =
                                              now.add(const Duration(days: 1));
                                          String toDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(tomorrow);

                                          String? selectedToDate;
                                          //If custom date selected
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

                                          await controller.getDiaSessSuperAdmin(
                                              controller.fDateController.text
                                                      .isNotEmpty
                                                  ? controller
                                                      .fDateController.text
                                                  : fromDate,
                                              controller.tDateController.text
                                                      .isNotEmpty
                                                  ? selectedToDate
                                                  : toDate,
                                              newRegistrationController
                                                  .instituteList?.data
                                                  ?.firstWhere((e) =>
                                                      e.unitName == unitName)
                                                  .unitId);

                                          Get.to(TotalDialysisPatient(
                                            showTreatment: true,
                                            showAbha: false,
                                            patients:
                                                controller.dialysisPatient ??
                                                    [],
                                            pageTitle: 'Total Dialysis Patient',
                                          ));
                                        },
                                      ));
                                    },
                                    child: DashCard(
                                      title: 'Dialysis Sessions',
                                      firstCount: controller.dashboardCountModel
                                          ?.totalDialysisSession
                                          .toString(),
                                      firstCountText: "Till Date",
                                      secondCount: controller
                                          .dashboardCountModel
                                          ?.currentDateDialysisSession
                                          .toString(),
                                      secondCountText: dashboardController
                                              .isTodaysDate
                                          ? "Current Date"
                                          // ? "Current Date Dialysis Session"
                                          : "Date Wise",
                                      // : "Date Wise Dialysis Session Count",
                                      iconPath: 'assets/dialysis_session.png',
                                      isSecondCount: true,
                                      isInfoVisible: true,
                                      // onInfoClick: () {
                                      //   Get.to(DashInfoTableTotal(
                                      //     isShowButton: true,
                                      //     dataList: dashboardController
                                      //             .dialysisSessionAdmin ??
                                      //         [],
                                      //     pageTitle: 'Dialysis Sessions',
                                      //     pageTitleSecond:
                                      //         "Total Dialysis Sessions",
                                      //     showData: (unitName) async {
                                      //       DateTime now = DateTime.now();
                                      //       String fromDate =
                                      //           DateFormat('yyyy/MM/dd')
                                      //               .format(now);
                                      //       DateTime tomorrow =
                                      //           now.add(const Duration(days: 1));
                                      //       String toDate = DateFormat('yyyy/MM/dd')
                                      //           .format(tomorrow);
                                      //
                                      //       String? selectedToDate;
                                      //       //If custom date selected
                                      //       if (controller
                                      //           .tDateController.text.isNotEmpty) {
                                      //         DateTime selectedDate =
                                      //             DateFormat('yyyy/MM/dd').parse(
                                      //                 controller
                                      //                     .tDateController.text);
                                      //         // Add one day to the selected date
                                      //         DateTime nextDate = selectedDate
                                      //             .add(const Duration(days: 1));
                                      //         // Format the new date back to 'yyyy/MM/dd' and update the controller
                                      //         selectedToDate =
                                      //             DateFormat('yyyy/MM/dd')
                                      //                 .format(nextDate);
                                      //       }
                                      //
                                      //       await controller.getDiaSessSuperAdmin(
                                      //           controller.fDateController.text
                                      //                   .isNotEmpty
                                      //               ? controller
                                      //                   .fDateController.text
                                      //               : fromDate,
                                      //           controller.tDateController.text
                                      //                   .isNotEmpty
                                      //               ? selectedToDate
                                      //               : toDate,
                                      //           newRegistrationController
                                      //               .instituteList?.data
                                      //               ?.firstWhere((e) =>
                                      //                   e.unitName == unitName)
                                      //               .unitId);
                                      //
                                      //       Get.to(TotalDialysisPatient(
                                      //         showTreatment: true,
                                      //         showAbha: false,
                                      //         patients:
                                      //             controller.dialysisPatient ?? [],
                                      //         pageTitle: 'Total Dialysis Patient',
                                      //       ));
                                      //     },
                                      //   ));
                                      // },
                                      cardHeight: 80.h,
                                    ),
                                  )),
                                ),
                              ],
                            ),
                            if ((isDAR == true || isDCS == true) && (isDDC == true || isDMC == true))
                              HorizontalDottedDivider(
                                width: double.infinity,
                                dashHeight: 4,
                                dashWidth: 1,
                                color: Colors.black26,
                              ),
                            Row(
                              children: [
                                Visibility(
                                  visible: isDDC == true,
                                  child: Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Get.to(DashInfoTableTotal(
                                        isShowButton: false,
                                        dataList: dashboardController
                                                .dialysisSessionCancelledAdmin ??
                                            [],
                                        pageTitle: 'Total Dialysis Cancelled',
                                        showData: () {},
                                      ));
                                    },
                                    child: DashCard(
                                      title: 'Total Dialysis Cancelled',
                                      firstCount: controller.dashboardCountModel
                                          ?.totalDialysisCnacel
                                          .toString(),
                                      firstCountText: "Till Date",
                                      secondCount: controller
                                          .dashboardCountModel
                                          ?.currentdialCancel
                                          .toString(),
                                      secondCountText: dashboardController
                                              .isTodaysDate
                                          ? "Current Date"
                                          // ? "Current Date Dialysis Cancelled"
                                          : "Date Wise",
                                      // : "Date Wise Dialysis Cancel Count",
                                      iconPath: 'assets/dialysis_cancelled.png',
                                      isSecondCount: true,
                                      isInfoVisible: true,
                                      // onInfoClick: () {
                                      //   Get.to(DashInfoTableTotal(
                                      //     isShowButton: false,
                                      //     dataList: dashboardController
                                      //             .dialysisSessionCancelledAdmin ??
                                      //         [],
                                      //     pageTitle: 'Total Dialysis Cancelled',
                                      //     showData: () {},
                                      //   ));
                                      // },
                                      cardHeight: 80.h,
                                    ),
                                  )),
                                ),
                                if (isDDC == true && isDMC == true)
                                  VerticalDottedDivider(
                                    height: 150.h,
                                    color: Colors.black26,
                                    dashHeight: 4,
                                    dashWidth: 1,
                                  ),
                                Visibility(
                                  visible: isDMC == true,
                                  child: Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Get.to(DashInfoTableTotal(
                                        isShowButton: false,
                                        dataList: dashboardController
                                                .machineCountInfo ??
                                            [],
                                        pageTitle: 'Total Machines',
                                        showData: () {},
                                      ));
                                    },
                                    child: DashCard(
                                      title: 'Machine Count',
                                      firstCount: controller
                                          .dashboardCountModel?.totalMachine
                                          .toString(),
                                      firstCountText: "Till Date",
                                      secondCount: "",
                                      secondCountText: "",
                                      iconPath: 'assets/machine.png',
                                      isSecondCount: true,
                                      isInfoVisible: true,
                                      // onInfoClick: () {
                                      //   Get.to(DashInfoTableTotal(
                                      //     isShowButton: false,
                                      //     dataList: dashboardController
                                      //             .machineCountInfo ??
                                      //         [],
                                      //     pageTitle: 'Total Machines',
                                      //     showData: () {},
                                      //   ));
                                      // },
                                      cardHeight: 80.h,
                                    ),
                                  )),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: isDLT == true,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(DashInfoTableSubHeaderTestDet(
                                    dataList:
                                        dashboardController.testDetails ?? [],
                                    pageTitle: 'Total Laboratory Test Assigned',
                                  ));
                                },
                                child: DashCard(
                                  title: 'Total Laboratory Test Assigned',
                                  firstCount: controller
                                      .dashboardCountModel?.totalLbTest
                                      .toString(),
                                  firstCountText: "Till Date",
                                  secondCount: controller
                                      .dashboardCountModel?.currentDateLabTest
                                      .toString(),
                                  secondCountText: dashboardController
                                          .isTodaysDate
                                      ? "Current Dated"
                                      // ? "Current Date Laboratory Test Assigned"
                                      : "Date Wise",
                                  // : "Date Wise Test Assign Count",
                                  pendingCount: controller
                                      .dashboardCountModel?.totalLbTest
                                      .toString(),
                                  complateCount: "0",
                                  isVisiableRow: true,
                                  iconPath: 'assets/leboretory.png',
                                  isSecondCount: true,
                                  isInfoVisible: true,
                                  // onInfoClick: () {
                                  //   Get.to(DashInfoTableSubHeaderTestDet(
                                  //     dataList:
                                  //         dashboardController.testDetails ?? [],
                                  //     pageTitle: 'Total Laboratory Test Assigned',
                                  //   ));
                                  // },
                                  cardHeight: 80.h,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: isDAE == true,
                                  child: Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Get.to(DashInfoTableAdmin(
                                        isEvent: true,
                                        patients:
                                            dashboardController.eventDetAdmin ??
                                                [],
                                        pageTitle: 'Adverse Events',
                                        showPopUp: (unitId) async {
                                          DateTime now = DateTime.now();
                                          String fromDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(now);
                                          DateTime tomorrow =
                                              now.add(const Duration(days: 1));
                                          String toDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(tomorrow);

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
                                          await controller
                                              .getEventForIdSuperAdmin(
                                                  controller.fDateController
                                                          .text.isNotEmpty
                                                      ? controller
                                                          .fDateController.text
                                                      : fromDate,
                                                  controller.tDateController
                                                          .text.isNotEmpty
                                                      ? selectedToDate
                                                      : toDate,
                                                  unitId.toString());
                                          Get.to(DashInfoTableEvent(
                                            patients:
                                                controller.eventDetIdList ?? [],
                                            pageTitle: 'Total Adverse Event',
                                          ));
                                        },
                                      ));
                                    },
                                    child: DashCard(
                                      title: 'Adverse Event',
                                      firstCount: controller
                                          .dashboardCountModel?.totalEvent
                                          .toString(),
                                      firstCountText: "Till Date",
                                      secondCount: controller
                                          .dashboardCountModel?.currentDateEvent
                                          .toString(),
                                      secondCountText:
                                          dashboardController.isTodaysDate
                                              ? "Current Date"
                                              : "Date Wise",
                                      iconPath: 'assets/event.png',
                                      isSecondCount: true,
                                      isInfoVisible: true,
                                      onInfoClick: () {
                                        Get.to(DashInfoTableAdmin(
                                          isEvent: true,
                                          patients: dashboardController
                                                  .eventDetAdmin ??
                                              [],
                                          pageTitle: 'Adverse Events',
                                          showPopUp: (unitId) async {
                                            DateTime now = DateTime.now();
                                            String fromDate =
                                                DateFormat('yyyy/MM/dd')
                                                    .format(now);
                                            DateTime tomorrow = now
                                                .add(const Duration(days: 1));
                                            String toDate =
                                                DateFormat('yyyy/MM/dd')
                                                    .format(tomorrow);

                                            String? selectedToDate;
                                            if (controller.tDateController.text
                                                .isNotEmpty) {
                                              DateTime selectedDate =
                                                  DateFormat('yyyy/MM/dd')
                                                      .parse(controller
                                                          .tDateController
                                                          .text);
                                              // Add one day to the selected date
                                              DateTime nextDate = selectedDate
                                                  .add(const Duration(days: 1));
                                              // Format the new date back to 'yyyy/MM/dd' and update the controller
                                              selectedToDate =
                                                  DateFormat('yyyy/MM/dd')
                                                      .format(nextDate);
                                            }
                                            await controller
                                                .getEventForIdSuperAdmin(
                                                    controller.fDateController
                                                            .text.isNotEmpty
                                                        ? controller
                                                            .fDateController
                                                            .text
                                                        : fromDate,
                                                    controller.tDateController
                                                            .text.isNotEmpty
                                                        ? selectedToDate
                                                        : toDate,
                                                    unitId.toString());
                                            Get.to(DashInfoTableEvent(
                                              patients:
                                                  controller.eventDetIdList ??
                                                      [],
                                              pageTitle: 'Total Adverse Event',
                                            ));
                                          },
                                        ));
                                      },
                                      cardHeight: 80.h,
                                    ),
                                  )),
                                ),
                                Visibility(
                                  visible: isDTS == true,
                                  child: Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Get.to(DashInfoTableSubHeaderTicket(
                                        dataList:
                                            dashboardController.totalTickets ??
                                                [],
                                        pageTitle: 'Tickets',
                                      ));
                                    },
                                    child: DashCard(
                                      title: 'Total Tickets',
                                      firstCount: controller
                                          .dashboardCountModel?.ticket
                                          .toString(),
                                      firstCountText: "Till Date",
                                      // secondCount: "61",
                                      // secondCountText: "Working Machine Count",
                                      isVisiableCol: true,
                                      pendingCount: controller
                                          .dashboardCountModel?.pendingTickets
                                          .toString(),
                                      complateCount: controller
                                          .dashboardCountModel?.completTicket
                                          .toString(),
                                      iconPath: 'assets/ticket.png',
                                      isSecondCount: false,
                                      isInfoVisible: true,
                                      // onInfoClick: () {
                                      //   Get.to(DashInfoTableSubHeaderTicket(
                                      //     dataList:
                                      //         dashboardController.totalTickets ??
                                      //             [],
                                      //     pageTitle: 'Tickets',
                                      //   ));
                                      // },
                                      cardHeight: 80.h,
                                    ),
                                  )),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: isDFC == true,
                              child: DashCard(
                                title: 'Total Feedback',
                                firstCount: controller
                                    .dashboardCountModel?.feedback
                                    .toString(),
                                firstCountText: "Till Date",
                                secondCount: controller
                                    .dashboardCountModel?.currentDateFeedback
                                    .toString(),
                                secondCountText:
                                    dashboardController.isTodaysDate
                                        ? "Current Date"
                                        : "Date Wise",
                                iconPath: 'assets/feedback.png',
                                isSecondCount: true,
                                cardHeight: 80.h,
                              ),
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: isDCC == true,
                                  child: Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Get.to(DashInfoTableSubHeaderComplaints(
                                        dataList:
                                            dashboardController.complaint ?? [],
                                        pageTitle: 'Online Complaints',
                                      ));
                                    },
                                    child: DashCard(
                                      title: 'Online Complaints',
                                      firstCount: controller
                                          .dashboardCountModel?.totalComplaint
                                          .toString(),
                                      firstCountText: "Till Date",
                                      pendingCount: controller
                                          .dashboardCountModel?.pendingComplaint
                                          .toString(),
                                      complateCount: controller
                                          .dashboardCountModel
                                          ?.completeComplaint
                                          .toString(),
                                      iconPath: 'assets/complaints.png',
                                      isSecondCount: false,
                                      isVisiableCol: true,
                                      isInfoVisible: true,
                                      cardHeight: 80.h,
                                    ),
                                  )),
                                ),
                                Visibility(
                                  visible: isDIA == true,
                                  child: Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Get.to(TotalPatientRegistration(
                                        pageTitle: 'Invoice Amount',
                                        patients: dashboardController
                                                .totalInvoiceAmountModel ??
                                            [],
                                      ));
                                    },
                                    child: DashCard(
                                      title: 'Total Invoice Amount',
                                      firstCount: controller.dashboardCountModel
                                          ?.totalInvoiceAmount
                                          .toString(),
                                      firstCountText: "Till Date",
                                      secondCount: controller
                                          .dashboardCountModel
                                          ?.currentMonthInvAmt
                                          .toString(),
                                      secondCountText: "Current Month",
                                      iconPath: 'assets/invoice.png',
                                      isSecondCount: true,
                                      cardHeight: 80.h,
                                      isVisiableCol: false,
                                      isInfoVisible: true,
                                      // onInfoClick: () {
                                      //   Get.to(TotalPatientRegistration(
                                      //     pageTitle: 'Invoice Amount',
                                      //     patients: dashboardController
                                      //             .totalInvoiceAmountModel ??
                                      //         [],
                                      //   ));
                                      // }
                                    ),
                                  )),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: isDPA == true,
                              child: DashCard(
                                title: 'Total Payment',
                                firstCount: controller.dashboardCountModel
                                            ?.totalInvoicePayment ==
                                        null
                                    ? ""
                                    : controller.dashboardCountModel
                                        ?.totalInvoicePayment
                                        .toString(),
                                firstCountText: "Till Date",
                                secondCount: controller.dashboardCountModel
                                            ?.currentMonthInvPymt ==
                                        null
                                    ? "0"
                                    : controller.dashboardCountModel
                                        ?.currentMonthInvPymt
                                        .toString(),
                                secondCountText: "Current Month",
                                iconPath: 'assets/payment.png',
                                isSecondCount: true,
                                cardHeight: 80.h,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 8.h, left: 8.w, bottom: 0, right: 8.w),
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
                                  buildTab(0, "Dialysis Performance"),
                                  buildTab(1, "ABHA Registration")
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0, left: 8.w, bottom: 8.h, right: 8.w),
                              child: Container(
                                height: 340.h,
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
                                          controller.barChartModelAbha,
                                      fromPage: '2',
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0, left: 8.w, bottom: 8.h, right: 8.w),
                              child: Container(
                                height: 300.h,
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
                                          text: "Viral Load Status",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                    ).paddingOnly(left: 8.w, top: 2.h),
                                    CustomRadialChart(
                                        chartData: controller.createList()),
                                  ],
                                ),
                              ),
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
      width: 130.w,
      height: 40.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 0.8.w, vertical: 6.h),
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
        fontSize: 12.sp,
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
}
