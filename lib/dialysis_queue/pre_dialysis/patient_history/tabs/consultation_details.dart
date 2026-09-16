import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class ConsultationDetails extends StatefulWidget {
  const ConsultationDetails({super.key});

  @override
  State<ConsultationDetails> createState() => _ConsultationDetailsState();
}

class _ConsultationDetailsState extends State<ConsultationDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:   EdgeInsets.only(top: 8,left: 8,right: 8,bottom: MediaQuery.sizeOf(context).height/1.7),

      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.borderColor)),
      child:   Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CustomText(
                  text: "${context.l10n.colPatientId} : ",
                  fontSize: 14,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Colors.black,
                  textAlign: TextAlign.start),
              CustomText(
                  text: "344447",
                  fontSize: 14,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Colors.grey,
                  textAlign: TextAlign.start),
             SizedBox(width: 20,),
              CustomText(
                  text: "${context.l10n.colTreatmentId} : ",
                  fontSize: 14,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Colors.black,
                  textAlign: TextAlign.start),
              CustomText(
                  text: "344447",
                  fontSize: 14,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Colors.grey,
                  textAlign: TextAlign.start),
            ],
          ).paddingSymmetric(vertical: 2),
          Row(
            children: [
              CustomText(
                  text: "${context.l10n.colInstituteName} : ",
                  fontSize: 14,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Colors.black,
                  textAlign: TextAlign.start),
               Expanded(
                 child: CustomText(
                    text: "Aarshdeep Hospital Pvt Ltd",
                    fontSize: 14,
                    fontFam: "Lato",
                    fontWeight: FontWeight.w400,
                    textColor: Colors.grey,
                    textAlign: TextAlign.start),
               ),

            ],
          ).paddingSymmetric(vertical: 2),
          Row(
            children: [
              CustomText(
                  text: "${context.l10n.schedAppointmentDate} : ",
                  fontSize: 14,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Colors.black,
                  textAlign: TextAlign.start),
              CustomText(
                  text: " Jul 26, 2024, 12:00:00 AM",
                  fontSize: 14,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Colors.grey,
                  textAlign: TextAlign.start),

            ],
          ).paddingSymmetric(vertical: 2),
          Row(
            children: [
              CustomText(
                  text: "${context.l10n.schedSlotTime} : ",
                  fontSize: 14,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Colors.black,
                  textAlign: TextAlign.start),
              CustomText(
                  text: "07:00 - 11:00",
                  fontSize: 14,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Colors.grey,
                  textAlign: TextAlign.start),

            ],
          ).paddingSymmetric(vertical: 2),
          Row(
            children: [
              CustomText(
                  text: "${context.l10n.schedBedNo} : ",
                  fontSize: 14,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Colors.black,
                  textAlign: TextAlign.start),
              CustomText(
                  text: "3",
                  fontSize: 14,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Colors.grey,
                  textAlign: TextAlign.start),

            ],
          ).paddingSymmetric(vertical: 2),

        ],
      ),
    );
  }
}
