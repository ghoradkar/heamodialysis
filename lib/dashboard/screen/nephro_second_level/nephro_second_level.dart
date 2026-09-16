import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/controller/dashboard_controller.dart';
import 'package:heamodialysis/dashboard/screen/nephro_second_level/nephro_slider.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/dashboard/widget/drawer_screen.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/bar_chart.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/dash_card.dart';
import 'package:heamodialysis/widgets/radila_chart.dart';
import 'package:intl/intl.dart';


class NephroSecondLevel extends StatefulWidget {
  const NephroSecondLevel({super.key});

  @override
  State<NephroSecondLevel> createState() => _NephroSecondLevelState();
}

class _NephroSecondLevelState extends State<NephroSecondLevel>
    with SingleTickerProviderStateMixin {
  final DashboardController dashboardController =
  Get.put(DashboardController());

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
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    dashboardController.update();
    if (hasInternet) {
      DateTime now = DateTime.now();
      String fromDate = DateFormat('yyyy/MM/dd').format(now);
      await dashboardController.getDashCount(fromDate,fromDate,userData['mulSelunit'].toString());

      await dashboardController.getDash(userData['unitId'].toString(), fromDate, fromDate);
      await dashboardController.getChartData(fromDate, fromDate,ApiConstants.baseUrl4);
      await dashboardController.getViralStatueList();
      await dashboardController.getChartDataAbha(fromDate, fromDate, userData['unitId'].toString());
      dashboardController.getVersionName();

      // await dashboardController.getRadialChartData();
      await dashboardController.getRadialChart(userData['unitId'], fromDate, fromDate);
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);

    userType = userData['user_Type'];
    userName = '${userData['f_name']} ${userData['l_name']}';

    setState(() {

    });
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
        title:  CustomText(
          text: context.l10n.drawerDashboard,
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
            onTap: () {},
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
            onTap: () {},
            child: Padding(
              padding:  EdgeInsets.only(right: 8.w),
              child: Image.asset("assets/gradient_calender.png"),
            ),
          ),
        ],
      ),
      drawer:  Drawer(
        child: DrawerScreen(userType: userType,userName: userName,
          userData: userData,
          packageInfo: dashboardController.packageInfo,

        ),
      ),
      body: GetBuilder<DashboardController>(
          init: DashboardController(),
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                ?  const NephroSecondLevelShimmer()
                : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [

                      Expanded(
                          child: DashCard(
                            title: context.l10n.dashTotalPatientRegistration,
                            firstCountText: context.l10n.dashTillDate,
                            firstCount: controller
                                .dashboardCountModel?.patientAdded
                                .toString(),
                            secondCount: controller
                                .dashboardCountModel?.currentDatePatient
                                .toString(),
                            secondCountText:
                            "Current Date",
                            iconPath: 'assets/total_patient.png',
                            isSecondCount: true, cardHeight: 80.h,
                          )
                      ),

                      Expanded(
                          child: DashCard(
                            title: context.l10n.dashTotalAbhaRegistration,
                            firstCount: controller
                                .dashboardCountModel?.abhaRegistration
                                .toString(),
                            firstCountText: context.l10n.dashTillDate,
                            secondCount: controller
                                .dashboardCountModel?.currentDateAbhaReg
                                .toString(),
                            secondCountText:
                            "Current Date",
                            iconPath: 'assets/abha_registration.png',
                            isSecondCount: true, cardHeight: 80.h,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Expanded(
                            child: DashCard(
                              title: context.l10n.dashTotalDialysisSessions,
                              firstCount: controller
                                  .dashboardCountModel?.totalDialysisSession
                                  .toString(),
                              firstCountText: context.l10n.dashTillDate,
                              secondCount: controller.dashboardCountModel
                                  ?.currentDateDialysisSession
                                  .toString(),
                              secondCountText:
                              "Current Date",
                              iconPath: 'assets/dialysis_session.png',
                              isSecondCount: true, cardHeight: 80.h,
                            )),
                      ),
                      Expanded(
                          child: DashCard(
                            title: context.l10n.dashTotalDialysisCancelled,
                            firstCount: controller
                                .dashboardCountModel?.totalDialysisCnacel
                                .toString(),
                            firstCountText: context.l10n.dashTillDate,
                            secondCount: controller
                                .dashboardCountModel?.currentdialCancel
                                .toString(),
                            secondCountText:
                            "Current Date",
                            iconPath: 'assets/dialysis_cancelled.png',
                            isSecondCount: true, cardHeight: 80.h,
                          ))

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: DashCard(
                            title: context.l10n.dashTotalEventOccurred,
                            firstCount: controller
                                .dashboardCountModel?.totalEvent
                                .toString(),
                            firstCountText: context.l10n.dashTillDate,
                            secondCount: controller
                                .dashboardCountModel?.currentDateEvent
                                .toString(),
                            secondCountText: context.l10n.dashCurrentDay,
                            iconPath: 'assets/event.png',
                            isSecondCount: true, cardHeight: 80.h,
                          )),

                      Expanded(
                          child: DashCard(
                            title: context.l10n.dashTotalActiveMachines,
                            firstCount: controller
                                .dashboardCountModel?.ticket
                                .toString(),
                            firstCountText: context.l10n.dashTillDate,
                            secondCount: controller
                                .dashboardCountModel?.ticket
                                .toString(),
                            secondCountText: context.l10n.dashCurrentDate,
                            iconPath: 'assets/machine.png',
                            isSecondCount: true, cardHeight: 80.h,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DashCard(
                          title: context.l10n.dashTotalLabTestAssigned,
                          firstCount: controller
                              .dashboardCountModel?.totalLbTest
                              .toString(),
                          firstCountText: context.l10n.dashTillDate,
                          secondCount: controller
                              .dashboardCountModel?.currentDateLabTest
                              .toString(),
                          secondCountText:
                          "Current Date",
                          pendingCount: controller
                              .dashboardCountModel?.totalLbTest
                              .toString(),
                          complateCount: "0",
                          isVisiableRow: true,
                          iconPath: 'assets/leboretory.png',
                          isSecondCount: true, cardHeight: 80.h,
                        ),
                      ),
                      Expanded(
                        child: DashCard(
                          title: context.l10n.dashTotalFeedback,
                          firstCount: controller
                              .dashboardCountModel?.feedback
                              .toString(),
                          firstCountText: context.l10n.dashTillDate,
                          secondCount: controller
                              .dashboardCountModel?.currentDateFeedback
                              .toString(),
                          secondCountText: context.l10n.dashCurrentDate,
                          iconPath: 'assets/feedback.png',
                          isSecondCount: true, cardHeight: 80.h,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DashCard(
                          title: context.l10n.dashTotalOnlineComplaints,
                          firstCount: controller
                              .dashboardCountModel?.totalLbTest
                              .toString(),
                          firstCountText: context.l10n.dashTillDate,
                          secondCount: controller
                              .dashboardCountModel?.currentDateLabTest
                              .toString(),
                          secondCountText:
                          "Current Day",
                          pendingCount: controller
                              .dashboardCountModel?.totalLbTest
                              .toString(),
                          complateCount: "0",
                          isVisiableRow: true,
                          iconPath: 'assets/complaints.png',
                          isSecondCount: true, cardHeight: 80.h,
                        ),
                      ),
                      Expanded(
                        child: DashCard(
                          title: context.l10n.dashTotalOnlineTickets,
                          firstCount: controller
                              .dashboardCountModel?.ticket
                              .toString(),
                          firstCountText: context.l10n.dashTillDate,
                          secondCount: controller
                              .dashboardCountModel?.ticket
                              .toString(),
                          secondCountText:
                          "Current Day",
                          pendingCount:  controller
                              .dashboardCountModel?.pendingTickets
                              .toString(),
                          complateCount: "0",
                          isVisiableRow: true,
                          iconPath: 'assets/ticket.png',
                          isSecondCount: true, cardHeight: 80.h,
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding:  EdgeInsets.only(
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
                        buildTab(0, context.l10n.dashSchemePerformance),
                        buildTab(1, context.l10n.colViralLoadStatus)
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(
                        top: 0, left: 8.w, bottom: 8.h, right: 8.w),
                    child: Container(
                      height: 340.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.4),
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
                          // RadialBarChartSample(chartData: controller.createList())
                          CustomRadialChart(
                              chartData: controller.createList())
                        ],
                      ),
                    ),
                  ),

                   Padding(
                    padding: EdgeInsets.only(
                        top: 8.h, left: 8.w, bottom: 0, right: 8.w),
                    child: CustomText(
                        text: context.l10n.nephroOngoingDialysisSession,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                  ),
                    Padding(
                    padding: EdgeInsets.only(
                        top: 8.h, left: 8.w, bottom: 8.h, right: 8.w),
                    child: const ImageCarouselWithIndicator(list: [],),
                  )
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
      padding:  EdgeInsets.symmetric(horizontal: 0.8.w, vertical: 6.h),
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
}
