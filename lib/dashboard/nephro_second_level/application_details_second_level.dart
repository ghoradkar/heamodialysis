import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/first_level_controller.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/model/first_level_scrutiny_approval_list.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/model/patient_details_model.dart';
import 'package:heamodialysis/dashboard/nephro_second_level/second_level_service_description_tab.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/screens/new_registration.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';

class ApplicationDetailsSecondLevel extends StatefulWidget {
  final FirstLevelTmCmScrutinyBean? patient;

  const ApplicationDetailsSecondLevel({super.key, this.patient});

  @override
  State<ApplicationDetailsSecondLevel> createState() =>
      _ApplicationDetailsSecondLevelState();
}

class _ApplicationDetailsSecondLevelState
    extends State<ApplicationDetailsSecondLevel>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final FirstLevelController firstLevelScrutinyController =
      Get.find<FirstLevelController>();

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
    firstLevelScrutinyController.levelSecondList.clear();
    firstLevelScrutinyController.levelOneAnswerList.clear();
    checkInternetAndLoadData();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
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
      await firstLevelScrutinyController.getQuestions(
          widget.patient?.srnMoveId ?? 0,
          widget.patient?.scrutinyLevelDetId ?? 0,
          int.parse(userData['unitId'].toString()));

      // await firstLevelScrutinyController.getQuestions(
      //     widget.patient?.srnMoveId ?? 0,
      //     widget.patient?.scrutinyLevelDetId ?? 0,
      //     int.parse(userData['unitId']));

      await firstLevelScrutinyController.getAnswers(
        widget.patient?.srnId ?? 0,
      );
      await firstLevelScrutinyController
          .getPatientDet(widget.patient?.patientId);
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  CustomText(
          text: 'Patient Details',
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
                  pageTitle: "View Application",
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
                        text: "View Application",
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
            return hasInternet
                ? controller.isLoading
                    ?  Center(child: buildShimmerLoader())
                    : Column(
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
                              buildTab(0, "Application Details"),
                              buildTab(1, "Service Description"),
                            ],
                          ).paddingOnly(top: 14.h, bottom: 10.h),
                          Expanded(
                              child: TabBarView(
                            controller: tabController,
                            children: [
                              firstTab(),
                              SecondLevelServiceDescriptionTab(
                                patient: widget.patient,
                              )
                            ],
                          )),
                        ],
                      ).paddingOnly(left: 9.w, right: 9.w)
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }

  Widget firstTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 240.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.4), // Shadow color
                  spreadRadius: 1, // How much the shadow should spread
                  blurRadius: 4, // How soft the shadow should appear
                  offset:
                      const Offset(1, 1), // The position of the shadow (x, y)
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
                        labelText: 'Application Number',
                        hintText: 'Application Number',
                        isRequired: false,
                        initialValue: widget.patient?.appNumber,
                        fillColor: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    // const SizedBox(height: 8),
                    Expanded(
                      child: CustomTextField(
                        onChanged: (value) async {},
                        maxLines: 1,
                        isReadOnly: true,
                        keyBoardType: TextInputType.text,
                        labelText: 'Service Name',
                        hintText: 'Service Name',
                        isRequired: false,
                        initialValue: widget.patient?.serviceName,
                        fillColor: Colors.white,
                        fontSize: 16.sp,
                      ),
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
                        labelText: 'District Name',
                        hintText: 'District Name',
                        isRequired: false,
                        initialValue: widget.patient?.distName,
                        fillColor: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    // const SizedBox(height: 8),
                    Expanded(
                      child: CustomTextField(
                        onChanged: (value) async {},
                        maxLines: 1,
                        isReadOnly: true,
                        keyBoardType: TextInputType.text,
                        labelText: 'Institute Name',
                        hintText: 'Institute Name',
                        isRequired: false,
                        initialValue: widget.patient?.unitName,
                        fillColor: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).paddingOnly(top: 10.h),
        ],
      ),
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
                text: 'Patient ID : ',
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
                text: 'Patient Name  : ',
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
                      text: 'Age :',
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
                      text: 'Gender :',
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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Row(
                  children: [
                     CustomText(
                      text: 'Viral Load Status :',
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
                ),
              ),
              // Flexible(
              //   flex: 1,
              //   child: Row(
              //     children: [
              //        CustomText(
              //         text: 'Blood Group :',
              //         fontSize: 12.sp,
              //         fontFam: 'Lato',
              //         fontWeight: FontWeight.w400,
              //         textColor: Colors.black,
              //         textAlign: TextAlign.start,
              //       ),
              //       CustomText(
              //         text: patient?.bloodGroup != null
              //             ? patient!.bloodGroup!
              //             : "",
              //         fontSize: 12.sp,
              //         fontFam: 'Lato',
              //         fontWeight: FontWeight.w400,
              //         textColor: Colors.grey,
              //         textAlign: TextAlign.start,
              //       ),
              //     ],
              //   ),
              // )
            ],
          ).paddingOnly(top: 2.h, bottom: 1.h),
          Row(
            children: [
              CustomText(
                text: 'Blood Group :',
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
                            text: 'Height :',
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
                            text: 'Weight :',
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
                            text: 'Date Of Registration :',
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
                            text: 'Nephrologist Name :',
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
                            text: 'Relative Name :',
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
                            text: 'Relative Contact :',
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
