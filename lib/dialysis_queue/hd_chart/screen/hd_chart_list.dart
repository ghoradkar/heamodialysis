import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/screen/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/screen/add_edit_hd_chart_screen.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/controller/hd_chart_controller.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/hd_chart_list_model.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/schedular/screen/patient_history_schedular.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../../utils/status_update_screen.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_shimmer_loader.dart';

class HdChartList extends StatefulWidget {
  const HdChartList({super.key});

  @override
  State<HdChartList> createState() => HdChartListState();
}

class HdChartListState extends State<HdChartList> {
  final HdChartController hdChartController = Get.put(HdChartController());
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Patient Id',
    'Patient Name',
    'Patient Age',
    'Mobile Number',
    'Treatment Id',
    'Dialysis Date',
    'Hd Treatment Count'
  ];

  SearchedData? dropDownValue;

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
    setState(() {
      hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi));
    });
    hdChartController.update();
    if (hasInternet) {
      await hdChartController.getHdChartList(
          '', '', hdChartController.userData['unitId'].toString());
      await hdChartController.searchByDropDownList();
    }
  }

  Future<void> getUserData() async {
    hdChartController.userData =
        await SharedPref().read(const SharedPrefConstant().kUserData);
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
    return _isNetworkAvailable
        ? Scaffold(
            appBar: AppBar(
              title: CustomText(
                text: 'HD Chart List',
                fontSize: 18.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.black,
                textAlign: TextAlign.start,
              ),
              leading: InkWell(
                  onTap: () {
                    Get.off(const InstituteWiseDashboardScreen());
                  },
                  child: Image.asset('assets/arrow-left.png')),
              actions: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setModalState) {
                            return Container(
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
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
                                  // header row ...
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: "Search",
                                        fontSize: 16.sp,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start,
                                      ).paddingSymmetric(vertical: 4.h),
                                      InkWell(
                                        onTap: () {
                                          setModalState(() {
                                            dropDownValue = null;
                                          });
                                          hdChartController.valueController
                                              .clear();
                                          Get.back();
                                        },
                                        child: Image.asset(
                                          "assets/cancel.png",
                                          width: 24.w,
                                          height: 24.h,
                                          color:
                                              AppColor.primaryBackgroundColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Search By
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Search By",
                                        fontSize: 16.sp,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: const Color(0xff515151),
                                        textAlign: TextAlign.start,
                                      ).paddingOnly(top: 10.h, bottom: 4.h),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFFE1E1E1)),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        child: DropdownButton<SearchedData>(
                                          isExpanded: true,
                                          value: dropDownValue,
                                          hint: const Text("select"),
                                          onChanged: (SearchedData? newValue) {
                                            setModalState(() {
                                              dropDownValue = newValue;
                                            });
                                          },
                                          items: (hdChartController
                                                      .searchByModel?.data ??
                                                  [])
                                              .map<
                                                      DropdownMenuItem<
                                                          SearchedData>>(
                                                  (SearchedData value) {
                                            return DropdownMenuItem<
                                                SearchedData>(
                                              value: value,
                                              child: Text(
                                                  value.lookupDetDescEn ?? ""),
                                            );
                                          }).toList(),
                                          underline: const SizedBox(),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color:
                                                AppColor.primaryBackgroundColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Value field
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      text: "Value",
                                      fontSize: 16.sp,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.normal,
                                      textColor: const Color(0xff515151),
                                      textAlign: TextAlign.start,
                                    ),
                                  ).paddingOnly(top: 10.h, bottom: 4.h),

                                  TextField(
                                    controller:
                                        hdChartController.valueController,
                                    decoration: const InputDecoration(
                                      labelText:
                                          'Patient Id, name, mobile no etc.',
                                      labelStyle:
                                          TextStyle(color: Color(0xFFE1E1E1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFE1E1E1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFE1E1E1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                  ),

                                  // Buttons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Cancel
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            setModalState(() {
                                              dropDownValue = null;
                                            });
                                            hdChartController.valueController
                                                .clear();
                                            Get.back();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            alignment: Alignment.center,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColor.red,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    "assets/cancel.png"),
                                                CustomText(
                                                  text: "Cancel",
                                                  fontSize: 16.sp,
                                                  fontFam: "Lato",
                                                  fontWeight: FontWeight.normal,
                                                  textColor: Colors.white,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ).paddingOnly(top: 20.h),

                                      SizedBox(width: 14.w),

                                      // Search
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () async {
                                            await hdChartController
                                                .getHdChartList(
                                              hdChartController
                                                  .valueController.text,
                                              dropDownValue?.lookupDetValue ??
                                                  "",
                                              hdChartController
                                                  .userData['unitId']
                                                  .toString(),
                                            );
                                            Get.back();
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
                                                  AppColor.secondaryColor,
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.search,
                                                    color: Colors.white),
                                                CustomText(
                                                  text: "Search",
                                                  fontSize: 16.sp,
                                                  fontFam: "Lato",
                                                  fontWeight: FontWeight.normal,
                                                  textColor: Colors.white,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ).paddingOnly(top: 20.h),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Image.asset("assets/filter-line.png"),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
              ],
            ),
            body: GetBuilder<HdChartController>(builder: (controller) {
              if (controller.isLoading) {
                return const Center(child: SessionEndPatientsShimmer());
              }
              final hdChartList = controller.hdChartList;
              if (hdChartList == null || hdChartList.isEmpty){

                return CommonStatusScreen(
                  title: "No Data Found",
                  description: "We are unable to find the data that\nyou are looking for ",
                  img: "assets/no_Data_Found.png",
                  buttonText: "Go Back",
                  onPressed: () {
                    Get.back();
                  },
                  // secondButtonText: "Refresh",
                  // secondOnPressed: () {
                  //   checkInternetAndLoadData();
                  // },
                );
              }
              return
              HdChartCardList(
                      patientList: controller.hdChartList ?? [],
                      cardItemDetailsList: cardItemDetailsList,
                      isSecondColumnVisiable: false,
                      isfromPredialysis: true,
                      path1: "assets/file-list.png",
                      path3: "assets/eye.png",
                      // path5: controller.hdChartList[index].hdChartTreatCount == 0
                      //     ? "assets/add-pre-dialysis.png"
                      //     : "assets/edit.png",
                      callB1: (index) {
                        PatientData patientData = PatientData(
                          patientId: controller.hdChartList![index].patientId,
                          patientName: controller.hdChartList![index].fName,
                          treatmentId:
                              controller.hdChartList![index].treatmentId,
                          age: controller.hdChartList![index].age,
                        );
                        Get.to(() => PatientHistorySchedular(
                              patientData: patientData,
                            ));
                      },
                      callB5: (index) {
                        Get.to(() => AddEditHdChartScreen(
                              hdChartListModel: controller.hdChartList![index],
                            ));
                      },
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
}

class HdChartCardList extends StatelessWidget {
  final List<HdChartListModel> patientList;
  final List<String> cardItemDetailsList;
  final bool isSecondColumnVisiable;
  final bool isfromPredialysis;
  final String? path1;
  final String? path3;
  final Function callB1;
  final Function callB5;

  const HdChartCardList(
      {super.key,
      required this.patientList,
      required this.cardItemDetailsList,
      required this.isSecondColumnVisiable,
      this.path1,
      this.path3,
      required this.isfromPredialysis,
      required this.callB1,
      required this.callB5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: patientList.length,
        itemBuilder: (context, index) {
          return Container(
            // height: 180.h,
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
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            patientDetailsCard(cardItemDetailsList[0],
                                patientList[index].patientId.toString()),
                            //SizedBox(width: 2,),
                            patientDetailsCard(cardItemDetailsList[4],
                                patientList[index].treatmentId.toString()),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  patientCardActions(path1!, () {
                                    callB1(index);
                                  }, null),
                                  Visibility(
                                    visible: isSecondColumnVisiable,
                                    child: SizedBox(
                                        // width: 12.w,
                                        ),
                                  ),
                                  Visibility(
                                    visible: isSecondColumnVisiable,
                                    child: SizedBox(
                                        // width: 12.w,
                                        ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Visibility(
                                    visible: isfromPredialysis == true,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        patientCardActions(
                                                patientList[index]
                                                            .hdChartTreatCount ==
                                                        0
                                                    ? "assets/add-pre-dialysis.png"
                                                    : "assets/edit.png", () {
                                          callB5(index);
                                        }, null)
                                            .paddingOnly(left: 5, right: 2.w),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        patientDetailsCard(
                            cardItemDetailsList[1],
                            isfromPredialysis
                                ? patientList[index].fName
                                : patientList[index].fName),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: patientDetailsCard(cardItemDetailsList[2],
                                  patientList[index].age.toString()),
                            ),
                            Expanded(
                              flex: 2,
                              child: patientDetailsCard(cardItemDetailsList[3],
                                  patientList[index].mobile.toString()),
                            ),
                            // Expanded(
                            //   child: patientDetailsCard(cardItemDetailsList[7],
                            //       patientList[index].gender.toString()),
                            // ),
                          ],
                        ),
                        patientDetailsCard(cardItemDetailsList[5],
                            patientList[index].dialysisDate),
                        patientDetailsCard(cardItemDetailsList[6],
                            patientList[index].hdChartTreatCount.toString())
                      ],
                    ).paddingOnly(left: 4.w, top: 2.h, bottom: 2.h, right: 3.w),
                  ),
                ],
              ),
            ),
          ).paddingSymmetric(vertical: 8.h, horizontal: 4.w);
        });
  }

  // Widget patientDetailsCard(String text, String details) {
  //   return Row(
  //     children: [
  //       CustomText(
  //               text: "$text :",
  //               fontSize: 12.sp,
  //               fontFam: "Lato",
  //               fontWeight: FontWeight.normal,
  //               textColor: Colors.black,
  //               textAlign: TextAlign.start)
  //           .paddingSymmetric(vertical: 2.h),
  //       Expanded(
  //         child: CustomText(
  //                 text: details,
  //                 fontSize: 12.sp,
  //                 fontFam: "Lato",
  //                 fontWeight: FontWeight.normal,
  //                 textColor: Colors.grey,
  //                 textAlign: TextAlign.start)
  //             .paddingSymmetric(vertical: 2.h),
  //       ),
  //     ],
  //   );
  // }

  String extractStringUpToParenthesis(String input) {
    int index = input.indexOf('(');
    if (index != -1) {
      return input.substring(0, index).trim();
    }
    return input.trim();
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
