import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/new_registration/model/refferedBy/referred_by_data.dart';
import 'package:heamodialysis/new_registration/model/view_patient_model.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';
import '../../widgets/custom_expandable.dart';

class UploadDocument extends StatefulWidget {
  final bool isViewPatient;
  final ViewPatientModel? viewPatientModel;
  final String? pageTitle;

  const UploadDocument(
      {super.key,
        required this.isViewPatient,
        this.viewPatientModel,
        this.pageTitle});

  @override
  State<UploadDocument> createState() => UploadDocumentState();
}

class UploadDocumentState extends State<UploadDocument>
    with AutomaticKeepAliveClientMixin {
  final NewRegistrationController newRegistrationController =
  Get.find<NewRegistrationController>();

  var userData;

  bool hasInternet = true;

  @override
  void initState() {
    getUserData();
    checkInternetAndLoadData();
    //loadDocuments();
    super.initState();
  }

  Future<void> loadDocuments() async {
    await newRegistrationController.getDocList(

      widget.isViewPatient,
      widget.pageTitle == 'Edit Patient Details',
      widget.viewPatientModel?.data?.patientId,
    );
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));

    newRegistrationController.refreshUi();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    newRegistrationController.refreshUi();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<NewRegistrationController>(
        init: newRegistrationController,
        builder: (controller) {
          return hasInternet
              ? controller.isLoading
              ? const Center(child: PatientListShimmer())
              : SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                CustomExpandableContainer(
                  text: context.l10n.regUploadDocument,
                  leading: "assets/file-text.png",
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF8F8F8),
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColor.borderColor)),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 16.h),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 11.h,
                                            horizontal: 11.w),
                                        child: Image.asset(
                                            'assets/file.png'),
                                      ),
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text:
                                                'Browse and choose the files you want to upload',
                                                fontSize: 11.sp,
                                                fontFam: 'Lato',
                                                fontWeight:
                                                FontWeight.w400,
                                                textColor:
                                                Color(0xFF666666),
                                                textAlign:
                                                TextAlign.start,
                                              ),
                                              CustomText(
                                                text:
                                                'Supported Formats : JPEG, PNG, PDF, Word',
                                                fontSize: 11.sp,
                                                fontFam: 'Lato',
                                                fontWeight:
                                                FontWeight.w400,
                                                textColor:
                                                Color(0xFF666666),
                                                textAlign:
                                                TextAlign.start,
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              CustomText(
                                                text:
                                                'Max File Size: 10 MB',
                                                fontSize: 11.sp,
                                                fontFam: 'Lato',
                                                fontWeight:
                                                FontWeight.w600,
                                                textColor: Colors.black,
                                                textAlign:
                                                TextAlign.start,
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                  SizedBox(height: 16.h),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 8.w),
                              decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColor.borderColor)),
                              child: SizedBox(
                                height: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.45,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount:
                                    newRegistrationController
                                        .items.length,
                                    itemBuilder: (context, index) {
                                      final item =
                                      newRegistrationController
                                          .items[index];
                                      print(
                                        'itemitem : name=${item.name}, '
                                            'selected=${item.isSelected}, '
                                            'isReq=${item.isReq}, '
                                            'file=${item.file?.path}',
                                      );

                                      return CustomUploadButton(
                                        isSelected:
                                        newRegistrationController
                                            .items[index]
                                            .isSelected,
                                        index: index,
                                        title:
                                        newRegistrationController
                                            .items[index].name,
                                        callB: () {
                                          pickFile(
                                              newRegistrationController
                                                  .items[index]);
                                        },
                                        callDelete: () {
                                          newRegistrationController
                                              .items[index]
                                              .isSelected = false;
                                          newRegistrationController
                                              .items[index]
                                              .file = null;
                                          setState(() {});
                                        },
                                        viewCallBack: () {
                                          debugPrint(
                                              newRegistrationController
                                                  .items[index]
                                                  .file!
                                                  .path);
                                          Get.to(() => CustomViewer(
                                            fileUrl:
                                            newRegistrationController
                                                .items[index]
                                                .file!
                                                .path,
                                          ));
                                          // }
                                        },
                                        isReq:
                                        newRegistrationController
                                            .items[index].isReq,
                                        isViewProfile:
                                        widget.isViewPatient,
                                        showIndex: true,
                                      ).paddingOnly(bottom: 8.h);
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Theme(
                //     data: ThemeData()
                //         .copyWith(dividerColor: Colors.transparent),
                //     child: Container(
                //       decoration: BoxDecoration(
                //           color: AppColor.darkBlue,
                //           borderRadius: BorderRadius.circular(10)),
                //       child: ExpansionTile(
                //         maintainState: true,
                //         iconColor: Colors.white,
                //         collapsedIconColor: Colors.white,
                //         title: Row(children: [
                //           Image.asset('assets/file-text.png'),
                //           SizedBox(width: 12.w),
                //           Text(
                //             "Upload Document",
                //             style: TextStyle(
                //                 fontSize: 14.sp,
                //                 color: Colors.white,
                //                 fontFamily: 'Lato'),
                //           ),
                //         ]),
                //         children: <Widget>[
                //           Container(
                //             padding: EdgeInsets.symmetric(
                //                 vertical: 8.h, horizontal: 8.w),
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             child: Column(
                //               children: [
                //                 Container(
                //                   padding: EdgeInsets.symmetric(
                //                       vertical: 8.h, horizontal: 8.w),
                //                   decoration: BoxDecoration(
                //                       color: Colors.grey[50],
                //                       borderRadius:
                //                       BorderRadius.circular(10),
                //                       border: Border.all(
                //                           color:
                //                           AppColor.borderColor)),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                     CrossAxisAlignment.stretch,
                //                     children: [
                //                       SizedBox(height: 16.h),
                //                       Row(
                //                         children: [
                //                           Padding(
                //                             padding:
                //                             EdgeInsets.symmetric(
                //                                 vertical: 16.h,
                //                                 horizontal: 16.w),
                //                             child: Image.asset(
                //                                 'assets/file.png'),
                //                           ),
                //                           Expanded(
                //                               child: Column(
                //                                 crossAxisAlignment:
                //                                 CrossAxisAlignment
                //                                     .start,
                //                                 children: [
                //                                   CustomText(
                //                                     text:
                //                                     'Browse and choose the files you want to upload',
                //                                     fontSize: 12.sp,
                //                                     fontFam: 'Lato',
                //                                     fontWeight:
                //                                     FontWeight.w400,
                //                                     textColor:
                //                                     Color(0xFF666666),
                //                                     textAlign:
                //                                     TextAlign.start,
                //                                   ),
                //                                   CustomText(
                //                                     text:
                //                                     'Supported Formats : JPEG, PNG, PDF, Word',
                //                                     fontSize: 12.sp,
                //                                     fontFam: 'Lato',
                //                                     fontWeight:
                //                                     FontWeight.w400,
                //                                     textColor:
                //                                     Color(0xFF666666),
                //                                     textAlign:
                //                                     TextAlign.start,
                //                                   ),
                //                                   SizedBox(height: 2,),
                //                                   CustomText(
                //                                     text:
                //                                     'Max File Size: 10 MB',
                //                                     fontSize: 12.sp,
                //                                     fontFam: 'Lato',
                //                                     fontWeight:
                //                                     FontWeight.w600,
                //                                     textColor:
                //                                     Colors.black,
                //                                     textAlign:
                //                                     TextAlign.start,
                //                                   ),
                //                                 ],
                //                               ))
                //                         ],
                //                       ),
                //                       SizedBox(height: 16.h),
                //                     ],
                //                   ),
                //                 ),
                //                 SizedBox(height: 16.h),
                //                 Container(
                //                   padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                //                   decoration: BoxDecoration(
                //                       color: Colors.grey[50],
                //                       borderRadius:
                //                       BorderRadius.circular(10),
                //                       border: Border.all(
                //                           color:
                //                           AppColor.borderColor)),
                //                   child: SizedBox(
                //                     height: MediaQuery.of(context)
                //                         .size
                //                         .height *
                //                         0.45,
                //                     child: ListView.builder(
                //                         shrinkWrap: true,
                //                         primary: false,
                //                         itemCount:
                //                         newRegistrationController
                //                             .items.length,
                //                         itemBuilder:
                //                             (context, index) {
                //                           return CustomUploadButton(
                //                             isSelected:
                //                             newRegistrationController
                //                                 .items[index]
                //                                 .isSelected,
                //                             index: index,
                //                             title:
                //                             newRegistrationController
                //                                 .items[index]
                //                                 .name,
                //                             callB: () {
                //                               pickFile(
                //                                   newRegistrationController
                //                                       .items[index]);
                //                             },
                //                             callDelete: () {
                //                               newRegistrationController
                //                                   .items[index]
                //                                   .isSelected = false;
                //                               newRegistrationController
                //                                   .items[index]
                //                                   .file = null;
                //                               setState(() {});
                //                             },
                //                             viewCallBack: () {
                //                               debugPrint(
                //                                   newRegistrationController
                //                                       .items[index]
                //                                       .file!
                //                                       .path);
                //                               Get.to(
                //                                       () => CustomViewer(
                //                                     fileUrl: newRegistrationController
                //                                         .items[
                //                                     index]
                //                                         .file!
                //                                         .path,
                //                                   ));
                //                               // }
                //                             },
                //                             isReq:
                //                             newRegistrationController
                //                                 .items[index]
                //                                 .isReq,
                //                             isViewProfile:
                //                             widget.isViewPatient,
                //                             showIndex: true,
                //                           ).paddingOnly(bottom: 8.h);
                //                         }),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     )),
                //
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
                    buttonText: context.l10n.commonSave,
                    path: 'assets/save-next.png',
                    callB: newRegistrationController.isLoading
                        ? null
                        : () async {
                      // Check if all required documents are uploaded
                      // First validate Personal Info Tab
                      if (!validatePersonalInfoTab()) {
                        CustomMessage.toast(context.l10n.regCompletePersonalFirst);
                        return;
                      }

                      // Validate Demographic Info Tab
                      if (!validateDemographicInfoTab()) {
                        CustomMessage.toast(context.l10n.regCompleteDemographicFirst);
                        return;
                      }

                      // Validate History of Dialysis Tab
                      if (!validateHistoryOfDialysisTab()) {
                        CustomMessage.toast(context.l10n.regCompleteHistoryFirst);
                        return;
                      }
                      bool allRequiredDocsUploaded =
                      newRegistrationController.items.any(
                              (item) =>
                          item.isReq &&
                              item.file != null);

                      if (!allRequiredDocsUploaded) {
                        CustomMessage.toast(
                            context.l10n.regUploadRequiredDocuments);
                        return;
                      }

                      // Validate duplicate mobile number
                      controller.mobileNoCheckMsg =
                      await controller
                          .checkDuplicateMobileNo(controller
                          .mobileController.text);

                      String createdDate =
                      formatDateTimeToCustomString(
                          DateTime.now());

                      // Set patient ID for edit
                      if (widget.pageTitle ==
                          'Edit Patient Details') {
                        newRegistrationController
                            .savePatientReqModel.patientId =
                            widget.viewPatientModel?.data
                                ?.patientId
                                ?.toString();
                      }

                      // Collect data from tabs
                      profileInfoTabData();
                      demographicInfoData();
                      historyOfDialysis();
                      uploadDocTabData(createdDate);

                      final isNew = widget.pageTitle ==
                          'New Registration';
                      final isEditOrView = widget.pageTitle ==
                          'Edit Patient Details' ||
                          widget.pageTitle ==
                              'View Patient Details';

                      if (isNew) {
                        bool isScrutinyReady =
                            controller.isServiceDefined ==
                                true &&
                                controller.isScrutinyDefined ==
                                    true &&
                                controller.isQuestionsDefined ==
                                    true;

                        if (!isScrutinyReady) {
                          CustomPopup.showSuccessDialog(
                                () => Get.back(),
                            "Info",
                            "Scrutiny is not defined for this institute against patient registration service!!",
                          );
                          controller.update();
                          return;
                        }

                        if (controller.mobileNoCheckMsg ==
                            'Mobile number already exists') {
                          CustomMessage.toast(
                              controller.mobileNoCheckMsg);
                          controller.mobileController.clear();
                          controller.update();
                          return;
                        }
                      }

                      // Save data for new or edit
                      if (isNew || isEditOrView) {
                        newRegistrationController.savePatient(
                          widget.pageTitle,
                          userData['user_ID'].toString(),
                        );
                      }

                      // bool hasNullFilePath =
                      //     (newRegistrationController.items.any(
                      //         (obj) =>
                      //             obj.isReq &&
                      //             obj.file != null));
                      // if (hasNullFilePath) {
                      //   controller.mobileNoCheckMsg =
                      //       await controller
                      //           .checkDuplicateMobileNo(
                      //               controller
                      //                   .mobileController.text);
                      //
                      //   var creDate =
                      //       formatDateTimeToCustomString(
                      //           DateTime.now());
                      //   if (widget.pageTitle ==
                      //       'Edit Patient Details') {
                      //     newRegistrationController
                      //             .savePatientReqModel
                      //             .patientId =
                      //         widget.viewPatientModel?.data
                      //             ?.patientId
                      //             .toString();
                      //   }
                      //
                      //   profileInfoTabData();
                      //   demographicInfoData();
                      //   historyOfDialysis();
                      //   uploadDocTabData(creDate);
                      //
                      //   if (widget.pageTitle ==
                      //       'New Registration') {
                      //     if (controller.isServiceDefined ==
                      //             true &&
                      //         controller.isScrutinyDefined ==
                      //             true &&
                      //         controller.isQuestionsDefined ==
                      //             true) {
                      //       if (controller.mobileNoCheckMsg !=
                      //           'Mobile number already exists') {
                      //         newRegistrationController
                      //             .savePatient(
                      //                 widget.pageTitle,
                      //                 userData['user_ID']
                      //                     .toString());
                      //       } else {
                      //         CustomMessage.toast(
                      //             controller.mobileNoCheckMsg);
                      //         controller.mobileController
                      //             .clear();
                      //         controller.update();
                      //       }
                      //     } else {
                      //       CustomPopup.showSuccessDialog(() {
                      //         Get.back();
                      //       }, "Info",
                      //           "Scrutiny is not define for this institute against patient registration service!!");
                      //
                      //       controller.update();
                      //     }
                      //   } else if (widget.pageTitle ==
                      //           'Edit Patient Details' ||
                      //       widget.pageTitle ==
                      //           'View Patient Details') {
                      //     newRegistrationController.savePatient(
                      //         widget.pageTitle,
                      //         userData['user_ID'].toString());
                      //   }
                      // } else {
                      //   CustomMessage.toast(
                      //       context.l10n.regUploadRequiredDocuments);
                      // }
                    },
                    buttonWidth: 150.w,
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          )
              : InternetIssue(
            onRetryPressed: () {
              checkInternetAndLoadData();
            },
          );
        });
  }

  void profileInfoTabData() {
    newRegistrationController.savePatientReqModel.imageName =
        newRegistrationController.image?.path.split("/").last;
    newRegistrationController.savePatientReqModel.abhaNo =
        newRegistrationController.abhaNoController.text;
    newRegistrationController.savePatientReqModel.prefix =
        newRegistrationController.prefixVal;
    newRegistrationController.savePatientReqModel.fName =
        newRegistrationController.firstNameController.text;
    newRegistrationController.savePatientReqModel.mName =
        newRegistrationController.middleNameController.text;
    newRegistrationController.savePatientReqModel.lName =
        newRegistrationController.lastNameController.text;
    newRegistrationController.savePatientReqModel.mobile =
        newRegistrationController.mobileController.text;
    newRegistrationController.savePatientReqModel.emailId =
        newRegistrationController.emailController.text;
    newRegistrationController.savePatientReqModel.gender =
        newRegistrationController.selectedGender;

    newRegistrationController.savePatientReqModel.dob =
        newRegistrationController.formattedDateDBO;
    newRegistrationController.savePatientReqModel.maritalStatusId =
        newRegistrationController.selectedMarriedObj?.lookupDetId;
    newRegistrationController.savePatientReqModel.age =
        newRegistrationController.years;
    newRegistrationController.savePatientReqModel.ageMonths =
        newRegistrationController.months;
    newRegistrationController.savePatientReqModel.ageDays =
        newRegistrationController.days;

    newRegistrationController.savePatientReqModel.talukaId =
        newRegistrationController.selectedTalukaObject?.talukaID;
    newRegistrationController.savePatientReqModel.pertalukaId =
        newRegistrationController.perSelectedTalukaObject?.talukaID ??
            newRegistrationController.selectedTalukaObject?.talukaID;
    newRegistrationController.savePatientReqModel.townId =
        newRegistrationController.selectedTownObj?.cityId;
    newRegistrationController.savePatientReqModel.pertownId =
        newRegistrationController.perSelectedTownObj?.cityId ??
            newRegistrationController.selectedTownObj?.cityId;
    newRegistrationController.savePatientReqModel.districtId =
        newRegistrationController.selectedDistObj?.districtID;
    newRegistrationController.savePatientReqModel.perdistrictId =
        newRegistrationController.perSelectedDistObj?.districtID ??
            newRegistrationController.selectedDistObj?.districtID;
    newRegistrationController.savePatientReqModel.divisionId =
        newRegistrationController.selectedDivisionObj?.divId;
    newRegistrationController.savePatientReqModel.perDivisionId =
        newRegistrationController.perSelectedDivisionObj?.divId ??
            newRegistrationController.selectedDivisionObj?.divId;

    newRegistrationController.savePatientReqModel.stateId =
        newRegistrationController.selectedStateObj?.stateID;
    newRegistrationController.savePatientReqModel.perstateId =
        newRegistrationController.perSelectedStateObj?.stateID ??
            newRegistrationController.selectedStateObj?.stateID;

    newRegistrationController.savePatientReqModel.countryId = 1;

    newRegistrationController.savePatientReqModel.address =
        newRegistrationController.addressController.text;
    newRegistrationController.savePatientReqModel.perAddress =
    newRegistrationController.perAddressController.text.isNotEmpty
        ? newRegistrationController.perAddressController.text
        : newRegistrationController.addressController.text;

    newRegistrationController.savePatientReqModel.percountryId = 1;

    newRegistrationController.savePatientReqModel.countryId = 1;

    newRegistrationController.savePatientReqModel.occupation =
    newRegistrationController.selectedOccuObj?.lookupDetId != null
        ? newRegistrationController.selectedOccuObj!.lookupDetId.toString()
        : '';
    newRegistrationController.savePatientReqModel.education =
    newRegistrationController.selectedEduObj?.lookupDetId != null
        ? newRegistrationController.selectedEduObj!.lookupDetId.toString()
        : '';
    newRegistrationController.savePatientReqModel.monthlyIncome =
        newRegistrationController.selectedMonthlyIncomeObj?.lookupId;

    newRegistrationController.savePatientReqModel.economicStatus =
        newRegistrationController.socEcoStat;
    newRegistrationController.savePatientReqModel.religion =
    newRegistrationController.selectedRelifionObj?.lookupDetId != null
        ? newRegistrationController.selectedRelifionObj!.lookupDetId
        .toString()
        : '';

    if (newRegistrationController.pincodeController.text.isNotEmpty) {
      newRegistrationController.savePatientReqModel.areaCode =
          int.parse(newRegistrationController.pincodeController.text);
    }
    if (newRegistrationController.perPincodeController.text.isNotEmpty) {
      newRegistrationController.savePatientReqModel.perareaCode =
          int.parse(newRegistrationController.perPincodeController.text);
    }
    if (newRegistrationController.pincodeController.text.isNotEmpty) {
      newRegistrationController.savePatientReqModel.perareaCode =
          int.parse(newRegistrationController.pincodeController.text);
    }
  }

  void demographicInfoData() {
    newRegistrationController.savePatientReqModel.nationalityId = 1;
    newRegistrationController.savePatientReqModel.referredContactNumber =
        newRegistrationController.reffContactNoController.text;
    newRegistrationController.savePatientReqModel.relativeMobileNo =
        newRegistrationController.contactNoController.text;

    newRegistrationController.savePatientReqModel.procedureType =
        newRegistrationController.selectedProcedureType?.lookupDetDescEn;
    newRegistrationController
        .savePatientReqModel.lookupDetIdHaemodialysisProcedureType =
        newRegistrationController.selectedProcedureType?.lookupDetId;
    newRegistrationController.savePatientReqModel.lookupDetIdDialysisMode =
        newRegistrationController.selectedDialysisModeObj?.lookupDetId;
    newRegistrationController.savePatientReqModel.identificationNumber =
        newRegistrationController.selectedIdProof;
    newRegistrationController.savePatientReqModel.relativeName =
        newRegistrationController.relativeNameController.text;

    newRegistrationController.savePatientReqModel.patientRelativeContactnoId =
        newRegistrationController.relativeDoc.patientRelativeContactnoId;
    newRegistrationController.savePatientReqModel.referenceByName =
        newRegistrationController.refByNameController.text;
    newRegistrationController.savePatientReqModel.nephrologistContactNumber =
        newRegistrationController.nephrologyContactNoController.text;
    newRegistrationController.savePatientReqModel.nephrologistName =
        newRegistrationController.nephrologyController.text;
    if (newRegistrationController.selectedDiaModeFreq != null) {
      // newRegistrationController
      //         .savePatientReqModel.lookupDetIdDialysisFrequencyInWeek =
      //     int.parse(newRegistrationController.selectedDiaModeFreq!);

      newRegistrationController
          .savePatientReqModel.lookupDetIdDialysisFrequencyInWeek =
          newRegistrationController.dialysisFreqModel?.dialysisFrequency
              ?.firstWhere((e) =>
          e.lookupDescEn ==
              newRegistrationController.selectedDiaModeFreq)
              .lookupId;

      newRegistrationController.savePatientReqModel.dialysisFrequencyInWeek =
          int.parse(newRegistrationController.selectedDiaModeFreq!);
    }

    newRegistrationController.savePatientReqModel.referedContactNumber =
        newRegistrationController.reffContactNoController.text;
    newRegistrationController.savePatientReqModel.referedContactNumber =
        newRegistrationController.reffContactNoController.text;
    newRegistrationController.savePatientReqModel.refByName =
        newRegistrationController.refByNameController.text;
    newRegistrationController.savePatientReqModel.identificationNumber =
        newRegistrationController.identificationNoController.text;

    var referredB = newRegistrationController.referredByModel?.data?.firstWhere(
            (e) =>
        e.lookupDetDescEn == newRegistrationController.selectedReferredBy,
        orElse: () => ReferredByData());
    newRegistrationController.savePatientReqModel.lookupDetIdRefByRef =
        referredB?.lookupDetId;
    newRegistrationController.savePatientReqModel.referredBy =
        newRegistrationController.refByNameController.text;
    if (newRegistrationController.weightController.text.isNotEmpty &&
        newRegistrationController.weightController.text != 'null') {
      newRegistrationController.savePatientReqModel.pweight =
          double.parse(newRegistrationController.weightController.text);
    }
    if (newRegistrationController.heightFeetController.text.isNotEmpty) {
      newRegistrationController.savePatientReqModel.pheight =
          double.parse(newRegistrationController.heightCmController.text);
    }

    newRegistrationController.savePatientReqModel.bloodGroupId =
        newRegistrationController.selectedBloodObj?.bloodGroupId;
    newRegistrationController.savePatientReqModel.relationId =
        newRegistrationController.selectedRelationObj?.lookupDetId;
    newRegistrationController.savePatientReqModel.identityProofId =
        newRegistrationController.selectedIdProfObj?.lookupDetId;
    newRegistrationController.savePatientReqModel.lookupDetIdPatientType =
        newRegistrationController.selectedSchemeObj?.lookupDetId;

    newRegistrationController.savePatientReqModel.mJPJAYEnrollmentNo =
        newRegistrationController.mjpjayEnrollNoController.text;

    newRegistrationController.savePatientReqModel.mjpjayenrollmentNo =
        newRegistrationController.mjpjayEnrollNoController.text;

    newRegistrationController.savePatientReqModel.nephrologistContactNo =
        newRegistrationController.nephrologyContactNoController.text;
  }

  void historyOfDialysis() {
    if (newRegistrationController.groupVal == CustomRadioButtons.yes) {
      newRegistrationController.savePatientReqModel.firstTimeDialysisFlag = "Y";
    } else {
      newRegistrationController.savePatientReqModel.firstTimeDialysisFlag = "N";
      newRegistrationController.savePatientReqModel.previoushospitalName =
          newRegistrationController.hospitalName.text;

      final inputDate = newRegistrationController.lastDialysisDate.text;
      if (inputDate.isNotEmpty) {
        final parsedDate = DateFormat('yyyy-MM-dd').parse(inputDate);

        // Construct 8:00 AM UTC time
        final utcFormatted = DateTime(
          parsedDate.year,
          parsedDate.month,
          parsedDate.day,
          8,
          0,
          0,
        ).toUtc().toIso8601String();

        // Set in model
        newRegistrationController.savePatientReqModel.hospitalsessionDate =
            utcFormatted; // OR just utcFormatted if already includes 'Z'
      }
      // if (inputDate.isNotEmpty) {
      //   final parsedDate = DateFormat('yyyy-MM-dd').parse(inputDate);
      //
      //   final utcFormatted = '${DateTime(
      //     parsedDate.year,
      //     parsedDate.month,
      //     parsedDate.day,
      //     8,
      //     0,
      //     0,
      //   ).toUtc().toIso8601String()}Z';
      //
      //   newRegistrationController.savePatientReqModel.hospitalsessionDate =
      //       utcFormatted;
      // }

      final inputDate1 = newRegistrationController.dialysisDate.text;
      if (inputDate1.isNotEmpty) {
        final parsedDate = DateFormat('yyyy-MM-dd').parse(inputDate1);

        // Create the DateTime at 8:00 AM local time
        final dateTime = DateTime(
          parsedDate.year,
          parsedDate.month,
          parsedDate.day,
          8,
          0,
          0,
        );

        // Convert to UTC ISO string
        final utcFormatted = dateTime.toUtc().toIso8601String();

        // Save into model
        newRegistrationController.savePatientReqModel.sstartSessionDate =
            utcFormatted;
      }

      newRegistrationController.historyOfDialysis.isSelected = true;
      newRegistrationController.historyOfDialysis.file;
      newRegistrationController.update();
    }
  }

  void uploadDocTabData(creDate) {
    newRegistrationController.savePatientReqModel.unitId =
        int.parse(userData['unitId'].toString());
    newRegistrationController.savePatientReqModel.deleted = userData['deleted'];
    newRegistrationController.savePatientReqModel.organDonarFlag = "Y";
    newRegistrationController.savePatientReqModel.createdBy = userData['user_ID'];
    newRegistrationController.savePatientReqModel.createdDateTime = creDate;
    newRegistrationController.savePatientReqModel.updatedBy =
    userData['updatedBy'];
    newRegistrationController.savePatientReqModel.updatedDateTime =
    userData['updatedDate'];
    newRegistrationController.savePatientReqModel.deletedBy =
    userData['deletedBy'];
    newRegistrationController.savePatientReqModel.deletedDateTime =
    userData['deletedDate'];
    newRegistrationController.savePatientReqModel.mrnno = "";
    newRegistrationController.savePatientReqModel.unitCount = 1;
    newRegistrationController.savePatientReqModel.transSMS = "Y";
    newRegistrationController.savePatientReqModel.transEmail = "N";
    newRegistrationController.savePatientReqModel.pramoEmail = "N";
    newRegistrationController.savePatientReqModel.external = "N";
    newRegistrationController.savePatientReqModel.emergency = "N";
    newRegistrationController.savePatientReqModel.blockFlag = "N";
    newRegistrationController.savePatientReqModel.blockNarration1 = "-";
    newRegistrationController.savePatientReqModel.blockNarration2 = "-";
    newRegistrationController.savePatientReqModel.blockNarration3 = "-";
    newRegistrationController.savePatientReqModel.blockUserId1 = 0;
    newRegistrationController.savePatientReqModel.blockUserId2 = 0;
    newRegistrationController.savePatientReqModel.blockUserId3 = 0;
    newRegistrationController.savePatientReqModel.centerPatientId = "";
    newRegistrationController.savePatientReqModel.serviceCode = "NPV";
  }

  String formatDateTimeToCustomString(DateTime dateTime) {
    // Create a new DateTime object with the desired time (08:00:00)
    DateTime customDateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      8,
      0,
      0,
      0,
      0, // 08:00:00 time
    );

    // Convert to the desired string format with 'Z' for UTC
    String formattedDate = '${customDateTime.toIso8601String().split('.')[0]}Z';

    return formattedDate;
  }

  Future<void> pickFile(FileDetails uploadedFile) async {
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
        //     newRegistrationController.items.firstWhere((e) => e.key == key);
        uploadedFile.file = file;
        uploadedFile.isSelected = true;
      });

      debugPrint(newRegistrationController.items.length.toString());
    } else {
      debugPrint('No file selected.');
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  bool validatePersonalInfoTab() {
    final controller = newRegistrationController;

    // Check required Personal Info fields
    if (controller.prefixVal == null || controller.prefixVal!.isEmpty) {
      return false;
    }
    if (controller.firstNameController.text.isEmpty) {
      return false;
    }
    if (controller.lastNameController.text.isEmpty) {
      return false;
    }
    if (controller.selectedGender == null || controller.selectedGender!.isEmpty) {
      return false;
    }
    if (controller.selectedMaritalVal == null || controller.selectedMaritalVal!.isEmpty) {
      return false;
    }
    if (controller.mobileController.text.isEmpty ||
        controller.mobileController.text.length != 10) {
      return false;
    }
    if (controller.dboController.text.isEmpty) {
      return false;
    }
    if (controller.addressController.text.isEmpty) {
      return false;
    }
    if (controller.pincodeController.text.isEmpty) {
      return false;
    }
    if (controller.selectedTownVal == null || controller.selectedTownVal!.isEmpty) {
      return false;
    }
    if (controller.selectedTalukaVal == null || controller.selectedTalukaVal!.isEmpty) {
      return false;
    }
    if (controller.selectedDistVal == null || controller.selectedDistVal!.isEmpty) {
      return false;
    }
    if (controller.selectedStateVal == null || controller.selectedStateVal!.isEmpty) {
      return false;
    }

    return true;
  }

  bool validateDemographicInfoTab() {
    final controller = newRegistrationController;

    // Check required Demographic Info fields
    if (controller.selectedSchema == null || controller.selectedSchema!.isEmpty) {
      return false;
    }
    if (controller.selectedViralStat == null || controller.selectedViralStat!.isEmpty) {
      return false;
    }
    if (controller.heightFeetController.text.isEmpty) {
      return false;
    }
    if (controller.heightCmController.text.isEmpty) {
      return false;
    }
    if (controller.weightController.text.isEmpty) {
      return false;
    }
    if (controller.nephrologyController.text.isEmpty) {
      return false;
    }
    if (controller.selectedDiaModeFreq == null || controller.selectedDiaModeFreq!.isEmpty) {
      return false;
    }

    return true;
  }

  bool validateHistoryOfDialysisTab() {
    final controller = newRegistrationController;

    // Check History of Dialysis fields based on selection
    if (controller.groupVal == CustomRadioButtons.no) {
      if (controller.dialysisDate.text.isEmpty) {
        return false;
      }
      if (controller.hospitalName.text.isEmpty) {
        return false;
      }
      if (controller.lastDialysisDate.text.isEmpty) {
        return false;
      }
      if (!controller.historyOfDialysis.isSelected ||
          controller.historyOfDialysis.file == null) {
        return false;
      }
    }

    return true;
  }
}

class CustomUploadButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isViewProfile;
  final bool isReq;
  final bool showIndex;
  final int index;
  final Function callB;
  final Function callDelete;
  final Function viewCallBack;

  const CustomUploadButton(
      {super.key,
        required this.title,
        required this.callB,
        required this.index,
        required this.isSelected,
        required this.callDelete,
        required this.viewCallBack,
        required this.isReq,
        required this.isViewProfile,
        required this.showIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(
          colors: [
            AppColor.primaryBackgroundColor.withValues(alpha: 0.2),
            AppColor.secondaryColor.withValues(alpha: 0.2)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        )
            : const LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                showIndex
                    ? Text('${(index + 1).toString()}.$title')
                    : Text(title),
                const SizedBox(
                  width: 4,
                ),
                Visibility(
                    visible: isReq,
                    child: Text(
                      '*',
                      style: TextStyle(color: AppColor.red),
                    )),
                const SizedBox(
                  width: 4,
                ),
                Visibility(
                    visible: isSelected,
                    child: Image.asset('assets/checkbox-circle.png'))
              ],
            ),
          ),
          Row(
            children: [
              Visibility(
                visible: isSelected,
                child: InkWell(
                    onTap: () {
                      viewCallBack();
                    },
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: AppColor.primaryBackgroundColor,
                    )),
              ),
              const SizedBox(
                width: 15,
              ),
              isSelected == false
                  ? Visibility(
                visible: isViewProfile == false,
                child: InkWell(
                    onTap: () {
                      callB();
                    },
                    child: Image.asset('assets/upload.png')),
              )
                  : Visibility(
                visible: isViewProfile == false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                      onTap: () {
                        callDelete();
                      },
                      child: Image.asset('assets/delete-bin.png')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FileDetails {
  String name;
  String? ids;
  int? patientRelativeContactnoId;
  String key;
  bool isSelected;
  bool isReq;
  File? file;

  FileDetails(
      {required this.name,
        required this.key,
        required this.isSelected,
        required this.isReq,
        this.file,
        this.ids,
        this.patientRelativeContactnoId});
}
