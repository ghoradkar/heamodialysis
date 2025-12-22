import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/discharge_form/session_end_controller.dart';
import 'package:heamodialysis/discharge_form/model/discharge_list.dart';
import 'package:heamodialysis/discharge_form/model/discharge_patient_details.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../widgets/custom_shimmer_loader.dart';

class SessionEndFormDetails extends StatefulWidget {
  final DischargeListModel dialysisEventDet;
  final dynamic userData;

  const SessionEndFormDetails(
      {super.key, required this.dialysisEventDet, this.userData});

  @override
  State<SessionEndFormDetails> createState() => _SessionEndFormDetailsState();
}

class _SessionEndFormDetailsState extends State<SessionEndFormDetails> {
  bool isExpanded = false;

  final SessionEndController dischargeController =
      Get.find<SessionEndController>();

  bool hasInternet = true;

  @override
  void initState() {
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
    dischargeController.update();
    if (hasInternet) {
      dischargeController.termsCondition?.isSelected = false;
      await dischargeController
          .getPatientDetails(widget.dialysisEventDet.patientId.toString());

      await dischargeController.getPostFlag(
          widget.dialysisEventDet.patientId.toString(),
          widget.dialysisEventDet.treatmentId.toString());
      setCheckboxStates();
    }
  }

  void setCheckboxStates() {
    List<String> items = dischargeController.dischargeFlagString.split('#');

    // Ensure the list has at least 8 items
    if (items.length >= 8) {
      int first = int.tryParse(items[5]) ?? 0;
      int second = int.tryParse(items[6]) ?? 0;
      int third = int.tryParse(items[7]) ?? 0;
      setState(() {
        // Set checkbox states based on conditions
        dischargeController.predialysis?.isSelected = items[4].isNotEmpty;
        dischargeController.postDialysis?.isSelected = items[0].isNotEmpty;
        dischargeController.event?.isSelected = items[2].isNotEmpty;
        dischargeController.doctorDesk?.isSelected = first > 0;
        dischargeController.nephroDesk?.isSelected = second > 0;
        dischargeController.dietician?.isSelected = third > 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Discharge',
          fontSize: 18.0,
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
      ),
      body: GetBuilder<SessionEndController>(
          init: dischargeController,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                ?  Center(child: buildShimmerLoader())
                    : Column(
                        children: [
                          DischargePatientCardDetails(
                            patientDetails:
                                controller.dischargePatientDet?.listReg?[0],
                            isExpand: (value) {
                              isExpanded = value;
                              setState(() {});
                            },
                            isExpanded: isExpanded,
                            patientId: controller.dischargePatientDet
                                        ?.listReg?[0].patientId !=
                                    null
                                ? controller
                                    .dischargePatientDet!.listReg![0].patientId
                                    .toString()
                                : "",
                            patientName: controller.dischargePatientDet
                                        ?.listReg?[0].fName !=
                                    null
                                ? controller.dischargePatientDet!.listReg![0]
                                        .fName! +
                                    controller
                                        .dischargePatientDet!.listReg![0].lName!
                                : "",
                            age: controller
                                        .dischargePatientDet?.listReg?[0].age !=
                                    null
                                ? controller
                                    .dischargePatientDet!.listReg![0].age
                                    .toString()
                                : "",
                            gender: controller.dischargePatientDet?.listReg?[0]
                                        .gender !=
                                    null
                                ? controller
                                    .dischargePatientDet!.listReg![0].gender!
                                : "",
                            dialysisDate:
                                widget.dialysisEventDet.dialysisDate ?? "",
                            // patientDetails: widget.preDialysisData,
                          ).paddingSymmetric(vertical: 10),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              // borderRadius: BorderRadius.circular(10),
                              // border: Border.all(color: AppColor.borderColor)
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColor.borderColor)),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                activeColor: AppColor
                                                    .primaryBackgroundColor,
                                                value: controller
                                                    .predialysis?.isSelected,
                                                // Boolean value for checkbox state
                                                onChanged: (bool? newValue) {
                                                  // controller.predialysis
                                                  //     ?.isSelected = newValue;
                                                  // setState(() {});
                                                },
                                              ),
                                              CustomText(
                                                  text: controller.predialysis
                                                          ?.checkTitle ??
                                                      "",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: Colors.black,
                                                  textAlign: TextAlign.start),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                activeColor: AppColor
                                                    .primaryBackgroundColor,
                                                value: controller
                                                    .postDialysis?.isSelected,
                                                // Boolean value for checkbox state
                                                onChanged: (bool? newValue) {
                                                  // controller.postDialysis
                                                  //     ?.isSelected = newValue;
                                                  // setState(() {});
                                                },
                                              ),
                                              CustomText(
                                                  text: controller.postDialysis
                                                          ?.checkTitle ??
                                                      "",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: Colors.black,
                                                  textAlign: TextAlign.start),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                activeColor: AppColor
                                                    .primaryBackgroundColor,
                                                value: controller
                                                    .event?.isSelected,
                                                // Boolean value for checkbox state
                                                onChanged: (bool? newValue) {
                                                  // controller.event?.isSelected =
                                                  //     newValue;
                                                  // setState(() {});
                                                },
                                              ),
                                              CustomText(
                                                  text: controller
                                                          .event?.checkTitle ??
                                                      "",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: Colors.black,
                                                  textAlign: TextAlign.start),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                activeColor: AppColor
                                                    .primaryBackgroundColor,
                                                value: controller
                                                    .doctorDesk?.isSelected,
                                                // Boolean value for checkbox state
                                                onChanged: (bool? newValue) {
                                                  // controller.doctorDesk
                                                  //     ?.isSelected = newValue;
                                                  // setState(() {});
                                                },
                                              ),
                                              CustomText(
                                                  text: controller.doctorDesk
                                                          ?.checkTitle ??
                                                      "",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: Colors.black,
                                                  textAlign: TextAlign.start),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                activeColor: AppColor
                                                    .primaryBackgroundColor,
                                                value: controller
                                                    .nephroDesk?.isSelected,
                                                // Boolean value for checkbox state
                                                onChanged: (bool? newValue) {
                                                  // controller.nephroDesk
                                                  //     ?.isSelected = newValue;
                                                  // setState(() {});
                                                },
                                              ),
                                              CustomText(
                                                  text: controller.nephroDesk
                                                          ?.checkTitle ??
                                                      "",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: Colors.black,
                                                  textAlign: TextAlign.start),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                activeColor: AppColor
                                                    .primaryBackgroundColor,
                                                value: controller
                                                    .dietician?.isSelected,
                                                // Boolean value for checkbox state
                                                onChanged: (bool? newValue) {
                                                  // controller.dietician
                                                  //     ?.isSelected = newValue;
                                                  // setState(() {});
                                                },
                                              ),
                                              CustomText(
                                                  text: controller.dietician
                                                          ?.checkTitle ??
                                                      "",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: Colors.black,
                                                  textAlign: TextAlign.start),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      const CustomText(
                                        text: "Terms & Conditions",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start,
                                      ),
                                      CustomText(
                                        text: "*",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        textColor: AppColor.red,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ).paddingOnly(top: 20),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor:
                                          AppColor.primaryBackgroundColor,
                                      value:
                                          controller.termsCondition?.isSelected,
                                      // Boolean value for checkbox state
                                      onChanged: (bool? newValue) {
                                        controller.termsCondition?.isSelected =
                                            newValue;
                                        setState(() {});
                                      },
                                    ),
                                    Expanded(
                                      child: CustomText(
                                          text: controller
                                                  .termsCondition?.checkTitle ??
                                              "",
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black54,
                                          textAlign: TextAlign.start),
                                    ),
                                  ],
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            alignment: Alignment.center,
                                            width: 100,
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
                                                const CustomText(
                                                    text: "Cancel",
                                                    fontSize: 16,
                                                    fontFam: "Lato",
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                          CustomPopup.showAlertDialog(
                                              () {
                                                Get.back();
                                              },
                                              () {
                                                if (controller.predialysis
                                                            ?.isSelected ==
                                                        true &&
                                                    controller.postDialysis
                                                            ?.isSelected ==
                                                        true) {
                                                  if (controller.termsCondition
                                                          ?.isSelected ==
                                                      true) {
                                                    controller.saveDischarge(
                                                        widget.dialysisEventDet
                                                            .patientId
                                                            .toString(),
                                                        widget.dialysisEventDet
                                                            .treatmentId
                                                            .toString(),
                                                        widget.userData[
                                                            'unitId'].toString(),
                                                        widget.userData['ui']
                                                            .toString(),
                                                        widget.userData);
                                                  } else {
                                                    CustomMessage.toast(
                                                        "Please select terms checkbox");
                                                  }
                                                } else {
                                                  CustomMessage.toast(
                                                      "Pre And Post Dialysis is mandatory");
                                                }
                                              },
                                              "Discharge",
                                              "1st Time Dietician Consultation Completed?.",
                                              "assets/consultation.png",
                                              true,
                                              "Yes",
                                              () {
                                                Get.back();
                                              });
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            alignment: Alignment.center,
                                            width: 120,
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
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                                CustomText(
                                                    text: "Discharge",
                                                    fontSize: 16,
                                                    fontFam: "Lato",
                                                    fontWeight:
                                                        FontWeight.normal,
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
}

class DischargePatientCardDetails extends StatelessWidget {
  final String patientId;
  final String dialysisDate;
  final String patientName;
  final String gender;
  final String age;
  final bool? isExpanded;
  final ListReg? patientDetails;
  final Function? isExpand;

  const DischargePatientCardDetails(
      {super.key,
      required this.patientId,
      required this.patientName,
      required this.gender,
      required this.age,
      this.isExpand,
      this.isExpanded,
      this.patientDetails,
      required this.dialysisDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              AppColor.primaryBackgroundColor.withValues(alpha: (0.2)),
              AppColor.secondaryColor.withValues(alpha: (0.2))
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          )),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const CustomText(
                text: 'Patient ID : ',
                fontSize: 12.0,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.black,
                textAlign: TextAlign.start,
              ),
              CustomText(
                text: patientId,
                fontSize: 12.0,
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
          ).paddingOnly(top: 2),
          Row(
            children: [
              const CustomText(
                text: 'Patient Name  : ',
                fontSize: 12.0,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.black,
                textAlign: TextAlign.start,
              ),
              CustomText(
                text: patientName,
                fontSize: 12.0,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.grey,
                textAlign: TextAlign.start,
              )
            ],
          ).paddingOnly(bottom: 1),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    const CustomText(
                      text: 'Gender :',
                      fontSize: 12.0,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: gender,
                      fontSize: 12.0,
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
                    const CustomText(
                      text: 'Age :',
                      fontSize: 12.0,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: age,
                      fontSize: 12.0,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
            ],
          ).paddingOnly(top: 2, bottom: 1),
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
                          const CustomText(
                            text: 'Mobile :',
                            fontSize: 12.0,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          CustomText(
                            text: patientDetails?.mobile ?? "",
                            fontSize: 12.0,
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
                          const CustomText(
                            text: 'Dialysis Date :',
                            fontSize: 12.0,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          CustomText(
                            text: dialysisDate,
                            fontSize: 12.0,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(top: 2, bottom: 1),
              ],
            ),
          )
        ],
      ),
    );
  }
}
