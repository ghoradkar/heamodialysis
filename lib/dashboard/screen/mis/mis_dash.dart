import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/controller/dashboard_controller.dart';
import 'package:heamodialysis/dashboard/widget/drawer_screen.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';


class MISDashboardScreen extends StatefulWidget {
  const MISDashboardScreen({super.key});

  @override
  State<MISDashboardScreen> createState() => _MISDashboardScreenState();
}

class _MISDashboardScreenState extends State<MISDashboardScreen>
    with SingleTickerProviderStateMixin {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());

  // late TabController tabController;
  bool hasInternet = true;

  var userData;

  String? userType;
  String? userName;

  @override
  void initState() {
    getUserData();

    checkInternetAndLoadData();
    super.initState();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    dashboardController.update();
    if (hasInternet) {
      // await dashboardController.getDashCount();
      dashboardController.labtestDetails?.clear();
      DateTime now = DateTime.now();
      // String fromDate = DateFormat('yyyy-MM-dd').format(now);

      DateTime tomorrow = now.add(const Duration(days: 1));
      String toDate = DateFormat('yyyy-MM-dd').format(tomorrow);

      await dashboardController.getDashMis("2022-01-01", toDate);
      await dashboardController.getVersionName();

      ///Called patient registration api on dashbard to load page fast
      // await newRegistrationController.getStateList();
      // await newRegistrationController.getDivisionList();
      // await newRegistrationController.getDistrictList();
      // await newRegistrationController.getTalukaList();
      // await newRegistrationController.getTownList();
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);

    userType = userData['user_Type'];
    userName = '${userData['f_name']} ${userData['l_name']}';
    debugPrint(userData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:  CustomText(
            text: context.l10n.dashMisDashboard,
            fontSize: 18.sp,
            fontFam: 'Lato',
            fontWeight: FontWeight.w400,
            textColor: Colors.black,
            textAlign: TextAlign.start,
          ),
          actions: [
            InkWell(
              onTap: () async {
                DateTime now = DateTime.now();
                String fromDate = DateFormat('yyyy-MM-dd').format(now);

                DateTime tomorrow = now.add(const Duration(days: 1));
                String toDate = DateFormat('yyyy-MM-dd').format(tomorrow);
                dashboardController.labtestDetails?.clear();

                await dashboardController.getDashMis(fromDate, toDate);

                dashboardController.fDateController.text = '';
                dashboardController.tDateController.text = '';
                dashboardController.isCustomCalender = false;
                dashboardController.isTodaysDate = true;
                dashboardController.update();
              },
              child:  CustomText(
                  text: context.l10n.dashToday,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black,
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
                padding:  EdgeInsets.only(right: 8.w),
                child: Image.asset("assets/gradient_calender.png"),
              ),
            ),
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset('assets/drawer-icon.png'),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          )),
      drawer: Drawer(
        child: DrawerScreen(
          userType: userType,
          userName: userName,
          userData: userData,
          packageInfo: dashboardController.packageInfo,
        ),
      ),
      body: GetBuilder<DashboardController>(
          init: dashboardController,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ?  const MISDashboardShimmer()
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Visibility(
                              visible: dashboardController.isCustomCalender,
                              child: Container(
                                padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
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
                                                DateFormat('yyyy-MM-dd').parse(
                                                    controller
                                                        .tDateController.text);
                                            // Add one day to the selected date
                                            DateTime nextDate = selectedDate
                                                .add(const Duration(days: 1));
                                            // Format the new date back to 'yyyy/MM/dd' and update the controller
                                            selectedToDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(nextDate);
                                          }

                                          await dashboardController.getDashMis(
                                              dashboardController
                                                  .fDateController.text,
                                              selectedToDate);

                                          await dashboardController
                                              .getLaboratoryAss(
                                                  userData['unitId'].toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);

                                          await dashboardController
                                              .getAbhaPatientTechnician(
                                                  userData['unitId'].toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);

                                          await dashboardController
                                              .getRadialChart(
                                                  userData['unitId'].toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);
                                          await dashboardController
                                              .getPatientRegTechnician(
                                                  userData['unitId'].toString(),
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
                                                  userData['unitId'].toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);

                                          await dashboardController
                                              .getDialysisSessionCancelled(
                                                  userData['unitId'].toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);

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
                                                  userData['unitId'].toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);

                                          await dashboardController
                                              .getTicketTechnician(
                                                  userData['unitId'].toString(),
                                                  dashboardController
                                                      .fDateController.text,
                                                  selectedToDate);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h, horizontal: 20.w),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.search,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 6.w),
                                                  CustomText(
                                                      text: context.l10n.commonSearch,
                                                      fontSize: 16.sp,
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
                                     SizedBox(
                                      height: 4.h,
                                    ),
                                  ],
                                ),
                              ).paddingSymmetric(vertical: 10.h, horizontal: 10.w),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: MISDashCard(
                                  firstCountText: context.l10n.misFunctionalInstitute,
                                  firstCount: controller
                                      .misCount?.functionalUnit
                                      .toString(),
                                  iconPath: 'assets/professional-services.png',
                                  isSecondCount: true,
                                  onInfoClick: () {
                                    // Get.to(DashInfoTable(
                                    //   patients:
                                    //       dashboardController.dashInfoData ??
                                    //           [],
                                    //   pageTitle: 'Patient Added List',
                                    // ));
                                  },
                                  cardHeight: 160.h,
                                )),
                                Expanded(
                                    child: MISDashCard(
                                  firstCount: controller.misCount?.totalPatient
                                      .toString(),
                                  firstCountText: context.l10n.misNumberOfPatients,
                                  iconPath: 'assets/total_patient.png',
                                  isSecondCount: true,
                                  onInfoClick: () {
                                    // Get.to(DashInfoTable(
                                    //   patients: dashboardController
                                    //           .dashInfoDataAdmin ??
                                    //       [],
                                    //   pageTitle: 'Patient Added List',
                                    // ));
                                    //
                                  },
                                  cardHeight: 160.h,
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: MISDashCard(
                                  firstCount: controller.misCount?.mjpjayCount
                                      .toString(),
                                  firstCountText: context.l10n.misDialysisUnderMjpjay,
                                  iconPath: 'assets/dialysis_session.png',
                                  isSecondCount: true,
                                  onInfoClick: () {

                                  },
                                  cardHeight: 160.h,
                                )),
                                Expanded(
                                    child: MISDashCard(
                                  firstCount: controller
                                      .misCount?.nonmjpjayCount
                                      .toString(),
                                  firstCountText: context.l10n.misDialysisUnderNonMjpjay,
                                  iconPath: 'assets/dialysis_cancelled.png',
                                  isSecondCount: true,
                                  onInfoClick: () {

                                  },
                                  cardHeight: 160.h,
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: MISDashCard(
                                  firstCount: controller
                                      .misCount?.positivePatient
                                      .toString(),
                                  firstCountText: context.l10n.misSeroPositive,
                                  iconPath: 'assets/event.png',
                                  isSecondCount: true,
                                  onInfoClick: () {

                                  },
                                  cardHeight: 160.h,
                                )),
                                Expanded(
                                    child: MISDashCard(
                                  firstCount: controller
                                      .misCount?.negativePatient
                                      .toString(),
                                  firstCountText: context.l10n.misSeroNegative,
                                  iconPath: 'assets/machine.png',
                                  isSecondCount: true,
                                  onInfoClick: () {

                                  },
                                  cardHeight: 160.h,
                                )),
                              ],
                            ),
                            MISDashCard(
                              firstCount:
                                  controller.misCount?.testSendToLab.toString(),
                              firstCountText: context.l10n.misLabTestsSentToMahaLabs,
                              iconPath: 'assets/leboretory.png',
                              isSecondCount: true,
                              cardHeight: 160.h,
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
      DateFormat formatter = DateFormat('yyyy-MM-dd');
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
      DateFormat formatter = DateFormat('yyyy-MM-dd');
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

class MISDashCard extends StatelessWidget {
  final String? firstCount;
  final String? firstCountText;
  final String iconPath;
  final bool isSecondCount;
  final Function? onInfoClick;
  final double cardHeight;

  const MISDashCard(
      {super.key,
      this.firstCount,
      this.firstCountText,
      required this.iconPath,
      required this.isSecondCount,
      this.onInfoClick,
      required this.cardHeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
      child: Container(
        // width: 180,
        height: cardHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.4), // Shadow color
                spreadRadius: 1, // How much the shadow should spread
                blurRadius: 4, // How soft the shadow should appear
                offset: const Offset(1, 1), // The position of the shadow (x, y)
              ),
            ],
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.centerRight, child: Image.asset(iconPath)),
            CustomText(
                text: firstCount ?? "",
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                textColor: Colors.black,
                textAlign: TextAlign.start),
            CustomText(
                text: firstCountText ?? "",
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                textColor: Colors.black,
                textAlign: TextAlign.start),
          ],
        ).paddingSymmetric(vertical: 8.h,horizontal: 8.w),
      ),
    );
  }
}
