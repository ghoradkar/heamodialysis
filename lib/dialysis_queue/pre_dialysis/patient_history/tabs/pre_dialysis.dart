import 'package:flutter/material.dart';
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
                const SizedBox(height: 10,),
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
                const SizedBox(height: 10,),

                const Row(
                  children: [
                    CustomText(
                        text: 'Dialysis Type :',
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
                        text: 'Dialysis Type :',
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
                const Row(
                  children: [
                    CustomText(
                        text: 'Access Site :',
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
                const Row(
                  children: [
                    CustomText(
                        text: 'Dialyzer Type :',
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
                const Row(
                  children: [
                    CustomText(
                        text: 'Dialyzer Barcode No./Sr. No :',
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
                const Row(
                  children: [
                    CustomText(
                        text: 'Dialyzer Reuse No :',
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
                const Row(
                  children: [
                    CustomText(
                        text: 'Dialyzer Remark :',
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
                const Row(
                  children: [
                    CustomText(
                        text: 'Blood Tubing Barcode No./Sr. No :',
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
                const Row(
                  children: [
                    CustomText(
                        text: 'Blood Tubing Reuse No :',
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
                const Row(
                  children: [
                    CustomText(
                        text: 'Blood Tubing Reuse No :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Blood Tubing Remark',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),

                  ],
                ).paddingSymmetric(vertical: 2),
                const Row(
                  children: [
                    CustomText(
                        text: 'Special Dialysis :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Yes',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),

                  ],
                ).paddingSymmetric(vertical: 2),
                const Row(
                  children: [
                    CustomText(
                        text: 'Pre Dialysis Weight  :',
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
                        text: 'Dry Weight :',
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
                const Row(
                  children: [
                    CustomText(
                        text: 'Interdialytic Gain :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Blood Tubing Remarks',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),

                  ],
                ).paddingSymmetric(vertical: 2),
                const Row(
                  children: [
                    CustomText(
                        text: 'Pre HD Condition :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Blood Tubing Remarks',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),

                  ],
                ).paddingSymmetric(vertical: 2),
                const Row(
                  children: [
                    CustomText(
                        text: 'Pre HD Condition :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Blood Tubing Remarks',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),

                  ],
                ).paddingSymmetric(vertical: 2),
                const Row(
                  children: [
                    CustomText(
                        text: 'Dialyzer Remark :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Blood Tubing Remarks',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start),

                  ],
                ).paddingSymmetric(vertical: 2),
                const Row(
                  children: [
                    CustomText(
                        text: 'Dialyzer Decarded :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Blood Tubing Remarks',
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
                const SizedBox(height: 10,),

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
                const SizedBox(height: 10,),

                const Row(
                  children: [
                    CustomText(
                        text: 'Dialysis Type :',
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
                        text: 'Dialysis Type :',
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
                const Row(
                  children: [
                    CustomText(
                        text: 'Dialysis Type :',
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
                        text: 'Dialysis Type :',
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

                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      text: 'Dialysis Start Date and Tim',
                      fontSize: 16,
                      fontFam: "Lato",
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black,
                      textAlign: TextAlign.start),
                ),
                const SizedBox(height: 10,),

                 const Row(
                  children: [
                    CustomText(
                        text: 'Dialysis Start Date and Time :',
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
