import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/billing/invoice_approval/invoice_approval.dart';
import 'package:heamodialysis/billing/invoice_generation/invoice_generation.dart';
import 'package:heamodialysis/dashboard/cluster_dashboard/cluster_district_wise_dash.dart';
import 'package:heamodialysis/dashboard/cluster_dashboard/cluster_division_dash.dart';
import 'package:heamodialysis/dashboard/dashboard_controller.dart';
import 'package:heamodialysis/dashboard/mis/mis_dash.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/nephro_dashboard.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/scrutiny_first_level_list.dart';
import 'package:heamodialysis/dashboard/nephro_second_level/scrutiny_second_level_list.dart';
import 'package:heamodialysis/dashboard/super_admin/super_admin_dash_screen.dart';
import 'package:heamodialysis/dashboard/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/dialysis_queue/consumable_entry/consumable.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/dialysis_event_list.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_queue_screen.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/hd_chart_list.dart';
import 'package:heamodialysis/dialysis_queue/investigation/investigation_queue.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/post_dialysis_screen.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/pre_dialysis_list/pre_dialysis_screen.dart';
import 'package:heamodialysis/discharge_form/session_end_list.dart';
import 'package:heamodialysis/login/login_controller.dart';
import 'package:heamodialysis/login/login_screen.dart';
import 'package:heamodialysis/machine_status/machine_counter_list.dart';
import 'package:heamodialysis/nephro_desk_patient_list/nephro_desk_patient_list.dart';
import 'package:heamodialysis/new_registration/screens/new_registration.dart';
import 'package:heamodialysis/patient_health_trends/dialysis_investigation_report/patient_dialysis_invest_screen.dart';
import 'package:heamodialysis/patient_health_trends/dialysis_vital_chart/patient_dialysis_vital_screen.dart';
import 'package:heamodialysis/patient_health_trends/patient_health_trends_screen.dart';
import 'package:heamodialysis/patient_health_trends/patient_hemoglobin_tracking/patient_hemoglobin_list_screen.dart';
import 'package:heamodialysis/registered_patient_list/screens/registered_patient_list.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/screens/daily_ro_logsheet_list.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screens/ro_disinfection_details.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/screens/ro_log_sheet_list.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/screens/ro_machine_issue_log.dart';
import 'package:heamodialysis/schedular/screens/schedular_list.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../registration/registration_screen.dart';
import '../ro_maintenance/ro_maintenance_screen.dart';

class DrawerScreen extends StatefulWidget {
  final String? userType;
  final String? userName;
  final dynamic userData;
  final PackageInfo? packageInfo;

