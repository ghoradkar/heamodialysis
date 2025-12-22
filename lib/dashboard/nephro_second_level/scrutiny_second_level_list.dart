import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/first_level_controller.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/model/first_level_scrutiny_approval_list.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/nephro_dashboard.dart';
import 'package:heamodialysis/dashboard/nephro_second_level/application_details_second_level.dart';
import 'package:heamodialysis/dashboard/nephro_second_level/nephro_second_level.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class ScrutinySecondLevel extends StatefulWidget {
  final dynamic userType;

  const ScrutinySecondLevel({super.key, this.userType});

  @override
  State<ScrutinySecondLevel> createState() => _ScrutinySecondLevelState();
}

class _ScrutinySecondLevelState extends State<ScrutinySecondLevel> {
  final FirstLevelController firstLevelScrutinyController =
      Get.put(FirstLevelController());
  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Application No',
    'Application Date',
    'Patient ID',
    'Applicant Name',
    'Unit Name',
    'District Name',
    "Service Name"
  ];

  var userData;

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
    firstLevelScrutinyController.update();
    if (hasInternet) {
      // await firstLevelScrutinyController.getFirstApprovalList(
      //     userData['ui'], userData['unitId']);

      await firstLevelScrutinyController.getFirstApprovalList(
          userData['ui'], userData['unitId']);
      firstLevelScrutinyController.originalPatientList =
          firstLevelScrutinyController
                  .firstLevelScrutinyApprovalModel?.details?.tmCmScrutinyBean ??
              [];
      firstLevelScrutinyController.filteredPatientList =
          firstLevelScrutinyController.originalPatientList;
    }
  }

  void filterList() {
    String query =
        firstLevelScrutinyController.searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() {
        firstLevelScrutinyController.filteredPatientList =
            firstLevelScrutinyController.originalPatientList;
      });
    } else {
      setState(() {
        firstLevelScrutinyController.filteredPatientList =
            firstLevelScrutinyController.originalPatientList.where((patient) {
          final lowerQuery = query.toLowerCase();
          final formattedDate = formatDate(patient.appDate ?? '');

          return patient.appName?.toLowerCase().contains(lowerQuery) == true ||
              patient.patientId?.toString().contains(lowerQuery) == true ||
              patient.appNumber?.toLowerCase().contains(lowerQuery) == true ||
              formattedDate.contains(lowerQuery);
        }).toList();
      });
    }
  }

  String formatDate(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return dateString; // If parsing fails, return the original string
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Scrutiny Approval",
          fontSize: 18.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              if (widget.userType == "NEPHROLOGIST") {
                Get.off(const NephroDashboard());
              } else {
                Get.off(const NephroSecondLevel());
              }
            },
            child: Image.asset('assets/arrow-left.png')),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isDismissible: false,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      padding: EdgeInsets.symmetric(
                          vertical: 14.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: const Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 0.5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                      text: "Search",
                                      fontSize: 16.sp,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start)
                                  .paddingSymmetric(vertical: 4.h),
                              InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    "assets/cancel.png",
                                    width: 30.w,
                                    height: 30.h,
                                    color: AppColor.primaryBackgroundColor,
                                  )),
                            ],
                          ),
                           Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                text: "Search BY",
                                fontSize: 16.sp,
                                fontFam: "Lato",
                                fontWeight: FontWeight.normal,
                                textColor: const Color(0xff515151),
                                textAlign: TextAlign.start),
                          ).paddingOnly(top: 10.h, bottom: 4.h),
                          TextField(
                              controller:
                                  firstLevelScrutinyController.searchController,
                              decoration: const InputDecoration(
                                labelText:
                                    'Application no, date, patient id, name',
                                labelStyle: TextStyle(color: Color(0xFFE1E1E1)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFE1E1E1)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFE1E1E1)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                      padding:  EdgeInsets.symmetric(
                                          vertical: 8.h),
                                      alignment: Alignment.center,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.red,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset("assets/cancel.png"),
                                           CustomText(
                                              text: "Cancel",
                                              fontSize: 16.sp,
                                              fontFam: "Lato",
                                              fontWeight: FontWeight.normal,
                                              textColor: Colors.white,
                                              textAlign: TextAlign.start),
                                        ],
                                      )),
                                ),
                              ).paddingOnly(top: 20.h),
                               SizedBox(
                                width: 14.w,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    filterList(); // Perform search when the button is tapped
                                    Get.back();
                                  },
                                  child: Container(
                                      padding:  EdgeInsets.symmetric(
                                          vertical: 8.h),
                                      alignment: Alignment.center,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColor.primaryBackgroundColor,
                                            AppColor.secondaryColor
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      child:  Row(
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
                              ).paddingOnly(top: 20.h),
                            ],
                          )
                        ],
                      ),
                    );
                  });
                },
              );
            },
            child: Padding(
              padding:  EdgeInsets.only(right: 8.w),
              child: Image.asset("assets/filter-line.png"),
            ),
          ),
        ],
      ),
      body: GetBuilder<FirstLevelController>(
          init: firstLevelScrutinyController,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ?  Center(child: buildShimmerLoader())
                    : ScrutinyApprovalCard(
                        patientList: controller.filteredPatientList,
                        cardItemDetailsList: cardItemDetailsList,
                        path1: "assets/edit.png",
                        callB1: (index) {
                          Get.to(() => ApplicationDetailsSecondLevel(
                                patient: controller.filteredPatientList[index],
                              ));
                        })
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }
}

