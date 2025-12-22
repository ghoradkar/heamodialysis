import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/model/schema_adopted/schema_data.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/new_registration/model/view_patient_model.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class PatientCardDetails extends StatefulWidget {
  // final String gender;
  // final String age;
  final String refBy;
  final String schemaAdopted;
  final String? imagePath;
  final bool? isFromAddPredialysis;
  final bool? isExpanded;
  final ViewPatientModel? patientDetails;
  final Function? isExpand;

  const PatientCardDetails(
      {super.key,

      // required this.gender,
      // required this.age,
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
    setState(() => isLoading = true);

    await newRegistrationController.getSchemaAdoptedList();

    // schemaList = newRegistrationController.schemaAdoptedModel?.data;
    // if (schemaList != null &&
    //     widget.patientDetails?.data?.lookupDetIdPatientType != null) {
    //   schemAdpt = schemaList?.firstWhere(
    //     (e) =>
    //         e.lookupDetId ==
    //         widget.patientDetails?.data?.lookupDetIdPatientType,
    //     orElse: () => SchemaData(),
    //   );
    // }

    setState(() => isLoading = false);
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

    return isLoading
        ? const CircularProgressIndicator()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    AppColor.primaryBackgroundColor.withValues(alpha: (0.2)),
                    AppColor.secondaryColor.withValues(alpha: (0.2))
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                )),
            child: Column(
              children: [
                Row(

                  children: [
                    (widget.imagePath == null || widget.imagePath == "")
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 4.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Icon(
                              Icons.account_circle,
                              color: Colors.grey,
                            ),
                          )
                        : Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            width: 30.w,
                            height: 30.h,
                            child: CachedNetworkImage(
                              imageUrl: widget.imagePath!,
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
                      text: widget.patientDetails?.data?.patientId.toString() ??
                          '',
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                    const Spacer(),
                    Visibility(
                        visible: widget.isFromAddPredialysis == true,
                        child: IconButton(
                            onPressed: () {
                              if (widget.isExpand != null) {
                                widget.isExpand!(!widget.isExpanded!);
                              }
                            },
                            icon: widget.isExpanded == true
                                ? const Icon(Icons.arrow_circle_up_outlined)
                                : const Icon(Icons.arrow_circle_down)))
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
                      text:
                          "${widget.patientDetails?.data?.fName} ${widget.patientDetails?.data?.lName ?? ''}",
                      fontSize: 12.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                      textAlign: TextAlign.start,
                    )
                  ],
                ).paddingOnly(bottom: 1.h),
                Visibility(
                  visible: widget.isFromAddPredialysis != true,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Row(
                          children: [
                            CustomText(
                              text: 'Mobile No :',
                              fontSize: 12.sp,
                              fontFam: 'Lato',
                              fontWeight: FontWeight.w400,
                              textColor: Colors.black,
                              textAlign: TextAlign.start,
                            ),
                            CustomText(
                              text: widget.patientDetails?.data?.mobile ?? "",
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
                              text:
                                  widget.patientDetails?.data?.age.toString() ??
                                      '0',
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
                ),
                Visibility(
                  visible: widget.isFromAddPredialysis == true,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child:Row(
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Scheme Adopt : ',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: schemAdpt?.lookupDetDescEn ?? '',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 2, // 🔑 responsive
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ).paddingOnly(top: 2.h, bottom: 1.h),
                      ),
                    ],
                  ).paddingOnly(top: 2.h, bottom: 1.h),
                ),
                Visibility(
                  visible: widget.isFromAddPredialysis == false ||
                      widget.isFromAddPredialysis == null,
                  child: Row(
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
                              text: widget.patientDetails?.data?.gender ?? '',
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
                              text: 'Ref. By :',
                              fontSize: 12.sp,
                              fontFam: 'Lato',
                              fontWeight: FontWeight.w400,
                              textColor: Colors.black,
                              textAlign: TextAlign.start,
                            ),
                            CustomText(
                              text: widget.refBy,
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
                ),
                Visibility(
                  visible: widget.isFromAddPredialysis == true,
                  child: Row(
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
                              text: widget.patientDetails?.data?.gender ?? '',
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
                              text:
                                  widget.patientDetails?.data?.age.toString() ??
                                      '',
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
                ),
                Visibility(
                  visible: widget.isExpanded == true,
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Row(
                              children: [
                                CustomText(
                                  text: 'Height :',
                                  fontSize: 12.sp,
                                  fontFam: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start,
                                ),
                                CustomText(
                                  text: widget.patientDetails?.data?.pheight !=
                                          null
                                      ? widget.patientDetails?.data?.pheight
                                              .toString() ??
                                          ''
                                      : "0 Kg",
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
                                  text: 'Weight :',
                                  fontSize: 12.sp,
                                  fontFam: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start,
                                ),
                                CustomText(
                                  text: widget.patientDetails?.data?.pweight !=
                                          null
                                      ? widget.patientDetails?.data?.pweight
                                              .toString() ??
                                          ''
                                      : "0 Kg",
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
                )
              ],
            ),
          );
  }
}
