import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/dash_info_table_admin.dart';
import 'package:heamodialysis/dashboard/dash_info_table_techni.dart';
import 'package:heamodialysis/dashboard/dash_info_table_total.dart';
import 'package:heamodialysis/dashboard/dashboard_controller.dart';
import 'package:heamodialysis/dashboard/dialysis_session_technician.dart';
import 'package:heamodialysis/dashboard/drawer_screen.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/dash_card.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:heamodialysis/widgets/radila_chart.dart';
import 'package:heamodialysis/widgets/scheme_performance_chart.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom _dottedline.dart';
import '../../widgets/custom_shimmer_loader.dart';

class InstituteWiseDashboardScreen extends StatefulWidget {
  const InstituteWiseDashboardScreen({super.key});

  @override
  State<InstituteWiseDashboardScreen> createState() =>
      _InstituteWiseDashboardScreenState();
}

class _InstituteWiseDashboardScreenState
    extends State<InstituteWiseDashboardScreen>
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

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    dashboardController.update();

    if (!hasInternet) return;

    dashboardController.labtestDetails?.clear();

    DateTime now = DateTime.now();
    String fromDate = DateFormat('yyyy/MM/dd').format(now);
    String toDate =
        DateFormat('yyyy/MM/dd').format(now.add(const Duration(days: 1)));

    String unitId = userData['unitId'].toString();
    String mulSelunit = userData['mulSelunit'].toString();

    await Future.wait([
      dashboardController.getDashboardShort(unitId),
      dashboardController.getDash(unitId, fromDate, toDate),
      dashboardController.getRadialChart(unitId, fromDate, toDate),
      dashboardController.getSchemePerformance(fromDate, toDate, unitId),
      dashboardController.getViralStatueList(),
      dashboardController.getOnGoingDialysisSession(fromDate, toDate, unitId),
      dashboardController.getVersionName(),

      /// Registration data
      newRegistrationController.getTownList(),
      newRegistrationController.getStateList(),
      newRegistrationController.getDivisionList(),
      newRegistrationController.getDistrictList(),
      newRegistrationController.getTalukaList(),

      /// Lab & Patient info
      dashboardController.getLaboratoryAss(unitId, fromDate, toDate),
      dashboardController.getPatientRegTechnician(unitId, fromDate, toDate),
      dashboardController.getAbhaPatientTechnician(unitId, fromDate, toDate),
      dashboardController.getDialysisSession(unitId, fromDate, toDate),
      dashboardController.getDialysisSessionCancelled(unitId, fromDate, toDate),
      dashboardController.getEventForIdTech(fromDate, toDate, unitId),
      dashboardController.getMachineCount(mulSelunit, fromDate, toDate),
      dashboardController.getComplaintTechnician(unitId, fromDate, toDate),
      dashboardController.getTicketTechnician(unitId, fromDate, toDate),
    ] as Iterable<Future>);
  }

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
        backgroundColor: AppColor.primaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30), // adjust as needed
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CustomText(
            text: 'Dashboard',
            fontSize: 18.0.sp,
            fontFam: 'Lato',
            fontWeight: FontWeight.w400,
            textColor: Colors.white,
            textAlign: TextAlign.start,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: InkWell(
              onTap: () async {
                DateTime now = DateTime.now();
                String fromDate = DateFormat('yyyy/MM/dd').format(now);
                String toDate = DateFormat('yyyy/MM/dd')
                    .format(now.add(const Duration(days: 1)));
                String unitId = userData['unitId'].toString();
                String mulSelunit = userData['mulSelunit'].toString();

                dashboardController.labtestDetails?.clear();

                await Future.wait([
                  dashboardController.getDash(unitId, fromDate, toDate),
                  dashboardController.getLaboratoryAss(
                      unitId, fromDate, toDate),
                  dashboardController.getRadialChart(unitId, fromDate, toDate),
                  dashboardController.getSchemePerformance(
                      fromDate, toDate, unitId),
                  dashboardController.getOnGoingDialysisSession(
                      fromDate, toDate, unitId),
                  dashboardController.getPatientRegTechnician(
                      unitId, fromDate, toDate),
                  dashboardController.getAbhaPatientTechnician(
                      unitId, fromDate, toDate),
                  dashboardController.getDialysisSession(
                      unitId, fromDate, toDate),
                  dashboardController.getDialysisSessionCancelled(
                      unitId, fromDate, toDate),
                  dashboardController.getEventForIdTech(
                      fromDate, toDate, unitId),
                  dashboardController.getMachineCount(
                      mulSelunit, fromDate, toDate),
                  dashboardController.getComplaintTechnician(
                      unitId, fromDate, toDate),
                  dashboardController.getTicketTechnician(
                      unitId, fromDate, toDate),
                ] as Iterable<Future>);

                dashboardController.fDateController.text = '';
                dashboardController.tDateController.text = '';
                dashboardController.isCustomCalender = false;
                dashboardController.isTodaysDate = true;
                dashboardController.update();
              },
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
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 8),
            child: InkWell(
              onTap: () {
                dashboardController.isCustomCalender =
                    !dashboardController.isCustomCalender;
                debugPrint(dashboardController.isCustomCalender.toString());
                dashboardController.update();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Image.asset(
                  "assets/gradient_calender.png",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: DrawerScreen(
          userData: userData,
          userType: userType,
          userName: userName,
          packageInfo: dashboardController.packageInfo,
        ),
      ),
      body: SafeArea(
        child: GetBuilder<DashboardController>(
            init: dashboardController,
            builder: (controller) {
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
                      ? Center(child: buildShimmerLoader())
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
                                            dashboardController.labtestDetails
                                                ?.clear();
                                            dashboardController.isTodaysDate =
                                                false;

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

                                            await dashboardController.getDash(
                                                userData['unitId'].toString(),
                                                dashboardController
                                                    .fDateController.text,
                                                selectedToDate);

                                            await dashboardController
                                                .getLaboratoryAss(
                                                    userData['unitId']
                                                        .toString(),
                                                    dashboardController
                                                        .fDateController.text,
                                                    selectedToDate);

                                            await dashboardController
                                                .getAbhaPatientTechnician(
                                                    userData['unitId']
                                                        .toString(),
                                                    dashboardController
                                                        .fDateController.text,
                                                    selectedToDate);

                                            await dashboardController
                                                .getRadialChart(
                                                    userData['unitId'],
                                                    dashboardController
                                                        .fDateController.text,
                                                    selectedToDate);
                                            await dashboardController
                                                .getPatientRegTechnician(
                                                    userData['unitId']
                                                        .toString(),
                                                    dashboardController
                                                        .fDateController.text,
                                                    selectedToDate);
                                            await dashboardController
                                                .getOnGoingDialysisSession(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['unitId'].toString(),
                                            );

                                            await dashboardController
                                                .getSchemePerformance(
                                                    dashboardController
                                                        .fDateController.text,
                                                    selectedToDate,
                                                    userData['unitId']
                                                        .toString());

                                            await dashboardController
                                                .getDialysisSession(
                                                    userData['unitId']
                                                        .toString(),
                                                    dashboardController
                                                        .fDateController.text,
                                                    selectedToDate);

                                            await dashboardController
                                                .getDialysisSessionCancelled(
                                                    userData['unitId']
                                                        .toString(),
                                                    dashboardController
                                                        .fDateController.text,
                                                    selectedToDate);

                                            ///uncomment
                                            // await dashboardController
                                            //     .getEventDetail(
                                            //         userData['unitId']
                                            //             .toString(),
                                            //         dashboardController
                                            //             .fDateController.text,
                                            //     selectedToDate);

                                            await dashboardController
                                                .getEventForIdTech(
                                                    dashboardController
                                                        .fDateController.text,
                                                    selectedToDate,
                                                    userData['unitId']
                                                        .toString());
                                            await dashboardController
                                                .getMachineCount(
                                                    userData['mulSelunit']
                                                        .toString(),
                                                    dashboardController
                                                        .fDateController.text,
                                                    selectedToDate);

                                            await dashboardController
                                                .getComplaintTechnician(
                                                    userData['unitId']
                                                        .toString(),
                                                    dashboardController
                                                        .fDateController.text,
                                                    selectedToDate);

                                            await dashboardController
                                                .getTicketTechnician(
                                                    userData['unitId']
                                                        .toString(),
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
                                                      textAlign:
                                                          TextAlign.start),
                                                ],
                                              )),
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
                              // Patient Registration
                              Row(
                                children: [
                                  Visibility(
                                    visible: isDPR == true,
                                    child: Expanded(
                                        child: DashCard(
                                      title: 'Patient Registration',
                                      firstCountText: "Till Date",
                                      firstCount: controller.newCountModel
                                                  ?.patientAdded !=
                                              null
                                          ? controller
                                              .newCountModel?.patientAdded
                                              .toString()
                                          : "",
                                      secondCount: controller.newCountModel
                                                  ?.currentDatePatient !=
                                              null
                                          ? controller
                                              .newCountModel?.currentDatePatient
                                              .toString()
                                          : '',
                                      secondCountText:
                                          dashboardController.isTodaysDate
                                              ? "Current Date"
                                              : "Date Wise",
                                      iconPath: 'assets/total_patient.png',
                                      isSecondCount: true,
                                      isInfoVisible: false,
                                      onInfoClick: () {
                                        Get.to(DashInfoTable(
                                          patients: dashboardController
                                                  .dashInfoData ??
                                              [],
                                          pageTitle: 'Patient Added List',
                                        ));
                                      },
                                      cardHeight: 100.h,
                                    )),
                                  ),
                                  const VerticalDottedDivider(
                                    height: 190,
                                    color: Colors.black26,
                                    dashHeight: 4,
                                    dashWidth: 1,
                                  ),

                                  // ABHA Registration
                                  Visibility(
                                    visible: isDAR == true,
                                    child: Expanded(
                                        child: DashCard(
                                      title: 'ABHA Registration',
                                      firstCount: controller.newCountModel
                                                  ?.abhaRegistration !=
                                              null
                                          ? controller
                                              .newCountModel?.abhaRegistration
                                              .toString()
                                          : '',
                                      firstCountText: "Till Date",
                                      secondCount: controller.newCountModel
                                                  ?.currentDateAbhaReg !=
                                              null
                                          ? controller
                                              .newCountModel?.currentDateAbhaReg
                                              .toString()
                                          : '',
                                      secondCountText:
                                          dashboardController.isTodaysDate
                                              ? "Current Date"
                                              : "Date Wise",
                                      iconPath: 'assets/abha_registration.png',
                                      isSecondCount: true,
                                      isInfoVisible: false,
                                      onInfoClick: () {
                                        Get.to(DashInfoTable(
                                          patients: dashboardController
                                                  .dashInfoDataAdmin ??
                                              [],
                                          pageTitle: 'Patient Added List',
                                        ));
                                        // showPatientTableDialog(context, dashboardController.dashInfoData);
                                      },
                                      cardHeight: 100.h,
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
                              // Divider(color: Colors.grey[300], height: 1, thickness: 1),
                              Row(
                                children: [
                                  //Dialysis Sessions
                                  Visibility(
                                    visible: isDCS == true,
                                    child: Expanded(
                                        child: DashCard(
                                      title: 'Dialysis Sessions',
                                      firstCount: controller.newCountModel
                                                  ?.totalDialysisSession !=
                                              null
                                          ? controller.newCountModel
                                              ?.totalDialysisSession
                                              .toString()
                                          : '',
                                      firstCountText: "Till Date",
                                      secondCount: controller.newCountModel
                                                  ?.currentDateDialysisSession !=
                                              null
                                          ? controller.newCountModel
                                              ?.currentDateDialysisSession
                                              .toString()
                                          : '',
                                      secondCountText:
                                          dashboardController.isTodaysDate
                                              ? "Current Day"
                                              : "Date Wise",
                                      iconPath: 'assets/dialysis_session.png',
                                      isSecondCount: true,
                                      isInfoVisible: false,
                                      onInfoClick: () {
                                        List<Map<String, dynamic>> patients =
                                            [];
                                        patients.add({
                                          "mjpjayCount": dashboardController
                                              .dialysisSession['mjpjayCount']
                                              .toString()
                                        });
                                        patients.add({
                                          "nonMjpjyCount": dashboardController
                                              .dialysisSession['nonMjpjyCount']
                                              .toString()
                                        });

                                        Get.to(DashInfoTableTechnician(
                                          patients: patients,
                                          pageTitle: 'Dialysis Session',
                                          showData: (scheme) async {
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
                                                .getDialysisSessionIdWise(
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
                                                    userData['unitId']
                                                        .toString(),
                                                    scheme);
                                            Get.to(TotalDialysisPatient(
                                              showTreatment: true,
                                              patients: controller
                                                      .dialysisSessionId ??
                                                  [],
                                              pageTitle: 'Dialysis Session',
                                              pageTitleSecond: "",
                                              showAbha: false,
                                            ));
                                          },
                                        ));
                                      },
                                      cardHeight: 100.h,
                                    )),
                                  ),
                                  const VerticalDottedDivider(
                                    height: 190,
                                    color: Colors.black26,
                                    dashHeight: 4,
                                    dashWidth: 1,
                                  ),
                                  // const SizedBox(
                                  //   height: 200, // Adjust the height as needed
                                  //   child: VerticalDivider(
                                  //     color: Colors.grey,
                                  //     width: 5,
                                  //     thickness: 1,
                                  //   ),
                                  // ),
                                  Visibility(
                                    visible: isDDC == true,
                                    child: Expanded(
                                        child: DashCard(
                                      title: 'Dialysis Cancelled',
                                      firstCount: controller.newCountModel
                                                  ?.totalDialysisCnacel !=
                                              null
                                          ? controller.newCountModel
                                              ?.totalDialysisCnacel
                                              .toString()
                                          : '',
                                      firstCountText: "Total",
                                      secondCount: controller.newCountModel
                                                  ?.currentdialCancel !=
                                              null
                                          ? controller
                                              .newCountModel?.currentdialCancel
                                              .toString()
                                          : '',
                                      secondCountText:
                                          dashboardController.isTodaysDate
                                              ? "Current Day"
                                              : "Date Wise",
                                      iconPath: 'assets/dialysis_cancelled.png',
                                      isSecondCount: true,
                                      isInfoVisible: false,
                                      onInfoClick: () {
                                        List<Map<String, dynamic>> patients =
                                            [];
                                        patients.add({
                                          "mjpjayCount": dashboardController
                                              .dialysisSessionCancelled[
                                                  'mjpjayCancelCount']
                                              .toString()
                                        });
                                        patients.add({
                                          "nonMjpjyCount": dashboardController
                                              .dialysisSessionCancelled[
                                                  'nonMjpjyCancelCount']
                                              .toString()
                                        });

                                        Get.to(DashInfoTableTechnician(
                                          patients: patients,
                                          pageTitle: 'Total Dialysis Cancelled',
                                          showData: (scheme) async {
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
                                                .getDialysisSessionCancelIdWise(
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
                                                    userData['unitId']
                                                        .toString(),
                                                    scheme);
                                            Get.to(TotalDialysisPatient(
                                              showTreatment: true,
                                              showAbha: false,
                                              patients:
                                                  controller.dialysisCancelId ??
                                                      [],
                                              pageTitle: 'Dialysis Cancel',
                                              pageTitleSecond: "",
                                            ));
                                          },
                                        ));
                                      },
                                      cardHeight: 100.h,
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
                              Row(
                                children: [
                                  //Online Complaints
                                  Expanded(
                                    child: Visibility(
                                      visible: isDCC == true,
                                      child: DashCard(
                                        title: 'Online Complaints',
                                        firstCount: controller.newCountModel
                                                    ?.totalComplaint !=
                                                null
                                            ? controller
                                                .newCountModel?.totalComplaint
                                                .toString()
                                            : '',
                                        firstCountText: "Till Date",
                                        secondCount: controller.newCountModel
                                                    ?.currentDateFeedback !=
                                                null
                                            ? controller.newCountModel
                                                ?.currentDateFeedback
                                                .toString()
                                            : '',
                                        secondCountText: "Current Day",
                                        pendingCount: controller.newCountModel
                                                    ?.pendingComplaint !=
                                                null
                                            ? controller
                                                .newCountModel?.pendingComplaint
                                                .toString()
                                            : '',
                                        complateCount: controller.newCountModel
                                                    ?.completeComplaint !=
                                                null
                                            ? controller.newCountModel
                                                ?.completeComplaint
                                                .toString()
                                            : '',
                                        isVisiableRow: true,
                                        iconPath: 'assets/complaints.png',
                                        isSecondCount: true,
                                        isInfoVisible: false,
                                        onInfoClick: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return DashInfoTable1(
                                                pageTitle:
                                                    "Total Online Complaints",
                                                l1: const ['1', '2', '3', '4'],
                                                l2: const [
                                                  'Dashboard Down',
                                                  'Machine Not Working',
                                                  'Denial of Services',
                                                  'Money taken against treatment'
                                                ],
                                                l3: [
                                                  dashboardController
                                                      .complaintTechnician
                                                      ?.complaintMachineDown,
                                                  dashboardController
                                                      .complaintTechnician
                                                      ?.complaintDenialService,
                                                  dashboardController
                                                      .complaintTechnician
                                                      ?.complaintMonetTakeBytreatment,
                                                  dashboardController
                                                      .complaintTechnician
                                                      ?.complaintDashDown
                                                ],
                                                tableHeader: const [
                                                  "Sr. No",
                                                  "Type\n",
                                                  "Count\n"
                                                ],
                                                onButtonPressed:
                                                    handleButtonPress,
                                              );
                                            },
                                          );
                                        },
                                        cardHeight: 100.h,
                                      ),
                                    ),
                                  ),
                                  const VerticalDottedDivider(
                                    height: 190,
                                    color: Colors.black26,
                                    dashHeight: 4,
                                    dashWidth: 1,
                                  ),
                                  //Online Tickets
                                  Expanded(
                                    child: Visibility(
                                      visible: isDTS == true,
                                      child: DashCard(
                                        title: 'Online Tickets',
                                        firstCount: controller
                                                    .newCountModel?.ticket !=
                                                null
                                            ? controller.newCountModel?.ticket
                                                .toString()
                                            : '',
                                        firstCountText: "Till Date",
                                        secondCount: controller.newCountModel
                                                    ?.currentDateTicket !=
                                                null
                                            ? controller.newCountModel
                                                ?.currentDateTicket
                                                .toString()
                                            : '',
                                        secondCountText: "Current Day",
                                        pendingCount: controller.newCountModel
                                                    ?.pendingTickets !=
                                                null
                                            ? controller
                                                .newCountModel?.pendingTickets
                                                .toString()
                                            : '',
                                        complateCount: "0",
                                        isVisiableRow: true,
                                        iconPath: 'assets/ticket.png',
                                        isSecondCount: true,
                                        isInfoVisible: false,
                                        onInfoClick: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return DashInfoTable1(
                                                pageTitle:
                                                    "Total Online Complaints",
                                                l1: const [
                                                  '1',
                                                  '2',
                                                  '3',
                                                  '4',
                                                  '5',
                                                  '6'
                                                ],
                                                l2: const [
                                                  'Data Correction',
                                                  'New Requirement',
                                                  'Operator Issue',
                                                  'Software Services',
                                                  'Bug',
                                                  'Inhancement'
                                                ],
                                                l3: [
                                                  dashboardController
                                                      .ticketTechnician
                                                      ?.dataCorrectionTicketCount,
                                                  dashboardController
                                                      .ticketTechnician
                                                      ?.newRequirmentTIcketCount,
                                                  dashboardController
                                                      .ticketTechnician
                                                      ?.operatorIssueTicketCount,
                                                  dashboardController
                                                      .ticketTechnician
                                                      ?.softwereServiceTicketCount,
                                                  dashboardController
                                                      .ticketTechnician
                                                      ?.bugTicketCount,
                                                  dashboardController
                                                      .ticketTechnician
                                                      ?.inhancementTicketCount
                                                ],
                                                tableHeader: const [
                                                  "Sr. No",
                                                  "Type",
                                                  "Count"
                                                ],
                                                onButtonPressed:
                                                    handleButtonPress,
                                              );
                                            },
                                          );
                                        },
                                        cardHeight: 100.h,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              HorizontalDottedDivider(
                                width: double.infinity,
                                dashHeight: 4,
                                dashWidth: 1,
                                color: Colors.black26,
                              ),
                              Row(
                                children: [
                                  //Total Feedback
                                  Expanded(
                                    child: Visibility(
                                      visible: isDFC == true,
                                      child: DashCard(
                                        title: 'Feedback',
                                        firstCount: controller
                                                    .newCountModel?.feedback !=
                                                null
                                            ? controller.newCountModel?.feedback
                                                .toString()
                                            : '',
                                        firstCountText: "Total",
                                        secondCount: controller.newCountModel
                                                    ?.currentDateFeedback !=
                                                null
                                            ? controller.newCountModel
                                                ?.currentDateFeedback
                                                .toString()
                                            : '',
                                        secondCountText:
                                            dashboardController.isTodaysDate
                                                ? "Current Day"
                                                : "Date Wise Feedback",
                                        iconPath: 'assets/feedback.png',
                                        isSecondCount: true,
                                        cardHeight: 100.h,
                                      ),
                                    ),
                                  ),
                                  const VerticalDottedDivider(
                                    height: 190,
                                    color: Colors.black26,
                                    dashHeight: 4,
                                    dashWidth: 1,
                                  ),
                                  //Laboratory Test Assigned
                                  Expanded(
                                    child: Visibility(
                                      visible: isDLT == true,
                                      child: DashCard(
                                        title: 'Laboratory Test Assigned',
                                        firstCount: controller.newCountModel
                                                    ?.totalLbTest !=
                                                null
                                            ? controller
                                                .newCountModel?.totalLbTest
                                                .toString()
                                            : '',
                                        firstCountText: "Till Date",
                                        secondCount: controller.newCountModel
                                                    ?.currentDateLabTest !=
                                                null
                                            ? controller.newCountModel
                                                ?.currentDateLabTest
                                                .toString()
                                            : '',
                                        secondCountText: dashboardController
                                                .isTodaysDate
                                            ? "Current Day"
                                            : "Date Wise Laboratory Test Assigned",
                                        pendingCount: controller.newCountModel
                                                    ?.totalLbTest !=
                                                null
                                            ? controller
                                                .newCountModel?.totalLbTest
                                                .toString()
                                            : "",
                                        // complateCount: "0",
                                        isVisiableRow: false,
                                        iconPath: 'assets/leboretory.png',
                                        isSecondCount: true,
                                        isInfoVisible: false,
                                        onInfoClick: () {
                                          Get.to(DashInfoTableSubHeaderTestDet(
                                            dataList: dashboardController
                                                    .labtestDetails ??
                                                [],
                                            pageTitle:
                                                'Total Laboratory Test Assigned',
                                          ));
                                        },
                                        cardHeight: 100.h,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              HorizontalDottedDivider(
                                width: double.infinity,
                                dashHeight: 4,
                                dashWidth: 1,
                                color: Colors.black26,
                              ),
                              Row(
                                children: [
                                  Visibility(
                                    visible: isDAE == true,
                                    child: Expanded(
                                        child: DashCard(
                                      title: 'Event Occurred',
                                      firstCount: controller
                                                  .newCountModel?.totalEvent !=
                                              null
                                          ? controller.newCountModel?.totalEvent
                                              .toString()
                                          : '',
                                      firstCountText: "Till Date",
                                      secondCount: controller.newCountModel
                                                  ?.currentDateEvent !=
                                              null
                                          ? controller
                                              .newCountModel?.currentDateEvent
                                              .toString()
                                          : '',
                                      secondCountText:
                                          dashboardController.isTodaysDate
                                              ? "Current Day"
                                              : "Date Wise Events",
                                      iconPath: 'assets/event.png',
                                      isSecondCount: true,
                                      isInfoVisible: false,
                                      onInfoClick: () {
                                        Get.to(DashInfoTableEvent(
                                          patients:
                                              controller.eventDetIdListTech ??
                                                  [],
                                          pageTitle: 'Total Adverse Event',
                                        ));
                                      },
                                      cardHeight: 100.h,
                                    )),
                                  ),
                                  const VerticalDottedDivider(
                                    height: 190,
                                    color: Colors.black26,
                                    dashHeight: 4,
                                    dashWidth: 1,
                                  ),
                                  Visibility(
                                    visible: isDMC == true,
                                    child: Expanded(
                                        child: DashCard(
                                      title: 'Machine Count',
                                      firstCount: controller.newCountModel
                                                  ?.totalMachine !=
                                              null
                                          ? controller
                                              .newCountModel?.totalMachine
                                              .toString()
                                          : '',
                                      firstCountText: "Total",
                                      secondCount: controller.newCountModel
                                                  ?.machineWorking !=
                                              null
                                          ? controller
                                              .newCountModel?.machineWorking
                                              .toString()
                                          : '',
                                      secondCountText: "Working",
                                      iconPath: 'assets/machine.png',
                                      isSecondCount: true,
                                      isInfoVisible: false,
                                      onInfoClick: () {
                                        Get.to(DashInfoTableTotal(
                                          isShowButton: false,
                                          dataList: dashboardController
                                                  .machineCountInfo ??
                                              [],
                                          pageTitle: 'Machine Count',
                                          showData: () {},
                                        ));
                                      },
                                      cardHeight: 100.h,
                                    )),
                                  ),
                                ],
                              ),
                              // HorizontalDottedDivider(
                              //   width: double.infinity,
                              //   dashHeight: 4,
                              //   dashWidth: 1,
                              //   color: Colors.black26,
                              // ),
                              const SizedBox(height: 20),
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
                                    buildTab(0, "Scheme Performance"),
                                    buildTab(1, "Viral Load Status")
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 8, bottom: 8, right: 12),
                                child: Container(
                                  height: 420,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withValues(alpha: 0.4),
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      SchemePerformanceChart(
                                        dates: controller.dates ?? [],
                                        mjpjayCounts:
                                            controller.mjpjayCounts ?? [],
                                        nonMjpjayCounts:
                                            controller.nonMjpjayCounts ?? [],
                                      ),
                                      CustomRadialChart(
                                          chartData: controller.createList())
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
      ),
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
      width: 150,
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

      // Format the date as "01-OCT-2024"
      DateFormat formatter = DateFormat('yyyy/MM/dd');
      dashboardController.formattedToDate =
          formatter.format(dashboardController.selectedToDate!);

      // Set the formatted date in the text field
      dashboardController.tDateController.text =
          dashboardController.formattedToDate!;

      // Refresh the UI
      setState(() {});
    }
  }
}

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:heamodialysis/dashboard/dash_info_table_admin.dart';
// import 'package:heamodialysis/dashboard/dash_info_table_techni.dart';
// import 'package:heamodialysis/dashboard/dash_info_table_total.dart';
// import 'package:heamodialysis/dashboard/dashboard_controller.dart';
// import 'package:heamodialysis/dashboard/dialysis_session_technician.dart';
// import 'package:heamodialysis/dashboard/drawer_screen.dart';
// import 'package:heamodialysis/internet/no_internet_connectivity.dart';
// import 'package:heamodialysis/new_registration/new_registration_controller.dart';
// import 'package:heamodialysis/utils/color_constants.dart';
// import 'package:heamodialysis/utils/shared_pref_constants.dart';
// import 'package:heamodialysis/utils/shared_preference.dart';
// import 'package:heamodialysis/widgets/custom_text.dart';
// import 'package:heamodialysis/widgets/custom_textfield.dart';
// import 'package:heamodialysis/widgets/dash_card.dart';
// import 'package:heamodialysis/widgets/date_picker.dart';
// import 'package:heamodialysis/widgets/radila_chart.dart';
// import 'package:heamodialysis/widgets/scheme_performance_chart.dart';
// import 'package:intl/intl.dart';
//
// class InstituteWiseDashboardScreen extends StatefulWidget {
//   const InstituteWiseDashboardScreen({super.key});
//
//   @override
//   State<InstituteWiseDashboardScreen> createState() =>
//       _InstituteWiseDashboardScreenState();
// }
//
// class _InstituteWiseDashboardScreenState
//     extends State<InstituteWiseDashboardScreen>
//     with SingleTickerProviderStateMixin {
//   // Controllers
//   late final DashboardController _dashboardController;
//   late final NewRegistrationController _newRegistrationController;
//   late final TabController _tabController;
//
//   // State variables
//   bool _hasInternet = true;
//   Map<String, dynamic>? _userData;
//   String? _userType;
//   String? _userName;
//
//   // Constants
//   static const _dateFormat = 'yyyy/MM/dd';
//   static const _tabLength = 2;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeControllers();
//     _setupTabController();
//     _initializeData();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       drawer: _buildDrawer(),
//       body: GetBuilder<DashboardController>(
//         init: _dashboardController,
//         builder: (controller) => _hasInternet
//             ? _buildDashboardContent(controller)
//             : _buildNoInternetContent(),
//       ),
//     );
//   }
//
//   void _initializeControllers() {
//     _dashboardController = Get.put(DashboardController());
//     _newRegistrationController = Get.put(NewRegistrationController());
//   }
//
//   void _setupTabController() {
//     _tabController = TabController(length: _tabLength, vsync: this);
//     _tabController.addListener(() => setState(() {}));
//   }
//
//   void _initializeData() {
//     _getUserData();
//     _checkInternetAndLoadData();
//   }
//
//   Future<void> _checkInternetAndLoadData() async {
//     await _checkInternetConnectivity();
//     _dashboardController.update();
//
//     if (!_hasInternet) return;
//
//     await _loadDashboardData();
//   }
//
//   Future<void> _checkInternetConnectivity() async {
//     final connectivityResult = await Connectivity().checkConnectivity();
//     _hasInternet = connectivityResult.contains(ConnectivityResult.mobile) ||
//         connectivityResult.contains(ConnectivityResult.wifi);
//   }
//
//   Future<void> _loadDashboardData() async {
//     if (_userData == null) return;
//
//     _dashboardController.labtestDetails?.clear();
//
//     final dateRange = _getCurrentDateRange();
//     final unitId = _userData!['unitId'].toString();
//     final mulSelunit = _userData!['mulSelunit'].toString();
//
//     await Future.wait<dynamic>([
//       // Dashboard data
//       _dashboardController.getDashboardShort(unitId),
//       _dashboardController.getDash(unitId, dateRange.from, dateRange.to),
//       _dashboardController.getRadialChart(unitId, dateRange.from, dateRange.to),
//       _dashboardController.getSchemePerformance(dateRange.from, dateRange.to, unitId),
//       _dashboardController.getViralStatueList(),
//       _dashboardController.getOnGoingDialysisSession(dateRange.from, dateRange.to, unitId),
//
//       // Registration data
//       ..._getRegistrationFutures(),
//
//       // Lab & Patient info
//       ..._getLabAndPatientFutures(unitId, dateRange.from, dateRange.to, mulSelunit),
//     ]);
//   }
//
//   DateRange _getCurrentDateRange() {
//     final now = DateTime.now();
//     return DateRange(
//       from: DateFormat(_dateFormat).format(now),
//       to: DateFormat(_dateFormat).format(now.add(const Duration(days: 1))),
//     );
//   }
//
//   List<Future<dynamic>> _getRegistrationFutures() {
//     return [
//       _newRegistrationController.getTownList(),
//       _newRegistrationController.getStateList(),
//       _newRegistrationController.getDivisionList(),
//       _newRegistrationController.getDistrictList(),
//       _newRegistrationController.getTalukaList(),
//     ];
//   }
//
//   List<Future<dynamic>> _getLabAndPatientFutures(String unitId, String fromDate, String toDate, String mulSelunit) {
//     return [
//       _dashboardController.getLaboratoryAss(unitId, fromDate, toDate),
//       _dashboardController.getPatientRegTechnician(unitId, fromDate, toDate),
//       _dashboardController.getAbhaPatientTechnician(unitId, fromDate, toDate),
//       _dashboardController.getDialysisSession(unitId, fromDate, toDate),
//       _dashboardController.getDialysisSessionCancelled(unitId, fromDate, toDate),
//       _dashboardController.getEventForIdTech(fromDate, toDate, unitId),
//       _dashboardController.getMachineCount(mulSelunit, fromDate, toDate),
//       _dashboardController.getComplaintTechnician(unitId, fromDate, toDate),
//       _dashboardController.getTicketTechnician(unitId, fromDate, toDate),
//     ];
//   }
//
//   Future<void> _getUserData() async {
//     try {
//       _userData = await SharedPref().read(const SharedPrefConstant().kUserData);
//       if (_userData != null) {
//         _userType = _userData!['ut'];
//         _userName = '${_userData!['fname']} ${_userData!['lname']}';
//         setState(() {});
//       }
//     } catch (e) {
//       debugPrint('Error loading user data: $e');
//     }
//   }
//
//   Future<void> _refreshTodayData() async {
//     if (_userData == null) return;
//
//     final dateRange = _getCurrentDateRange();
//     final unitId = _userData!['unitId'].toString();
//     final mulSelunit = _userData!['mulSelunit'].toString();
//
//     _dashboardController.labtestDetails?.clear();
//
//     await Future.wait<dynamic>([
//       _dashboardController.getDash(unitId, dateRange.from, dateRange.to),
//       _dashboardController.getLaboratoryAss(unitId, dateRange.from, dateRange.to),
//       _dashboardController.getRadialChart(unitId, dateRange.from, dateRange.to),
//       _dashboardController.getSchemePerformance(dateRange.from, dateRange.to, unitId),
//       _dashboardController.getOnGoingDialysisSession(dateRange.from, dateRange.to, unitId),
//       _dashboardController.getPatientRegTechnician(unitId, dateRange.from, dateRange.to),
//       _dashboardController.getAbhaPatientTechnician(unitId, dateRange.from, dateRange.to),
//       _dashboardController.getDialysisSession(unitId, dateRange.from, dateRange.to),
//       _dashboardController.getDialysisSessionCancelled(unitId, dateRange.from, dateRange.to),
//       _dashboardController.getEventForIdTech(dateRange.from, dateRange.to, unitId),
//       _dashboardController.getMachineCount(mulSelunit, dateRange.from, dateRange.to),
//       _dashboardController.getComplaintTechnician(unitId, dateRange.from, dateRange.to),
//       _dashboardController.getTicketTechnician(unitId, dateRange.from, dateRange.to),
//     ]);
//
//     _resetDateFilters();
//   }
//
//   void _resetDateFilters() {
//     _dashboardController.fDateController.clear();
//     _dashboardController.tDateController.clear();
//     _dashboardController.isCustomCalender = false;
//     _dashboardController.isTodaysDate = true;
//     _dashboardController.update();
//   }
//
//   void _toggleCalendar() {
//     _dashboardController.isCustomCalender = !_dashboardController.isCustomCalender;
//     _dashboardController.update();
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       title: const CustomText(
//         text: 'Dashboard',
//         fontSize: 18.0,
//         fontFam: 'Lato',
//         fontWeight: FontWeight.w400,
//         textColor: Colors.black,
//         textAlign: TextAlign.start,
//       ),
//       leading: Builder(
//         builder: (context) => IconButton(
//           icon: Image.asset('assets/drawer-icon.png'),
//           onPressed: () => Scaffold.of(context).openDrawer(),
//         ),
//       ),
//       actions: [
//         _buildTodayButton(),
//         const SizedBox(width: 10),
//         _buildCalendarButton(),
//       ],
//     );
//   }
//
//   Widget _buildTodayButton() {
//     return InkWell(
//       onTap: _refreshTodayData,
//       child: const CustomText(
//         text: "Today",
//         fontSize: 14,
//         fontWeight: FontWeight.bold,
//         textColor: Colors.black,
//         textAlign: TextAlign.start,
//       ),
//     );
//   }
//
//   Widget _buildCalendarButton() {
//     return InkWell(
//       onTap: _toggleCalendar,
//       child: Padding(
//         padding: const EdgeInsets.only(right: 8),
//         child: Image.asset("assets/gradient_calender.png"),
//       ),
//     );
//   }
//
//   Widget _buildDrawer() {
//     return Drawer(
//       child: DrawerScreen(
//         userData: _userData,
//         userType: _userType,
//         userName: _userName,
//       ),
//     );
//   }
//
//   Widget _buildDashboardContent(DashboardController controller) {
//     if (controller.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     final permissions = _getDepartmentPermissions(controller);
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 4),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           _buildCustomDateFilter(),
//           _buildDashboardCards(controller, permissions),
//           _buildTabSection(),
//           _buildChartSection(controller),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNoInternetContent() {
//     return InternetIssue(
//       onRetryPressed: _checkInternetAndLoadData,
//     );
//   }
//
//   DepartmentPermissions _getDepartmentPermissions(DashboardController controller) {
//     final departments = controller.deptList?.departments ?? [];
//     return DepartmentPermissions(
//       isDPR: departments.contains("DPR"),
//       isDAR: departments.contains("DAR"),
//       isDCS: departments.contains("DCS"),
//       isDDC: departments.contains("DDC"),
//       isDLT: departments.contains("DLT"),
//       isDAE: departments.contains("DAE"),
//       isDMC: departments.contains("DMC"),
//       isDFC: departments.contains("DFC"),
//       isDCC: departments.contains("DCC"),
//       isDTS: departments.contains("DTS"),
//     );
//   }
//
//   Widget _buildCustomDateFilter() {
//     return Visibility(
//       visible: _dashboardController.isCustomCalender,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.grey[50],
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: AppColor.borderColor),
//         ),
//         child: Column(
//           children: [
//             _buildDateField('From Date', _dashboardController.fDateController, _selectFromDate),
//             _buildDateField('To Date', _dashboardController.tDateController, _selectToDate),
//             const SizedBox(height: 8),
//             _buildSearchButton(),
//             const SizedBox(height: 4),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDateField(String label, TextEditingController controller, VoidCallback onTap) {
//     return CustomDateField(
//       labelText: label,
//       hint: 'Select Date',
//       isRequired: false,
//       callB: onTap,
//       selectedDate: controller,
//       filledColor: Colors.white,
//       dontDhowPrefix: false,
//     );
//   }
//
//   Widget _buildSearchButton() {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: InkWell(
//         onTap: _performCustomDateSearch,
//         child: Container(
//           width: 100,
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             gradient: LinearGradient(
//               colors: [AppColor.primaryBackgroundColor, AppColor.secondaryColor],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.search, color: Colors.white),
//               CustomText(
//                 text: "Search",
//                 fontSize: 16,
//                 fontFam: "Lato",
//                 fontWeight: FontWeight.normal,
//                 textColor: Colors.white,
//                 textAlign: TextAlign.start,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _performCustomDateSearch() async {
//     if (_userData == null) return;
//
//     _dashboardController.labtestDetails?.clear();
//     _dashboardController.isTodaysDate = false;
//
//     final unitId = _userData!['unitId'].toString();
//     final mulSelunit = _userData!['mulSelunit'].toString();
//     final fromDate = _dashboardController.fDateController.text;
//     final selectedToDate = _getSelectedToDate();
//
//     await Future.wait<dynamic>([
//       _dashboardController.getDash(unitId, fromDate, selectedToDate),
//       _dashboardController.getLaboratoryAss(unitId, fromDate, selectedToDate),
//       _dashboardController.getAbhaPatientTechnician(unitId, fromDate, selectedToDate),
//       _dashboardController.getRadialChart(unitId, fromDate, selectedToDate),
//       _dashboardController.getPatientRegTechnician(unitId, fromDate, selectedToDate),
//       _dashboardController.getOnGoingDialysisSession(fromDate, selectedToDate, unitId),
//       _dashboardController.getSchemePerformance(fromDate, selectedToDate, unitId),
//       _dashboardController.getDialysisSession(unitId, fromDate, selectedToDate),
//       _dashboardController.getDialysisSessionCancelled(unitId, fromDate, selectedToDate),
//       _dashboardController.getEventForIdTech(fromDate, selectedToDate, unitId),
//       _dashboardController.getMachineCount(mulSelunit, fromDate, selectedToDate),
//       _dashboardController.getComplaintTechnician(unitId, fromDate, selectedToDate),
//       _dashboardController.getTicketTechnician(unitId, fromDate, selectedToDate),
//     ]);
//   }
//
//   String? _getSelectedToDate() {
//     if (_dashboardController.tDateController.text.isEmpty) return null;
//
//     final selectedDate = DateFormat(_dateFormat).parse(_dashboardController.tDateController.text);
//     final nextDate = selectedDate.add(const Duration(days: 1));
//     return DateFormat(_dateFormat).format(nextDate);
//   }
//
//   Widget _buildDashboardCards(DashboardController controller, DepartmentPermissions permissions) {
//     return Column(
//       children: [
//         _buildPatientRegistrationRow(controller, permissions),
//         _buildDialysisSessionRow(controller, permissions),
//         _buildLaboratoryTestCard(controller, permissions),
//         _buildEventMachineRow(controller, permissions),
//         _buildFeedbackCard(controller, permissions),
//         _buildComplaintCard(controller, permissions),
//         _buildTicketCard(controller, permissions),
//       ],
//     );
//   }
//
//   Widget _buildPatientRegistrationRow(DashboardController controller, DepartmentPermissions permissions) {
//     return Row(
//       children: [
//         if (permissions.isDPR) _buildPatientRegistrationCard(controller),
//         if (permissions.isDAR) _buildAbhaRegistrationCard(controller),
//       ],
//     );
//   }
//
//   Widget _buildDialysisSessionRow(DashboardController controller, DepartmentPermissions permissions) {
//     return Row(
//       children: [
//         if (permissions.isDCS) _buildDialysisSessionCard(controller),
//         if (permissions.isDDC) _buildDialysisCancelledCard(controller),
//       ],
//     );
//   }
//
//   Widget _buildEventMachineRow(DashboardController controller, DepartmentPermissions permissions) {
//     return Row(
//       children: [
//         if (permissions.isDAE) _buildEventCard(controller),
//         if (permissions.isDMC) _buildMachineCard(controller),
//       ],
//     );
//   }
//
//   // Individual card builders
//   Widget _buildPatientRegistrationCard(DashboardController controller) {
//     return Expanded(
//       child: DashCard(
//         firstCountText: "Total Patient Registration",
//         firstCount: controller.newCountModel?.patientAdded?.toString() ?? "",
//         secondCount: controller.newCountModel?.currentDatePatient?.toString() ?? '',
//         secondCountText: _dashboardController.isTodaysDate
//             ? "Current Date Patient Registration"
//             : "Date Wise Patient Registration",
//         iconPath: 'assets/total_patient.png',
//         isSecondCount: true,
//        isInfoVisible: false,
//         onInfoClick: () => Get.to(DashInfoTable(
//           patients: _dashboardController.dashInfoData ?? [],
//           pageTitle: 'Patient Added List',
//         )),
//         cardHeight: 100.h,
//       ),
//     );
//   }
//
//   Widget _buildAbhaRegistrationCard(DashboardController controller) {
//     return Expanded(
//       child: DashCard(
//         firstCount: controller.newCountModel?.abhaRegistration?.toString() ?? '',
//         firstCountText: "Total ABHA Registration",
//         secondCount: controller.newCountModel?.currentDateAbhaReg?.toString() ?? '',
//         secondCountText: _dashboardController.isTodaysDate
//             ? "Current Date ABHA Registration"
//             : "Date Wise ABHA Registration",
//         iconPath: 'assets/abha_registration.png',
//         isSecondCount: true,
//         isInfoVisible: false,
//         onInfoClick: () => Get.to(DashInfoTable(
//           patients: _dashboardController.dashInfoDataAdmin ?? [],
//           pageTitle: 'Patient Added List',
//         )),
//         cardHeight: 100.h,
//       ),
//     );
//   }
//
//   Widget _buildDialysisSessionCard(DashboardController controller) {
//     return Expanded(
//       child: DashCard(
//         firstCount: controller.newCountModel?.totalDialysisSession?.toString() ?? '',
//         firstCountText: "Total Dialysis Sessions",
//         secondCount: controller.newCountModel?.currentDateDialysisSession?.toString() ?? '',
//         secondCountText: _dashboardController.isTodaysDate
//             ? "Current Day Dialysis Sessions"
//             : "Date Wise Dialysis Sessions",
//         iconPath: 'assets/dialysis_session.png',
//         isSecondCount: true,
//        isInfoVisible: false,
//         onInfoClick: () => _showDialysisSessionInfo(controller),
//         cardHeight: 100.h,
//       ),
//     );
//   }
//
//   Widget _buildDialysisCancelledCard(DashboardController controller) {
//     return Expanded(
//       child: DashCard(
//         firstCount: controller.newCountModel?.totalDialysisCnacel?.toString() ?? '',
//         firstCountText: "Total Dialysis Cancelled",
//         secondCount: controller.newCountModel?.currentdialCancel?.toString() ?? '',
//         secondCountText: _dashboardController.isTodaysDate
//             ? "Current Day Dialysis Cancelled"
//             : "Date Wise Dialysis Cancelled",
//         iconPath: 'assets/dialysis_cancelled.png',
//         isSecondCount: true,
//       isInfoVisible: false,
//         onInfoClick: () => _showDialysisCancelledInfo(controller),
//         cardHeight: 100.h,
//       ),
//     );
//   }
//
//   Widget _buildLaboratoryTestCard(DashboardController controller, DepartmentPermissions permissions) {
//     if (!permissions.isDLT) return const SizedBox.shrink();
//
//     return DashCard(
//       firstCount: controller.newCountModel?.totalLbTest?.toString() ?? '',
//       firstCountText: "Total Laboratory Test Assigned",
//       secondCount: controller.newCountModel?.currentDateLabTest?.toString() ?? '',
//       secondCountText: _dashboardController.isTodaysDate
//           ? "Current Day Laboratory Test Assigned"
//           : "Date Wise Laboratory Test Assigned",
//       pendingCount: controller.newCountModel?.totalLbTest?.toString() ?? "",
//       isVisiableRow: false,
//       iconPath: 'assets/leboretory.png',
//       isSecondCount: true,
//      isInfoVisible: false,
//       onInfoClick: () => Get.to(DashInfoTableSubHeaderTestDet(
//         dataList: _dashboardController.labtestDetails ?? [],
//         pageTitle: 'Total Laboratory Test Assigned',
//       )),
//       cardHeight: 100.h,
//     );
//   }
//
//   Widget _buildEventCard(DashboardController controller) {
//     return Expanded(
//       child: DashCard(
//         firstCount: controller.newCountModel?.totalEvent?.toString() ?? '',
//         firstCountText: "Total Event Occured",
//         secondCount: controller.newCountModel?.currentDateEvent?.toString() ?? '',
//         secondCountText: _dashboardController.isTodaysDate
//             ? "Current Day Events"
//             : "Date Wise Events",
//         iconPath: 'assets/event.png',
//         isSecondCount: true,
//       isInfoVisible: false,
//         onInfoClick: () => Get.to(DashInfoTableEvent(
//           patients: controller.eventDetIdListTech ?? [],
//           pageTitle: 'Total Adverse Event',
//         )),
//         cardHeight: 100.h,
//       ),
//     );
//   }
//
//   Widget _buildMachineCard(DashboardController controller) {
//     return Expanded(
//       child: DashCard(
//         firstCount: controller.newCountModel?.totalMachine?.toString() ?? '',
//         firstCountText: "Total Active Machines",
//         secondCount: '',
//         secondCountText: "",
//         iconPath: 'assets/machine.png',
//         isSecondCount: true,
//         isInfoVisible: false,
//         onInfoClick: () => Get.to(DashInfoTableTotal(
//           isShowButton: false,
//           dataList: _dashboardController.machineCountInfo ?? [],
//           pageTitle: 'Machine Count',
//           showData: () {},
//         )),
//         cardHeight: 100.h,
//       ),
//     );
//   }
//
//   Widget _buildFeedbackCard(DashboardController controller, DepartmentPermissions permissions) {
//     if (!permissions.isDFC) return const SizedBox.shrink();
//
//     return DashCard(
//       firstCount: controller.newCountModel?.feedback?.toString() ?? '',
//       firstCountText: "Total Feedback",
//       secondCount: controller.newCountModel?.currentDateFeedback?.toString() ?? '',
//       secondCountText: _dashboardController.isTodaysDate
//           ? "Current Date Feedback"
//           : "Date Wise Feedback",
//       iconPath: 'assets/feedback.png',
//       isSecondCount: true,
//       cardHeight: 100.h,
//     );
//   }
//
//   Widget _buildComplaintCard(DashboardController controller, DepartmentPermissions permissions) {
//     if (!permissions.isDCC) return const SizedBox.shrink();
//
//     return DashCard(
//       firstCount: controller.newCountModel?.totalComplaint?.toString() ?? '',
//       firstCountText: "Total Online Complaints",
//       secondCount: controller.newCountModel?.currentDateFeedback?.toString() ?? '',
//       secondCountText: "Current Day Complaints",
//       pendingCount: controller.newCountModel?.pendingComplaint?.toString() ?? '',
//       complateCount: controller.newCountModel?.completeComplaint?.toString() ?? '',
//       isVisiableRow: true,
//       iconPath: 'assets/complaints.png',
//       isSecondCount: true,
//      isInfoVisible: false,
//       onInfoClick: () => _showComplaintDialog(),
//       cardHeight: 100.h,
//     );
//   }
//
//   Widget _buildTicketCard(DashboardController controller, DepartmentPermissions permissions) {
//     if (!permissions.isDTS) return const SizedBox.shrink();
//
//     return DashCard(
//       firstCount: controller.newCountModel?.ticket?.toString() ?? '',
//       firstCountText: "Total Online Tickets",
//       secondCount: controller.newCountModel?.currentDateTicket?.toString() ?? '',
//       secondCountText: "Current Day Tickets",
//       pendingCount: controller.newCountModel?.pendingTickets?.toString() ?? '',
//       complateCount: "0",
//       isVisiableRow: true,
//       iconPath: 'assets/ticket.png',
//       isSecondCount: true,
//     isInfoVisible: false,
//       onInfoClick: () => _showTicketDialog(),
//       cardHeight: 100.h,
//     );
//   }
//
//   Widget _buildTabSection() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8, left: 8, bottom: 0, right: 8),
//       child: TabBar(
//         tabAlignment: TabAlignment.start,
//         isScrollable: true,
//         controller: _tabController,
//         dividerColor: Colors.transparent,
//         indicatorColor: Colors.transparent,
//         padding: EdgeInsets.zero,
//         indicatorPadding: EdgeInsets.zero,
//         labelPadding: EdgeInsets.zero,
//         tabs: [
//           _buildTab(0, "Scheme Performance"),
//           _buildTab(1, "Viral Load Status"),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTab(int index, String text) {
//     final isSelected = _tabController.index == index;
//     return Container(
//       width: 150,
//       height: 40,
//       alignment: Alignment.center,
//       padding: const EdgeInsets.symmetric(horizontal: 0.8, vertical: 6),
//       decoration: BoxDecoration(
//         gradient: isSelected
//             ? LinearGradient(
//           colors: [AppColor.primaryBackgroundColor, AppColor.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomCenter,
//         )
//             : const LinearGradient(
//           colors: [Colors.transparent, Colors.transparent],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomCenter,
//         ),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//         border: Border.all(color: const Color(0xffE1E1E1)),
//       ),
//       child: CustomText(
//         text: text,
//         fontSize: 12.0,
//         fontFam: 'Lato',
//         fontWeight: FontWeight.normal,
//         textColor: isSelected ? Colors.white : const Color(0xff777777),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
//
//   Widget _buildChartSection(DashboardController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 0, left: 8, bottom: 8, right: 12),
//       child: Container(
//         height: 420,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withValues(alpha: (0.4),
//               spreadRadius: 1,
//               blurRadius: 4,
//               offset: const Offset(1, 1),
//             ),
//           ],
//           color: Colors.white,
//         ),
//         child: TabBarView(
//           controller: _tabController,
//           physics: const NeverScrollableScrollPhysics(),
//           children: [
//             SchemePerformanceChart(
//               dates: controller.dates ?? [],
//               mjpjayCounts: controller.mjpjayCounts ?? [],
//               nonMjpjayCounts: controller.nonMjpjayCounts ?? [],
//             ),
//             CustomRadialChart(chartData: controller.createList()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Helper methods
//   void _showDialysisSessionInfo(DashboardController controller) {
//     final patients = <Map<String, dynamic>>[
//       {"mjpjayCount": _dashboardController.dialysisSession['mjpjayCount'].toString()},
//       {"nonMjpjyCount": _dashboardController.dialysisSession['nonMjpjyCount'].toString()},
//     ];
//
//     Get.to(DashInfoTableTechnician(
//       patients: patients,
//       pageTitle: 'Dialysis Session',
//       showData: (scheme) => _showDialysisSessionDetails(controller, scheme),
//     ));
//   }
//
//   Future<void> _showDialysisSessionDetails(DashboardController controller, String scheme) async {
//     final dateRange = _getDateRangeForDetails(controller);
//
//     await controller.getDialysisSessionIdWise(
//       dateRange.from,
//       dateRange.to,
//       _userData!['unitId'].toString(),
//       scheme,
//     );
//
//     Get.to(TotalDialysisPatient(
//       showTreatment: true,
//       patients: controller.dialysisSessionId ?? [],
//       pageTitle: 'Dialysis Session',
//       pageTitleSecond: "",
//       showAbha: false,
//     ));
//   }
//
//   void _showDialysisCancelledInfo(DashboardController controller) {
//     final patients = <Map<String, dynamic>>[
//       {"mjpjayCount": _dashboardController.dialysisSessionCancelled['mjpjayCancelCount'].toString()},
//       {"nonMjpjyCount": _dashboardController.dialysisSessionCancelled['nonMjpjyCancelCount'].toString()},
//     ];
//
//     Get.to(DashInfoTableTechnician(
//       patients: patients,
//       pageTitle: 'Total Dialysis Cancelled',
//       showData: (scheme) => _showDialysisCancelledDetails(controller, scheme),
//     ));
//   }
//
//   Future<void> _showDialysisCancelledDetails(DashboardController controller, String scheme) async {
//     final dateRange = _getDateRangeForDetails(controller);
//
//     await controller.getDialysisSessionCancelIdWise(
//       dateRange.from,
//       dateRange.to,
//       _userData!['unitId'].toString(),
//       scheme,
//     );
//
//     Get.to(TotalDialysisPatient(
//       showTreatment: true,
//       showAbha: false,
//       patients: controller.dialysisCancelId ?? [],
//       pageTitle: 'Dialysis Cancel',
//       pageTitleSecond: "",
//     ));
//   }
//
//   DateRange _getDateRangeForDetails(DashboardController controller) {
//     final now = DateTime.now();
//     final defaultFromDate = DateFormat(_dateFormat).format(now);
//     final defaultToDate = DateFormat(_dateFormat).format(now.add(const Duration(days: 1)));
//
//     String? selectedToDate;
//     if (controller.tDateController.text.isNotEmpty) {
//       final selectedDate = DateFormat(_dateFormat).parse(controller.tDateController.text);
//       final nextDate = selectedDate.add(const Duration(days: 1));
//       selectedToDate = DateFormat(_dateFormat).format(nextDate);
//     }
//
//     return DateRange(
//       from: controller.fDateController.text.isNotEmpty ? controller.fDateController.text : defaultFromDate,
//       to: controller.tDateController.text.isNotEmpty ? selectedToDate! : defaultToDate,
//     );
//   }
//
//   void _showComplaintDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return DashInfoTable1(
//           pageTitle: "Total Online Complaints",
//           l1: const ['1', '2', '3', '4'],
//           l2: const [
//             'Dashboard Down',
//             'Machine Not Working',
//             'Denial of Services',
//             'Money taken against treatment'
//           ],
//           l3: [
//             _dashboardController.complaintTechnician?.complaintMachineDown,
//             _dashboardController.complaintTechnician?.complaintDenialService,
//             _dashboardController.complaintTechnician?.complaintMonetTakeBytreatment,
//             _dashboardController.complaintTechnician?.complaintDashDown
//           ],
//           tableHeader: const ["Sr. No", "Type\n", "Count\n"],
//           onButtonPressed: _handleButtonPress,
//         );
//       },
//     );
//   }
//
//   void _showTicketDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return DashInfoTable1(
//           pageTitle: "Total Online Tickets",
//           l1: const ['1', '2', '3', '4', '5', '6'],
//           l2: const [
//             'Data Correction',
//             'New Requirement',
//             'Operator Issue',
//             'Software Services',
//             'Bug',
//             'Enhancement'
//           ],
//           l3: [
//             _dashboardController.ticketTechnician?.dataCorrectionTicketCount,
//             _dashboardController.ticketTechnician?.newRequirmentTIcketCount,
//             _dashboardController.ticketTechnician?.operatorIssueTicketCount,
//             _dashboardController.ticketTechnician?.softwereServiceTicketCount,
//             _dashboardController.ticketTechnician?.bugTicketCount,
//             _dashboardController.ticketTechnician?.inhancementTicketCount
//           ],
//           tableHeader: const ["Sr. No", "Type", "Count"],
//           onButtonPressed: _handleButtonPress,
//         );
//       },
//     );
//   }
//
//   void _handleButtonPress(int index) {
//     debugPrint('Button pressed at index: $index');
//     // Add specific actions based on index if needed
//   }
//
//   Future<void> _selectFromDate() async {
//     final DateTime? picked = await DatePickerHelper.selectDate(context);
//     if (picked != null) {
//       _dashboardController.selectedFromDate = picked;
//       final formatter = DateFormat(_dateFormat);
//       _dashboardController.formattedFromDate = formatter.format(picked);
//       _dashboardController.fDateController.text = _dashboardController.formattedFromDate!;
//       setState(() {});
//     }
//   }
//
//   Future<void> _selectToDate() async {
//     final DateTime? picked = await DatePickerHelper.selectDate(context);
//     if (picked != null) {
//       _dashboardController.selectedToDate = picked;
//       final formatter = DateFormat(_dateFormat);
//       _dashboardController.formattedToDate = formatter.format(picked);
//       _dashboardController.tDateController.text = _dashboardController.formattedToDate!;
//       setState(() {});
//     }
//   }
// }
//
// // Helper classes for better code organization
// class DateRange {
//   final String from;
//   final String to;
//
//   const DateRange({required this.from, required this.to});
// }
//
// class DepartmentPermissions {
//   final bool isDPR;
//   final bool isDAR;
//   final bool isDCS;
//   final bool isDDC;
//   final bool isDLT;
//   final bool isDAE;
//   final bool isDMC;
//   final bool isDFC;
//   final bool isDCC;
//   final bool isDTS;
//
//   const DepartmentPermissions({
//     required this.isDPR,
//     required this.isDAR,
//     required this.isDCS,
//     required this.isDDC,
//     required this.isDLT,
//     required this.isDAE,
//     required this.isDMC,
//     required this.isDFC,
//     required this.isDCC,
//     required this.isDTS,
//   });
// }

// 23-09-2025
