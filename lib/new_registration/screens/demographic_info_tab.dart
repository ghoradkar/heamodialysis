import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/new_registration/model/id_proof/Id_proof_data.dart';
import 'package:heamodialysis/new_registration/model/view_patient_model.dart';
import 'package:heamodialysis/new_registration/model/viral_status/viral_data.dart';
import 'package:heamodialysis/new_registration/screens/upload_document_tab.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';

class DemographicInfo extends StatefulWidget {
  final Function callB;
  final List<IdProofData> idProofListModel;
  final List<ViralData> viralStatusList;
  final bool isViewPatient;
  final ViewPatientModel? viewPatientModel;
  final String? pageTitle;

  const DemographicInfo(
      {super.key,
      required this.callB,
      required this.idProofListModel,
      required this.viralStatusList,
      required this.isViewPatient,
      this.viewPatientModel,
      this.pageTitle});

  @override
  State<DemographicInfo> createState() => DemographicInfoState();
}

class DemographicInfoState extends State<DemographicInfo>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NewRegistrationController newRegistrationController =
      Get.find<NewRegistrationController>();

  @override
  void initState() {
    // if (widget.isViewPatient || widget.pageTitle == 'Edit Patient Details') {
    //   setValuesDemographicInfo();
    // } else {
    //   newRegistrationController.refByNameController.text = "";
    //   newRegistrationController.nephrologyController.text = "";
    //   newRegistrationController.nephrologyContactNoController.text = "";
    //   newRegistrationController.relativeNameController.text = "";
    //   newRegistrationController.identificationNoController.text = "";
    //   newRegistrationController.heightFeetController.text = "";
    //   newRegistrationController.weightController.text = "";
    //   newRegistrationController.reffContactNoController.text = "";
    //   newRegistrationController.reffContactNoController.text = "";
    // }

    if (widget.isViewPatient != true) {
      newRegistrationController.heightFeetController.addListener(() {
        if (newRegistrationController.isCmChanging) {
          return; // Avoid circular updates
        }

        final feetText = newRegistrationController.heightFeetController.text;
        final regex = RegExp(r"^(\d+)'(\d+)$");

        if (regex.hasMatch(feetText)) {
          final match = regex.firstMatch(feetText);
          final feet = double.tryParse(match?.group(1) ?? '0') ?? 0;
          final inches = double.tryParse(match?.group(2) ?? '0') ?? 0;
          final totalInches = (feet * 12) + inches;
          final cm = totalInches * 2.54;

          newRegistrationController.isFeetChanging = true;
          newRegistrationController.heightCmController.text =
              cm.toStringAsFixed(2);
          newRegistrationController.isFeetChanging = false;
        }
      });

      newRegistrationController.heightCmController.addListener(() {
        if (newRegistrationController.isFeetChanging) {
          return; // Avoid circular updates
        }

        final cmText = newRegistrationController.heightCmController.text;
        final cm = double.tryParse(cmText);

        if (cm != null) {
          final totalInches = cm / 2.54;
          final feet = totalInches ~/ 12;
          final inches = totalInches % 12;

          newRegistrationController.isCmChanging = true;
          newRegistrationController.heightFeetController.text =
              "$feet'${inches.toStringAsFixed(0)}";
          newRegistrationController.isCmChanging = false;
        }
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    // if (widget.isViewPatient != true) {
    //   newRegistrationController.heightFeetController.dispose();
    //   newRegistrationController.heightCmController.dispose();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
             SizedBox(
              height: 20.h,
            ),
            Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.darkBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: ExpansionTile(
                    maintainState: true,
                    collapsedIconColor: Colors.white,
                    iconColor: Colors.white,
                    title: Row(children: [
                      Image.asset("assets/file-info.png"),
                       SizedBox(width: 12.w),
                       Text(
                        "Patient Information",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontFamily: 'Lato'),
                      ),
                    ]),
                    children: <Widget>[
                      Container(
                        padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                        decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColor.borderColor)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                             SizedBox(height: 16.h),
                            MyCustomDropdown(
                                isViewProfile: widget.isViewPatient,
                                selectedItem:
                                    newRegistrationController.selectedSchema,
                                labelText: 'Scheme Adopted',
                                items: newRegistrationController
                                        .schemaAdoptedModel?.data
                                        ?.map((e) => e.lookupDetDescEn)
                                        .toList() ??
                                    [],
                                // items: ['Schema1'],
                                hint: 'Select',
                                isRequired: true,
                                senValue: (value) {
                                  newRegistrationController.selectedSchema =
                                      value;
                                  newRegistrationController.selectedSchemeObj =
                                      newRegistrationController
                                          .schemaAdoptedModel?.data
                                          ?.firstWhere((e) =>
                                              e.lookupDetDescEn == value);
                                  newRegistrationController.refreshUi();
                                },
                                filledColor: Colors.white),
                             SizedBox(height: 8.h),
                            Visibility(
                              visible: newRegistrationController
                                      .selectedSchema ==
                                  "MJPJAY(Mahatma Jyotirao Phule Jan Arogya Yojana )",
                              child: CustomTextField(
                                maxLines: 1,
                                isReadOnly: widget.isViewPatient ? true : false,
                                keyBoardType: TextInputType.text,
                                labelText: 'MJPJAY Enrollment No',
                                hintText: 'MJPJAY Enrollment No',
                                isRequired: false,
                                txtController: newRegistrationController
                                    .mjpjayEnrollNoController,
                                fillColor: Colors.white,fontSize: 16.sp,
                              ),
                            ),
                             SizedBox(height: 8.h),
                            MyCustomDropdown(
                                isViewProfile: widget.isViewPatient,
                                selectedItem:
                                    newRegistrationController.selectedViralStat,
                                labelText: 'Viral Marker Status',
                                items: widget.viralStatusList
                                    .map((e) => e.lookupDetDescEn)
                                    .toList(),
                                hint: 'Select',
                                isRequired: true,
                                senValue: (value) {
                                  newRegistrationController.selectedViralStat =
                                      value;
                                  newRegistrationController
                                          .selectedProcedureType =
                                      widget.viralStatusList.firstWhere(
                                          (e) => e.lookupDetDescEn == value);
                                  newRegistrationController.refreshUi();
                                },
                                filledColor: Colors.white),
                             SizedBox(height: 8.h),
                            MyCustomDropdown(
                                isViewProfile: widget.isViewPatient,
                                selectedItem: newRegistrationController
                                    .selectedDialysisMode,
                                labelText: 'Dialysis Mode',
                                items: newRegistrationController
                                        .dialysisMode?.data
                                        ?.map((e) => e.lookupDetDescEn)
                                        .toList() ??
                                    [],
                                hint: 'Select',
                                isRequired: false,
                                senValue: (value) {
                                  newRegistrationController
                                      .selectedDialysisMode = value;
                                  newRegistrationController
                                          .selectedDialysisModeObj =
                                      newRegistrationController
                                          .dialysisMode?.data
                                          ?.firstWhere((e) =>
                                              e.lookupDetDescEn == value);
                                  newRegistrationController.refreshUi();
                                },
                                filledColor: Colors.white),
                             SizedBox(height: 8.h),
                            MyCustomDropdown(
                                isViewProfile: widget.isViewPatient,
                                selectedItem:
                                    newRegistrationController.selectedIdProof,
                                labelText: 'Id Proof',
                                items: widget.idProofListModel
                                    .map((e) => e.lookupDetDescEn)
                                    .toList(),
                                hint: 'Select',
                                isRequired: false,
                                senValue: (value) {
                                  newRegistrationController.selectedIdProof =
                                      value;
                                  newRegistrationController.selectedIdProfObj =
                                      widget.idProofListModel.firstWhere(
                                          (e) => e.lookupDetDescEn == value);
                                  newRegistrationController
                                      .identificationNoController.text = '';
                                  newRegistrationController.refreshUi();
                                },
                                filledColor: Colors.white),
                             SizedBox(height: 8.h),
                            CustomTextField(
                              identification:
                                  newRegistrationController.selectedIdProof,
                              maxLines: 1,
                              isReadOnly: widget.isViewPatient ? true : false,
                              keyBoardType:
                                  newRegistrationController.selectedIdProof ==
                                          "Pan Card"
                                      ? TextInputType.text
                                      : TextInputType.number,
                              labelText: 'Identification Number',
                              hintText: 'Identification Number',
                              isRequired: false,
                              txtController: newRegistrationController
                                  .identificationNoController,
                              fillColor: Colors.white,fontSize: 16.sp,
                            ),
                             SizedBox(height: 8.h),
                            Row(
                              children: [
                                Expanded(
                                  child: MyCustomDropdown(
                                    isViewProfile: widget.isViewPatient,
                                    selectedItem: newRegistrationController
                                        .selectedNationa,
                                    labelText: 'Nationality',
                                    items:
                                        newRegistrationController.nationality,
                                    hint: 'Select',
                                    senValue: (value) {
                                      newRegistrationController
                                          .selectedNationa = value;
                                      newRegistrationController.refreshUi();
                                    },
                                    filledColor: Colors.white,
                                    isRequired: false,
                                  ),
                                ),
                                 SizedBox(width: 6.w),
                                Expanded(
                                  child: MyCustomDropdown(
                                      isViewProfile: widget.isViewPatient,
                                      selectedItem: newRegistrationController
                                          .selectedBlood,
                                      labelText: 'Blood Group',
                                      items: newRegistrationController
                                              .bloodGroupModel?.data
                                              ?.map((e) => e.bloodGrouptName)
                                              .toList() ??
                                          [],
                                      hint: 'Select',
                                      isRequired: false,
                                      senValue: (value) {
                                        newRegistrationController
                                                .selectedBloodObj =
                                            newRegistrationController
                                                .bloodGroupModel?.data
                                                ?.firstWhere((e) =>
                                                    e.bloodGrouptName == value);
                                        newRegistrationController
                                                .selectedBlood =
                                            newRegistrationController
                                                .selectedBloodObj
                                                ?.bloodGrouptName;
                                        newRegistrationController.refreshUi();
                                      },
                                      filledColor: Colors.white),
                                ),
                              ],
                            ),
                             SizedBox(height: 8.h),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                      maxLines: 1,
                                      isReadOnly:
                                          widget.isViewPatient ? true : false,
                                      keyBoardType: TextInputType.text,
                                      labelText: 'Height (In Ft.)',
                                      hintText: 'Enter In Feet and Inches',
                                      isRequired: true,
                                      txtController: newRegistrationController
                                          .heightFeetController,
                                      fillColor: Colors.white,fontSize: 16.sp,),
                                ),
                                 SizedBox(width: 6.w),
                                Expanded(
                                  child: CustomTextField(
                                      maxLines: 1,
                                      isReadOnly:
                                          widget.isViewPatient ? true : false,
                                      keyBoardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      isRequired: true,
                                      labelText: 'Height (In cm.)',
                                      hintText: 'Enter',
                                      txtController: newRegistrationController
                                          .heightCmController,
                                      fillColor: Colors.white,fontSize: 16.sp,),
                                ),
                              ],
                            ),
                             SizedBox(height: 8.h),
                            CustomTextField(
                                maxLines: 1,
                                isReadOnly: widget.isViewPatient ? true : false,
                                keyBoardType: TextInputType.number,
                                isRequired: true,
                                labelText: 'Weight(Kg-Grams)',
                                hintText: 'Enter',
                                txtController:
                                    newRegistrationController.weightController,
                                fillColor: Colors.white,fontSize: 16.sp,),
                             SizedBox(height: 8.h),
                            MyCustomDropdown(
                                isViewProfile: widget.isViewPatient,
                                selectedItem: newRegistrationController
                                    .selectedReferredBy,
                                labelText: 'Referred By',
                                items: newRegistrationController
                                        .referredByModel?.data
                                        ?.map((e) => e.lookupDetDescEn)
                                        .toList() ??
                                    [],
                                hint: 'Select',
                                isRequired: false,
                                senValue: (value) {
                                  newRegistrationController.selectedReferredBy =
                                      value;
                                  newRegistrationController.refreshUi();
                                },
                                filledColor: Colors.white),
                             SizedBox(height: 8.h),
                            CustomTextField(
                                maxLines: 1,
                                isReadOnly: widget.isViewPatient ? true : false,
                                keyBoardType: TextInputType.name,
                                labelText: 'Reference By Name',
                                hintText: 'Enter name',
                                isRequired: false,
                                txtController: newRegistrationController
                                    .refByNameController,
                                fillColor: Colors.white,fontSize: 16.sp,),
                             SizedBox(height: 8.h),
                            CustomTextField(
                                maxLines: 1,
                                isReadOnly: widget.isViewPatient ? true : false,
                                keyBoardType: TextInputType.phone,
                                labelText: 'Referred Contact Number',
                                hintText: 'Enter contact number',
                                isRequired: false,
                                txtController: newRegistrationController
                                    .reffContactNoController,
                                fillColor: Colors.white,fontSize: 16,),
                             SizedBox(height: 8.h),
                            CustomTextField(
                                maxLines: 1,
                                isReadOnly: widget.isViewPatient ? true : false,
                                keyBoardType: TextInputType.name,
                                labelText: 'Nephrologist Name',
                                hintText: 'Enter name',
                                isRequired: true,
                                txtController: newRegistrationController
                                    .nephrologyController,
                                fillColor: Colors.white,fontSize: 16.sp,),
                             SizedBox(height: 8.h),
                            CustomTextField(
                                maxLines: 1,
                                isReadOnly: widget.isViewPatient ? true : false,
                                keyBoardType: TextInputType.phone,
                                labelText: 'Nephrologist Contact No',
                                hintText: 'Enter number',
                                isRequired: false,
                                txtController: newRegistrationController
                                    .nephrologyContactNoController,
                                fillColor: Colors.white,fontSize: 16.sp,),
                             SizedBox(height: 8.h),
                            MyCustomDropdown(
                                selectedItem: newRegistrationController
                                    .selectedDiaModeFreq,
                                isViewProfile: widget.isViewPatient,
                                labelText: 'Dialysis Frequency in Week',

                                items: newRegistrationController
                                        .dialysisFreqModel?.dialysisFrequency
                                        ?.map((e) => e.lookupDescEn)
                                        .toList() ??
                                    [],
                                hint: 'Select',
                                isRequired: true,
                                senValue: (value) {
                                  newRegistrationController
                                      .selectedDiaModeFreq = value;
                                },
                                filledColor: Colors.white),
                             SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
             SizedBox(
              height: 10.h,
            ),
            Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.darkBlue,
                        borderRadius: BorderRadius.circular(10)),
                    child: ExpansionTile(
                      maintainState: true,
                      collapsedIconColor: Colors.white,
                      iconColor: Colors.white,
                      title: Row(children: [
                        Image.asset("assets/relation.png"),
                         SizedBox(width: 12.w),
                         Text(
                          "Emergency Relative Info",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontFamily: 'Lato'),
                        ),
                      ]),
                      children: <Widget>[
                        Container(
                          padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                          decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.borderColor)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              CustomTextField(
                                  maxLines: 1,
                                  isReadOnly:
                                      widget.isViewPatient ? true : false,
                                  keyBoardType: TextInputType.name,
                                  labelText: 'Relative Name',
                                  hintText: 'Enter name',
                                  isRequired: false,
                                  txtController: newRegistrationController
                                      .relativeNameController,
                                  fillColor: Colors.white,fontSize: 16.sp,),
                               SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: MyCustomDropdown(
                                      isViewProfile: widget.isViewPatient,
                                      selectedItem: newRegistrationController
                                          .selectedRelation,
                                      labelText: 'Relation',
                                      items: newRegistrationController
                                              .relationModel?.data
                                              ?.where((e) =>
                                                  e.lookupDetDescEn !=
                                                  'SELF') // Exclude 'Father'
                                              .map((e) => e.lookupDetDescEn)
                                              .toList() ??
                                          [],
                                      hint: 'Select',
                                      isRequired: false,
                                      senValue: (value) {
                                        newRegistrationController
                                                .selectedRelationObj =
                                            newRegistrationController
                                                .relationModel?.data
                                                ?.firstWhere((e) =>
                                                    e.lookupDetDescEn == value);
                                        newRegistrationController
                                            .selectedRelation = value;
                                        newRegistrationController.refreshUi();
                                      },
                                      filledColor: Colors.white,
                                    ),
                                  ),
                                   SizedBox(width: 8.w),
                                  Expanded(
                                    child: CustomTextField(
                                        maxLines: 1,
                                        isReadOnly:
                                            widget.isViewPatient ? true : false,
                                        keyBoardType: TextInputType.phone,
                                        labelText: 'Contact No',
                                        hintText: 'Enter number',
                                        isRequired: false,
                                        txtController: newRegistrationController
                                            .contactNoController,
                                        fillColor: Colors.white,fontSize: 16.sp,),
                                  ),
                                ],
                              ),
                               SizedBox(height: 16.h),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 18),
                              child: CustomText(text: 'Upload Document', fontSize: 14, fontWeight: FontWeight.w600, textColor: Colors.black, textAlign: TextAlign.start),
                            ),
                              const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 18),
                              child: CustomText(text: 'Supported Formats : JPEG, PNG, PDF', fontSize: 14, fontWeight: FontWeight.w400, textColor: Colors.grey, textAlign: TextAlign.start),
                            ),
                              const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                              child: CustomText(text: 'Max File Size : 10 MB', fontSize: 14, fontWeight: FontWeight.w400, textColor: Colors.grey, textAlign: TextAlign.start),
                            ),
                              CustomUploadButton(
                                isSelected: newRegistrationController
                                    .relativeDoc.isSelected,
                                index: 0,
                                title:
                                newRegistrationController.relativeDoc.name,
                                callB: () {
                                  pickFile(newRegistrationController
                                      .relativeDoc.key);
                                },
                                callDelete: () {
                                  // newRegistrationController.items[index].isSelected = false;
                                  newRegistrationController
                                      .relativeDoc.isSelected = false;
                                  newRegistrationController.relativeDoc.file =
                                  null;
                                  setState(() {});
                                },
                                viewCallBack: () {
                                  Get.to(() => CustomViewer(
                                    fileUrl: newRegistrationController
                                        .relativeDoc.file!.path,
                                  ));
                                  // }
                                },
                                isReq:
                                newRegistrationController.relativeDoc.isReq,
                                isViewProfile: widget.isViewPatient,
                                showIndex: false,
                              ).paddingOnly(bottom: 8.h,left: 5.w,right: 5.w),

                            ],
                          ),
                        ),
                      ],
                    ))),
             SizedBox(
              height: 40.h,
            ),
            Visibility(
              visible: widget.isViewPatient == false,
              child: CustomButton(
                primColor: AppColor.primaryBackgroundColor,
                secColor: AppColor.secondaryColor,
                textColor: Colors.white,
                iconColor: Colors.white,
                buttonText: 'Save & Next',
                path: 'assets/save-next.png',
                callB: () {
                  if (formKey.currentState?.validate() ?? false) {
                    // Form is valid, proceed with further actions
                    widget.callB();
                    // newRegistrationController
                    //     .savePatientReqModel.nationalityId = 1;
                    // newRegistrationController
                    //         .savePatientReqModel.referredContactNumber =
                    //     newRegistrationController.reffContactNoController.text;
                    // newRegistrationController
                    //         .savePatientReqModel.relativeMobileNo =
                    //     newRegistrationController.contactNoController.text;
                    //
                    // newRegistrationController
                    //         .savePatientReqModel.procedureType =
                    //     newRegistrationController
                    //         .selectedProcedureType?.lookupDetDescEn;
                    // newRegistrationController.savePatientReqModel
                    //         .lookupDetIdHaemodialysisProcedureType =
                    //     newRegistrationController
                    //         .selectedProcedureType?.lookupDetId;
                    // newRegistrationController
                    //         .savePatientReqModel.lookupDetIdDialysisMode =
                    //     newRegistrationController
                    //         .selectedDialysisModeObj?.lookupDetId;
                    // newRegistrationController
                    //         .savePatientReqModel.identificationNumber =
                    //     newRegistrationController.selectedIdProof;
                    // newRegistrationController.savePatientReqModel.relativeName =
                    //     newRegistrationController.relativeNameController.text;
                    // newRegistrationController
                    //         .savePatientReqModel.referenceByName =
                    //     newRegistrationController.refByNameController.text;
                    // newRegistrationController
                    //         .savePatientReqModel.nephrologistContactNumber =
                    //     newRegistrationController
                    //         .nephrologyContactNoController.text;
                    // newRegistrationController
                    //         .savePatientReqModel.nephrologistName =
                    //     newRegistrationController.nephrologyController.text;
                    // if (newRegistrationController.selectedDiaModeFreq != null) {
                    //   newRegistrationController.savePatientReqModel
                    //           .lookupDetIdDialysisFrequencyInWeek =
                    //       int.parse(
                    //           newRegistrationController.selectedDiaModeFreq!);
                    //
                    //   newRegistrationController
                    //           .savePatientReqModel.dialysisFrequencyInWeek =
                    //       int.parse(
                    //           newRegistrationController.selectedDiaModeFreq!);
                    // }
                    //
                    // newRegistrationController
                    //         .savePatientReqModel.referedContactNumber =
                    //     newRegistrationController.reffContactNoController.text;
                    // newRegistrationController
                    //         .savePatientReqModel.referedContactNumber =
                    //     newRegistrationController.reffContactNoController.text;
                    // newRegistrationController.savePatientReqModel.refByName =
                    //     newRegistrationController.refByNameController.text;
                    // newRegistrationController
                    //         .savePatientReqModel.identificationNumber =
                    //     newRegistrationController
                    //         .identificationNoController.text;
                    //
                    // var referredB = newRegistrationController
                    //     .referredByModel?.data
                    //     ?.firstWhere(
                    //         (e) =>
                    //             e.lookupDetDescEn ==
                    //             newRegistrationController.selectedReferredBy,
                    //         orElse: () => ReferredByData());
                    // newRegistrationController.savePatientReqModel
                    //     .lookupDetIdRefByRef = referredB?.lookupDetId;
                    // newRegistrationController.savePatientReqModel.referredBy =
                    //     newRegistrationController.refByNameController.text;
                    // if (newRegistrationController
                    //     .weightController.text.isNotEmpty) {
                    //   newRegistrationController.savePatientReqModel.pweight =
                    //       double.parse(
                    //           newRegistrationController.weightController.text);
                    // }
                    // if (newRegistrationController
                    //     .heightFeetController.text.isNotEmpty) {
                    //   newRegistrationController.savePatientReqModel.pheight =
                    //       double.parse(newRegistrationController
                    //           .heightCmController.text);
                    // }
                    //
                    // newRegistrationController.savePatientReqModel.bloodGroupId =
                    //     newRegistrationController
                    //         .selectedBloodObj?.bloodGroupId;
                    // newRegistrationController.savePatientReqModel.relationId =
                    //     newRegistrationController
                    //         .selectedRelationObj?.lookupDetId;
                    // newRegistrationController
                    //         .savePatientReqModel.identityProofId =
                    //     newRegistrationController
                    //         .selectedIdProfObj?.lookupDetId;
                    // newRegistrationController
                    //         .savePatientReqModel.lookupDetIdPatientType =
                    //     newRegistrationController
                    //         .selectedSchemeObj?.lookupDetId;
                    //
                    // newRegistrationController
                    //         .savePatientReqModel.mJPJAYEnrollmentNo =
                    //     newRegistrationController.mjpjayEnrollNoController.text;
                    //
                    // newRegistrationController
                    //         .savePatientReqModel.mJPJAYEnrollmentNo =
                    //     newRegistrationController.mjpjayEnrollNoController.text;
                    //
                    // newRegistrationController
                    //         .savePatientReqModel.nephrologistContactNo =
                    //     newRegistrationController
                    //         .nephrologyContactNoController.text;
                    debugPrint('Form is valid');
                  }
                  // else {
                  //   // Form is invalid, show errors
                  //   CustomMessage.toast("Please fill madetory details");
                  //   debugPrint('Form is invalid');
                  // }
                },
                buttonWidth: 140.w,
              ),
            ),
             SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickFile(String key) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String extension = file.path.split('.').last.toLowerCase();
      int fileSizeInBytes = await file.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (['jpg', 'jpeg', 'png'].contains(extension) && fileSizeInMB > 10) {
        debugPrint('Image should not exceed 10 MB.');
        return;
      }

      setState(() {
        // FileDetails uploadedFile =
        // newRegistrationController.items.firstWhere((e) => e.key == key);

        FileDetails uploadedFile = newRegistrationController.relativeDoc;
        uploadedFile.file = file;
        uploadedFile.isSelected = true;
      });

      debugPrint(newRegistrationController.items.length.toString());
    } else {
      debugPrint('No file selected.');
    }
  }

  convertCmHeightToFeet() {
    final cmText = widget.viewPatientModel?.data?.pheight.toString();
    if (cmText != null) {
      final cm = double.tryParse(cmText);

      if (cm != null) {
        final totalInches = cm / 2.54;
        final feet = totalInches ~/ 12;
        final inches = totalInches % 12;

        newRegistrationController.isCmChanging = true;
        newRegistrationController.heightFeetController.text =
            "$feet'${inches.toStringAsFixed(0)}";
        newRegistrationController.isCmChanging = false;
      }
    } else {
      newRegistrationController.heightFeetController.text = '';
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
