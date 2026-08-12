import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';

import 'custom_card.dart';

class RoMaintenanceCardList extends StatelessWidget {
  final List<dynamic> roList;
  final List<String> cardItemDetailsList;
  final String? path1;
  final String? path2;
  final Function callB1;
  final Function callB2;
  final bool isMachineIssueLog;

  const RoMaintenanceCardList({
    super.key,
    required this.roList,
    required this.cardItemDetailsList,
    this.path1,
    this.path2,
    required this.callB1,
    required this.callB2,
    required this.isMachineIssueLog,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(isMachineIssueLog.toString());
    return ListView.builder(
        shrinkWrap: true,
        itemCount: roList.length,
        itemBuilder: (context, index) {
          return Card(
            // height: 250,
            // decoration: BoxDecoration(
            //   color: const Color(0xffF8F8F8),
            //   borderRadius: BorderRadius.circular(6),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black.withValues(alpha: (0.1)),
            //       spreadRadius: 2,
            //       blurRadius: 4,
            //       offset: const Offset(0, 0.5), // changes position of shadow
            //     ),
            //   ],
            // ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isMachineIssueLog == false
                      ? Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              patientDetailsCard(cardItemDetailsList[0],
                                  roList[index].machineName ?? "-"),
                              patientDetailsCard(cardItemDetailsList[1],
                                  roList[index].unitName ?? "-"),
                              patientDetailsCard(cardItemDetailsList[2],
                                  roList[index].lookupDetDescEn ?? "-"),
                              patientDetailsCard(
                                  cardItemDetailsList[3],
                                  roList[index].inspectionDate ?? "-"),
                              patientDetailsCard(
                                  cardItemDetailsList[4],
                                  roList[index].nextInspectionDate ?? "-"),
                              patientDetailsCard(cardItemDetailsList[5],
                                  roList[index].doneBy ?? "-"),
                              patientDetailsCard(cardItemDetailsList[6],
                                  roList[index].comments ?? "-")
                            ],
                          ).paddingSymmetric(vertical: 4, horizontal: 4),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                patientDetailsCard(
                                    cardItemDetailsList[0],
                                    roList[index]
                                            .tmRoMachineMaster
                                            ?.machineName ??
                                        "-"),
                                patientDetailsCard(cardItemDetailsList[1],
                                    roList[index].unitMasterDto?.unitName ?? "-"),
                                patientDetailsCard(cardItemDetailsList[2],
                                    roList[index].informedTo ?? "-"),
                                patientDetailsCard(cardItemDetailsList[3],
                                    roList[index].informedBy ?? "-"),
                                patientDetailsCard(
                                    cardItemDetailsList[4],
                                    // dateConversion(roList[index].issueDate ?? "-")
                                    roList[index].fIssueDate ?? "-"
                                        ),
                                patientDetailsCard(cardItemDetailsList[5],
                                    // dateConversion(roList[index].informationDate) ?? "-"
                                roList[index].fInformationDate ?? "-"
                                ),
                                patientDetailsCard(cardItemDetailsList[6],
                                    roList[index].comments ?? "-")
                              ],
                            ).paddingSymmetric(vertical: 4, horizontal: 4),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      height:35,width: 65,
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          patientCardActions(path1!, () {
                            callB1(index);
                            // Get.to(() => BookAppointmentScreen(
                            //     patientData: patientList[index]));
                          }, null),
                          patientCardActions(path2!, () {
                            callB2(index);
                          }, null)
                          // .paddingOnly(top: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).paddingAll(8.0);
        });
  }

  // Widget patientDetailsCard(String text, String details) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Flexible(
  //         child: CustomText(
  //             text: "$text : $details",
  //                 fontSize: 13,
  //                 fontFam: "Lato",
  //                 fontWeight: FontWeight.normal,
  //                 textColor:Colors.black,
  //                 textAlign: TextAlign.start)
  //             .paddingSymmetric(vertical: 2),
  //       ),
  //
  //       // Flexible(
  //       //   child: CustomText(
  //       //           text: details,
  //       //           fontSize: 13,
  //       //           fontFam: "Lato",
  //       //           fontWeight: FontWeight.normal,
  //       //           textColor: Colors.grey,
  //       //           textAlign: TextAlign.start)
  //       //       .paddingSymmetric(vertical: 2),
  //       // ),
  //     ],
  //   );
  // }

  // Widget patientDetailsCard(String text, String details) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 2),
  //     child: RichText(
  //       textAlign: TextAlign.start,
  //       text: TextSpan(
  //         children: [
  //           TextSpan(
  //             text: "$text : ",
  //             style: const TextStyle(
  //               fontSize: 16,
  //               fontFamily: "Lato",
  //               fontWeight: FontWeight.w400,
  //               color: Colors.black,
  //             ),
  //           ),
  //           TextSpan(
  //             text: details,
  //             style: const TextStyle(
  //               fontSize: 16,
  //               fontFamily: "Lato",
  //               fontWeight: FontWeight.w400,
  //               color: Colors.grey,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }


  dateConversion(inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  Widget patientCardActions(String path, Function callB, bool? yes) {
    return InkWell(
        onTap: () {
          callB();
        },
        child: Image.asset(
          path,
          color: yes == null ?  AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