class ScrutinyApprovalCard extends StatelessWidget {
  final List<FirstLevelTmCmScrutinyBean> patientList;
  final List<String> cardItemDetailsList;
  final String? path1;
  final Function callB1;

  const ScrutinyApprovalCard(
      {super.key,
      required this.patientList,
      required this.cardItemDetailsList,
      this.path1,
      required this.callB1});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: patientList.length,
        itemBuilder: (context, index) {
          return Card(
            // height: 186.h,
            // decoration: BoxDecoration(
            //   color: const Color(0xffF8F8F8),
            //   borderRadius: BorderRadius.circular(6),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black.withValues(alpha: 0.1),
            //       spreadRadius: 2,
            //       blurRadius: 4,
            //       offset: const Offset(0, 0.5), // changes position of shadow
            //     ),
            //   ],
            // ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: patientDetailsCard(
                                cardItemDetailsList[0],
                                patientList[index].appNumber.toString(),
                                false,
                                patientList[index].status),
                          ),
                          patientCardActions(path1!, () {
                            callB1(index);
                          }, null),
                        ],
                      ),
                      patientDetailsCard(
                          cardItemDetailsList[1],
                          patientList[index].appDate != null
                              ? formatDate(patientList[index].appDate!)
                              : "",
                          false,
                          patientList[index].status),
                      patientDetailsCard(
                          cardItemDetailsList[2],
                          patientList[index].patientId != null
                              ? patientList[index].patientId.toString()
                              : "",
                          false,
                          patientList[index].status),
                      patientDetailsCard(
                          cardItemDetailsList[3],
                          patientList[index].appName ?? '',
                          false,
                          patientList[index].status),
                      patientDetailsCard(
                          cardItemDetailsList[4],
                          extractStringUpToParenthesis(
                              "${patientList[index].unitName}"),
                          false,
                          patientList[index].status),
                      patientDetailsCard(
                          cardItemDetailsList[5],
                          patientList[index].distName ?? "",
                          false,
                          patientList[index].status),
                      patientDetailsCard(
                          cardItemDetailsList[6],
                          "${patientList[index].serviceName}",
                          true,
                          patientList[index].status),
                    ],
                  ).paddingOnly(left: 6.w, top: 2.h, bottom: 2.h, right: 4.w),
                ),
                // Container(
                //   width: 50.w,
                //   decoration: BoxDecoration(
                //     color: AppColor.darkBlue,
                //     borderRadius: const BorderRadius.only(
                //         topRight: Radius.circular(6),
                //         bottomRight: Radius.circular(6)),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           // patientCardActions(path1!, () {
                //           //   callB1(index);
                //           // }, null),
                //         ],
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ).paddingSymmetric(vertical: 8.h,horizontal: 8.w);
        });
  }

  String formatDate(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return dateString; // If parsing fails, return the original string
    }
  }

  Widget patientDetailsCard(
      String text, String details, bool showStatus, String? status) {
    return Column(
      children: [
        Row(
          children: [
            CustomText(
                    text: "$text :",
                    fontSize: 13.sp,
                    fontFam: "Lato",
                    fontWeight: FontWeight.normal,
                    textColor: Colors.black,
                    textAlign: TextAlign.start)
                .paddingSymmetric(vertical: 2.h),
            Expanded(
              child: CustomText(
                      text: details,
                      fontSize: 13.sp,
                      fontFam: "Lato",
                      fontWeight: FontWeight.normal,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start)
                  .paddingSymmetric(vertical: 2.h),
            ),

          ],
        ),
        Align(
          alignment:Alignment.bottomRight,
          child: Visibility(
            visible: showStatus,
            child: Container(
              padding:  EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
              decoration: BoxDecoration(
                  color: AppColor.inProcess,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                child: CustomText(
                    text: status ?? "",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    textColor: Colors.white,
                    textAlign: TextAlign.center),
              ),
            ).paddingOnly(top: 4.h, right: 4.w),
          ),
        )
      ],
    );
  }

  String extractStringUpToParenthesis(String input) {
    int index = input.indexOf('(');
    if (index != -1) {
      return input
          .substring(0, index)
          .trim(); // Extract up to '(' and trim whitespace
    }
    return input.trim(); // Return the original string if '(' is not found
  }

  Widget patientCardActions(String path, Function callB, bool? yes) {
    return InkWell(
        onTap: () {
          callB();
        },
        child: Image.asset(
          width: 24.w,
          height: 24.h,
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
