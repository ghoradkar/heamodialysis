import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/screen/add_dialysis_event.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/controller/dialysis_event_controller.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_list_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/incedent_type_model.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/patient_card_details.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class DialysisEventDetails extends StatefulWidget {
  final DialysisEventListModel dialysisEventDet;

  // final List<HistoryData>? historyList;

  const DialysisEventDetails({super.key, required this.dialysisEventDet});

  @override
  State<DialysisEventDetails> createState() => _DialysisEventDetailsState();
}

class _DialysisEventDetailsState extends State<DialysisEventDetails> {
  bool isExpanded = false;

  final DialysisEventController dialysisEventController =
      Get.find<DialysisEventController>();
  final NewRegistrationController newRegistrationController =
  Get.put(NewRegistrationController());
  bool hasInternet = true;

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
    dialysisEventController.update();
    if (hasInternet) {
      await newRegistrationController
          .viewPatientData(widget.dialysisEventDet.patientId);

      await dialysisEventController.getEventPatientDetails(
          widget.dialysisEventDet.treatmentId.toString(),
          widget.dialysisEventDet.patientId.toString());
      await dialysisEventController
          .getEventDetailsList(widget.dialysisEventDet.patientId.toString());

      ///todo
      // for (int i = 0;
      //     i < dialysisEventController.incidentList.length;
      //     i++) {
      //   await dialysisEventController.getIncidentSubType(
      //       dialysisEventController.dialysisPatientEventDetList[i].lookupDetIdIncidentSubType);
      // }

      // await dialysisEventController.searchByDropDownList();
      // if (dialysisEventController.searchByModel?.data != null ||
      //     dialysisEventController.searchByModel!.data!.isNotEmpty) {
      //   dropDownValue = dialysisEventController.searchByModel!.data!.first;
      //   dialysisEventController.refreshUi();
      // }
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
          text: 'Dialysis Event Details',
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
                    dialysisEventController.cardList.clear();

                    Get.to(() => AddDialysisEvent(
                          isFrom: true,
                          dialysisEventDet: dialysisEventController
                                  .dialysisPatientEventDetList.isNotEmpty
                              ? dialysisEventController.dialysisPatientEventDetList[0]
                              : null,
                      patientDet: widget.dialysisEventDet,
                        ));
                  },
                  child: Image.asset('assets/add-pre-dialysis.png'))
              .paddingOnly(right: 4.w)
        ],
      ),
      body: GetBuilder<DialysisEventController>(
          init: null,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ?  Center(child: buildShimmerLoader())
                    : Column(
                        children: [
                          PatientCardDetails(
                            isExpand: (value) {
                              isExpanded = value;
                              setState(() {});
                            },
                            isExpanded: isExpanded,
                            isFromAddPredialysis: true,
                            // patientId:
                            //     widget.dialysisEventDet.patientId.toString(),
                            // patientName:
                            //     widget.dialysisEventDet.fName.toString(),
                            // gender: widget.dialysisEventDet.gender ?? "",
                            // refDoc: "",
                            // age: widget.dialysisEventDet.age.toString(),
                            refBy: "",
                            schemaAdopted: '',
                            patientDetails: newRegistrationController.viewPatientModel,
                          ).paddingSymmetric(vertical: 10.h),
                          controller.dialysisPatientEventDetList.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                      itemCount: controller
                                          .dialysisPatientEventDetList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[50],
                                            // borderRadius: BorderRadius.circular(10),
                                            // border: Border.all(color: AppColor.borderColor)
                                          ),
                                          child: Stack(
                                            children: [
                                              Column(
                                                children: [
                                                   SizedBox(height: 20.h),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[50],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: AppColor
                                                                .borderColor)),
                                                    padding:
                                                         EdgeInsets.symmetric(
                                                            vertical: 10.h,horizontal: 10.w),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .cardList
                                                                  .clear();
                                                              Get.to(() => AddDialysisEvent(
                                                                  isFrom: false,
                                                                  dialysisEventDet:
                                                                      dialysisEventController
                                                                              .dialysisPatientEventDetList[
                                                                          0],
                                                                patientDet: widget.dialysisEventDet,

                                                              ));
                                                            },
                                                            child: Image.asset(
                                                              'assets/edit.png',
                                                              color: AppColor
                                                                  .secondaryColor,
                                                              width: 20.w,
                                                              height: 20.h,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                             CustomText(
                                                                text:
                                                                    "Center :",
                                                                fontSize: 14.sp,
                                                                fontFam: "Lato",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start),
                                                            CustomText(
                                                                // text: cardData.dialyserBarcodeSerialNo ?? '',
                                                                text: controller
                                                                        .dialysisPatientEventDetList[
                                                                            index]
                                                                        .unitName ??
                                                                    "",
                                                                fontSize: 14.sp,
                                                                fontFam: "Lato",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                 CustomText(
                                                                    text:
                                                                        "Date :",
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontFam:
                                                                        "Lato",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start),
                                                                CustomText(
                                                                    // text: formatDateFromTimestamp(cardData.dialysisStartDate) ?? "",
                                                                    text: formatDate(controller
                                                                        .dialysisPatientEventDetList[
                                                                            index]
                                                                        .date),
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontFam:
                                                                        "Lato",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                 CustomText(
                                                                    text:
                                                                        "Time :",
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontFam:
                                                                        "Lato",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start),
                                                                CustomText(
                                                                    // text: formatDateFromTimestamp(cardData.dialysisStartDate) ?? "",
                                                                    text: formatTime(controller
                                                                        .dialysisPatientEventDetList[
                                                                            index]
                                                                        .date),
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontFam:
                                                                        "Lato",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                             CustomText(
                                                                text:
                                                                    "Dialysis Incident Type :",
                                                                fontSize: 14.sp,
                                                                fontFam: "Lato",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start),
                                                            CustomText(
                                                                // text: cardData.dialyserRemarks ?? "",
                                                                text: controller
                                                                        .incidentList
                                                                        .firstWhere((e) => e.lookupDetValue == controller.dialysisPatientEventDetList[index].lookupDetEng,
                                                                            orElse: () =>
                                                                                IncedentTypeModel())
                                                                        .lookupDetValue ??
                                                                    '',
                                                                fontSize: 14.sp,
                                                                fontFam: "Lato",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                             CustomText(
                                                                text:
                                                                    "Dialysis Incident Sub Type :",
                                                                fontSize: 14.sp,
                                                                fontFam: "Lato",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start),
                                                            Expanded(
                                                              child: CustomText(
                                                                  // text: cardData.dialyserRemarks ?? "",
                                                                  text: controller
                                                                          .incidentSubTypeList
                                                                          .firstWhere((e) => e.lookupDetValue == controller.dialysisPatientEventDetList[index].incidentSubTypeName,
                                                                              orElse: () =>
                                                                                  IncedentTypeModel())
                                                                          .lookupDetValue ??
                                                                      '',
                                                                  fontSize: 14.sp,
                                                                  fontFam:
                                                                      "Lato",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                             CustomText(
                                                                text:
                                                                    "Event Description :",
                                                                fontSize: 14.sp,
                                                                fontFam: "Lato",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start),
                                                            Expanded(
                                                              child: CustomText(
                                                                  // text: cardData.dialyserRemarks ?? "",
                                                                  text: controller
                                                                          .dialysisPatientEventDetList[
                                                                              index]
                                                                          .eventDescription ??
                                                                      "",
                                                                  fontSize: 14.sp,
                                                                  fontFam:
                                                                      "Lato",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                             CustomText(
                                                                text:
                                                                    "Action Taken :",
                                                                fontSize: 14.sp,
                                                                fontFam: "Lato",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start),
                                                            CustomText(
                                                                // text: cardData.dialyserRemarks ?? "",
                                                                text: controller
                                                                        .dialysisPatientEventDetList[
                                                                            index]
                                                                        .actionTaken ??
                                                                    "",
                                                                fontSize: 14.sp,
                                                                fontFam: "Lato",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Positioned(
                                                top: 0.8,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 24.w,
                                                  height: 24.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        AppColor
                                                            .primaryBackgroundColor,
                                                        AppColor.secondaryColor
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    (index + 1).toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              :  Center(
                                  child: CustomText(
                                      text: "No Data Found",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.center),
                                )
                        ],
                      ).paddingSymmetric(horizontal: 4)
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }

  String formatDate(String? dateTimeStr) {
    if (dateTimeStr != null) {
      DateTime dateTime = DateTime.parse(dateTimeStr);
      // Format the date as "dd-MM-yyyy"
      return DateFormat("dd-MM-yyyy").format(dateTime);
    } else {
      return "";
    }
  }

  String formatTime(String? dateTimeStr) {
    if (dateTimeStr != null) {
      DateTime dateTime = DateTime.parse(dateTimeStr);
      // Format the time as "hh:mm:ss"
      return DateFormat("HH:mm:ss").format(dateTime);
    } else {
      return "";
    }
  }
}
