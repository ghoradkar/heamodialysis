import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/diagnostic_inv_list_model.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_card.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

// import '../../widgets/custom_card.dart';

class TestNameCard extends StatelessWidget {
  final Map<String, dynamic>? userData;
  final ListSubServiceIpdDto? patientList;
  final int index;
  final List<String> cardItemDetailsList;
  final bool isSecondColumnVisiable;
  final String? path1;
  final String? path2;
  final String? path3;
  final String? path4;
  final Function callB1;
  final Function callB2;
  final Function callB3;
  final Function callB4;

  const TestNameCard({
    super.key,
    this.patientList,
    required this.cardItemDetailsList,
    required this.isSecondColumnVisiable,
    this.path1,
    this.path2,
    this.path3,
    this.path4,
    required this.callB1,
    required this.callB2,
    required this.callB3,
    required this.callB4,
    required this.index,
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    // debugPrint(patientList!.toJson().toString());
    debugPrint("👤 Logged User FU Name => ${userData?['fuNm']}");
    return Container(
      // elevation:7,
      // height: 180,
      decoration: BoxDecoration(
        color: const Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 0.5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: patientDetailsCard(cardItemDetailsList[0],
                            patientList?.categoryName ?? ""),
                      ),
                      SizedBox(
                        width: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            patientCardActions(path1!, () {
                              callB1(index);
                              // Get.to(() => BookAppointmentScreen(
                              //     patientData: patientList));
                            }, null),
                            Visibility(
                              visible: isSecondColumnVisiable,
                              child: const SizedBox(
                                  // width: 12,
                                  ),
                            ),
                            Visibility(
                                visible: isSecondColumnVisiable,
                                child: patientCardActions(path2!, () {
                                  callB2(index);
                                }, null)),
                            SizedBox(
                              width: 0,
                            ),
                            Visibility(
                                visible: isSecondColumnVisiable,
                                child: patientCardActions(path3!, () {
                                  callB3(index);
                                }, null)
                                // .paddingOnly(top: 16),
                                ),
                            Visibility(
                              visible: isSecondColumnVisiable,
                              child: const SizedBox(
                                  // width: 12,
                                  ),
                            ),
                            Visibility(
                                visible: isSecondColumnVisiable,
                                child: patientCardActions(
                                    path4!, () {
                                  callB4(index);
                                }, null
                                )
                                // .paddingOnly(top: 16),
                                ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: patientDetailsCard(cardItemDetailsList[1],
                        "${userData?['fuNm']?.toString() ?? ''}"),
                  ),
                  patientDetailsCard(
                      cardItemDetailsList[2], patientList?.serviceName ?? ''),
                  patientDetailsCard(cardItemDetailsList[3],
                      patientList?.investigationEventDesc ?? ""),
                  patientDetailsCard(
                    cardItemDetailsList[4],
                    // patientList?.clinicalNotes ?? "N/A",
                    (patientList?.clinicalNotes == null ||
                        patientList!.clinicalNotes!.trim().isEmpty)
                        ? "N/A"
                        : patientList!.clinicalNotes!,
                    showStatus: true,
                    status: patientList?.sendtotechflag == null
                        ? "CT Assign"
                        : "Assign To Technician",
                  ),
                  // patientDetailsCard(
                  //     cardItemDetailsList[5], patientList?.instructions ?? "")
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: Container(
                  //     padding: const EdgeInsets.all(8),
                  //     decoration: BoxDecoration(
                  //         color: patientList?.sendtotechflag == null
                  //             ? AppColor.secondaryColor
                  //             : AppColor.inProcess,
                  //         borderRadius: BorderRadius.circular(16)),
                  //     child: CustomText(
                  //         text: patientList?.sendtotechflag == null
                  //             ? "CT Assign"
                  //             : "Assign To Technician",
                  //         fontSize: 9,
                  //         fontWeight: FontWeight.normal,
                  //         textColor: Colors.white,
                  //         textAlign: TextAlign.center),
                  //   ),
                  // )
                ],
              ).paddingOnly(left: 6, top: 2, bottom: 2, right: 4),
            ),
            // Container(
            //   width: 70,
            //   decoration: BoxDecoration(
            //     color: AppColor.darkBlue,
            //     borderRadius: const BorderRadius.only(
            //         topRight: Radius.circular(6),
            //         bottomRight: Radius.circular(6)),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           patientCardActions(path1!, () {
            //             callB1(index);
            //             // Get.to(() => BookAppointmentScreen(
            //             //     patientData: patientList));
            //           }, null),
            //           Visibility(
            //             visible: isSecondColumnVisiable,
            //             child: const SizedBox(
            //               width: 12,
            //             ),
            //           ),
            //           Visibility(
            //               visible: isSecondColumnVisiable,
            //               child: patientCardActions(path2!, () {
            //                 callB2(index);
            //               }, null)),
            //         ],
            //       ),
            //       const SizedBox(
            //         height: 25,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Visibility(
            //             visible: isSecondColumnVisiable,
            //             child: patientCardActions(path3!, () {
            //               callB3(index);
            //             }, null)
            //                 .paddingOnly(top: 16),
            //           ),
            //           Visibility(
            //             visible: isSecondColumnVisiable,
            //             child: const SizedBox(
            //               width: 12,
            //             ),
            //           ),
            //           Visibility(
            //             visible: isSecondColumnVisiable,
            //             child: patientCardActions(path4!, () {
            //               callB4(index);
            //             }, null)
            //                 .paddingOnly(top: 16),
            //           )
            //         ],
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    ).paddingAll(8.0);
  }

  // Widget patientDetailsCard(String label, String details) {
  //   return RichText(
  //     text: TextSpan(
  //       children: [
  //         TextSpan(
  //           text: "$label: ",
  //           style: const TextStyle(
  //             fontSize: 13,
  //             fontFamily: "Lato",
  //             fontWeight: FontWeight.w400,
  //             color: Colors.black,
  //           ),
  //         ),
  //         TextSpan(
  //           text: details,
  //           style: const TextStyle(
  //             fontSize: 14,
  //             fontFamily: "Lato",
  //             fontWeight: FontWeight.w400,
  //             color: Colors.grey, // details ka color
  //           ),
  //         ),
  //       ],
  //     ),
  //     maxLines: 2,
  //     overflow: TextOverflow.ellipsis,
  //   );
  // }

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
          width: 22,
          height: 22,
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
