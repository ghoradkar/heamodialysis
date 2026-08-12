import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_detaisl_model.dart';
import 'package:heamodialysis/new_registration/model/view_patient_model.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';

// import '../../dashboard/model/nephro_list.dart';

class ExpandableCardDetails extends StatelessWidget {
  // final NephroList? patientData;
  final DialysisEventDetaislModel? patientData;
  final bool? isExpanded;
  final Function? isExpand;
  final String? currentStat;

  const ExpandableCardDetails({
    super.key,
    this.isExpand,
    this.isExpanded,
    this.patientData,
    this.currentStat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
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
                  text: patientData?.patientId.toString() ?? "-",
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
            Padding(
              padding: const EdgeInsets.only(left: 43.0),
              child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Patient Name  : ',
                    fontSize: 12.0,
                    fontFam: 'Lato',
                    fontWeight: FontWeight.w400,
                    textColor: Colors.black,
                    textAlign: TextAlign.start,
                  ),
                  Flexible(
                    child: CustomText(
                      text: "${patientData?.patientName}",
                      fontSize: 12.0,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ).paddingOnly(bottom: 1),
            ),
            SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(left: 43.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        const CustomText(
                          text: 'Patient Mobile No : ',
                          fontSize: 12.0,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black,
                          textAlign: TextAlign.start,
                        ),
                        Expanded(
                          child: CustomText(
                            text: patientData?.patientNo ?? "-",
                            fontSize: 12.0,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        const CustomText(
                          text: 'Age : ',
                          fontSize: 12.0,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black,
                          textAlign: TextAlign.start,
                        ),
                        CustomText(
                          text: patientData?.age.toString() ?? "-",
                          fontSize: 12.0,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w400,
                          textColor: Colors.grey,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ).paddingOnly(top: 2, bottom: 1),
            ),
            SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(left: 43.0),
              child: Visibility(
                visible: isExpanded == true,
                child: Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              CustomText(
                                text: 'Machine No. : ',
                                fontSize: 12.0,
                                fontFam: 'Lato',
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                                textAlign: TextAlign.start,
                              ),
                              CustomText(
                                text: "",
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
                                text: 'Bed No. : ',
                                fontSize: 12.0,
                                fontFam: 'Lato',
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                                textAlign: TextAlign.start,
                              ),
                              CustomText(
                                text: patientData?.bedNo ?? '-',
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
                    SizedBox(height: 3),
                    const Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              CustomText(
                                text: 'Registration Date : ',
                                fontSize: 12.0,
                                fontFam: 'Lato',
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                                textAlign: TextAlign.start,
                              ),
                              CustomText(
                                text: "",
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
                              CustomText(
                                text: 'Relative Contact :',
                                fontSize: 12.0,
                                fontFam: 'Lato',
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                                textAlign: TextAlign.start,
                              ),
                              CustomText(
                                text: "",
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
                    SizedBox(height: 3),
                    Row(
                      children: [
                        const CustomText(
                          text: 'Nephrologist Name : ',
                          fontSize: 12.0,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black,
                          textAlign: TextAlign.start,
                        ),
                        Expanded(
                          child: CustomText(
                            text: patientData?.nephrologistName ?? '-',
                            fontSize: 12.0,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w400,
                            textColor: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ).paddingOnly(top: 2, bottom: 1),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        const CustomText(
                          text: 'Relative Name : ',
                          fontSize: 12.0,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black,
                          textAlign: TextAlign.start,
                        ),
                        CustomText(
                          text: patientData?.relativeName ?? "",
                          fontSize: 12.0,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w400,
                          textColor: Colors.grey,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ).paddingOnly(top: 2, bottom: 1),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        const CustomText(
                          text: 'Registration Date : ',
                          fontSize: 12.0,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black,
                          textAlign: TextAlign.start,
                        ),
                        CustomText(
                          // text: patientData?.regDate != null
                          //     ? getDate(patientData!.regDate)
                          //     : "",
                          text: patientData?.regDate != null
                              ? patientData!.regDate.toString()
                              : "",
                          fontSize: 12.0,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w400,
                          textColor: Colors.grey,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ).paddingOnly(top: 2, bottom: 1),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        const CustomText(
                          text: 'Status : ',
                          fontSize: 12.0,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black,
                          textAlign: TextAlign.start,
                        ),
                        CustomText(
                          text: currentStat == "true" ? "Completed" : "Pending",
                          fontSize: 12.0,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w400,
                          textColor: Colors.grey,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ).paddingOnly(top: 2, bottom: 1),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        const CustomText(
                          text: 'BMI : ',
                          fontSize: 12.0,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black,
                          textAlign: TextAlign.start,
                        ),
                        CustomText(
                          text: patientData?.bmi.toString() ?? '-',
                          fontSize: 12.0,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w400,
                          textColor: Colors.grey,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getDate(timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Format it to dd/MM/yyyy
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
