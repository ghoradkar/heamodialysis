import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/schedular/model/schedular_pre_dialysis_history.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class SchedularPreDialysisTab extends StatefulWidget {
  final SchedularPreDialysisHistory? schedularPreDialysisHistory;

  const SchedularPreDialysisTab({super.key, this.schedularPreDialysisHistory});

  @override
  State<SchedularPreDialysisTab> createState() =>
      _SchedularPreDialysisTabState();
}

class _SchedularPreDialysisTabState extends State<SchedularPreDialysisTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.schedularPreDialysisHistory != null
          ? Column(
        children: [
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
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      text: 'Pre Dialysis Investigation',
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
                  children: [
                    const CustomText(
                        text: 'Dialysis Type :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.dialysisType !=
                            null
                            ? widget.schedularPreDialysisHistory!
                            .dialysisType!
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
                    const CustomText(
                        text: 'Dialyser Type :',
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.dialyserType !=
                            null
                            ? widget.schedularPreDialysisHistory!
                            .dialyserType!
                            : "",
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                  ],
                ).paddingSymmetric(vertical: 2),
                Row(
                  children: [
                    const CustomText(
                        text: 'Access Site :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.accessSite !=
                            null
                            ? widget
                            .schedularPreDialysisHistory!.accessSite!
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
                    const CustomText(
                        text: 'Dialyzer Barcode No./Sr. No :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.dialyserBarcodeSerialNo !=
                            null
                            ? widget.schedularPreDialysisHistory!
                            .dialyserBarcodeSerialNo!
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
                    const CustomText(
                        text: 'Dialyzer Reuse No :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.dialyserResueNo !=
                            null
                            ? widget.schedularPreDialysisHistory!
                            .dialyserResueNo
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
                    const CustomText(
                        text: 'Dialyzer Remark :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.dialyserRemarks !=
                            null
                            ? widget.schedularPreDialysisHistory!
                            .dialyserRemarks!
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
                    const CustomText(
                        text: 'Blood Tubing Barcode No./Sr. No :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.tubeBarcodeSerialNo !=
                            null
                            ? widget.schedularPreDialysisHistory!
                            .tubeBarcodeSerialNo!
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
                    const CustomText(
                        text: 'Blood Tubing Reuse No :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.tubeBarcodeSerialNo !=
                            null
                            ? widget.schedularPreDialysisHistory!
                            .tubeBarcodeSerialNo!
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
                    const CustomText(
                        text: 'Blood Tubing Reuse No :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.tubeResueNo !=
                            null
                            ? widget
                            .schedularPreDialysisHistory!.tubeResueNo!
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
                    const CustomText(
                        text: 'Special Dialysis :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.specialDialysis !=
                            null
                            ? widget.schedularPreDialysisHistory!
                            .specialDialysis!
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
                    const CustomText(
                        text: 'Pre Dialysis Weight  :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.weight !=
                            null
                            ? widget.schedularPreDialysisHistory!.weight!
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
                    const CustomText(
                        text: 'Dry Weight :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.dryWeight !=
                            null
                            ? widget
                            .schedularPreDialysisHistory!.dryWeight!
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
                    const CustomText(
                        text: 'Interdialytic Gain :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.interDialyticWeightGain !=
                            null
                            ? widget.schedularPreDialysisHistory!
                            .interDialyticWeightGain!
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
                    const CustomText(
                        text: 'Pre HD Condition :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.preHdCondition !=
                            null
                            ? widget.schedularPreDialysisHistory!
                            .preHdCondition!
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
                    const CustomText(
                        text: 'Dialyzer Remark :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.dialyserRemarks !=
                            null
                            ? widget.schedularPreDialysisHistory!
                            .dialyserRemarks!
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
                    const CustomText(
                        text: 'Dialyzer Dicarded :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.discardreamrk !=
                            null
                            ? widget.schedularPreDialysisHistory!
                            .discardreamrk!
                            : "",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                  ],
                ).paddingSymmetric(vertical: 2),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.borderColor)),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      text: 'Pre Dialysis Vitals',
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
                  children: [
                    const CustomText(
                        text: 'Blood Pressure :',
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.bloodPressureH !=
                            null
                            ? "${widget.schedularPreDialysisHistory!.bloodPressureH!.toString()}"
                            "/${widget.schedularPreDialysisHistory!.bloodPressureL!.toString()}"
                            : "",
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                  ],
                ).paddingSymmetric(vertical: 2),
                Row(
                  children: [
                    const CustomText(
                        text: 'Pulse :',
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory?.pulse !=
                            null
                            ? widget.schedularPreDialysisHistory!.pulse!
                            .toString()
                            : "",
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                  ],
                ),
                Row(
                  children: [
                    const CustomText(
                        text: 'Temperature :',
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.temperature !=
                            null
                            ? widget
                            .schedularPreDialysisHistory!.temperature!
                            .toString()
                            : "",
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                  ],
                ),
                Row(
                  children: [
                    const CustomText(
                        text: 'Oxygen Level:',
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: widget.schedularPreDialysisHistory
                            ?.oxyLevel !=
                            null
                            ? widget
                            .schedularPreDialysisHistory!.oxyLevel!
                            .toString()
                            : "",
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.borderColor)),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      text: 'Dialysis Start Date and Time',
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
                  children: [
                    const CustomText(
                        text: 'Dialysis Start Date and Time :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    Expanded(
                      child: CustomText(
                          text: widget.schedularPreDialysisHistory
                              ?.preDialysisStart !=
                              null
                              ? widget.schedularPreDialysisHistory!
                              .preDialysisStart!
                              : "",
                          fontSize: 14,
                          fontFam: "Lato",
                          fontWeight: FontWeight.normal,
                          textColor: Colors.grey,
                          textAlign: TextAlign.start),
                    ),
                  ],
                ).paddingSymmetric(vertical: 2),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      )
          : const Text("No consultation details available.",textAlign: TextAlign.center,),
    );
  }
}
