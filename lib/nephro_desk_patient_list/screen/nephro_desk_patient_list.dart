import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/screen/nephro_second_level/nephro_second_level.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/nephro_desk_dropdown.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/nepro_card.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/edit_nephro_desk.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/schedular/screen/patient_history_schedular.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

import '../../utils/status_update_screen.dart';
import '../../widgets/custom_shimmer_loader.dart';

class NephroDeskPatientList extends StatefulWidget {
  final String appBarTitle;

  const NephroDeskPatientList({super.key, required this.appBarTitle});

  @override
  State<NephroDeskPatientList> createState() => _NephroDeskPatientListState();
}

class _NephroDeskPatientListState extends State<NephroDeskPatientList> {
  final NephroController nephroController = Get.put(NephroController());
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  bool hasInternet = true;
  bool isPageLoading = true;
  LookupList? dropDownValue;
  PatientStatus? selectedStatus;
  UnitList? dropDownValue2;
  var userData;
  String? userType;

  List<String> _cardItemDetailsList(BuildContext context) => [
        context.l10n.colPatientId,
        context.l10n.colPatientName,
        context.l10n.commonAge,
        context.l10n.commonMobileNo,
        context.l10n.colTreatmentId,
        context.l10n.commonGender,
        context.l10n.schedAppointmentDate,
        context.l10n.schedSlot,
        context.l10n.colViralLoadStatus
      ];

  List<PatientStatus> statusList = [
    PatientStatus('All', 'N'),
    PatientStatus('Pending', 'Y')
  ];

  @override
  void initState() {
    super.initState();
    userType = Get.arguments;

    debugPrint('👤 User Type in NephroDeskPatientList: $userType');
    checkInternetAndLoadData();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  // Method to determine API code based on user type
  String getApiCode() {
    if (userType == "DOCTOR") {
      return 'PNA'; // Doctor Desk API code
    } else {
      return 'PNA'; // Nephrologist Desk API code (default)
    }
  }

  // Method to call appropriate API based on user type
  Future<void> callDeskApi({
    required String searchType,
    required String searchValue,
    required String unitId,
    required String districtId,
    required String status,
  }) async {
    if (userType == "DOCTOR") {
      await nephroController.getDoctorList(userData['unitId'].toString());
    } else {
      await nephroController.getNephroList(
          'PNA',
          '',
          userData['mulSelunit'].toString(),
          userData['district'] != null ? userData['district'].toString() : "0",
          "N");
    }
  }

  checkInternetAndLoadData() async {
    isPageLoading = true;
    nephroController.update();
    await getUserData();
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));

    debugPrint('Internet status: $hasInternet');
    nephroController.update();

