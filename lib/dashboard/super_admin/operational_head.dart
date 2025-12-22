import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';

class OperationalHeadScreen extends StatefulWidget {
  const OperationalHeadScreen({super.key});

  @override
  State<OperationalHeadScreen> createState() => _OperationalHeadScreenState();
}

class _OperationalHeadScreenState extends State<OperationalHeadScreen> {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());

  // late TabController tabController;
  bool hasInternet = true;

  var userData;

  String? userType;
  String? userName;

  String? apiDateString;

  @override
  void initState() {
    getUserData();
    // tabController = TabController(length: 2, vsync: this);
    // tabController.addListener(() {
    //   setState(() {});
    // });
    checkInternetAndLoadData();
    super.initState();
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
  //     DateTime tomorrow = now.add(const Duration(days: 1));
  //     String toDate = DateFormat('yyyy/MM/dd').format(tomorrow);
  //
  //     await dashboardController.getDashCount(fromDate, toDate,userData['mulSelunit'].toString());
  //
  //     await newRegistrationController.getInstituteList();
  //
  //     // String toDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  //     await dashboardController.getPatientRegSuperAdmin(fromDate, toDate,userData['mulSelunit'].toString());
  //     await dashboardController.getFunctionalUnitList(
  //         fromDate, toDate, userData['unitId'].toString());
  //     dashboardController.isTodaysDate = true;
  //
  //     await dashboardController.getDialysisSessionAdmin(
  //         userData['unitId'].toString(), fromDate, toDate);
  //
  //     ///Called patient registration api on dashbard to load page fast
  //     // await newRegistrationController.getStateList();
  //     // await newRegistrationController.getDivisionList();
  //     // await newRegistrationController.getDistrictList();
  //     // await newRegistrationController.getTalukaList();
  //     // await newRegistrationController.getTownList();
  //   }
  // }

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

    await Future.wait([
      dashboardController.getDashCount(fromDate, toDate, mulSelUnit),
      dashboardController.getVersionName(),
      newRegistrationController.getInstituteList(),
      dashboardController.getPatientRegSuperAdmin(fromDate, toDate, mulSelUnit),
      dashboardController.getFunctionalUnitList(fromDate, toDate, unitId),
      dashboardController.getDialysisSessionAdmin(mulSelUnit, fromDate, toDate),
    ] as Iterable<Future>);

    dashboardController.isTodaysDate = true;
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);

    userType = userData['ut'];
    userName = '${userData['fname']} ${userData['lname']}';

    setState(() {});
  }

  @override
  void dispose() {
    // tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Dashboard',
          fontSize: 18.sp,
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

              String unitId = userData['unitId'].toString();
              String mulSelUnit = userData['mulSelunit'].toString();

              await Future.wait([
                dashboardController.getDashCount(fromDate, toDate, mulSelUnit),
                newRegistrationController.getInstituteList(),
                dashboardController.getPatientRegSuperAdmin(
                    fromDate, toDate, mulSelUnit),
                dashboardController.getFunctionalUnitList(
                    fromDate, toDate, unitId),
                dashboardController.getDialysisSessionAdmin(
                    mulSelUnit, fromDate, toDate),
              ] as Iterable<Future>);

              dashboardController.fDateController.clear();
              dashboardController.tDateController.clear();
              dashboardController.isCustomCalender = false;
              dashboardController.isTodaysDate = true;

              dashboardController.update();
              // DateTime now = DateTime.now();
              // String fromDate = DateFormat('yyyy/MM/dd').format(now);
              //
              // DateTime tomorrow = now.add(const Duration(days: 1));
              // String toDate = DateFormat('yyyy/MM/dd').format(tomorrow);
              //
              // await dashboardController.getDashCount(fromDate, toDate,userData['mulSelunit'].toString());
              //
              // await newRegistrationController.getInstituteList();
              //
              // await dashboardController.getPatientRegSuperAdmin(
              //     fromDate, toDate,userData['mulSelunit'].toString());
              // await dashboardController.getFunctionalUnitList(
              //     fromDate, toDate, userData['unitId'].toString());
              // await dashboardController.getDialysisSessionAdmin(
              //     userData['unitId'].toString(), fromDate, toDate);
              // dashboardController.fDateController.clear();
              // dashboardController.tDateController.clear();
              // dashboardController.isCustomCalender = false;
              // dashboardController.isTodaysDate = true;
              //
              // dashboardController.update();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
              child: CustomText(
                  text: "Today",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black,
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
              padding: EdgeInsets.fromLTRB(4.w, 4.h, 12.w, 4.h),
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
                    ?  Center(child: buildShimmerLoader())
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
                                                  userData['unitId']
                                                      .toString());

                                          await dashboardController
                                              .getDialysisSessionAdmin(
                                                  userData['mulSelunit']
                                                      .toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);
                                          dashboardController.isTodaysDate =
                                              false;

                                          await dashboardController
                                              .getTotalTickets(
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
                            Row(
                              children: [
                                Expanded(
                                    child: DashCard(
                                      title:'Total Projected Center',
                                  firstCount: controller
                                      .dashboardCountModel?.totalCentre
                                      .toString(),
                                  firstCountText: "Till Date",
                                  secondCount: controller
                                      .dashboardCountModel?.functionalCenter
                                      .toString(),
                                  secondCountText: "Functional Center",
                                  iconPath: 'assets/professional-services.png',
                                  isSecondCount: true,
                                  isInfoVisible: true,
                                  onInfoClick: () {
                                    Get.to(FunctionalCenterTable(
                                      patients: dashboardController
                                              .dashInfoFunctionalUnit ??
                                          [],
                                      pageTitle: 'Total Functional Unit',
                                    ));
                                    // showPatientTableDialog(context, dashboardController.dashInfoData);
                                  },
                                  cardHeight: 80.h,
                                )),
                                Expanded(
                                    child: DashCard(
                                      title:'Total Patient Registration',
                                  firstCountText: "Till Date",
                                  firstCount: controller
                                      .dashboardCountModel?.patientAdded
                                      .toString(),
                                  secondCount: controller
                                      .dashboardCountModel?.currentDatePatient
                                      .toString(),
                                  secondCountText: dashboardController
                                          .isTodaysDate
                                      ? "Current Date"
                                      // ? "Current Date Patient Registerd"
                                      : "Date Wise",
                                      // : "Date Wise Patient Registered Count",
                                  iconPath: 'assets/total_patient.png',
                                  isSecondCount: true,
                                  isInfoVisible: true,
                                  onInfoClick: () {
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
                                        String toDate = DateFormat('yyyy/MM/dd')
                                            .format(tomorrow);

                                        String? selectedToDate;
                                        if (controller
                                            .tDateController.text.isNotEmpty) {
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
                                        Get.to(TotalDialysisPatient(
                                            patients: controller
                                                    .totalDialysisPatient ??
                                                [],
                                            pageTitle: 'Total Patient',
                                            pageTitleSecond:
                                                "Total Dialysis Patient",
                                            showTreatment: false,
                                            showAbha: false));
                                      },
                                    ));
                                    // showPatientTableDialog(context, dashboardController.dashInfoData);
                                  },
                                  cardHeight: 80.h,
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: DashCard(
                                      title:'Total Payment',

                                  firstCount: controller
                                      .dashboardCountModel?.totalInvoicePayment
                                      .toString(),
                                  firstCountText: "Till Date",
                                  secondCount: controller
                                      .dashboardCountModel?.currentMonthInvPymt
                                      .toString(),
                                  secondCountText:
                                      "Current Month",
                                      // "Current Month Payment Amount",
                                  iconPath: 'assets/payment.png',
                                  isSecondCount: true,
                                  cardHeight: 80.h,
                                )),
                                Expanded(
                                    child: DashCard(
                                      title: 'Dialysis Sessions',
                                  firstCount: controller
                                      .dashboardCountModel?.totalDialysisSession
                                      .toString(),
                                  firstCountText: "Till Date",
                                  secondCount: controller.dashboardCountModel
                                      ?.currentDateDialysisSession
                                      .toString(),
                                  secondCountText:
                                      dashboardController.isTodaysDate
                                          ? "Current Date"
                                          // ? "Current Date Dialysis Session"
                                          : "Date Wise",
                                          // : "Date Wise Dialysis Session Count",
                                  iconPath: 'assets/dialysis_session.png',
                                  isSecondCount: true,
                                  isInfoVisible: true,
                                  onInfoClick: () {
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
                                        String toDate = DateFormat('yyyy/MM/dd')
                                            .format(tomorrow);

                                        String? selectedToDate;
                                        //If custom date selected
                                        if (controller
                                            .tDateController.text.isNotEmpty) {
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
                                        // await controller
                                        //     .getDiaSessSuperAdmin(
                                        //     controller.fDateController.text,
                                        //     controller.tDateController.text,
                                        //     userData['unitId']
                                        //         .toString());
                                        Get.to(TotalDialysisPatient(
                                            patients:
                                                controller.dialysisPatient ??
                                                    [],
                                            pageTitle: 'Total Dialysis Patient',
                                            showTreatment: true,
                                            showAbha: false));
                                      },
                                    ));
                                  },
                                  cardHeight: 80.h,
                                )),
                              ],
                            ),
                            DashCard(
                              title:'Total Invoice Amount' ,
                              firstCount: controller
                                  .dashboardCountModel?.totalInvoiceAmount
                                  ?.toInt()
                                  .toString(),
                              firstCountText: "Till Date",
                              secondCount: controller
                                  .dashboardCountModel?.currentMonthInvAmt
                                  ?.toInt()
                                  .toString(),
                              secondCountText: "Current Month",
                              // secondCountText: "Current Month Invoice Amount",
                              iconPath: 'assets/invoice.png',
                              isSecondCount: true,
                              cardHeight: 80.h,
                            )
                          ],
                        ).paddingOnly(left: 4.w, right: 4.w),
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
