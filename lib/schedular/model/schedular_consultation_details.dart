import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/schedular/model/consultation_model.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class SchedularConsultationDetails extends StatefulWidget {
  final ConsultationModel? consultationModel;

  const SchedularConsultationDetails({super.key, this.consultationModel});

  @override
  State<SchedularConsultationDetails> createState() =>
      _SchedularConsultationDetailsState();
}

class _SchedularConsultationDetailsState
    extends State<SchedularConsultationDetails> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 5,
          left: 8,
          right: 8,
          bottom: MediaQuery.sizeOf(context).height / 1.65),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.borderColor)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [

              CustomText(
                  text: "${context.l10n.colPatientId} : ",
                  fontSize: 12,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF000000),
                  textAlign: TextAlign.start,

              ),
              CustomText(
                  text: widget.consultationModel?.patientId != null
                      ? widget.consultationModel!.patientId.toString()
                      : "",
                  fontSize: 12,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Color(0Xff484848),
                  textAlign: TextAlign.start),
              const SizedBox(
                width: 20,
              ),
              CustomText(
                  text: "${context.l10n.colTreatmentId} : ",
                  fontSize: 12,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF000000),
                  textAlign: TextAlign.start
              ),
              CustomText(
                  text: widget.consultationModel?.treatmentId != null
                      ? widget.consultationModel!.treatmentId.toString()
                      : "",
                  fontSize: 12,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: const Color(0xFF484848),
                  textAlign: TextAlign.start),
            ],
          ).paddingSymmetric(vertical: 2),
          Row(
            children: [
              CustomText(
                  text: "${context.l10n.colInstituteName} : ",
                  fontSize: 12,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF000000),
                  textAlign: TextAlign.start),
              CustomText(
                  text: widget.consultationModel?.instituteName != null
                      ? widget.consultationModel!.instituteName!
                      : "",
                  fontSize: 12,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF484848),
                  textAlign: TextAlign.start),
            ],
          ).paddingSymmetric(vertical: 2),
          Row(
            children: [
              CustomText(
                  text: "${context.l10n.schedAppointmentDate} : ",
                  fontSize: 12,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF000000),
                  textAlign: TextAlign.start),
              CustomText(
                  text: widget.consultationModel?.appointmentDateS != null
                      ? widget.consultationModel!.appointmentDateS!
                      : "",
                  fontSize: 12,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF484848),
                  textAlign: TextAlign.start),
            ],
          ).paddingSymmetric(vertical: 2),
          Row(
            children: [
              CustomText(
                  text: "${context.l10n.schedSlotTime} : ",
                  fontSize: 12,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF000000),
                  textAlign: TextAlign.start),
              CustomText(
                  text: widget.consultationModel?.slotTime != null
                      ? widget.consultationModel!.slotTime!
                      : "",
                  fontSize: 12,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF484848),
                  textAlign: TextAlign.start),
            ],
          ).paddingSymmetric(vertical: 2),
          Row(
            children: [
              CustomText(
                  text: "${context.l10n.schedBedNo} : ",
                  fontSize: 12,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF000000),
                  textAlign: TextAlign.start),
              CustomText(
                  text: widget.consultationModel?.bedNo != null
                      ? widget.consultationModel!.bedNo!
                      : "",
                  fontSize: 12,
                  fontFam: "Lato",
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF484848),
                  textAlign: TextAlign.start),
            ],
          ).paddingSymmetric(vertical: 2),
        ],
      ),
    );
  }
}
