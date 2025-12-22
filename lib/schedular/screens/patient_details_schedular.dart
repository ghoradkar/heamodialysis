import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/data_event.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class PatientDetailsSchedular extends StatelessWidget {
  final String patientId;
  final String patientName;
  final String? bloodGroup;
  final String gender;
  final String? dbo;
  final String age;
  final String? height;
  final String? weight;
  final String mobile;
  final String? schemaAdopted;
  final DataEvent? patientDetailsModel;

  const PatientDetailsSchedular(
      {super.key,
      required this.patientId,
      required this.patientName,
       this.bloodGroup,
      required this.gender,
       this.dbo,
      required this.age,
       this.height,
       this.schemaAdopted,
      this.patientDetailsModel,
       this.weight,
      required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              AppColor.primaryBackgroundColor.withValues(alpha: 0.2),
              AppColor.secondaryColor.withValues(alpha: 0.2)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          )),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding:  EdgeInsets.symmetric(vertical: 4.h,horizontal: 4.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                ),
              ),
               SizedBox(
                width: 10.w,
              ),
               CustomText(
                text: 'Patient ID : ',
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.black,
                textAlign: TextAlign.start,
              ),
              CustomText(
                text: patientId,
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.grey,
                textAlign: TextAlign.start,
              ),
            ],
          ).paddingOnly(top: 2.h),
          Row(
            children: [
               CustomText(
                text: 'Patient Name  : ',
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.black,
                textAlign: TextAlign.start,
              ),
              CustomText(
                text: patientName,
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.grey,
                textAlign: TextAlign.start,
              )
            ],
          ).paddingOnly(bottom: 1),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                     CustomText(
                      text: 'Blood Group :',
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: bloodGroup ?? '',
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                     CustomText(
                      text: 'Age :',
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: age,
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
            ],
          ).paddingOnly(top: 2.h, bottom: 1.h),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomText(
                      text: 'Viral Load Status :',
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    Expanded(
                      child: CustomText(
                        text: schemaAdopted ?? "",
                        fontSize: 12.sp,
                        fontFam: 'Lato',
                        fontWeight: FontWeight.w400,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomText(
                      text: 'Date Of Birth :',
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    Expanded(
                      child: CustomText(
                        text: dbo ?? "",
                        fontSize: 12.sp,
                        fontFam: 'Lato',
                        fontWeight: FontWeight.w400,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).paddingOnly(top: 2.h, bottom: 1.h),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                     CustomText(
                      text: 'Gender :',
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: gender,
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                     CustomText(
                      text: 'Height :',
                      fontSize: 12.h,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: height ?? "",
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
            ],
          ).paddingOnly(top: 2.h, bottom: 1.h),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                     CustomText(
                      text: 'Weight :',
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: weight ?? "",
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                     CustomText(
                      text: 'Mobile :',
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: mobile,
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
            ],
          ).paddingOnly(top: 2.h, bottom: 1.h),

        ],
      ),
    ).paddingSymmetric(vertical: 4.h, horizontal: 10.w);
  }
}