  const DrawerScreen(
      {super.key,
      this.userType,
      this.userName,
      this.userData,
      this.packageInfo});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    getDashList(widget.userType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController =
        Get.find<DashboardController>();

    final LoginController loginController = Get.put(LoginController());

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF27A9E3),
            Color(0xFF07B259),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            // decoration: BoxDecoration(
            //   borderRadius: const BorderRadius.only(
            //     bottomLeft: Radius.circular(24),
            //     bottomRight: Radius.circular(24),
            //   ),
            //   gradient: const LinearGradient(
            //     colors: [
            //       Color(0xFF27A9E3),
            //       Color(0xFF07B259),
            //     ],
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //   ),
            //
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                const Icon(Icons.account_circle, size: 80, color: Colors.white),
                SizedBox(height: 10.h),
                CustomText(
                  text: widget.userName ?? "",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontFam: 'Nunito Sans',
                ),
                SizedBox(height: 5.h),
                CustomText(
                  text: "(${widget.userType})",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontFam: 'Nunito Sans',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          // Main content with condition-based views
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // dashList != null
                //     ? CustomExpansionTile(
                //         title: 'Dashboard',
                //         iconPath: 'assets/dashboard.png',
                //         // iconPath: 'assets/all_dashboard.png',
                //         items: dashList!,
                //         onTap: (index) {
                //           if (widget.userType == "SUPER ADMIN" ||
                //               widget.userType == "ADMIN" ||
                //               widget.userType == "OPERATIONAL TEAM") {
                //             if (index == 0) {
                //               Get.back();
                //               Get.off(() => const SuperAdminDashScreen());
                //             } else if (index == 1) {
                //               Get.back();
                //               Get.off(() => const MISDashboardScreen());
                //             } else if (index == 2) {
                //               Get.back();
                //               Get.off(() => const NephroDashboard());
                //             } else if (index == 3) {
                //               Get.back();
                //               Get.off(() => const InstituteWiseDashboardScreen());
                //             } else if (index == 4) {
                //               Get.back();
                //               Get.off(() => const ClusterDistrictWiseDash());
                //             } else if (index == 5) {
                //               Get.back();
                //               Get.off(() => const ClusterDivisionWiseDash());
                //             }
                //           } else if (widget.userType == "TECHNICIAN") {
                //             Get.back();
                //             Get.off(() => const InstituteWiseDashboardScreen());
                //           } else if (widget.userType == "NEPHROLOGIST") {
                //             Get.back();
                //             Get.off(() => const NephroDashboard());
                //           } else if (widget.userType == "CLUSTER HEAD DISTRICT") {
                //             Get.back();
                //             Get.off(() => const ClusterDistrictWiseDash());
                //           } else if (widget.userType == "CLUSTER HEAD DIVISION") {
                //             Get.back();
                //             Get.off(() => const ClusterDivisionWiseDash());
                //           } else if (widget.userType == "MIS") {
                //             Get.back();
                //             Get.off(() => const MISDashboardScreen());
                //           }
                //         },
                //         showIcon: true,
                //       )
                //     : const SizedBox.shrink(),

                Visibility(
                  visible: widget.userType == "INVOICE SECOND APPROVAL",
                  // || widget.userType == "OPERATION HEAD",
                  child: CustomExpansionTile(
                    title: 'Billing',
                    iconPath: 'assets/file-list.png',
                    items: const ["Invoice Approval(2nd Level)"],
                    onTap: (index) {
                      if (index == 0) {
                        Get.to(() => const InvoiceApproval());
                      }
                    },
                    showIcon: true,
                  ),
                ),
                Visibility(
                  // visible: widget.userType == "INVOICE GENERATION",
                  visible: widget.userType == "OPERATION HEAD",
                  child: CustomExpansionTile(
                    title: 'Billing',
                    iconPath: 'assets/file-list.png',
                    items: const ["Invoice Generation"],
                    // items: const ["Invoice Generation"],
                    onTap: (index) {
                      if (index == 0) {
                        Get.to(() => const InvoiceGeneration());
                      }
                    },
                    showIcon: true,
                  ),
                ),
                Visibility(
                  visible: widget.userType == "SUPER ADMIN" ||
                      widget.userType == "nurse" ||
                      widget.userType == "Admin" ||
                      widget.userType == "ADMIN" ||
                      widget.userType == "TECHNICIAN" ||
                      widget.userType == "Technician" ||
                      widget.userType == "CLUSTER HEAD DIVISION" ||
                      widget.userType == "OPERATIONAL TEAM",
                  child: Column(
                    children: [
                      simpleDrawerItem(() {
                        Get.back(); // closes drawer first
                        Get.offAll(() => const InstituteWiseDashboardScreen());
                      }, "Dashboard", 'assets/dashboard.png', true),
                      ListTile(
                        title: const Text(
                          'Registration',
                          style: TextStyle(
                              fontSize: 16,
                              color:Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Lato"),
                        ),
                        leading: Image.asset('assets/registration.png'),
                        onTap: () {
                          Get.to(() => const RegistrationScreen());
                        },
                      ),
                      // ListTile(
                      //   title: Text('Registration'),
                      //   leading: Image.asset('assets/registration.png'),
                      //   onTap:() {
                      //    get.to(RegistrationScreen);
                      //   },
                      //   // iconPath: 'assets/registration.png',
                      //   //  items: const ["New Registration", "Registered Patients "],
                      //   //  onTap: (index) {
                      //   //    if (index == 0) {
                      //   //      Get.to(() => const NewRegistration(
                      //   //            isViewPatient: false,
                      //   //            pageTitle: 'New Registration',
                      //   //            isEdit: false,
                      //   //          ));
                      //   //    } else if (index == 1) {
                      //   //      Get.to(() => const RegisteredPatientList());
                      //   //    }
                      //   //  },
                      //   //  showIcon: true,
                      // ),
                      simpleDrawerItem(() {
                        Get.to(() => const SchedularListScreen());
                      }, "Dialysis Scheduler", 'assets/schedular.png', true),
                      simpleDrawerItem(() async {
                        Get.to(SessionEndList(
                          userData: widget.userData,
                        ));
                      }, "Session End", 'assets/schedular.png', true)
                          .paddingOnly(left: 2),
                      ListTile(
                        title:const Text(
                          'Dialysis Queue',
                          style: TextStyle(
                              fontSize: 16,color:Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Lato"),
                        ),
                        leading: Image.asset('assets/cross arow.png'),
                        onTap: () {
                          Get.to(() => const DialysisQueueScreen());
                        },
                      ),
                      // CustomExpansionTile(
                      //   title: 'Dialysis Queue',
                      //   iconPath: '',
                      //   items: const [
                      //     "Pre Dialysis",
                      //     "Post Dialysis",
                      //     "Dialysis Event",
                      //     "Investigation",
                      //     "Consumable Entry",
                      //     "Hd Chart"
                      //   ],
                      //   onTap: (index) {
                      //     if (index == 0) {
                      //       Get.to(() => const PreDialysisScreen());
                      //     } else if (index == 1) {
                      //       Get.to(() => const PostDialysisScreen());
                      //     } else if (index == 2) {
                      //       Get.to(() => const DialysisEventList());
                      //     } else if (index == 3) {
                      //       Get.to(() => const InvestigationQueue());
                      //     } else if (index == 4) {
                      //       Get.to(() => const ConsumableScreen());
                      //     } else if (index == 5) {
                      //       Get.to(() => const HdChartList());
                      //     }
                      //   },
                      //   showIcon: false,
                      // ),
                      simpleDrawerItem(() {
                        Get.to(() => const RoMaintenanceScreen());
                      }, "RO Maintenance", 'assets/ROMaintenance.png', true),
                      // CustomExpansionTile(
                      //   title: 'RO Maintenance',
                      //   iconPath: 'assets/dialysis-queue.png',
                      //   items: const [
                      //     "RO Disinfection Details",
                      //     "RO Machine Issue Logs",
                      //     "RO Machine Log Sheet",
                      //     "Daily RO Log Sheet",
                      //   ],
                      //   onTap: (index) {
                      //     if (index == 0) {
                      //       Get.to(() => const RoDisinfectionDetails());
                      //     } else if (index == 1) {
                      //       Get.to(() => const RoMachineIssueLogs());
                      //     } else if (index == 2) {
                      //       Get.to(() => const RoLogSheetList());
                      //     } else if (index == 3) {
                      //       Get.to(() => const DailyRoLogSheetScreen());
                      //     }
                      //   },
                      //   showIcon: false,
                      // ),
                      simpleDrawerItem(() {
                        Get.to(() => const MachineCounterList());
                      }, "Machine Status", 'assets/MachineStatus.png', true),
                      // CustomExpansionTile(
                      //   title: 'Machine Status',
                      //   iconPath: 'assets/MachineStatus.png',
                      //   items: const [
                      //     "Dialysis Machine Counter",
                      //   ],
                      //   onTap: (index) {
                      //     if (index == 0) {
                      //       Get.to(() => const MachineCounterList());
                      //     } else if (index == 1) {
                      //       // Get.to(() => const RoMachineIssueLogs());
                      //     } else if (index == 2) {
                      //       // Get.to(() => const RoLogSheetList());
                      //     }
                      //   },
                      //   showIcon: false,
                      // ),
                      simpleDrawerItem(() {
                        Get.to(() => const PatientHealthTrendsScreen());
                      }, "Patient Health Trends", 'assets/PatientHealthTrends.png', true),
                      // CustomExpansionTile(
                      //   title: 'Patient Health Trends',
                      //   iconPath: 'assets/machine.png',
                      //   items: const [
                      //     "Patient Dialysis Vital Chart",
                      //     "Patient Dialysis Investigation Result Chart",
                      //     "Haemoglobin Tracking Report",
                      //   ],
                      //   onTap: (index) {
                      //     if (index == 0) {
                      //       Get.to(() => const PatientDialysisVitalScreen());
                      //     } else if (index == 1) {
                      //       Get.to(() => const PatientDialysisInvestScreen());
                      //     } else if (index == 2) {
                      //       Get.to(() => const PatientHemoglobinScreen());
                      //     }
                      //   },
                      //   showIcon: false,
                      // ),

                      ///comment for now
                      // simpleDrawerItem(() async {
                      //   Get.to(CctvFilter(
                      //     userData: widget.userData,
                      //   ));
                      // }, "CCTV Camera", 'assets/device-cctv.png', false)
                      //     .paddingOnly(left: 2),
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.userType == "NEPHROLOGIST",
                  child: Column(
                    children: [
                      simpleDrawerItem(() {
                        Get.to(() => const NephroDeskPatientList(
                              appBarTitle: 'Nephrologist Desk',
                            )
                        );
                      }, "Nephrologist Desk", 'assets/schedular.png', true),
                      // CustomExpansionTile(
                      //   title: 'Application Approval',
                      //   iconPath: 'assets/registration.png',
                      //   items: const ["Application Scrutiny"],
                      //   onTap: (index) {
                      //     if (index == 0) {
                      //       Get.to(() => ScrutinySecondLevel(
                      //             userType: widget.userType,
                      //           ));
                      //     }
                      //   },
                      //   showIcon: true,
                      // ),
                      simpleDrawerItem(() {
                        Get.to(() => ScrutinySecondLevel(
                          userType: widget.userType,
                        ));
                      }, "Application Scrutiny", 'assets/registration.png', true),
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.userType == "DOCTOR",
                  child: Column(
                    children: [
                      simpleDrawerItem(
                              () {
                        Get.to(() => const NephroDeskPatientList(
                              appBarTitle: 'Doctor Desk',
                            ));
                      }, "Doctor Desk", 'assets/schedular.png', true),
                      // CustomExpansionTile(
                      //   title: 'Application Approval',
                      //   iconPath: 'assets/registration.png',
                      //   items: const ["Application Scrutiny"],
                      //   onTap: (index) {
                      //     if (index == 0) {
                      //       Get.to(() => ScrutinyFirstLevel(
                      //             userType: widget.userType,
                      //           ));
                      //     }
                      //   },
                      //   showIcon: true,
                      // ),
                      simpleDrawerItem(() {
                        Get.to(() => ScrutinyFirstLevel(
                          userType: widget.userType,
                        ));
                      }, "Application Scrutiny", 'assets/registration.png', true),

                    ],
                  ),
                ),
                simpleDrawerItem(() async {
                  if (dashboardController.isCustomCalender) {
                    dashboardController.isCustomCalender = false;
                    dashboardController.fDateController.text = "";
                    dashboardController.tDateController.text = '';
                    dashboardController.update();
                  }

                  loginController.userName.value.text = '';
                  loginController.password.value.text = '';
                  loginController.captcha.value.text = '';
                  loginController.unitNameList = null;
                  loginController.update();
                  await SharedPref().clearSaveData();
                  Get.back();
                  Get.to(const LoginScreen());
                }, "Logout", 'assets/logout.png', true)
                    .paddingOnly(left: 2.w)
              ],
            ),
          ),
          SafeArea(
            bottom: true,
            top: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomText(
                text: widget.packageInfo?.version != null
                    ? "Version : ${widget.packageInfo!.version}"
                    : '',
                fontSize: 16.sp,
                fontFam: 'Nunito Sans',
                fontWeight: FontWeight.normal,
                textColor: Colors.white,
                textAlign: TextAlign.center,
              ),
            ).paddingOnly(bottom: 16.h),
          ),
        ],
      ),
    );
  }

  List<String>? dashList;

  getDashList(userType) {
    if (userType == 'SUPER ADMIN' ||
        userType == 'nurse' ||
        userType == 'Admin' ||
        userType == 'ADMIN') {
      dashList = [
        "Dashboard",
        // "MIS Dashboard",
        // "NEPHROLOGIST Dashboard",
        // "InstituteWise Dashboard",
        // "Cluster Dashboard District Wise",
        // "Cluster Dashboard Division Wise"
      ];
    } else if (userType == 'TECHNICIAN') {
      dashList = ["Dashboard"];
    } else if (userType == 'NEPHROLOGIST') {
      dashList = ["NEPHROLOGIST Dashboard"];
    } else if (userType == 'CLUSTER HEAD DISTRICT') {
      dashList = ["Dashboard"];
    } else if (userType == 'CLUSTER HEAD DIVISION') {
      dashList = ["Dashboard"];
    } else if (userType == 'MIS') {
      dashList = ["MIS Dashboard"];
    }
  }
}

