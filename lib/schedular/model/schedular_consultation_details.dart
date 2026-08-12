import 'package:flutter/material.dart';
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

              const CustomText(
                  text: "Patient ID : ",
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
              const CustomText(
                  text: "Treatment ID : ",
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
              const CustomText(
                  text: "Institute Name : ",
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
              const CustomText(
                  text: "Appointment Date : ",
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
              const CustomText(
                  text: "Slot Time : ",
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
              const CustomText(
                  text: "Bed No : ",
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
