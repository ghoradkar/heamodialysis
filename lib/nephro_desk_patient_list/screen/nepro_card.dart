import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../widgets/custom_card.dart';

class NeproCard extends StatelessWidget {
  final NephroList? patient;
  final List<String> cardItemDetailsList;

  final String? path1;
  final String? path2;
  final Function callB1;
  final Function callB3;

  const NeproCard(
      {super.key,
        required this.patient,
        required this.cardItemDetailsList,
        this.path1,
        this.path2,
        required this.callB1,
        required this.callB3});

  @override
  Widget build(BuildContext context) {
    return Container(
     // height: 160.h,

      decoration: BoxDecoration(
        color: const Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 0.5), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    patientDetailsCard(cardItemDetailsList[0],
                        patient?.patientId.toString() ?? ""),
                    patientDetailsCard(
                        "Treatment Id",
                        patient?.treatmentId != null
                            ? patient!.treatmentId!.toString()
                            : ""),
                    SizedBox(
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          patientCardActions(path1!, () {
                            callB1();
                            // Get.to(() => BookAppointmentScreen(
                            //     patientData: patientList[index]));
                          }, null),



                          patientCardActions(path2!, () {
                            callB3();
                            // Get.to(() => BookAppointmentScreen(
                            //     patientData: patientList[index]));
                          }, null),
                        ],
                      ),
                    ),

                  ],
                ),

                patientDetailsCard(cardItemDetailsList[1], "${patient?.fName}"),
                Row(

                  children: [
                    Expanded(
                      flex: 1,
                      child: patientDetailsCard(cardItemDetailsList[2],
                          patient?.age.toString() ?? ""),
                    ),

                    Expanded(
                    flex: 2,
                      child: patientDetailsCard(
                          cardItemDetailsList[5], "${patient?.gender}"),
                    ),
                  ],
                ),
                patientDetailsCard(cardItemDetailsList[3],
                    patient?.mobile != null ? patient!.mobile! : ""),
              ],
            ).paddingOnly(left: 6.w, top: 2.h, bottom: 2.h, right: 4.w),
          ),

        ],
      ),
    ).paddingSymmetric(vertical: 8.h,horizontal: 8.w);
  }

  // Widget patientDetailsCard(String text, String details) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       CustomText(
  //           text: "$text : ",
  //           fontSize: 13.sp,
  //           fontFam: "Lato",
  //           fontWeight: FontWeight.normal,
  //           textColor: Colors.black,
  //           textAlign: TextAlign.start)
  //           .paddingSymmetric(vertical: 2.h),
  //       Expanded(
  //         child: CustomText(
  //             text: details,
  //             fontSize: 13.sp,
  //             fontFam: "Lato",
  //             fontWeight: FontWeight.normal,
  //             textColor: Colors.grey,
  //             textAlign: TextAlign.start)
  //             .paddingSymmetric(vertical: 2.h),
  //       ),
  //     ],
  //   );
  // }

  String extractStringUpToParenthesis(String input) {
    int index = input.indexOf('(');
    if (index != -1) {
      return input
          .substring(0, index)
          .trim();
    }
    return input.trim(); 
  }

  Widget patientCardActions(String path, Function callB, bool? yes) {
    return InkWell(
        onTap: () {
          callB();
        },
        child: Image.asset(
          width: 22.w,
          height: 22.h,
          path,
          color: yes == null ?  AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
