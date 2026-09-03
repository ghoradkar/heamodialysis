import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/screen/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/edit_pre_dialysis_details.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/pre_dialysis_list/controller/pre_dialysis_controller.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/schedular/screen/patient_history_schedular.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../../../utils/status_update_screen.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/custom_shimmer_loader.dart';

class PreDialysisScreen extends StatefulWidget {
  const PreDialysisScreen({super.key});

  @override
  State<PreDialysisScreen> createState() => _PreDialysisScreenState();
}

class _PreDialysisScreenState extends State<PreDialysisScreen> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;




  final PreDialysisController preDialysisController =
      Get.put(PreDialysisController());

  // final DashboardController dashboardController =
  // Get.put(DashboardController());

  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Patient Id',
    'Patient Name',
    'Patient Age',
    'Mobile No',
    'Last dialysis session',
    'Viral Load Status'
  ];

  SearchedData? dropDownValue;
  SearchedData? dropDownValue2;

  TextEditingController valueController = TextEditingController();

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
    preDialysisController.refreshUi();
    if (hasInternet) {
      // await dashboardController.getAllRegisteredPatient();
      await preDialysisController.searchPreDialysisPatient(
          'PRD', '', int.parse(userData['unitId'].toString()));
      await preDialysisController.searchByDropDownList();
      if (preDialysisController.searchByModel?.data != null ||
          preDialysisController.searchByModel!.data!.isNotEmpty) {
        dropDownValue = preDialysisController.searchByModel!.data!.first;
        preDialysisController.refreshUi();
      }
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
          ),
        ),
        backgroundColor: AppColor.primaryBackgroundColor,
        title: const CustomText(
          text: 'Pre Dialysis Patient List',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.white,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.off(const InstituteWiseDashboardScreen());
            },
            child: Image.asset(
              'assets/arrow-left.png',
              color: Colors.white,
            )),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
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
                          offset: const Offset(
                              0, 0.5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                                    text: "Search",
                                    fontSize: 16,
                                    fontFam: "Lato",
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black,
                                    textAlign: TextAlign.start)
                                .paddingSymmetric(vertical: 4),
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Image.asset(
                                  "assets/cancel.png",
                                  width: 24,
                                  height: 24,
                                  color: AppColor.primaryBackgroundColor,
                                )),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                                    text: "Search By",
                                    fontSize: 16,
                                    fontFam: "Lato",
                                    fontWeight: FontWeight.normal,
                                    textColor: Color(0xff515151),
                                    textAlign: TextAlign.start)
                                .paddingOnly(top: 10, bottom: 4),
                            Container(
                              // width: 180,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFE1E1E1)),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: DropdownButton<SearchedData>(
                                isExpanded: true,
                                value: dropDownValue,
                                hint: const Text("select"),
                                onChanged: (SearchedData? newValue) {
                                  dropDownValue = newValue!;
                                  preDialysisController.update();
                                },
                                items: preDialysisController.searchByModel?.data
                                    ?.map<DropdownMenuItem<SearchedData>>(
                                        (SearchedData value) {
                                  return DropdownMenuItem<SearchedData>(
                                    value: value,
                                    child: Text(value.lookupDetDescEn ?? ""),
                                  );
                                }).toList(),
                                underline: const SizedBox(),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: AppColor.primaryBackgroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                              text: "Value",
                              fontSize: 16,
                              fontFam: "Lato",
                              fontWeight: FontWeight.normal,
                              textColor: Color(0xff515151),
                              textAlign: TextAlign.start),
                        ).paddingOnly(top: 10, bottom: 4),
                        TextField(
                            controller: valueController,
                            decoration: const InputDecoration(
                              labelText: 'Patient Id, name, mobile no etc.',
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    alignment: Alignment.center,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.red,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/cancel.png"),
                                        const CustomText(
                                            text: "Cancel",
                                            fontSize: 16,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.normal,
                                            textColor: Colors.white,
                                            textAlign: TextAlign.start),
                                      ],
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
                                  preDialysisController
                                      .searchPreDialysisPatient(
                                          dropDownValue?.lookupDetValue ?? "",
                                          valueController.text,
                                          userData['unitId']);
                                  Get.back();
                                },
                                child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    alignment: Alignment.center,
                                    width: 100,
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
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                        CustomText(
                                            text: "Search",
                                            fontSize: 16,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.normal,
                                            textColor: Colors.white,
                                            textAlign: TextAlign.start),
                                      ],
                                    )),
                              ),
                            ).paddingOnly(top: 20),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                "assets/filter-line.png",
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
        ],
      ),
      body:
      GetBuilder<PreDialysisController>(
          init: PreDialysisController(),
          builder: (controller) {
            if (controller.isLoading) {
              return Center(child: SessionEndPatientsShimmer());
            }
            // 2️⃣ Get list safely
            final preDialysisList =
                controller.preDialysisListModel?.data ?? [];

            // 3️⃣ No Data Found state
            if (preDialysisList.isEmpty) {
              return CommonStatusScreen(
                title: "No Data Found",
                description:
                "We are unable to find the data that\nyou are looking for ",
                img: "assets/no_Data_Found.png",
                buttonText: "Go Back",
                onPressed: () {
                  Get.back();
                },
              );
            }

            return  PreDialysisCardList(
                        patientList:
                            controller.preDialysisListModel?.data ?? [],
                        cardItemDetailsList: cardItemDetailsList,
                        isSecondColumnVisiable: false,
                        isfromPredialysis: true,
                        path1: "assets/file-list.png",
                        path3: "assets/eye.png",
                        path5: "assets/edit.png",
                        callB1: (index) {
                          PatientData patientData = PatientData(
                            patientId: controller
                                .preDialysisListModel!.data![index].patientId,
                            patientName: controller
                                .preDialysisListModel!.data![index].fName,
                            treatmentId: controller
                                .preDialysisListModel!.data![index].treatmentId,
                            age: controller
                                .preDialysisListModel!.data![index].age,
                          );
                          Get.to(() => PatientHistorySchedular(
                                patientData: patientData,
                              ));
                        },
                        callB5: (index) {
                          Get.to(() => EditPreDialysisScreen(
                                preDialysisData: controller
                                    .preDialysisListModel!.data![index],
                                callB: () {},
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

class PreDialysisCardList extends StatelessWidget {
  final List<dynamic> patientList;
  final List<String> cardItemDetailsList;
  final bool isSecondColumnVisiable;
  final bool isfromPredialysis;
  final String? path1;
  final String? path3;
  final String? path5;
  final Function callB1;
  final Function callB5;

  const PreDialysisCardList(
      {super.key,
      required this.patientList,
      required this.cardItemDetailsList,
      required this.isSecondColumnVisiable,
      this.path1,
      this.path3,
      this.path5,
      required this.isfromPredialysis,
      required this.callB1,
      required this.callB5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: patientList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: patientDetailsCard(cardItemDetailsList[0],
                                  patientList[index].patientId.toString()),
                            ),
                            SizedBox(
                              width: 70,
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
                                  Visibility(
                                    visible: isfromPredialysis == true,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        patientCardActions(path5!, () {
                                          callB5(index);
                                        }, null)
                                            //.paddingOnly(left: 13.h),
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
                                ? "${patientList[index].fName}"
                                : "${patientList[index].fName}"),
                        patientDetailsCard(cardItemDetailsList[2],
                            patientList[index].age.toString()),
                        patientDetailsCard(
                            cardItemDetailsList[3],
                            patientList[index].mobile != null
                                ? patientList[index].mobile.toString()
                                : ""),
                        patientDetailsCard(
                            cardItemDetailsList[5],
                            isfromPredialysis
                                ? "${patientList[index].procedureType}"
                                : "${patientList[index].procedureType}"),
                        patientDetailsCard(
                            cardItemDetailsList[4],
                            isfromPredialysis
                                ? extractStringUpToParenthesis(
                                    "${patientList[index].dialysisSupportType}")
                                : extractStringUpToParenthesis(
                                    "${patientList[index].dialysisSupportType}")),
                      ],
                    ).paddingOnly(left: 6.w, top: 2.h, bottom: 2.h, right: 4.w),
                  ),
                ],
              ).paddingSymmetric(vertical: 8.h, horizontal: 8.h),
            ),
          );
        });
  }

  // Widget patientDetailsCard(String text, String details) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Flexible(
  //         child: CustomText(
  //                 text: "$text $details:",
  //                 fontSize: 12.sp,
  //                 fontFam: "Lato",
  //                 fontWeight: FontWeight.normal,
  //                 textColor: Colors.black,
  //                 textAlign: TextAlign.start)
  //             .paddingSymmetric(vertical: 2.h),
  //       ),
  //       // Expanded(
  //       //   child: CustomText(
  //       //           text: details,
  //       //           fontSize: 12.sp,
  //       //           fontFam: "Lato",
  //       //           fontWeight: FontWeight.normal,
  //       //           textColor: Colors.grey,
  //       //           textAlign: TextAlign.start)
  //       //       .paddingSymmetric(vertical: 2.h),
  //       // ),
  //     ],
  //   );
  // }

  // Widget patientDetailsCard(String text, String details) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 2.h),
  //     child: RichText(
  //       textAlign: TextAlign.start,
  //       text: TextSpan(
  //         children: [
  //           TextSpan(
  //             text: "$text : ",
  //             style: TextStyle(
  //               fontSize: 13.sp,
  //               fontFamily: "Lato",
  //               fontWeight: FontWeight.w400,
  //               color: Colors.black,
  //             ),
  //           ),
  //           TextSpan(
  //             text: details,
  //             style: TextStyle(
  //               fontSize: 13.sp,
  //               fontFamily: "Lato",
  //               fontWeight: FontWeight.w400,
  //               color: Colors.grey,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
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
          width: 22.w,
          height: 22.h,
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
