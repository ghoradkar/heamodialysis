import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class RegisteredPatientCardList extends StatelessWidget {
  final List<dynamic> patientList;
  final List<String> cardItemDetailsList;
  final bool isSecondColumnVisiable;
  final bool isfromPredialysis;
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

  const RegisteredPatientCardList(
      {super.key,
      required this.patientList,
      required this.cardItemDetailsList,
      required this.isSecondColumnVisiable,
      this.path1,
      this.path2,
      this.path3,
      this.path4,
      this.path5,
      required this.isfromPredialysis,
      required this.callB1,
      required this.callB2,
      required this.callB3,
      required this.callB4,
      required this.callB5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: patientList.length,
        itemBuilder: (context, index) {
          return Card(

            color:const Color(0xffF8F8F8),
            // height: 170.h,
            // decoration: BoxDecoration(
            //   color: const Color(0xffF8F8F8),
            //   borderRadius: BorderRadius.circular(6),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black.withValues(alpha: (0.1)),
            //       spreadRadius: 2,
            //       blurRadius: 4,
            //       offset: const Offset(0, 0.5),
            //     ),
            //   ],
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              child: patientDetailsCard(
                                cardItemDetailsList[0],
                                patientList[index].patientId.toString(),
                              ),
                            ),

                            /// Icons Bar - FIXED WIDTH
                            SizedBox(
                              width: 140.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (isSecondColumnVisiable)
                                    patientCardActions(path2!, () => callB2(index), null),

                                  if (!isfromPredialysis)
                                    patientCardActions(path3!, () => callB3(index), null),

                                  patientCardActions(path1!, () => callB1(index), null),

                                  if (isSecondColumnVisiable)
                                    patientCardActions(path4!, () => callB4(index), null),
                                ],
                              ),
                            ),

                            /// Predialysis Icon (If true)
                            if (isfromPredialysis)
                              SizedBox(
                                width: 50.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    patientCardActions(path5!, () => callB5(index), null),
                                  ],
                                ),
                              )
                          ],
                        ),

                        patientDetailsCard(
                            cardItemDetailsList[1],
                            isfromPredialysis
                                ? "${patientList[index].fName}"
                                : "${patientList[index].fName}"),
                        patientDetailsCard(cardItemDetailsList[2],
                            patientList[index].age.toString()),
                        patientDetailsCard(
                            cardItemDetailsList[3],
                            patientList[index].abhaNo != null
                                ? patientList[index].abhaNo.toString()
                                : ""),
                        patientDetailsCard(
                            cardItemDetailsList[4],
                            isfromPredialysis
                                ? extractStringUpToParenthesis(
                                    "${patientList[index].dialysisSupportType}")
                                : extractStringUpToParenthesis(
                                    "${patientList[index].haemodialysisProcedureTypeEn}")),
                        patientDetailsCard(
                            cardItemDetailsList[5],
                            isfromPredialysis
                                ? "${patientList[index].procedureType}"
                                : "${patientList[index].patientTypeEn}")
                      ],
                    ).paddingOnly(left: 6, top: 2, bottom: 2, right: 2),
                  ),
                ),
              ],
            ),
          ).paddingAll(8.0);
        });
  }

  Widget patientDetailsCard(String text, String details) {
    return Row(
      children: [
        CustomText(
                text: " $text : ",
                fontSize: 12.sp,
                fontFam: "Lato",
                fontWeight: FontWeight.normal,
                textColor: Colors.black,
                textAlign: TextAlign.start)
            .paddingSymmetric(vertical: 2.h),
        Expanded(
          child: CustomText(
                  text: details,
                  fontSize: 12.sp,
                  fontFam: "Lato",
                  fontWeight: FontWeight.normal,
                  textColor: Colors.grey,
                  textAlign: TextAlign.start)
              .paddingSymmetric(vertical: 2.h),
        ),
      ],
    );
  }

  String extractStringUpToParenthesis(String input) {
    int index = input.indexOf('(');
    if (index != -1) {
      return input.substring(0, index).trim();
    }
    return input.trim();
  }

  Widget patientCardActions(String path, Function callB, bool? yes) {
    return InkWell(
        onTap: () {
          callB();
        },
        child: Image.asset(
          width: 25.w,
          height: 25.h,
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
