import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/data_event.dart';
import 'package:heamodialysis/utils/color_constants.dart';

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
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _field(context, context.l10n.colPatientId, patientId),
              ),
            ],
          ).paddingOnly(top: 2.h),
          _field(context, context.l10n.colPatientName, patientName),
          _pair(
            _field(context, context.l10n.colBloodGroup, bloodGroup ?? ''),
            _field(context, context.l10n.commonAge, age),
          ),
          _pair(
            _field(
                context, context.l10n.colViralLoadStatus, schemaAdopted ?? ''),
            _field(context, context.l10n.patientCardDob, dbo ?? ''),
          ),
          _pair(
            _field(context, context.l10n.commonGender, gender),
            _field(context, context.l10n.colHeight, height ?? ''),
          ),
          _pair(
            _field(context, context.l10n.colWeight, weight ?? ''),
            _field(context, context.l10n.commonMobileNo, mobile),
          ),
        ],
      ),
    ).paddingSymmetric(vertical: 4.h, horizontal: 10.w);
  }

  /// Two fields side by side; each half wraps independently so a long
  /// localized label can never push the row past the screen edge.
  Widget _pair(Widget left, Widget right) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        SizedBox(width: 12.w),
        Expanded(child: right),
      ],
    );
  }

  /// A "Label : value" line that flows as a single wrapping paragraph, so the
  /// bilingual (EN / FR) labels stay inside their column instead of overflowing.
  Widget _field(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            height: 1.3,
            color: Colors.black,
          ),
          children: [
            TextSpan(text: '$label : '),
            TextSpan(
              text: value,
              style: TextStyle(color: AppColor.textValue),
            ),
          ],
        ),
      ),
    );
  }
}
