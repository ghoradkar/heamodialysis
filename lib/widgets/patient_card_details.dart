import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/model/schema_adopted/schema_data.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/new_registration/model/view_patient_model.dart';
import 'package:heamodialysis/utils/color_constants.dart';

import 'custom_shimmer_loader.dart';

class PatientCardDetails extends StatefulWidget {
  final String refBy;
  final String schemaAdopted;
  final String? imagePath;
  final bool? isFromAddPredialysis;
  final bool? isExpanded;
  final ViewPatientModel? patientDetails;
  final Function? isExpand;

  const PatientCardDetails(
      {super.key,
      required this.refBy,
      required this.schemaAdopted,
      this.isFromAddPredialysis,
      this.isExpand,
      this.isExpanded,
      this.patientDetails,
      this.imagePath});

  @override
  State<PatientCardDetails> createState() => _PatientCardDetailsState();
}

class _PatientCardDetailsState extends State<PatientCardDetails> {
  SchemaData? schemAdpt;
  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());
  bool isLoading = false;
  List<SchemaData>? schemaList;

  @override
  void initState() {
    getData();

    super.initState();
  }

  getData() async {
    if (mounted) {
      setState(() => isLoading = true);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await newRegistrationController.getSchemaAdoptedList();
      if (mounted) {
        setState(() => isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    schemaList = newRegistrationController.schemaAdoptedModel?.data;
    if (schemaList != null &&
        widget.patientDetails?.data?.lookupDetIdPatientType != null) {
      schemAdpt = schemaList?.firstWhere(
        (e) =>
            e.lookupDetId ==
            widget.patientDetails?.data?.lookupDetIdPatientType,
        orElse: () => SchemaData(),
      );
    }

    if (isLoading) return const PatientHistoryShimmer.headerCard();

    final data = widget.patientDetails?.data;
    final bool addPredialysis = widget.isFromAddPredialysis == true;

    final detailRows = <Widget>[
      _field(context, context.l10n.colPatientName,
          "${data?.fName ?? ''} ${data?.lName ?? ''}".trim()),
      if (addPredialysis) ...[
        _field(context, context.l10n.regSchemeAdopted,
            schemAdpt?.lookupDetDescEn ?? ''),
        _pair(
          _field(context, context.l10n.commonGender, data?.gender ?? ''),
          _field(context, context.l10n.commonAge, data?.age?.toString() ?? ''),
        ),
        if (widget.isExpanded == true)
          _pair(
            _field(context, context.l10n.colHeight,
                data?.pheight?.toString() ?? '0'),
            _field(context, context.l10n.colWeight,
                data?.pweight?.toString() ?? '0'),
          ),
      ] else ...[
        _pair(
          _field(context, context.l10n.commonMobileNo, data?.mobile ?? ''),
          _field(context, context.l10n.commonAge, data?.age?.toString() ?? ''),
        ),
        _pair(
          _field(context, context.l10n.commonGender, data?.gender ?? ''),
          _field(context, context.l10n.patientCardRefBy, widget.refBy),
        ),
      ],
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
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
              _avatar(),
              SizedBox(width: 10.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: _field(context, context.l10n.colPatientId,
                      data?.patientId?.toString() ?? ''),
                ),
              ),
              if (addPredialysis && widget.isExpand != null)
                IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  constraints: const BoxConstraints(),
                  onPressed: () =>
                      widget.isExpand!(!(widget.isExpanded ?? false)),
                  icon: Icon(widget.isExpanded == true
                      ? Icons.arrow_circle_up_outlined
                      : Icons.arrow_circle_down),
                ),
            ],
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(left: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: detailRows,
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar() {
    if (widget.imagePath == null || widget.imagePath == "") {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: const Icon(Icons.account_circle, color: Colors.grey),
      );
    }
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      width: 30.w,
      height: 30.h,
      child: CachedNetworkImage(imageUrl: widget.imagePath!),
    );
  }

  /// Two fields side by side; each half wraps on its own so a long localized
  /// label can never push the row past the card edge.
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

  /// A "Label : value" line that flows as one wrapping paragraph, so bilingual
  /// (EN / FR) labels stay inside their column instead of overflowing.
  Widget _field(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            height: 1.3,
            color: Colors.black,
          ),
          children: [
            TextSpan(text: '$label : '),
            TextSpan(
              text: value,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