    if (hasInternet) {
      try {
        debugPrint('Calling ...');
        debugPrint('🔄 Loading data for user type: $userType');
        await callDeskApi(
          searchType: getApiCode(),
          searchValue: '',
          unitId: userData['unitId'].toString(),
          districtId: userData['district'] != null
              ? userData['district'].toString()
              : "0",
          status: "N",
        );

        // await nephroController.getNephroList(
        //     'PNA',
        //     '',
        //     userData['unitId'].toString(),
        //     userData['district'] != null
        //         ? userData['district'].toString()
        //         : "0",
        //     "N");
        await nephroController
            .searchByDropDownList(userData['district'].toString());
        await nephroController.getListOfPackage(userData['unitId'].toString());

        if (nephroController.searchByModel?.lookupList != null ||
            nephroController.searchByModel!.lookupList!.isNotEmpty) {
          dropDownValue = nephroController.searchByModel!.lookupList!.first;
        }
      } catch (e) {
        debugPrint('Error while calling getNephroList: $e');
      } finally {
        isPageLoading = false;
        nephroController.update();
      }
    } else {
      isPageLoading = false;
      nephroController.update();
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint('User data retrieved: $userData');
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
    return GetBuilder<NephroController>(builder: (controller) {
      return _isNetworkAvailable
          ? Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: CustomText(
                  text: widget.appBarTitle,
                  fontSize: 16.sp,
                  fontFam: 'Lato',
                  fontWeight: FontWeight.w400,
                  textColor: Colors.black,
                  textAlign: TextAlign.start,
                ),
                leading: InkWell(
                    onTap: () {
                      Get.back();
                      // Get.offAll(() => const NephroSecondLevel());
                    },
                    child: Image.asset('assets/arrow-left.png')),
                actions: [
                  InkWell(
                    onTap: () {
                      // dropDownValue2 = searchByList[0];
                      showModalBottomSheet(
                        isDismissible: false,
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
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
                                    offset: const Offset(
                                        0, 0.5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                              text: context.l10n.commonSearch,
                                              fontSize: 16.sp,
                                              fontFam: "Lato",
                                              fontWeight: FontWeight.w400,
                                              textColor: Colors.black,
                                              textAlign: TextAlign.start)
                                          .paddingSymmetric(vertical: 4),
                                      InkWell(
                                          onTap: () {
                                            dropDownValue = null;
                                            nephroController
                                                .valueController.text = "";
                                            Get.back();
                                          },
                                          child: Image.asset(
                                            "assets/cancel.png",
                                            width: 30.w,
                                            height: 30.h,
                                            color:
                                                AppColor.primaryBackgroundColor,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                              text: context.l10n.commonSearchBy,
                                              fontSize: 16.sp,
                                              fontFam: "Lato",
                                              fontWeight: FontWeight.normal,
                                              textColor:
                                                  const Color(0xff515151),
                                              textAlign: TextAlign.start)
                                          .paddingOnly(top: 10.h, bottom: 4.h),
                                      Container(
                                        // width: 180,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFFE1E1E1)),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        child: DropdownButton<LookupList>(
                                          isExpanded: true,
                                          value: dropDownValue,
                                          hint: Text("select"),
                                          onChanged: (LookupList? newValue) {
                                            dropDownValue = newValue!;
                                            setState(() {});
                                          },
                                          items: nephroController
                                              .searchByModel?.lookupList
                                              ?.map<
                                                      DropdownMenuItem<
                                                          LookupList>>(
                                                  (LookupList value) {
                                            return DropdownMenuItem<LookupList>(
                                              value: value,
                                              child: Text(
                                                  value.lookupDetDescEn ?? ""),
                                            );
                                          }).toList(),
                                          underline: SizedBox(),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color:
                                                AppColor.primaryBackgroundColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                        text: context.l10n.commonValue,
                                        fontSize: 16.sp,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: const Color(0xff515151),
                                        textAlign: TextAlign.start),
                                  ).paddingOnly(top: 12.h, bottom: 4.h),
                                  TextField(
                                      inputFormatters: [
                                        UpperCaseTextFormatter()
                                      ],
                                      controller:
                                          nephroController.valueController,
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
                                      )),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                              text: context.l10n.nephroClinicalHistoryStatus,
                                              fontSize: 16.sp,
                                              fontFam: "Lato",
                                              fontWeight: FontWeight.normal,
                                              textColor:
                                                  const Color(0xff515151),
                                              textAlign: TextAlign.start)
                                          .paddingOnly(top: 10.h, bottom: 4.h),
                                      Container(
                                        // width: 180,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFFE1E1E1)),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        child: DropdownButton<PatientStatus>(
                                          isExpanded: true,
                                          value: selectedStatus,
                                          hint: Text(context.l10n.regHintSelect),
                                          onChanged: (PatientStatus? newValue) {
                                            selectedStatus = newValue!;
                                            setState(() {});
                                          },
                                          items: statusList.map<
                                                  DropdownMenuItem<
                                                      PatientStatus>>(
                                              (PatientStatus value) {
                                            return DropdownMenuItem<
                                                PatientStatus>(
                                              value: value,
                                              child: Text(value.status == 'Y'
                                                  ? context.l10n.dashPending
                                                  : context.l10n.commonAll),
                                            );
                                          }).toList(),
                                          underline: SizedBox(),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color:
                                                AppColor.primaryBackgroundColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
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
                                                      text: context.l10n.commonCancel,
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
                                      ).paddingOnly(top: 20.h),
                                      SizedBox(
                                        width: 14.w,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () async {
                                            Get.back();
                                            isPageLoading = true;
                                            nephroController.update();
                                            try {
                                              if (userType == "DOCTOR") {
                                                await nephroController
                                                    .getDoctorSearchList(
                                                  dropDownValue
                                                          ?.lookupDetValue ??
                                                      "",
                                                  nephroController
                                                      .valueController.text,
                                                  userData['unitId'].toString(),
                                                );
                                              } else {
                                                await nephroController
                                                    .getNephroList(
                                                        dropDownValue
                                                                ?.lookupDetValue ??
                                                            "",
                                                        nephroController
                                                            .valueController
                                                            .text,
                                                        userData['mulSelunit']
                                                            .toString(),
                                                        userData['district'] !=
                                                                null
                                                            ? userData[
                                                                    'district']
                                                                .toString()
                                                            : '0',
                                                        selectedStatus?.status);
                                              }
                                            } finally {
                                              isPageLoading = false;
                                              nephroController.update();
                                            }
                                            // nephroController.getNephroList(
                                            //     dropDownValue?.lookupDetValue ?? "",
                                            //     nephroController.valueController.text,
                                            //     dropDownValue2?.unitId != null
                                            //         ? dropDownValue2!.unitId
                                            //             .toString()
                                            //         : "0",
                                            //     userData['district'].toString(),
                                            //     selectedStatus?.status);
                                            /* nephroController.getNephroList(
                                                dropDownValue?.lookupDetValue ??
                                                    "",
                                                nephroController
                                                    .valueController.text,
                                                userData['unitId'].toString(),
                                                userData['district'] != null
                                                    ? userData['district']
                                                        .toString()
                                                    : '0',
                                                selectedStatus?.status);*/
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
                                                      text: context.l10n.commonSearch,
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
                      padding: EdgeInsets.only(right: 8.w),
                      child: Image.asset("assets/filter-line.png"),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                ],
              ),
              body: GetBuilder<NephroController>(builder: (controller) {
                if (isPageLoading) {
                  return const PatientListShimmer();
                }

                if (controller.nephroList == null ||
                    controller.nephroList!.isEmpty) {
                  return CommonStatusScreen(
                    title: context.l10n.commonNoDataFound,
                    description:
                        "We are unable to find the data that\nyou are looking for ",
                    img: "assets/no_Data_Found.png",
                    buttonText: context.l10n.commonGoBack,
                    onPressed: () {
                      Get.back();
                    },
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.nephroList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return NeproCard(
                      patient: controller.nephroList?[index],
                      // isSecondColumnVisiable: true,
                      path1: "assets/file-list.png",
                      path2: "assets/edit.png",

                      callB1: () {
                        PatientData patientData = PatientData(
                          patientId: controller.nephroList![index].patientId!,
                          patientName: controller.nephroList?[index].fName,
                          treatmentId:
                              controller.nephroList?[index].treatmentId != null
                                  ? controller.nephroList![index].treatmentId!
                                  : null,
                          gender: controller.nephroList?[index].gender,
                          age: controller.nephroList?[index].age != null
                              ? controller.nephroList![index].age!
                              : null,
                        );

                        Get.to(() => PatientHistorySchedular(
                              patientData: patientData,
                            ));
                      },

                      callB3: () {
                        Get.to(() => EditNephroDesk(
                              patientData: controller.nephroList?[index],
                              appBarTitle: widget.appBarTitle,
                            ))?.then((_) {
                          checkInternetAndLoadData();
                        });
                      },

                      cardItemDetailsList: _cardItemDetailsList(context),
                    );
                  },
                );
              })
              // body: GetBuilder<NephroController>(
              //   init: nephroController,
              //   builder: (controller) {
              //     return hasInternet
              //         ? controller.isLoading
              //             ? Center(child: CircularProgressIndicator())
              //             : ListView.builder(
              //                 shrinkWrap: true,
              //                 itemCount: controller.nephroList?.length ?? 0,
              //                 itemBuilder: (BuildContext context, int index) {
              //                   return NeproCard(
              //                     patient: controller.nephroList?[index],
              //                     isSecondColumnVisiable: true,
              //                     path1: "assets/file-list.png",
              //                     path2: "assets/video_call.png",
              //                     path3: "assets/edit.png",
              //                     path4: "assets/phone.png",
              //                     path5: "assets/phone.png",
              //                     callB1: () {
              //                       PatientData patientData = PatientData(
              //                         patientId: controller.nephroList![index].patientId!,
              //                         patientName:
              //                             controller.nephroList?[index].fName,
              //                         treatmentId:
              //                             controller.nephroList?[index].treatmentId !=
              //                                     null
              //                                 ? controller
              //                                 .nephroList![index].treatmentId!
              //                                 : null,
              //                         gender: controller.nephroList?[index].gender,
              //                         age: controller.nephroList?[index].age != null
              //                             ? controller.nephroList![index].age!
              //                             : null,
              //                       );
              //
              //                       Get.to(() => PatientHistorySchedular(
              //                             patientData: patientData,
              //                           ));
              //                     },
              //                     callB2: () {
              //                       debugPrint('Video call pressed');
              //                     },
              //                     callB3: () {
              //                       Get.to(() => EditNephroDesk(
              //                             patientData: controller.nephroList?[index], appBarTitle: widget.appBarTitle,
              //                           ));
              //                     },
              //                     callB4: () {
              //                       // Implement cancellation logic if needed
              //                     },
              //                     callB5: () {},
              //                     cardItemDetailsList: cardItemDetailsList,
              //                   );
              //                 },
              //               )
              //         : InternetIssue(
              //             onRetryPressed: () {
              //               checkInternetAndLoadData();
              //             },
              //           );
              //   },
              // ),
              )
          : InternetIssue(
              onRetryPressed: () async {
                final result = await _connectivity.checkConnectivity();
                _updateConnectionStatus(result);
              },
            );
    });
  }
}

class PatientStatus {
  String? title;
  String? status;

  PatientStatus(this.title, this.status);
}
