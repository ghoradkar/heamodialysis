import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/ro_log_sheet_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class RoLogSheetCard extends StatelessWidget {
  final RoLogSheetData? roList;
  final List<String> cardItemDetailsList;
  final String? path1;
  final String? path2;
  final Function callB1;
  final Function callB2;

  final int index;

  const RoLogSheetCard({
    super.key,
    this.roList,
    required this.cardItemDetailsList,
    this.path1,
    this.path2,
    required this.callB1,
    required this.callB2,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                patientDetailsCard(cardItemDetailsList[0],
                    roList?.roMachineMaster?.machineName ?? "-"),
                // patientDetailsCard(
                //     cardItemDetailsList[1],
                //     roList?.roMachineMaster?.createdDate != null
                //         ? dateConversion(roList?.roMachineMaster?.createdDate)
                //         : "-"),
                patientDetailsCard(
                    cardItemDetailsList[1],
                    roList?.createdDate != null
                        ? dateConversion(roList?.createdDate)
                        : "-"),
                CustomText(
                    text: cardItemDetailsList[2],
                    fontSize: 14,
                    fontFam: "Lato",
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black,
                    textAlign: TextAlign.start),
                Row(
                  children: [
                    Expanded(
                      child: patientDetailsCard(cardItemDetailsList[3],
                          roList?.lookupDetIdSfpPre.toString() ?? ''),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: patientDetailsCard(cardItemDetailsList[4],
                          roList?.lookupDetIdSfpPost.toString() ?? ''),
                    ),
                  ],
                ),
                CustomText(
                    text: cardItemDetailsList[5],
                    fontSize: 14,
                    fontFam: "Lato",
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black,
                    textAlign: TextAlign.start),
                Row(
                  children: [
                    Expanded(
                      child: patientDetailsCard(
                          cardItemDetailsList[6],
                          roList?.lookupDetIdSandFilterBackwash.toString() ??
                              ""),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: patientDetailsCard(cardItemDetailsList[7],
                          roList?.lookupDetIdSandFilterRinse.toString() ?? ""),
                    )
                  ],
                )
              ],
            ).paddingSymmetric(vertical: 4, horizontal: 4),
          ),
          Container(
            height: 35,width: 65,padding: const EdgeInsets.only(right: 5),
            decoration: const BoxDecoration(
             // color:Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6)),
            ),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
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
          )
        ],
      ),
    )
        .paddingAll(6.0);
  }

  Widget patientDetailsCard(String text, String? details) {
    return Row(
      children: [
        CustomText(
                text: "$text :",
                fontSize: 13,
                fontFam: "Lato",
                fontWeight: FontWeight.normal,
                textColor: Colors.black,
                textAlign: TextAlign.start)
            .paddingSymmetric(vertical: 2),
        Expanded(
          child: CustomText(
                  text: details ?? "",
                  fontSize: 13,
                  fontFam: "Lato",
                  fontWeight: FontWeight.normal,
                  textColor: Colors.grey,
                  textAlign: TextAlign.start)
              .paddingSymmetric(vertical: 2),
        ),
      ],
    );
  }

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
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
