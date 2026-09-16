import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_table.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class PostDialysis extends StatefulWidget {
  const PostDialysis({super.key});

  @override
  State<PostDialysis> createState() => _PostDialysisState();
}

class _PostDialysisState extends State<PostDialysis> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.darkBlue,
                    borderRadius: BorderRadius.circular(10)),
                child: ExpansionTile(
                  maintainState: true,
                  collapsedIconColor: Colors.white,
                  iconColor: Colors.white,
                  title: Row(children: [
                    Image.asset("assets/file-info.png"),
                    const SizedBox(width: 12),
                    Text(
                      "Post Dialysis Investigation",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: 'Lato'),
                    ),
                  ]),
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.borderColor)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: AppColor.borderColor)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                        text:
                                            "${context.l10n.clinPostDialysisWeight} : ",
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    CustomText(
                                        text: '549878945',
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.grey,
                                        textAlign: TextAlign.start),
                                  ],
                                ).paddingSymmetric(vertical: 2),
                                Row(
                                  children: [
                                    CustomText(
                                        text:
                                            "${context.l10n.clinCurrentSessionWeightDiff} : ",
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    CustomText(
                                        text: '2',
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.grey,
                                        textAlign: TextAlign.start),
                                  ],
                                ).paddingSymmetric(vertical: 2),
                                Row(
                                  children: [
                                    CustomText(
                                        text:
                                            "${context.l10n.clinBloodPressure} : ",
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    CustomText(
                                        text: '100',
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.grey,
                                        textAlign: TextAlign.start),
                                    Spacer(),
                                    CustomText(
                                        text: "${context.l10n.clinPulse} : ",
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    CustomText(
                                        text: '100',
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.grey,
                                        textAlign: TextAlign.start),
                                  ],
                                ).paddingSymmetric(vertical: 2),
                                Row(
                                  children: [
                                    CustomText(
                                        text:
                                            "${context.l10n.clinTemperature} : ",
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    CustomText(
                                        text: '100',
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.grey,
                                        textAlign: TextAlign.start),
                                    Spacer(),
                                    CustomText(
                                        text:
                                            "${context.l10n.clinOxygenLevel} : ",
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    CustomText(
                                        text: '100',
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.grey,
                                        textAlign: TextAlign.start),
                                  ],
                                ).paddingSymmetric(vertical: 2),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          RoundedCornerTable(
                            l1: const ['1', '2'],
                            l2: const [
                              'Dialysis 1',
                              'Dialysis 1',
                            ],
                            l3: const [
                              '2024-07-22',
                              '2024-07-22',
                            ],
                            tableHeader: const [
                              "Final UFV",
                              "Venous Pressure",
                              "Blood Flow (QB)",
                              "Dialysate Flow (QD)"
                            ],
                            lastColumnWidgets: const [
                              CustomText(
                                  text: "13:00:40",
                                  fontSize: 14,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start),
                              CustomText(
                                  text: "13:00:40",
                                  fontSize: 14,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start)
                            ],
                            onButtonPressed: handleButtonPress,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.darkBlue,
                    borderRadius: BorderRadius.circular(10)),
                child: ExpansionTile(
                  maintainState: true,
                  collapsedIconColor: Colors.white,
                  iconColor: Colors.white,
                  title: Row(children: [
                    Image.asset("assets/file-info.png"),
                    const SizedBox(width: 12),
                    Text(
                      "Post Dialysis Injection/Medicine",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: 'Lato'),
                    ),
                  ]),
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.borderColor)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: AppColor.borderColor)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                        text:
                                            "${context.l10n.clinPostDialysisWeight} : ",
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    CustomText(
                                        text: '549878945',
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.grey,
                                        textAlign: TextAlign.start),
                                  ],
                                ).paddingSymmetric(vertical: 2),
                                Row(
                                  children: [
                                    CustomText(
                                        text:
                                            "${context.l10n.clinCurrentSessionWeightDiff} : ",
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    CustomText(
                                        text: '2',
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.grey,
                                        textAlign: TextAlign.start),
                                  ],
                                ).paddingSymmetric(vertical: 2),
                                Row(
                                  children: [
                                    CustomText(
                                        text:
                                            "${context.l10n.clinBloodPressure} : ",
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    CustomText(
                                        text: '100',
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.grey,
                                        textAlign: TextAlign.start),
                                    Spacer(),
                                    CustomText(
                                        text: "${context.l10n.clinPulse} : ",
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    CustomText(
                                        text: '100',
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.grey,
                                        textAlign: TextAlign.start),
                                  ],
                                ).paddingSymmetric(vertical: 2),
                                Row(
                                  children: [
                                    CustomText(
                                        text:
                                            "${context.l10n.clinTemperature} : ",
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    CustomText(
                                        text: '100',
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.grey,
                                        textAlign: TextAlign.start),
                                    Spacer(),
                                    CustomText(
                                        text:
                                            "${context.l10n.clinOxygenLevel} : ",
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    CustomText(
                                        text: '100',
                                        fontSize: 14,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.grey,
                                        textAlign: TextAlign.start),
                                  ],
                                ).paddingSymmetric(vertical: 2),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          RoundedCornerTable(
                            l1: const ['1', '2'],
                            l2: const [
                              'Dialysis 1',
                              'Dialysis 1',
                            ],
                            l3: const [
                              '2024-07-22',
                              '2024-07-22',
                            ],
                            tableHeader: const [
                              "Final UFV",
                              "Venous Pressure",
                              "Blood Flow (QB)",
                              "Dialysate Flow (QD)"
                            ],
                            lastColumnWidgets: const [
                              CustomText(
                                  text: "13:00:40",
                                  fontSize: 14,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start),
                              CustomText(
                                  text: "13:00:40",
                                  fontSize: 14,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start)
                            ],
                            onButtonPressed: handleButtonPress,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.borderColor)),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      text: context.l10n.clinDialysisStopDateTime,
                      fontSize: 16,
                      fontFam: "Lato",
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black,
                      textAlign: TextAlign.start),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CustomText(
                        text: "${context.l10n.clinDialysisStopDateTime} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    Expanded(
                      child: CustomText(
                          text: 'Jul 24, 2024  12:28:55 am',
                          fontSize: 14,
                          fontFam: "Lato",
                          fontWeight: FontWeight.normal,
                          textColor: Colors.grey,
                          textAlign: TextAlign.start),
                    ),
                  ],
                ).paddingSymmetric(vertical: 2),
                Row(
                  children: [
                    CustomText(
                        text: "${context.l10n.clinDialysisDuration} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: '100',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                    Spacer(),
                    CustomText(
                        text: "${context.l10n.clinOxygenLevel} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: '100',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                  ],
                ).paddingSymmetric(vertical: 2),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  handleButtonPress(int index) {
    // Perform action based on the index
    if (index == 0) {
      debugPrint('Button pressed at index: $index');
    } else if (index == 1) {
      debugPrint('Button pressed at index: $index');
    }
  }
}
