import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/screen/nephro_first_level/application_details_first_level.dart';
import 'package:heamodialysis/dashboard/controller/first_level_controller.dart';
import 'package:heamodialysis/dashboard/model/first_level_scrutiny_approval_list.dart';
import 'package:heamodialysis/dashboard/screen/nephro_first_level/nephro_dashboard.dart';
import 'package:heamodialysis/dashboard/screen/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';

import '../../../utils/status_update_screen.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_shimmer_loader.dart';



class ScrutinyFirstLevel extends StatefulWidget {
  final dynamic userType;

  const ScrutinyFirstLevel({super.key, this.userType});

  @override
  State<ScrutinyFirstLevel> createState() => _ScrutinyFirstLevelState();
}

class _ScrutinyFirstLevelState extends State<ScrutinyFirstLevel> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  final FirstLevelController firstLevelScrutinyController =
      Get.put(FirstLevelController());
  bool hasInternet = true;

  List<String> _cardItemDetailsList(BuildContext context) => [
        context.l10n.colApplicationNo,
        context.l10n.colApplicationDate,
        context.l10n.colPatientId,
        context.l10n.colApplicantName,
        context.l10n.colUnitName,
        context.l10n.colDistrictName,
        context.l10n.colServiceName,
      ];

  var userData;

  @override
  void initState() {
    getUserData();
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
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    firstLevelScrutinyController.update();
    if (hasInternet) {
      // await firstLevelScrutinyController.getFirstApprovalList(
      //     userData['user_ID'], userData['unitId']);
      await firstLevelScrutinyController.getFirstApprovalList(
          userData['user_ID'], userData['unitId'].toString());
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
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable ? Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:  CustomText(
          text: context.l10n.scrutinyApproval,
          fontSize: 18.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              if (widget.userType == "TECHNICIAN" || widget.userType =="DOCTOR") {
                Get.off(const InstituteWiseDashboardScreen());
              } else {
                Get.off(const NephroDashboard());
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 10),
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
                                      text: context.l10n.commonSearch,
                                      fontSize: 16,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start)
                                  .paddingSymmetric(vertical: 4),
                              InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    "assets/cancel.png",
                                    width: 30,
                                    height: 30,
                                    color: AppColor.primaryBackgroundColor,
                                  )),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                text: context.l10n.commonSearchBy,
                                fontSize: 16,
                                fontFam: "Lato",
                                fontWeight: FontWeight.normal,
                                textColor: Color(0xff515151),
                                textAlign: TextAlign.start),
                          ).paddingOnly(top: 10, bottom: 4),
                          TextField(
                              controller:
                                  firstLevelScrutinyController.searchController,
                              decoration: InputDecoration(
                                labelText: context.l10n.searchHintAppNoDateIdName,
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.red,
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/cancel.png"),
                                            const SizedBox(width: 6),
                                            CustomText(
                                                text: context.l10n.commonCancel,
                                                fontSize: 16,
                                                fontFam: "Lato",
                                                fontWeight: FontWeight.normal,
                                                textColor: Colors.white,
                                                textAlign: TextAlign.start),
                                          ],
                                        ),
                                      )),
                                ),
                              ).paddingOnly(top: 20),
                              const SizedBox(
                                width: 14,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    filterList(); // Perform search when the button is tapped
                                    Get.back();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      alignment: Alignment.center,
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
                                            const SizedBox(width: 6),
                                            CustomText(
                                                text: context.l10n.commonSearch,
                                                fontSize: 16,
                                                fontFam: "Lato",
                                                fontWeight: FontWeight.normal,
                                                textColor: Colors.white,
                                                textAlign: TextAlign.start),
                                          ],
                                        ),
                                      )),
                                ),
                              ).paddingOnly(top: 20),
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
            if (controller.isLoading) {
              return  const Center(child: ScrutinyApprovalShimmer());
            }
            if (controller.filteredPatientList.isEmpty) {
              return CommonStatusScreen(
                title: context.l10n.commonNoDataFound,
                description: context.l10n.commonNoDataFoundDescription,
                img: "assets/no_Data_Found.png",
                buttonText: context.l10n.commonGoBack,
                onPressed: () {
                  Get.back();
                },
              );
            }
            return ScrutinyApprovalCard(
                        patientList: controller.filteredPatientList,
                        cardItemDetailsList: _cardItemDetailsList(context),
                        path1: "assets/edit.png",
                        callB1: (index) {
                          Get.to(() => ApplicationDetailsFirstLevel(
                                patient: controller.filteredPatientList[index],
                              ));
                        });
          }),
    ) : InternetIssue(
      onRetryPressed: () async {
        final result = await _connectivity.checkConnectivity();
        _updateConnectionStatus(result);
      },
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
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
             // elevation:8,
             // height: 186,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                                    showStatus:false,
                                   status:  patientList[index].status,
                                ),
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
                             showStatus:  false,
                             status:  patientList[index].status),
                          patientDetailsCard(
                              cardItemDetailsList[2],
                              patientList[index].patientId.toString(),
                             showStatus:  false,
                            status:   patientList[index].status),
                          patientDetailsCard(
                              cardItemDetailsList[3],
                              patientList[index].appName ?? '',
                             showStatus:  false,
                             status:  patientList[index].status),
                          patientDetailsCard(
                              cardItemDetailsList[4],
                              extractStringUpToParenthesis(
                                  "${patientList[index].unitName}"),
                             showStatus:  false,
                             status:  patientList[index].status),
                          patientDetailsCard(
                              cardItemDetailsList[5],
                              "${patientList[index].distName}",
                             showStatus:  false,
                             status:  patientList[index].status),
                          patientDetailsCard(
                              cardItemDetailsList[6],
                              "${patientList[index].serviceName}",
                             showStatus:  true,
                             status:  patientList[index].status,

                          ),

                        ],
                      ).paddingOnly(left: 6, top: 2, bottom: 2, right: 4),
                    ),

                  ],
                ),
              ),
            ).paddingAll(8.0),
          );
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

  // Widget  patientDetailsCard(
  //     String text, String details, bool showStatus, String? status) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           CustomText(
  //                   text: "$text :",
  //                   fontSize: 13,
  //                   fontFam: "Lato",
  //                   fontWeight: FontWeight.normal,
  //                   textColor: Colors.black,
  //                   textAlign: TextAlign.start)
  //               .paddingSymmetric(vertical: 2),
  //           Expanded(
  //             child: CustomText(
  //                     text: details,
  //                     fontSize: 13,
  //                     fontFam: "Lato",
  //                     fontWeight: FontWeight.normal,
  //                     textColor: Colors.grey,
  //                     textAlign: TextAlign.start)
  //                 .paddingSymmetric(vertical: 2),
  //           ),
  //
  //         ],
  //       ),
  //       Align(
  //         alignment:Alignment.bottomRight,
  //         child: Visibility(
  //           visible: showStatus,
  //           child: Container(
  //             padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
  //             decoration: BoxDecoration(
  //                 color: AppColor.inProcess,
  //                 borderRadius: BorderRadius.circular(20)),
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
  //               child: CustomText(
  //                   text: status ?? "",
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.normal,
  //                   textColor: Colors.white,
  //                   textAlign: TextAlign.center),
  //             ),
  //           ).paddingOnly(top: 4, right: 4),
  //         ),
  //       )
  //     ],
  //   );
  // }

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
          width: 24,
          height: 24,
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
