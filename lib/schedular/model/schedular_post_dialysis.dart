import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/schedular/model/post_dialysis_schedular.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_table.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../widgets/custom_expandable.dart';

class SchedularPostDialysis extends StatefulWidget {
  final PostDialysisSchedular? postDialysisSchedular;

  const SchedularPostDialysis({super.key, this.postDialysisSchedular});

  @override
  State<SchedularPostDialysis> createState() => _SchedularPostDialysisState();
}

class _SchedularPostDialysisState extends State<SchedularPostDialysis> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.postDialysisSchedular?.postDialysisId != 0
          ? Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomExpandableContainer(
                  text: context.l10n.clinPostDialysisInvestigation,
                  leading: "assets/file-info.png",
                  child: Column(
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                          text:
                                              "${context.l10n.clinPostDialysisWeight} : ",
                                          fontSize: 12,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                      CustomText(
                                          text: widget.postDialysisSchedular
                                                      ?.weight !=
                                                  null
                                              ? widget
                                                  .postDialysisSchedular!.weight
                                                  .toString()
                                              : "",
                                          fontSize: 12,
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
                                              "${context.l10n.clinCurrentSessionWeightDiff} :",
                                          fontSize: 12,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                      CustomText(
                                          text: widget.postDialysisSchedular
                                                      ?.weightDifference !=
                                                  null
                                              ? widget.postDialysisSchedular!
                                                  .weightDifference
                                                  .toString()
                                              : "",
                                          fontSize: 12,
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
                                          fontSize: 12,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                      CustomText(
                                          text: widget.postDialysisSchedular
                                                      ?.bloodPressureH !=
                                                  null
                                              ? "${widget.postDialysisSchedular!.bloodPressureH!.toString()}"
                                                  "/${widget.postDialysisSchedular!.bloodPressureL!.toString()}"
                                              : "",
                                          fontSize: 12,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.grey,
                                          textAlign: TextAlign.start),
                                      const Spacer(),
                                      CustomText(
                                          text: "${context.l10n.clinPulse} : ",
                                          fontSize: 12,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                      CustomText(
                                          text: widget.postDialysisSchedular
                                                      ?.pulse !=
                                                  null
                                              ? widget
                                                  .postDialysisSchedular!.pulse
                                                  .toString()
                                              : "",
                                          fontSize: 12,
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
                                          fontSize: 12,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                      CustomText(
                                          text: widget.postDialysisSchedular
                                                      ?.temperature !=
                                                  null
                                              ? widget.postDialysisSchedular!
                                                  .temperature
                                                  .toString()
                                              : "",
                                          fontSize: 12,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.grey,
                                          textAlign: TextAlign.start),
                                      const Spacer(),
                                      CustomText(
                                          text:
                                              "${context.l10n.clinOxygenLevel} : ",
                                          fontSize: 12,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                      CustomText(
                                          text: widget.postDialysisSchedular
                                                      ?.oxyLevel !=
                                                  null
                                              ? widget.postDialysisSchedular!
                                                  .oxyLevel
                                                  .toString()
                                              : "",
                                          fontSize: 12,
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
                                              "${context.l10n.clinRespiratoryRate} : ",
                                          fontSize: 12,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                      CustomText(
                                          text: widget.postDialysisSchedular
                                                      ?.respiratoryRate !=
                                                  null
                                              ? widget.postDialysisSchedular!
                                                  .respiratoryRate
                                                  .toString()
                                              : "",
                                          fontSize: 12,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.grey,
                                          textAlign: TextAlign.start)
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
                              l1: [
                                widget.postDialysisSchedular!.finalUfv!
                                    .floor()
                                    .toString()
                              ],
                              l2: [
                                widget.postDialysisSchedular!.venousPressure!
                                    .floor()
                                    .toString()
                              ],
                              l3: [
                                widget.postDialysisSchedular!.bloodFlowQb!
                                    .floor()
                                    .toString()
                              ],
                              tableHeader: [
                                context.l10n.clinFinalUfv,
                                context.l10n.clinVenousPressure,
                                context.l10n.clinBloodFlowQb,
                                context.l10n.clinDialysateFlowQd
                              ],
                              lastColumnWidgets: [
                                CustomText(
                                    text: widget
                                        .postDialysisSchedular!.dialyticFlowQd!
                                        .floor()
                                        .toString(),
                                    fontSize: 14,
                                    fontFam: "Lato",
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black,
                                    textAlign: TextAlign.start),
                              ],
                              onButtonPressed: handleButtonPress,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Theme(
                //     data:
                //     ThemeData().copyWith(dividerColor: Colors.transparent),
                //     child: Container(
                //       decoration: BoxDecoration(
                //           color: AppColor.darkBlue,
                //           borderRadius: BorderRadius.circular(10)),
                //       child: ExpansionTile(
                //         maintainState: true,
                //         collapsedIconColor: Colors.white,
                //         iconColor: Colors.white,
                //         title: Row(children: [
                //           Image.asset("assets/file-info.png"),
                //           const SizedBox(width: 12),
                //           const Text(
                //             "Post Dialysis Investigation",
                //             style: TextStyle(
                //                 fontSize: 14.0,
                //                 color: Colors.white,
                //                 fontFamily: 'Lato'),
                //           ),
                //         ]),
                //         children: <Widget>[
                //           Container(
                //             padding: const EdgeInsets.all(8),
                //             decoration: BoxDecoration(
                //                 color: Colors.grey[50],
                //                 borderRadius: BorderRadius.circular(10),
                //                 border:
                //                 Border.all(color: AppColor.borderColor)),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.stretch,
                //               children: [
                //                 const SizedBox(
                //                   height: 20,
                //                 ),
                //                 Container(
                //                   padding: const EdgeInsets.all(8),
                //                   decoration: BoxDecoration(
                //                       color: Colors.grey[50],
                //                       borderRadius: BorderRadius.circular(10),
                //                       border: Border.all(
                //                           color: AppColor.borderColor)),
                //                   child: Column(
                //                     children: [
                //                       const SizedBox(
                //                         height: 10,
                //                       ),
                //                       Row(
                //                         children: [
                //                           const CustomText(
                //                               text: "${context.l10n.clinPostDialysisWeight} : ",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.black,
                //                               textAlign: TextAlign.start),
                //                           CustomText(
                //                               text: widget.postDialysisSchedular
                //                                   ?.weight !=
                //                                   null
                //                                   ? widget
                //                                   .postDialysisSchedular!
                //                                   .weight
                //                                   .toString()
                //                                   : "",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.grey,
                //                               textAlign: TextAlign.start),
                //                         ],
                //                       ).paddingSymmetric(vertical: 2),
                //                       Row(
                //                         children: [
                //                           const CustomText(
                //                               text:
                //                               'Current Dialysis Session Weight Difference :',
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.black,
                //                               textAlign: TextAlign.start),
                //                           CustomText(
                //                               text: widget.postDialysisSchedular
                //                                   ?.weightDifference !=
                //                                   null
                //                                   ? widget
                //                                   .postDialysisSchedular!
                //                                   .weightDifference
                //                                   .toString()
                //                                   : "",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.grey,
                //                               textAlign: TextAlign.start),
                //                         ],
                //                       ).paddingSymmetric(vertical: 2),
                //                       Row(
                //                         children: [
                //                           const CustomText(
                //                               text: "${context.l10n.clinBloodPressure} : ",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.black,
                //                               textAlign: TextAlign.start),
                //                           CustomText(
                //                               text: widget.postDialysisSchedular
                //                                   ?.bloodPressureH !=
                //                                   null
                //                                   ? "${widget.postDialysisSchedular!.bloodPressureH!.toString()}"
                //                                   "/${widget.postDialysisSchedular!.bloodPressureL!.toString()}"
                //                                   : "",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.grey,
                //                               textAlign: TextAlign.start),
                //                           const Spacer(),
                //                           const CustomText(
                //                               text: "${context.l10n.clinPulse} : ",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.black,
                //                               textAlign: TextAlign.start),
                //                           CustomText(
                //                               text: widget.postDialysisSchedular
                //                                   ?.pulse !=
                //                                   null
                //                                   ? widget
                //                                   .postDialysisSchedular!
                //                                   .pulse
                //                                   .toString()
                //                                   : "",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.grey,
                //                               textAlign: TextAlign.start),
                //                         ],
                //                       ).paddingSymmetric(vertical: 2),
                //                       Row(
                //                         children: [
                //                           const CustomText(
                //                               text: "${context.l10n.clinTemperature} : ",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.black,
                //                               textAlign: TextAlign.start),
                //                           CustomText(
                //                               text: widget.postDialysisSchedular
                //                                   ?.temperature !=
                //                                   null
                //                                   ? widget
                //                                   .postDialysisSchedular!
                //                                   .temperature
                //                                   .toString()
                //                                   : "",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.grey,
                //                               textAlign: TextAlign.start),
                //                           const Spacer(),
                //                           const CustomText(
                //                               text: "${context.l10n.clinOxygenLevel} : ",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.black,
                //                               textAlign: TextAlign.start),
                //                           CustomText(
                //                               text: widget.postDialysisSchedular
                //                                   ?.oxyLevel !=
                //                                   null
                //                                   ? widget
                //                                   .postDialysisSchedular!
                //                                   .oxyLevel
                //                                   .toString()
                //                                   : "",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.grey,
                //                               textAlign: TextAlign.start),
                //                         ],
                //                       ).paddingSymmetric(vertical: 2),
                //
                //                       Row(
                //                         children: [
                //                           const CustomText(
                //                               text: "${context.l10n.clinRespiratoryRate} : ",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.black,
                //                               textAlign: TextAlign.start),
                //                           CustomText(
                //                               text: widget.postDialysisSchedular
                //                                   ?.respiratoryRate !=
                //                                   null
                //                                   ? widget
                //                                   .postDialysisSchedular!
                //                                   .respiratoryRate
                //                                   .toString()
                //                                   : "",
                //                               fontSize: 12,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.grey,
                //                               textAlign: TextAlign.start)
                //                         ],
                //                       ).paddingSymmetric(vertical: 2),
                //                       const SizedBox(
                //                         height: 10,
                //                       ),
                //
                //                     ],
                //                   ),
                //                 ),
                //                 const SizedBox(
                //                   height: 15,
                //                 ),
                //                 SizedBox(
                //                   height: 150,
                //                   child: RoundedCornerTable(
                //                     l1: [
                //                       widget.postDialysisSchedular!.finalUfv!
                //                           .floor()
                //                           .toString()
                //                     ],
                //                     l2: [
                //                       widget.postDialysisSchedular!
                //                           .venousPressure!
                //                           .floor()
                //                           .toString()
                //                     ],
                //                     l3: [
                //                       widget.postDialysisSchedular!.bloodFlowQb!
                //                           .floor()
                //                           .toString()
                //                     ],
                //                     tableHeader: const [
                //                       "Final UFV",
                //                       "Venous Pressure",
                //                       "Blood Flow (QB)",
                //                       "Dialysate Flow (QD)"
                //                     ],
                //                     lastColumnWidgets: [
                //                       CustomText(
                //                           text: widget.postDialysisSchedular!
                //                               .dialyticFlowQd!
                //                               .floor()
                //                               .toString(),
                //                           fontSize: 14,
                //                           fontFam: "Lato",
                //                           fontWeight: FontWeight.w400,
                //                           textColor: Colors.black,
                //                           textAlign: TextAlign.start),
                //                     ],
                //                     onButtonPressed: handleButtonPress,
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     )),
                const SizedBox(
                  height: 10,
                ),
                CustomExpandableContainer(
                  text: context.l10n.clinPostDialysisInjection,
                  leading: "assets/file-info.png",
                  child: Column(
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                          text:
                                              "${context.l10n.clinRrfUrineVolume} :",
                                          fontSize: 14,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                      CustomText(
                                          text: widget.postDialysisSchedular
                                                      ?.rrfUrineVolumeMlDay !=
                                                  null
                                              ? widget.postDialysisSchedular!
                                                  .rrfUrineVolumeMlDay
                                                  .toString()
                                              : "",
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
                                              "${context.l10n.clinHeparin} : ",
                                          fontSize: 14,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                      CustomText(
                                          text: widget.postDialysisSchedular
                                                      ?.herapinIu !=
                                                  null
                                              ? widget.postDialysisSchedular!
                                                  .herapinIu
                                                  .toString()
                                              : "",
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
                                              "${context.l10n.clinCaseNarration} : ",
                                          fontSize: 14,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                      CustomText(
                                          text: widget.postDialysisSchedular
                                                      ?.caseNarration !=
                                                  null
                                              ? widget.postDialysisSchedular!
                                                  .caseNarration!
                                              : "",
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
                                              "${context.l10n.clinPercentOfFbv} :",
                                          fontSize: 14,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                      CustomText(
                                          text: widget.postDialysisSchedular
                                                      ?.actualFiberBundle !=
                                                  null
                                              ? widget.postDialysisSchedular!
                                                  .actualFiberBundle
                                                  .toString()
                                              : "",
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
                                              "${context.l10n.clinActualFbv} : ",
                                          fontSize: 14,
                                          fontFam: "Lato",
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                      CustomText(
                                          text: widget.postDialysisSchedular
                                                      ?.actualFiberBundle !=
                                                  null
                                              ? widget.postDialysisSchedular!
                                                  .actualFiberBundle
                                                  .toString()
                                              : "",
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Theme(
                //     data:
                //     ThemeData().copyWith(dividerColor: Colors.transparent),
                //     child: Container(
                //       decoration: BoxDecoration(
                //           color: AppColor.darkBlue,
                //           borderRadius: BorderRadius.circular(10)),
                //       child: ExpansionTile(
                //         maintainState: true,
                //         collapsedIconColor: Colors.white,
                //         iconColor: Colors.white,
                //         title: Row(children: [
                //           Image.asset("assets/file-info.png"),
                //           const SizedBox(width: 12),
                //           const Text(
                //             "Post Dialysis Injection/Medicine",
                //             style: TextStyle(
                //                 fontSize: 14.0,
                //                 color: Colors.white,
                //                 fontFamily: 'Lato'),
                //           ),
                //         ]),
                //         children: <Widget>[
                //           Container(
                //             padding: const EdgeInsets.all(8),
                //             decoration: BoxDecoration(
                //                 color: Colors.grey[50],
                //                 borderRadius: BorderRadius.circular(10),
                //                 border:
                //                 Border.all(color: AppColor.borderColor)),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.stretch,
                //               children: [
                //                 const SizedBox(
                //                   height: 20,
                //                 ),
                //                 Container(
                //                   padding: const EdgeInsets.all(8),
                //                   decoration: BoxDecoration(
                //                       color: Colors.grey[50],
                //                       borderRadius: BorderRadius.circular(10),
                //                       border: Border.all(
                //                           color: AppColor.borderColor)),
                //                   child: Column(
                //                     children: [
                //                       const SizedBox(
                //                         height: 10,
                //                       ),
                //                       Row(
                //                         children: [
                //                           const CustomText(
                //                               text:
                //                               'RRF Urine Volume(ml/Day) :',
                //                               fontSize: 14,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.black,
                //                               textAlign: TextAlign.start),
                //                           CustomText(
                //                               text: widget.postDialysisSchedular
                //                                   ?.rrfUrineVolumeMlDay !=
                //                                   null
                //                                   ? widget
                //                                   .postDialysisSchedular!
                //                                   .rrfUrineVolumeMlDay
                //                                   .toString()
                //                                   : "",
                //                               fontSize: 14,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.grey,
                //                               textAlign: TextAlign.start),
                //                         ],
                //                       ).paddingSymmetric(vertical: 2),
                //                       Row(
                //                         children: [
                //                           const CustomText(
                //                               text: "${context.l10n.clinHeparin} : ",
                //                               fontSize: 14,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.black,
                //                               textAlign: TextAlign.start),
                //                           CustomText(
                //                               text: widget.postDialysisSchedular
                //                                   ?.herapinIu !=
                //                                   null
                //                                   ? widget
                //                                   .postDialysisSchedular!
                //                                   .herapinIu
                //                                   .toString()
                //                                   : "",
                //                               fontSize: 14,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.grey,
                //                               textAlign: TextAlign.start),
                //                         ],
                //                       ).paddingSymmetric(vertical: 2),
                //                       Row(
                //                         children: [
                //                           const CustomText(
                //                               text: "${context.l10n.clinCaseNarration} : ",
                //                               fontSize: 14,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.black,
                //                               textAlign: TextAlign.start),
                //                           CustomText(
                //                               text: widget.postDialysisSchedular
                //                                   ?.caseNarration !=
                //                                   null
                //                                   ? widget
                //                                   .postDialysisSchedular!
                //                                   .caseNarration!
                //                                   : "",
                //                               fontSize: 14,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.grey,
                //                               textAlign: TextAlign.start),
                //                         ],
                //                       ).paddingSymmetric(vertical: 2),
                //                       Row(
                //                         children: [
                //                           const CustomText(
                //                               text: '% of FBV :',
                //                               fontSize: 14,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.black,
                //                               textAlign: TextAlign.start),
                //                           CustomText(
                //                               text: widget.postDialysisSchedular
                //                                   ?.actualFiberBundle !=
                //                                   null
                //                                   ? widget
                //                                   .postDialysisSchedular!
                //                                   .actualFiberBundle
                //                                   .toString()
                //                                   : "",
                //                               fontSize: 14,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.grey,
                //                               textAlign: TextAlign.start),
                //                         ],
                //                       ).paddingSymmetric(vertical: 2),
                //                       Row(
                //                         children: [
                //                           const CustomText(
                //                               text: "${context.l10n.clinActualFbv} : ",
                //                               fontSize: 14,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.black,
                //                               textAlign: TextAlign.start),
                //                           CustomText(
                //                               text: widget.postDialysisSchedular
                //                                   ?.actualFiberBundle !=
                //                                   null
                //                                   ? widget
                //                                   .postDialysisSchedular!
                //                                   .actualFiberBundle
                //                                   .toString()
                //                                   : "",
                //                               fontSize: 14,
                //                               fontFam: "Lato",
                //                               fontWeight: FontWeight.normal,
                //                               textColor: Colors.grey,
                //                               textAlign: TextAlign.start),
                //                         ],
                //                       ).paddingSymmetric(vertical: 2),
                //                       const SizedBox(
                //                         height: 10,
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     )),
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                              text:
                                  "${context.l10n.clinDialysisStartDateTime} : ",
                              fontSize: 14,
                              fontFam: "Lato",
                              fontWeight: FontWeight.normal,
                              textColor: Colors.black,
                              textAlign: TextAlign.start),
                          Expanded(
                            child: CustomText(
                                text: widget.postDialysisSchedular
                                            ?.dialysisStartDatetime !=
                                        null
                                    ? widget.postDialysisSchedular!
                                        .dialysisStartDatetime!
                                    : "",
                                fontSize: 14,
                                fontFam: "Lato",
                                fontWeight: FontWeight.normal,
                                textColor: Colors.grey,
                                textAlign: TextAlign.start),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                              text:
                                  "${context.l10n.clinDialysisStopDateTime} : ",
                              fontSize: 14,
                              fontFam: "Lato",
                              fontWeight: FontWeight.normal,
                              textColor: Colors.black,
                              textAlign: TextAlign.start),
                          Expanded(
                            child: CustomText(
                                text: widget.postDialysisSchedular
                                            ?.dialysisStopTime !=
                                        null
                                    ? widget.postDialysisSchedular!
                                        .dialysisStopTime!
                                    : "",
                                fontSize: 14,
                                fontFam: "Lato",
                                fontWeight: FontWeight.normal,
                                textColor: Colors.grey,
                                textAlign: TextAlign.start),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                              text: "${context.l10n.clinDialysisDuration} : ",
                              fontSize: 14,
                              fontFam: "Lato",
                              fontWeight: FontWeight.normal,
                              textColor: Colors.black,
                              textAlign: TextAlign.start),
                          CustomText(
                              text: widget.postDialysisSchedular
                                          ?.dialysisDuration !=
                                      null
                                  ? widget
                                      .postDialysisSchedular!.dialysisDuration!
                                  : "",
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
            )
          : Text(context.l10n.commonNoConsultationDetails,
              textAlign: TextAlign.center),
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
