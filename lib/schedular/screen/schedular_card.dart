import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/schedular/model/schedular_patient_list.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class SchedularCard extends StatelessWidget {
  final SchedularData? patientList;
  final List<String> cardItemDetailsList;
  final bool isSecondColumnVisiable;

  // final bool isfromPredialysis;
  final String? path1;
  final String? path2;
  final String? path3;
  final String? path4;
  final String? path5;
  final Function callB1;
  final Function callB2;
  final Function callB3;
  final Function callB4;
  final Function callB5;

  const SchedularCard(
      {super.key,
      required this.patientList,
      required this.cardItemDetailsList,
      required this.isSecondColumnVisiable,
      this.path1,
      this.path2,
      this.path3,
      this.path4,
      this.path5,
      // required this.isfromPredialysis,
      required this.callB1,
      required this.callB2,
      required this.callB3,
      required this.callB4,
      required this.callB5});

  @override
  Widget build(BuildContext context) {
    return Card(
      // height: 180.h,
      // decoration: BoxDecoration(
      //   color: const Color(0xffF8F8F8),
      //   borderRadius: BorderRadius.circular(6),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withValues(alpha: 0.1),
      //       spreadRadius: 2,
      //       blurRadius: 4,
      //       offset: const Offset(0, 0.5), // changes position of shadow
      //     ),
      //   ],
      // ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Expanded(
                        child: patientDetailsCard(cardItemDetailsList[0],
                            patientList?.patientId.toString() ?? ""),
                      ),
                      SizedBox(
                          width: 140.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            patientCardActions(path1!, () {
                              callB1();
                            }, null),
                            Visibility(
                              visible: isSecondColumnVisiable,
                              child:  SizedBox(
                              //  width: 14.w,
                              ),
                            ),
                            Visibility(
                                visible: isSecondColumnVisiable,
                                child: patientCardActions(path2!, () {
                                  callB2();
                                }, null)),
                            patientCardActions(path3!, () {
                              callB3();
                            }, null),
                            //.paddingOnly(top: 16.h),
                            Visibility(
                              visible: isSecondColumnVisiable,
                              child:  SizedBox(
                               // width: 14.w,
                              ),
                            ),
                            Visibility(
                                visible: isSecondColumnVisiable,
                                child: patientCardActions(path4!, () {
                                  callB4();
                                }, null)
                              //.paddingOnly(top: 16.h),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  patientDetailsCard(
                      cardItemDetailsList[1], "${patientList?.fName}"),
                  patientDetailsCard(cardItemDetailsList[3],
                      patientList?.mobile != null ? patientList!.mobile! : ""),

                  patientDetailsCard(
                      cardItemDetailsList[2], patientList?.age.toString() ?? ""),
                  patientDetailsCard(
                      cardItemDetailsList[5], "${patientList?.gender}"),
                  patientDetailsCard(
                      cardItemDetailsList[7], "${patientList?.slotTime}"),

                  patientDetailsCard(cardItemDetailsList[6],
                      "${patientList?.bedAllocationDate}"),

                ],
              ).paddingOnly(left: 6.w, top: 2.h, bottom: 2.h, right: 4.w),
            ),
          ),

        ],
      ),
    ).paddingSymmetric(vertical: 8.h,horizontal: 8.w);
  }

  Widget patientDetailsCard(String text, String details) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
                text: "$text :",
                fontSize: 13.sp,
                fontFam: "Lato",
                fontWeight: FontWeight.normal,
                textColor: Colors.black,
                textAlign: TextAlign.start)
            .paddingSymmetric(vertical: 2.h),
        Expanded(
          child: CustomText(
                  text: details,
                  fontSize: 13.sp,
                  fontFam: "Lato",
                  fontWeight: FontWeight.normal,
              textColor:AppColor.textValue,
                  textAlign: TextAlign.start)
              .paddingSymmetric(vertical: 2.h),
        ),
      ],
    );
  }

  String extractStringUpToParenthesis(String input) {
    int index = input.indexOf('(');
    if (index != -1) {
      return input
          .substring(0, index)
          .trim(); // Extract up to '(' and trim whitespace
    }
    return input.trim(); // Return the original string if '(' is not found
  }

  Widget patientCardActions(String path, Function callB, bool? yes) {
    return InkWell(
        onTap: () {
          callB();
        },
        child: Image.asset(
          width: 24.w,
          height: 24.h,
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