Widget simpleDrawerItem(
    Function callB, String text, String path, bool isShowIcon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    child: InkWell(
      onTap: () => callB(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isShowIcon)
            Image.asset(path, color: Colors.white, width: 24, height: 24),
          if (isShowIcon) const SizedBox(width: 16),
          // Even spacing
          Expanded(
            child: CustomText(
              text: text,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              textColor: Colors.white,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          // Optional indicator
        ],
      ),
    ),
  );
}

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final String iconPath;
  final List<String> items;
  final Function(int) onTap;
  final bool showIcon;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.iconPath,
    required this.items,
    required this.onTap,
    this.showIcon = true,
  });

  @override
  CustomExpansionTileState createState() => CustomExpansionTileState();
}

class CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() {
              isExpanded = !isExpanded;
            }),
            child: Row(
              children: [
                if (widget.showIcon)
                  Image.asset(
                    widget.iconPath,
                    width: 24,
                    height: 24,
                   // color: Colors.white,
                  ),
                if (widget.showIcon) const SizedBox(width: 16),
                Expanded(
                  child: CustomText(
                    text: widget.title,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white,
                    textAlign: TextAlign.start,
                  ).paddingOnly(left: 4),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.items.map((item) {
                  int index = widget.items.indexOf(item);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: InkWell(
                      onTap: () => widget.onTap(index),
                      child: CustomText(
                        text: item,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textColor: Colors.white,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class NavList {}
