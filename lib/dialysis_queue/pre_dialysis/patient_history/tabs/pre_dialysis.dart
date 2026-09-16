import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class PreDialysisTab extends StatefulWidget {
  const PreDialysisTab({super.key});

  @override
  State<PreDialysisTab> createState() => _PreDialysisTabState();
}

class _PreDialysisTabState extends State<PreDialysisTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.borderColor)),
            child:  Column(
              children: [
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      text: context.l10n.clinPreDialysisInvestigation,
                      fontSize: 16,
                      fontFam: "Lato",
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black,
                      textAlign: TextAlign.start),
                ),
                SizedBox(height: 10,),

                Row(
                  children: [
                    CustomText(
                        text: "${context.l10n.clinDialysisType} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Self',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                    Spacer(),
                    CustomText(
                        text: "${context.l10n.clinDialysisType} : ",
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Self',
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                  ],
                ).paddingSymmetric(vertical: 2),
                Row(
                  children: [
                    CustomText(
                        text: "${context.l10n.clinAccessSite} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Left Brachio Cephalic',
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
                        text: "${context.l10n.clinDialyzerType} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Ultraflux AV 600S',
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
                        text: "${context.l10n.clinDialyzerBarcode} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: '7878874784',
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
                        text: "${context.l10n.clinDialyzerReuseNo} : ",
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
                        text: "${context.l10n.clinDialyzerRemark} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: ' Dialyzer remarks test',
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
                        text: "${context.l10n.clinBloodTubingBarcode} : ",
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
                        text: "${context.l10n.clinBloodTubingReuseNo} : ",
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
                        text: "${context.l10n.clinBloodTubingReuseNo} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: context.l10n.clinBloodTubingRemark,
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
                        text: "${context.l10n.clinSpecialDialysis} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: context.l10n.commonYes,
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
                        text: "${context.l10n.clinPreDialysisWeight} : ",
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
                        text: "${context.l10n.clinDryWeight} : ",
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
                        text: "${context.l10n.clinInterdialyticGain} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: context.l10n.clinBloodTubingRemark,
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
                        text: "${context.l10n.clinPreHdCondition} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: context.l10n.clinBloodTubingRemark,
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
                        text: "${context.l10n.clinPreHdCondition} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: context.l10n.clinBloodTubingRemark,
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
                        text: "${context.l10n.clinDialyzerRemark} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: context.l10n.clinBloodTubingRemark,
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
                        text: "${context.l10n.clinDialyzerDiscarded} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: context.l10n.clinBloodTubingRemark,
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
          const SizedBox(height: 15,),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.borderColor)),
            child:  Column(
              children: [
                SizedBox(height: 10,),

                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      text: context.l10n.clinPreDialysisVitals,
                      fontSize: 16,
                      fontFam: "Lato",
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black,
                      textAlign: TextAlign.start),
                ),
                SizedBox(height: 10,),

                Row(
                  children: [
                    CustomText(
                        text: "${context.l10n.clinDialysisType} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Self',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                    Spacer(),
                    CustomText(
                        text: "${context.l10n.clinDialysisType} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Self',
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
                        text: "${context.l10n.clinDialysisType} : ",
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Self',
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                    Spacer(),
                    CustomText(
                        text: "${context.l10n.clinDialysisType} : ",
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Self',
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),
                  ],
                ).paddingSymmetric(vertical: 2),

              ],
            ),
          ),
          const SizedBox(height: 15,),


          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.borderColor)),
            child:  Column(
              children: [
                const SizedBox(height: 10,),

                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      text: context.l10n.clinDialysisStartDateTime,
                      fontSize: 16,
                      fontFam: "Lato",
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black,
                      textAlign: TextAlign.start),
                ),
                SizedBox(height: 10,),

                 Row(
                  children: [
                    CustomText(
                        text: "${context.l10n.clinDialysisStartDateTime} : ",
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    Expanded(
                      child: CustomText(
                          text: 'Jul 23, 2024 11:19:54 am',
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
          const SizedBox(height: 10,),

        ],
      ),
    );
  }
}
