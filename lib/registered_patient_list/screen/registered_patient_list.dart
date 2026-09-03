import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/book_appointment/screen/book_appointment.dart';
import 'package:heamodialysis/dashboard/screen/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/screen/new_registration.dart';
import 'package:heamodialysis/registered_patient_list/controller/registration_controller.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/schedular/screen/patient_history_schedular.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/registered_patient_cardlist.dart';

import '../../utils/status_update_screen.dart';
import '../../widgets/custom_shimmer_loader.dart';

class RegisteredPatientList extends StatefulWidget {
  const RegisteredPatientList({super.key});

  @override
  State<RegisteredPatientList> createState() => _RegisteredPatientListState();
}

class _RegisteredPatientListState extends State<RegisteredPatientList> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;


  final RegistrationController dashboardController =
      Get.put(RegistrationController());
  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Patient Id',
    'Patient Name',
    'Patient Age',
    'ABHA Number',
    'Scheme Adopt',
    'Viral Load Status'
  ];

  List<SearchByPatient> searchByList = [
    SearchByPatient('1', 'Dialysis Center'),
    SearchByPatient('2', 'State')
  ];

  SearchedData? dropDownValue;
  SearchByPatient? dropDownValue2;

  var userData;

  RadioButtons? radioButtons = RadioButtons.existingAbhaId;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkInternetAndLoadData();
    });

    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );

    super.initState();
  }

  checkInternetAndLoadData() async {
    dashboardController.isLoading = true;
    dashboardController.refreshUi();

    try {
      await getUserData();

      List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi));

      if (hasInternet && userData != null) {
        final unitIdStr = userData['unitId']?.toString() ?? '0';
        final unitId = int.tryParse(unitIdStr) ?? 0;

        await dashboardController.searchRegisteredPatient('PNA', '',
            unitId, searchByList[0].id);
        await dashboardController.searchByDropDownList();
        if (dashboardController.searchByModel?.data?.isNotEmpty ?? false) {
          dropDownValue = dashboardController.searchByModel!.data!.first;
        }
      }
    } catch (e, stacktrace) {
      debugPrint("Error in checkInternetAndLoadData: $e");
      debugPrint(stacktrace.toString());
    } finally {
      dashboardController.isLoading = false;
      dashboardController.refreshUi();
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
        backgroundColor:AppColor.primaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),  // adjust as needed
          ),
        ),
        title:  CustomText(
          text: 'Registered Patients',
          fontSize: 18.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.white,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.off(const InstituteWiseDashboardScreen());
            },
            child: Image.asset('assets/arrow-left.png',color: Colors.white,)),
        actions: [
          // InkWell(
          //   onTap: () {
          //     showModalBottomSheet(
          //       isDismissible: false,
          //       isScrollControlled: true,
          //       context: context,
          //       builder: (BuildContext context) {
          //         return StatefulBuilder(
          //             builder: (BuildContext context, StateSetter setState) {
          //           return Container(
          //             margin: EdgeInsets.only(
          //                 bottom: MediaQuery.of(context).viewInsets.bottom),
          //             padding:  EdgeInsets.symmetric(
          //                 vertical: 14.h, horizontal: 10.w),
          //             decoration: BoxDecoration(
          //               color: const Color(0xffF8F8F8),
          //               borderRadius: BorderRadius.circular(6),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withValues(alpha: 0.1),
          //                   spreadRadius: 2,
          //                   blurRadius: 4,
          //                   offset: const Offset(
          //                       0, 0.5), // changes position of shadow
          //                 ),
          //               ],
          //             ),
          //             child: Column(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                      CustomText(
          //                       text: 'Select Scheme',
          //                       fontSize: 18.sp,
          //                       fontFam: 'Lato',
          //                       fontWeight: FontWeight.w500,
          //                       textColor: Colors.black,
          //                       textAlign: TextAlign.start,
          //                     ),
          //                     InkWell(
          //                         onTap: () {
          //                           Get.back();
          //                         },
          //                         child: Image.asset(
          //                           "assets/cancel.png",
          //                           width: 24.w,
          //                           height: 24.h,
          //                           color: AppColor.primaryBackgroundColor,
          //                         )),
          //                   ],
          //                 ),
          //                 RadioListTile<RadioButtons>(
          //                   title: const Text('Existing ABHA ID'),
          //                   value: RadioButtons.existingAbhaId,
          //                   groupValue: radioButtons,
          //                   activeColor: AppColor.primaryBackgroundColor,
          //                   onChanged: (RadioButtons? value) {
          //                     setState(() {
          //                       radioButtons = value;
          //                     });
          //                   },
          //                 ),
          //                 RadioListTile<RadioButtons>(
          //                   title: const Text('Create new ABHA ID'),
          //                   value: RadioButtons.newAbhaId,
          //                   groupValue: radioButtons,
          //                   activeColor: AppColor.primaryBackgroundColor,
          //                   onChanged: (RadioButtons? value) {
          //                     setState(() {
          //                       radioButtons = value;
          //                     });
          //                   },
          //                 ),
          //                 RadioListTile<RadioButtons>(
          //                   title: const Text(
          //                       'Demographic Information based authentication'),
          //                   value: RadioButtons.demoInfoBasedAuth,
          //                   groupValue: radioButtons,
          //                   activeColor: AppColor.primaryBackgroundColor,
          //                   onChanged: (RadioButtons? value) {
          //                     setState(() {
          //                       radioButtons = value;
          //                     });
          //                   },
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     CustomButton(
          //                       buttonText: 'Cancel',
          //                       path: 'assets/cancel.png',
          //                       callB: () {
          //                         Get.back();
          //                       },
          //                       buttonWidth: 100,
          //                       primColor: AppColor.red,
          //                       secColor: AppColor.red,
          //                       textColor: Colors.white,
          //                       iconColor: Colors.white,
          //                     ),
          //                     const SizedBox(
          //                       width: 20,
          //                     ),
          //                     CustomButton(
          //                       buttonText: 'Next',
          //                       path: 'assets/next.png',
          //                       callB: () {
          //                         // Get.back();
          //                         // if (radioButtons ==
          //                         //     RadioButtons.newRegistration) {
          //                         //   Get.to(() => const NewRegistration(isViewPatient: false, pageTitle: 'New Registration',));
          //                         // }
          //                       },
          //                       buttonWidth: 100,
          //                       primColor: AppColor.primaryBackgroundColor,
          //                       secColor: AppColor.secondaryColor,
          //                       textColor: Colors.white,
          //                       iconColor: Colors.white,
          //                     )
          //                   ],
          //                 )
          //               ],
          //             ),
          //           );
          //         });
          //       },
          //     );
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(right: 8),
          //     child: Image.asset("assets/user-add.png"),
          //   ),
          // ),
          // const SizedBox(
          //   width: 4,
          // ),
          InkWell(
            onTap: () {
              dropDownValue2 = searchByList[0];
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
                      padding:  EdgeInsets.symmetric(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               CustomText(
                                      text: "Search",
                                      fontSize: 16.sp,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start)
                                  .paddingSymmetric(vertical: 4.h),
                              InkWell(
                                  onTap: () {
                                    dropDownValue = null;
                                    dashboardController.valueController.text =
                                        "";
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    "assets/cancel.png",
                                    width: 24.w,
                                    height: 24.h,
                                    color: AppColor.primaryBackgroundColor,
                                  )),
                            ],
                          ),
                           SizedBox(
                            height: 4.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               CustomText(
                                      text: "Search By",
                                      fontSize: 16.sp,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.normal,
                                      textColor: const Color(0xff515151),
                                      textAlign: TextAlign.start)
                                  .paddingOnly(top: 10.h, bottom: 4.h),
                              Container(
                                // width: 180,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFE1E1E1)),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                padding:  EdgeInsets.symmetric(
                                    horizontal: 12.w),
                                child: DropdownButton<SearchByPatient>(
                                  isExpanded: true,
                                  value: dropDownValue2,
                                  hint: const Text("select"),
                                  onChanged: (SearchByPatient? newValue) {
                                    dropDownValue2 = newValue!;
                                    setState(() {});
                                  },
                                  items: searchByList
                                      .map<DropdownMenuItem<SearchByPatient>>(
                                          (SearchByPatient value) {
                                    return DropdownMenuItem<SearchByPatient>(
                                      value: value,
                                      child: Text(value.searchBy),
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
                           SizedBox(
                            height: 4.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               CustomText(
                                      text: "Type",
                                      fontSize: 16.sp,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.normal,
                                      textColor: const Color(0xff515151),
                                      textAlign: TextAlign.start)
                                  .paddingOnly(top: 10, bottom: 4),
                              Container(
                                // width: 180,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:  Color(0xFFE1E1E1)),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                padding:  EdgeInsets.symmetric(
                                    horizontal: 12.sp),
                                child: DropdownButton<SearchedData>(
                                  isExpanded: true,
                                  value: dropDownValue,
                                  hint: const Text("select"),
                                  onChanged: (SearchedData? newValue) {
                                    dropDownValue = newValue!;
                                    setState(() {});
                                  },
                                  items: dashboardController.searchByModel?.data
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
                           SizedBox(
                            height: 4.h,
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
                          ).paddingOnly(top: 12.h, bottom: 4.h),
                          TextField(
                              inputFormatters: [UpperCaseTextFormatter()],
                              controller: dashboardController.valueController,
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
                                    final unitIdStr = userData?['unitId']?.toString() ?? '0';
                                    final unitId = int.tryParse(unitIdStr) ?? 0;
                                    dashboardController.searchRegisteredPatient(
                                        dropDownValue?.lookupDetValue ?? "",
                                        dashboardController
                                            .valueController.text,
                                        unitId,
                                        dropDownValue2?.id ?? "");
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
              child: Image.asset("assets/filter-line.png",color:Colors.white,),
            ),
          ),
           SizedBox(
            width: 2.w,
          ),
        ],
      ),
      body:
      GetBuilder<RegistrationController>(
          init: RegistrationController(),
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(child: RegisteredPatientsShimmer());
            }
            final patientList = controller.alreadyRegisteredPatient?.data ?? [];
            if (patientList.isEmpty) {
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

            return  RegisteredPatientCardList(
                        patientList:
                            controller.alreadyRegisteredPatient?.data ?? [],
                        cardItemDetailsList: cardItemDetailsList,
                        isSecondColumnVisiable: true,
                        path1: "assets/calendar.png",
                        path2: "assets/eye.png",
                        path3: "assets/edit.png",
                        path4: "assets/file-list.png",
                        path5: "assets/camera.png",
                        isfromPredialysis: false,
                        callB1: (index) async {
                          await controller.checkScrutinyApproval(controller
                              .alreadyRegisteredPatient!
                              .data![index]
                              .patientId);
                          if (controller.scrutinyType == "NEPHROLOGIST" &&
                              controller.approvalStat == "Approved") {
                            Get.to(() => BookAppointmentScreen(
                                  patientData: controller
                                      .alreadyRegisteredPatient!.data![index],
                                  isFromSchedular: false,
                                ));
                          } else {
                            controller.scrutinyType ??= "Undefined ";
                            CustomPopup.showSuccessDialog(() {
                              Get.back();
                            }, "",
                                "Approval From ${controller.scrutinyType} Is In Process");
                          }
                        },
                        callB2: (index) {
                          Get.to(() => NewRegistration(
                                isViewPatient: true,
                                patientData: controller
                                    .alreadyRegisteredPatient!.data![index],
                                pageTitle: 'View Patient Details',
                                isEdit: false,
                              ));
                        },
                        callB3: (index) {
                          Get.to(() => NewRegistration(
                                isViewPatient: false,
                                patientData: controller
                                    .alreadyRegisteredPatient!.data![index],
                                pageTitle: 'Edit Patient Details',
                                isEdit: true,
                              ));
                        },
                        callB4: (index) {
                          Get.to(() => PatientHistorySchedular(
                                patientData: controller
                                    .alreadyRegisteredPatient!.data![index],
                              ));
                        },
                        callB5: (index) {},
                      );
          }),

    ) : InternetIssue(
    onRetryPressed: () async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
    },
    );
  }
}

enum RadioButtons {
  existingAbhaId,
  newAbhaId,
  demoInfoBasedAuth,
  // newRegistration
}

class SearchByPatient {
  String id;
  String searchBy;

  SearchByPatient(this.id, this.searchBy);
}
