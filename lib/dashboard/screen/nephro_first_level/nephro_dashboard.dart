import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/widget/dash_info_table_admin.dart';
import 'package:heamodialysis/dashboard/widget/dash_info_table_total.dart';
import 'package:heamodialysis/dashboard/controller/dashboard_controller.dart';
import 'package:heamodialysis/dashboard/widget/drawer_screen.dart';
import 'package:heamodialysis/dashboard/screen/nephro_first_level/nephro_patient_reg.dart';
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

import '../../../widgets/custom _dottedline.dart';



class NephroDashboard extends StatefulWidget {
  const NephroDashboard({super.key});

  @override
  State<NephroDashboard> createState() => _NephroDashboardState();
}

class _NephroDashboardState extends State<NephroDashboard>
    with SingleTickerProviderStateMixin {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  final DashboardController dashboardController =
      Get.put(DashboardController());
  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());

  late TabController tabController;
  bool hasInternet = true;
  String? apiDateString;

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
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
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

    String district = userData['district'].toString();
    String ui = userData['ui'].toString();
    String unitId = userData['unitId'].toString();

    await Future.wait(<Future>[
      dashboardController.getDashboardShort(unitId),
      dashboardController.getVersionName(),
      dashboardController.getDashCountNephro(ui, fromDate, toDate, district),
      dashboardController.getPatientRegNephro(fromDate, toDate, district),
      dashboardController.getDialysisSessionNephro(district, fromDate, toDate),
      dashboardController.getDialysisSessionCancelNephro(
          district, fromDate, toDate),
      dashboardController.getEventNephro(district, fromDate, toDate),
    ]);

    // Fetch registration data in the background without blocking dashboard load
    Future.wait(<Future>[
      newRegistrationController.getInstituteList(),
    ]);
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);

    userType = userData['user_Type'];
    userName = '${userData['f_name']} ${userData['l_name']}';

    setState(() {});
  }

  Future<void> _initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  // Update connection status handler
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final isConnected = results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi,
    );

    setState(() {
      _isNetworkAvailable = isConnected;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.primaryBackgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30), // adjust as needed
                ),
              ),
              title: CustomText(
                text: 'Dashboard',
                fontSize: 18.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.white,
                textAlign: TextAlign.start,
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Image.asset(
                      'assets/drawer-icon.png',
                      color: Colors.white,
                    ),
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

                    String district = userData['district'].toString();
                    String ui = userData['ui'].toString();

                    await Future.wait([
                      dashboardController.getDashCountNephro(
                          ui, fromDate, toDate, district),
                      dashboardController.getPatientRegNephro(
                          fromDate, toDate, district),
                      dashboardController.getDialysisSessionNephro(
                          district, fromDate, toDate),
                      dashboardController.getDialysisSessionCancelNephro(
                          district, fromDate, toDate),
                      dashboardController.getEventNephro(
                          district, fromDate, toDate),
                    ]);

                    dashboardController.isCustomCalender = false;
                    dashboardController.update();
                  },
                  child: CustomText(
                      text: "Today",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      textColor: Colors.white,
                      textAlign: TextAlign.start),
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
                    padding: EdgeInsets.only(right: 8.w),
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
                  bool? isDPR =
                      controller.deptList?.departments.contains("DPR");
                  // bool? isDAR = controller.deptList?.departments.contains("DAR");
                  bool? isDCS =
                      controller.deptList?.departments.contains("DCS");
                  bool? isDDC =
                      controller.deptList?.departments.contains("DDC");
                  // bool? isDLT = controller.deptList?.departments.contains("DLT");
                  bool? isDAE =
                      controller.deptList?.departments.contains("DAE");
                  // bool? isDMC = controller.deptList?.departments.contains("DMC");
                  // bool? isDFC = controller.deptList?.departments.contains("DFC");
                  // bool? isDCC = controller.deptList?.departments.contains("DCC");
                  // bool? isDTS = controller.deptList?.departments.contains("DTS");
                  bool? isDVL =
                      controller.deptList?.departments.contains("DVL");

                  return SingleChildScrollView(
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
                                border:
                                    Border.all(color: AppColor.borderColor)),
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

                                      await dashboardController
                                          .getDashCountNephro(
                                              userData['ui'].toString(),
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['district'].toString());
                                      await dashboardController
                                          .getPatientRegNephro(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate,
                                              userData['district'].toString());

                                      await dashboardController
                                          .getDialysisSessionNephro(
                                        userData['district'].toString(),
                                        dashboardController
                                            .fDateController.text,
                                        selectedToDate,
                                      );

                                      await dashboardController
                                          .getDialysisSessionCancelNephro(
                                        userData['district'].toString(),
                                        dashboardController
                                            .fDateController.text,
                                        selectedToDate,
                                      );

                                      await dashboardController.getEventNephro(
                                        userData['district'].toString(),
                                        dashboardController
                                            .fDateController.text,
                                        selectedToDate,
                                      );
                                    },
                                    child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.h),
                                        alignment: Alignment.center,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor.primaryBackgroundColor,
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
                                                fontWeight: FontWeight.normal,
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
                          ).paddingSymmetric(vertical: 10.h, horizontal: 10.w),
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: isDPR == true,
                              child: Expanded(
                                child: DashCard(
                                  title: 'Patient Registration',
                                  firstCountText: "Till Date",
                                  firstCount: controller
                                      .nephroCounts?.patientAdded
                                      .toString(),
                                  secondCount: controller
                                      .nephroCounts?.currentDatePatient
                                      .toString(),
                                  secondCountText: "Current Date",
                                  // secondCountText: "Current Date Patient Registration",
                                  iconPath: 'assets/total_patient.png',
                                  isSecondCount: true,
                                  isInfoVisible: false,
                                  onInfoClick: () {
                                    Get.to(DashInfoTableNephro(
                                      patients: dashboardController
                                              .dashInfoDataNephro ??
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
                                        await controller.getPatientByID(
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
                                        Get.to(TotalDialysisPatientId(
                                          patients:
                                              controller.totalPatientByUnit ??
                                                  [],
                                          pageTitle: 'Total Patient',
                                          pageTitleSecond:
                                              "Total Dialysis Patient",
                                        ));
                                      },
                                    ));
                                  },
                                  cardHeight: 80.h,
                                ),
                              ),
                            ),
                            const VerticalDottedDivider(
                              height: 190,
                              color: Colors.black26,
                              dashHeight: 4,
                              dashWidth: 1,
                            ),
                            Visibility(
                              visible: isDCS == true,
                              child: Expanded(
                                child: DashCard(
                                  title: 'Dialysis Sessions',
                                  firstCount: controller
                                      .nephroCounts?.totalDialysisSession
                                      .toString(),
                                  firstCountText: "Till Date",
                                  secondCount: controller
                                      .nephroCounts?.currentDateDialysisSession
                                      .toString(),
                                  secondCountText: "Current Day",
                                  // secondCountText: "Current Day Dialysis Sessions",
                                  iconPath: 'assets/dialysis_session.png',
                                  isSecondCount: true,
                                  isInfoVisible: false,
                                  onInfoClick: () {
                                    Get.to(DashInfoTableTotal(
                                      isShowButton: true,
                                      dataList: dashboardController
                                              .dialysisSessionNephro ??
                                          [],
                                      pageTitle: 'Dialysis Sessions',
                                      pageTitleSecond: "Total Dialysis",
                                      // pageTitleSecond: "Total Dialysis Sessions",
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

                                        await controller.getDiaSessSuperNephro(
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

                                        Get.to(TotalDialysisPatientId(
                                          patients: controller
                                                  .dialysisPatientIDNephro ??
                                              [],
                                          pageTitle: 'Dialysis Sessions',
                                        ));
                                      },
                                    ));
                                  },
                                  cardHeight: 80.h,
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
                            Expanded(
                              child: Visibility(
                                visible: isDDC == true,
                                child: DashCard(
                                  title: 'Dialysis Cancelled',
                                  firstCount: controller
                                      .nephroCounts?.totalDialysisCnacel
                                      .toString(),
                                  firstCountText: "Till Date",
                                  secondCount: controller
                                      .nephroCounts?.currentdialCancel
                                      .toString(),
                                  secondCountText: "Current Day",
                                  // secondCountText: "Current Day Dialysis Cancelled",
                                  iconPath: 'assets/dialysis_cancelled.png',
                                  isSecondCount: true,
                                  isInfoVisible: false,
                                  onInfoClick: () {
                                    Get.to(DashInfoTableTotal(
                                      isShowButton: true,
                                      dataList: dashboardController
                                              .dialysisSessionCancelNephro ??
                                          [],
                                      pageTitle: 'Total Dialysis Cancelled',
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

                                        await controller.getDiaSessCancelNephro(
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

                                        Get.to(TotalDialysisPatientId(
                                          patients:
                                              controller.dialysisCancelNephro ??
                                                  [],
                                          pageTitle: 'Total Dialysis Cancelled',
                                        ));
                                      },
                                    ));
                                  },
                                  cardHeight: 80.h,
                                ),
                              ),
                            ),
                            const VerticalDottedDivider(
                              height: 190,
                              color: Colors.black26,
                              dashHeight: 4,
                              dashWidth: 1,
                            ),
                            Expanded(
                              child: Visibility(
                                visible: isDVL == true,
                                child: DashCard(
                                  title: 'Patient Verification',
                                  firstCount: "0",
                                  firstCountText: "Till Date",
                                  secondCount: "0",
                                  secondCountText: "Total Pending",
                                  //secondCountText: "Total Pending Verification",
                                  iconPath: 'assets/dialysis_cancelled.png',
                                  isSecondCount: true,
                                  isInfoVisible: false,
                                  cardHeight: 80.h,
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
                            Expanded(
                              child: Visibility(
                                visible: isDAE == true,
                                child: DashCard(
                                  title: 'Event Occurred',
                                  firstCount: controller
                                      .nephroCounts?.totalEvent
                                      .toString(),
                                  firstCountText: "Till Date",
                                  secondCount: controller
                                      .nephroCounts?.currentDateEvent
                                      .toString(),
                                  secondCountText: "Current Day",
                                  iconPath: 'assets/event.png',
                                  isSecondCount: true,
                                  isInfoVisible: false,
                                  onInfoClick: () {
                                    Get.to(DashInfoTableAdmin(
                                      patients:
                                          dashboardController.nephroEvent ?? [],
                                      isEvent: true,
                                      pageTitle: 'Total Event Occured',
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
                                        await controller.getEventNephroId(
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

                                        Get.to(DashInfoTableEvent(
                                          patients:
                                              controller.nephroEventId ?? [],
                                          pageTitle: 'Total Event Occured',
                                        ));
                                      },
                                    ));
                                  },
                                  cardHeight: 80.h,
                                ),
                              ),
                            ),
                            const VerticalDottedDivider(
                              height: 190,
                              color: Colors.black26,
                              dashHeight: 4,
                              dashWidth: 1,
                            ),
                            Expanded(child: Text(''))
                          ],
                        ),

                        // HorizontalDottedDivider(
                        //   width: double.infinity,
                        //   dashHeight: 4,
                        //   dashWidth: 1,
                        //   color: Colors.black26,
                        // ),
                      ],
                    ).paddingOnly(left: 4, right: 4),
                  );
                }),
          )
        : InternetIssue(
            onRetryPressed: () async {
              final result = await _connectivity.checkConnectivity();
              _updateConnectionStatus(result);
            },
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
