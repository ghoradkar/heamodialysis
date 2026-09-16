import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/controller/first_level_controller.dart';
import 'package:heamodialysis/dashboard/screen/nephro_first_level/first_level_service_description_tab.dart';
import 'package:heamodialysis/dashboard/model/first_level_scrutiny_approval_list.dart';
import 'package:heamodialysis/dashboard/model/patient_details_model.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/screen/new_registration.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

import '../../../utils/status_update_screen.dart';
import '../../../widgets/custom_shimmer_loader.dart';



class ApplicationDetailsFirstLevel extends StatefulWidget {
  final FirstLevelTmCmScrutinyBean? patient;

  const ApplicationDetailsFirstLevel({super.key, this.patient});

  @override
  State<ApplicationDetailsFirstLevel> createState() =>
      _ApplicationDetailsFirstLevelState();
}

class _ApplicationDetailsFirstLevelState
    extends State<ApplicationDetailsFirstLevel>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final FirstLevelController firstLevelScrutinyController =
      Get.find<FirstLevelController>();
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;





  bool hasInternet = true;
  bool isExpanded = false;
  var userData;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
      // firstLevelScrutinyController.update();
    });
    getUserData();
    firstLevelScrutinyController.levelOneList.clear();
    checkInternetAndLoadData();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    super.initState();
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

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    firstLevelScrutinyController.update();
    if (hasInternet) {
      await firstLevelScrutinyController
          .getPatientDet(widget.patient?.patientId);
      await firstLevelScrutinyController.getQuestions(
          widget.patient?.srnMoveId ?? 0,
          widget.patient?.scrutinyLevelDetId ?? 0,
          int.parse(userData['unitId'].toString()));
      // await firstLevelScrutinyController.getQuestions(
      //     widget.patient?.srnMoveId ?? 0,
      //     widget.patient?.scrutinyLevelDetId ?? 0,
      //     int.parse(userData['unitId']));
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }
  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable ? Scaffold(
      appBar: AppBar(
        title:  CustomText(
          text: context.l10n.patientDetailsTitle,
          fontSize: 18.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset('assets/arrow-left.png')),
        actions: [
          InkWell(
            onTap: () {
              PatientData patientDet = PatientData(
                  patientName: widget.patient?.appName,
                  patientId: widget.patient?.patientId);

              Get.to(NewRegistration(
                  patientData: patientDet,
                  isViewPatient: true,
                  pageTitle: context.l10n.viewApplication,
                  isEdit: false));
            },
            child: Container(
                    padding:  EdgeInsets.symmetric(horizontal: 4.w),
                    alignment: Alignment.center,
                    width: 120.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          AppColor.primaryBackgroundColor,
                          AppColor.secondaryColor
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child:  CustomText(
                        text: context.l10n.viewApplication,
                        fontSize: 12.sp,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.white,
                        textAlign: TextAlign.center))
                .paddingOnly(right: 4.w),
          )
        ],
      ),
      body: GetBuilder<FirstLevelController>(
          init: firstLevelScrutinyController,
          builder: (controller) {
            if (controller.isLoading) {
              return PatientDetails();
            }
            if (controller.patientData?.data == null || controller.patientData!.data!.isEmpty) {
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
            return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          PatientCardDetails(
                            patient: controller.patientData?.data?.first,
                            applicationDetails: widget.patient,
                            patientName: '',
                            isExpanded: isExpanded,
                            isExpand: (value) {
                              isExpanded = value;
                              setState(() {});
                            },
                          ),
                          TabBar(
                            controller: tabController,
                            dividerColor: Colors.transparent,
                            indicatorColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            indicatorPadding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            tabs: [
                              buildTab(0, context.l10n.tabApplicationDetails),
                              buildTab(1, context.l10n.tabServiceDescription),
                            ],
                          ).paddingOnly(top: 14.h, bottom: 10.h),
                          Expanded(
                              child: TabBarView(
                            controller: tabController,
                            children: [
                              firstTab(),
                               FirstLevelServiceDescriptionTab(patient: widget.patient,)
                            ],
                          )),
                        ],
                      ).paddingOnly(left: 9.w, right: 9.w);
          }),
    ) : InternetIssue(
    onRetryPressed: () async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
    },
    );
  }

  Widget firstTab() {
    return SingleChildScrollView(
      child: Container(
       // height: 330.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.4), // Shadow color
              spreadRadius: 1, // How much the shadow should spread
              blurRadius: 4, // How soft the shadow should appear
              offset: const Offset(1, 1), // The position of the shadow (x, y)
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      onChanged: (value) async {},
                      maxLines: 1,
                      isReadOnly: true,
                      keyBoardType: TextInputType.text,
                      labelText: context.l10n.colApplicationNumber,
                      hintText: context.l10n.colApplicationNumber,
                      isRequired: false,
                      initialValue: widget.patient?.appNumber,
                      fillColor: Colors.white, fontSize: 14.sp,),
                ),
                 SizedBox(width: 8.w),
                Expanded(
                  child: CustomTextField(
                      onChanged: (value) async {},
                      maxLines: 1,
                      isReadOnly: true,
                      keyBoardType: TextInputType.text,
                      labelText: context.l10n.colServiceName,
                      hintText: context.l10n.colServiceName,
                      isRequired: false,
                      initialValue: widget.patient?.serviceName,
                      fillColor: Colors.white, fontSize: 14.sp,),
                ),
              ],
            ),
             SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      onChanged: (value) async {},
                      maxLines: 1,
                      isReadOnly: true,
                      keyBoardType: TextInputType.text,
                      labelText: context.l10n.colDistrictName,
                      hintText: context.l10n.colDistrictName,
                      isRequired: false,
                      initialValue: widget.patient?.distName,
                      fillColor: Colors.white, fontSize: 14.sp,),
                ),
                 SizedBox(width: 8.w),
                Expanded(
                  child: CustomTextField(
                      onChanged: (value) async {},
                      maxLines: 1,
                      isReadOnly: true,
                      keyBoardType: TextInputType.text,
                      labelText: context.l10n.colInstituteName,
                      hintText: context.l10n.colInstituteName,
                      isRequired: false,
                      initialValue: widget.patient?.unitName,
                      fillColor: Colors.white, fontSize: 14.sp,),
                ),
              ],
            ),
          ],
        ),
      ).paddingOnly(top: 10.h, bottom: 390.h, left: 0, right: 0),
    );
  }

  Widget buildTab(int index, String text) {
    bool isSelected = tabController.index == index;
    return Container(
      alignment: Alignment.center,
      width: 210.w,
      height: 50.h,
      padding:  EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
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
          borderRadius: setBorderRadiusIndexWise(index),
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

  setBorderRadiusIndexWise(index) {
    if (index == 0) {
      return const BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
    } else if (index == 1) {
      return const BorderRadius.only(
          topRight: Radius.circular(10), bottomRight: Radius.circular(10));
    }
  }
}

class PatientCardDetails extends StatelessWidget {
  final FirstLevelTmCmScrutinyBean? applicationDetails;
  final PatientDataDet? patient;
  final String patientName;
  final bool? isExpanded;
  final Function? isExpand;

  const PatientCardDetails({
    super.key,
    required this.patientName,
    this.isExpand,
    this.isExpanded,
    this.applicationDetails,
    this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              AppColor.primaryBackgroundColor.withValues(alpha: 0.2),
              AppColor.secondaryColor.withValues(alpha: 0.2)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          )),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding:  EdgeInsets.symmetric(vertical: 4.h,horizontal: 4.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                ),
              ),
               SizedBox(
                width: 10.w,
              ),
               CustomText(
                text: "${context.l10n.colPatientId} : ",
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.black,
                textAlign: TextAlign.start,
              ),
              CustomText(
                text: applicationDetails?.patientId != null
                    ? applicationDetails!.patientId.toString()
                    : '',
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.grey,
                textAlign: TextAlign.start,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    if (isExpand != null) {
                      isExpand!(!isExpanded!);
                    }
                  },
                  icon: isExpanded == true
                      ? const Icon(Icons.arrow_circle_up_outlined)
                      : const Icon(Icons.arrow_circle_down))
            ],
          ).paddingOnly(top: 2.h),
          Row(
            children: [
               CustomText(
                text: "${context.l10n.colPatientName}  : ",
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.black,
                textAlign: TextAlign.start,
              ),
              CustomText(
                text: applicationDetails?.appName ?? "",
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.grey,
                textAlign: TextAlign.start,
              )
            ],
          ).paddingOnly(bottom: 1.h),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                     CustomText(
                      text: "${context.l10n.commonAge} :",
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: patient?.age != null ? patient!.age.toString() : "",
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                     CustomText(
                      text: "${context.l10n.commonGender} :",
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: patient?.gender != null ? patient!.gender! : "",
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
            ],
          ).paddingOnly(top: 2.h, bottom: 1.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "${context.l10n.colBloodGroup} : ",
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.black,
                textAlign: TextAlign.start,
              ),
              CustomText(
                text: patient?.bloodGroup != null
                    ? patient!.bloodGroup!
                    : "",
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.grey,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Row(
            children: [
              CustomText(
                text: "${context.l10n.colViralLoadStatus} : ",
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.black,
                textAlign: TextAlign.start,
              ),
              CustomText(
                text: patient?.viralLocalStatus != null
                    ? patient!.viralLocalStatus!
                    : "",
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.grey,
                textAlign: TextAlign.start,
              ),
            ],
          ).paddingOnly(top: 2.h, bottom: 1.h),
          Visibility(
            visible: isExpanded == true,
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                           CustomText(
                            text: "${context.l10n.colHeight} :",
                            fontSize: 12.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          CustomText(
                            text: patient?.height != null
                                ? patient!.height.toString()
                                : "",
                            fontSize: 12.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                           CustomText(
                            text: "${context.l10n.colWeight} :",
                            fontSize: 12.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          CustomText(
                            text: patient?.weight != null
                                ? patient!.weight.toString()
                                : "",
                            fontSize: 12.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(top: 2.h, bottom: 1.h),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                           CustomText(
                            text: "${context.l10n.colDateOfRegistration} :",
                            fontSize: 12.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          CustomText(
                            text: patient?.dateOfAdminssion != null
                                ? dateConversion(patient!.dateOfAdminssion!)
                                : "",
                            fontSize: 12.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                           CustomText(
                            text: "${context.l10n.colNephrologistName} :",
                            fontSize: 12.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          CustomText(
                            text: patient?.nephrologistName != null
                                ? patient!.nephrologistName!
                                : "",
                            fontSize: 12.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(top: 2.h, bottom: 1.h),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                           CustomText(
                            text: "${context.l10n.colRelativeName} :",
                            fontSize: 12.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          CustomText(
                            text: patient?.relativeName != null
                                ? patient!.relativeName!
                                : "",
                            fontSize: 12.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                           CustomText(
                            text: "${context.l10n.colRelativeContact} :",
                            fontSize: 12.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          CustomText(
                            text: patient?.relativeNo != null
                                ? patient!.relativeNo!
                                : "",
                            fontSize: 12.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(top: 2.h, bottom: 1.h)
              ],
            ),
          )
        ],
      ),
    );
  }

  dateConversion(dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the DateTime object to only show the date
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
}
