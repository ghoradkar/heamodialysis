import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/capture_photo/capture_photo.dart';
import 'package:heamodialysis/capture_photo/capture_photo_controller.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/new_registration/model/view_patient_model.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

class PersonalInfoScreen extends StatefulWidget {
  final Function callB;
  final bool isViewPatient;
  final ViewPatientModel? viewPatientModel;
  final String? pageTitle;

  const PersonalInfoScreen(
      {super.key,
      required this.callB,
      required this.isViewPatient,
      this.viewPatientModel,
      this.pageTitle});

  @override
  State<PersonalInfoScreen> createState() => PersonalInfoScreenState();
}

class PersonalInfoScreenState extends State<PersonalInfoScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NewRegistrationController newRegistrationController =
      Get.find<NewRegistrationController>();

  final CapturePhotoController capturePhotoController =
      Get.put(CapturePhotoController());

  @override
  void initState() {
    super.initState();

    newRegistrationController.dboController.addListener(() {
      formatDOB(newRegistrationController.dboController);
    });
  }

  @override
  void dispose() {
    newRegistrationController.dboController.removeListener(() {
      formatDOB(newRegistrationController.dboController);
    });
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
            SizedBox(height: 20.h),
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
                      Image.asset("assets/user_textfield.png"),
                      SizedBox(
                        width: 12.w,
                      ),
                      CustomText(
                        text: "Personal Info",
                        fontSize: 14.0.sp,
                        fontFam: 'Lato',
                        fontWeight: FontWeight.normal,
                        textColor: Colors.white,
                        textAlign: TextAlign.center,
                      )
                    ]),
                    children: <Widget>[
                      Container(

                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 8.h),
                            Center(
                              child: buildProfileImage(),
                            ),
                            SizedBox(height: 8.h),
                            Center(
                              child: Text(
                                newRegistrationController.firstNameController.text.isNotEmpty
                                    ? '${newRegistrationController.firstNameController.text} ${newRegistrationController.lastNameController.text}'
                                    : 'Patient Name',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Visibility(
                            //   visible: widget.isViewPatient == false,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Container(
                            //         width: 35.w,
                            //         height: 35.h,
                            //         decoration: BoxDecoration(
                            //           shape: BoxShape.circle,
                            //           gradient: LinearGradient(
                            //             colors: [
                            //               AppColor.primaryBackgroundColor,
                            //               AppColor.secondaryColor
                            //             ],
                            //             begin: Alignment.topLeft,
                            //             end: Alignment.bottomCenter,
                            //           ),
                            //         ),
                            //         child: IconButton(
                            //           icon: const Icon(
                            //             Icons.edit,
                            //             size: 15,
                            //             color: Colors.white,
                            //           ),
                            //           onPressed: () {
                            //             _pickImageFromDevice();
                            //           },
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         width: 6.w,
                            //       ),
                            //
                            //
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: 16.h),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColor.borderColor)),
                              child: Column(
                                children: [
                                  CustomTextField(
                                    maxLines: 1,
                                    isReadOnly: true,
                                    labelText: 'ABHA ID',
                                    hintText: '',
                                    isRequired: false,
                                    keyBoardType: TextInputType.number,
                                    txtController: newRegistrationController
                                        .abhaNoController,
                                    fillColor: Colors.white,
                                    fontSize: 14,
                                  ),
                                  SizedBox(height: 8.h),
                                  // CustomTextField(
                                  //   maxLines: 1,
                                  //   isReadOnly: true,
                                  //   labelText: 'ABHA Address',
                                  //   hintText: '',
                                  //   isRequired: false,
                                  //   keyBoardType: TextInputType.number,
                                  //   txtController: newRegistrationController
                                  //       .abhaAddressController,
                                  //   fillColor: Colors.white,
                                  //   fontSize: 16.sp,
                                  // ),
                                //  SizedBox(height: 8.h),
                                  MyCustomDropdown(
                                    isViewProfile: widget.isViewPatient,
                                    selectedItem:
                                        newRegistrationController.prefixVal,
                                    labelText: 'Prefix',
                                    items: newRegistrationController
                                            .predixList?.data
                                            ?.map((e) => e.title)
                                            .toList() ??
                                        [],
                                    hint: "Select Title",
                                    isRequired: true,
                                    senValue: (value) {
                                      if (widget.isViewPatient == false) {
                                        newRegistrationController.prefixVal =
                                            value;
                                        newRegistrationController.refreshUi();
                                      }
                                    },
                                    filledColor: Colors.white,
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          maxLines: 1,
                                          isReadOnly:
                                              widget.isViewPatient ? true : false,
                                          labelText: 'First Name',
                                          hintText: 'Enter first name',
                                          isRequired: true,
                                          keyBoardType: TextInputType.name,
                                          txtController: newRegistrationController
                                              .firstNameController,
                                          fillColor: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Expanded(
                                        child: CustomTextField(
                                          maxLines: 1,
                                          isReadOnly: false,
                                          keyBoardType: TextInputType.name,
                                          labelText: 'Middle Name',
                                          hintText: 'Enter middle name',
                                          isRequired: false,
                                          txtController: newRegistrationController
                                              .middleNameController,
                                          fillColor: Colors.white,
                                          fontSize: 16.sp,
                                        ),
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
                                          keyBoardType: TextInputType.name,
                                          labelText: 'Last Name',
                                          hintText: 'Enter last name',
                                          isRequired: true,
                                          txtController: newRegistrationController
                                              .lastNameController,
                                          fillColor: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Expanded(
                                        child: MyCustomDropdown(
                                            isViewProfile: widget.isViewPatient,
                                            selectedItem:
                                            newRegistrationController
                                                .selectedGender,
                                            labelText: 'Gender',
                                            items: const [
                                              'Male',
                                              'Female',
                                              'Other'
                                            ],
                                            hint: 'Select',
                                            isRequired: true,
                                            senValue: (value) {
                                              if (widget.isViewPatient ==
                                                  false) {
                                                newRegistrationController
                                                    .selectedGender = value;
                                                newRegistrationController
                                                    .refreshUi();
                                              }
                                            },
                                            filledColor: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MyCustomDropdown(
                                            isViewProfile: widget.isViewPatient,
                                            selectedItem:
                                                newRegistrationController
                                                    .selectedMaritalVal,
                                            labelText: 'Marital Status',
                                            items: newRegistrationController
                                                    .maritalStatusModel?.data
                                                    ?.map((e) =>
                                                        e.lookupDetDescEn)
                                                    .toList() ??
                                                [],
                                            hint: 'Select',
                                            isRequired: true,
                                            senValue: (value) {
                                              newRegistrationController
                                                      .selectedMarriedObj =
                                                  newRegistrationController
                                                      .maritalStatusModel?.data
                                                      ?.firstWhere((e) =>
                                                          e.lookupDetDescEn ==
                                                          value);
                                              newRegistrationController
                                                  .selectedMaritalVal = value;
                                              newRegistrationController
                                                  .refreshUi();
                                            },
                                            filledColor: Colors.white),
                                      ),
                                      Expanded(
                                        child: CustomTextField(
                                          maxLines: 1,
                                          isReadOnly: widget.isViewPatient
                                              ? true
                                              : false,
                                          keyBoardType: TextInputType.phone,
                                          labelText: 'Contact Number',
                                          hintText: 'Enter Contact Number',
                                          isRequired: true,
                                          txtController:
                                          newRegistrationController
                                              .mobileController,
                                          fillColor: Colors.white,
                                          fontSize: 16.sp,
                                          onChanged: (value) {},
                                         mazLenght:10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          maxLines: 1,
                                          isReadOnly: widget.isViewPatient
                                              ? true
                                              : false,
                                          keyBoardType:
                                              TextInputType.emailAddress,
                                          labelText: 'Email Id',
                                          hintText: 'Enter Email address',
                                          isRequired: false,
                                          txtController:
                                              newRegistrationController
                                                  .emailController,
                                          fillColor: Colors.white,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomDOBField(
                                          labelText: 'DOB',
                                          hint: 'Select',
                                          isRequired: true,
                                          callB: () {
                                            if (widget.isViewPatient == false) {
                                              _selectDate(context);
                                            }
                                          },
                                          selectedDate:
                                          newRegistrationController.dboController,
                                          filledColor: Colors.white,
                                          dontDhowPrefix: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(height: 16.h),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //         child: MyCustomDropdown(
                                  //             isViewProfile:
                                  //                 widget.isViewPatient,
                                  //             selectedItem:
                                  //                 newRegistrationController
                                  //                     .selectedEdu,
                                  //             labelText: 'Education',
                                  //             items: newRegistrationController
                                  //                     .commomDropdownList
                                  //                     ?.educationList
                                  //                     .map((e) =>
                                  //                         e.lookupDetDescEn)
                                  //                     .toList() ??
                                  //                 [],
                                  //             hint: 'Select',
                                  //             isRequired: true,
                                  //             senValue: (value) {
                                  //               newRegistrationController
                                  //                       .selectedEduObj =
                                  //                   newRegistrationController
                                  //                       .commomDropdownList
                                  //                       ?.educationList
                                  //                       .firstWhere((e) =>
                                  //                           e.lookupDetDescEn ==
                                  //                           value);
                                  //               newRegistrationController
                                  //                   .selectedEdu = value;
                                  //               newRegistrationController
                                  //                       .socEcoStat =
                                  //                   newRegistrationController.getEconomicStatus(
                                  //                       educationText:
                                  //                           newRegistrationController
                                  //                               .selectedEdu,
                                  //                       occupationText:
                                  //                           newRegistrationController
                                  //                               .selectedOccu,
                                  //                       monthlyIncomeText:
                                  //                           newRegistrationController
                                  //                               .selectedMonthlyIncome);
                                  //               setState(() {});
                                  //               // newRegistrationController
                                  //               //     .refreshUi();
                                  //             },
                                  //             filledColor: Colors.white)),
                                  //     Expanded(
                                  //       child: MyCustomDropdown(
                                  //           isViewProfile: widget.isViewPatient,
                                  //           selectedItem:
                                  //               newRegistrationController
                                  //                   .selectedOccu,
                                  //           labelText: 'Occupation',
                                  //           items: newRegistrationController
                                  //                   .commomDropdownList
                                  //                   ?.occupationList
                                  //                   .map((e) =>
                                  //                       e.lookupDetDescEn)
                                  //                   .toList() ??
                                  //               [],
                                  //           hint: 'Select',
                                  //           isRequired: true,
                                  //           senValue: (value) {
                                  //             newRegistrationController
                                  //                     .selectedOccuObj =
                                  //                 newRegistrationController
                                  //                     .commomDropdownList
                                  //                     ?.occupationList
                                  //                     .firstWhere((e) =>
                                  //                         e.lookupDetDescEn ==
                                  //                         value);
                                  //             newRegistrationController
                                  //                 .selectedOccu = value;
                                  //             newRegistrationController
                                  //                     .socEcoStat =
                                  //                 newRegistrationController.getEconomicStatus(
                                  //                     educationText:
                                  //                         newRegistrationController
                                  //                             .selectedEdu,
                                  //                     occupationText:
                                  //                         newRegistrationController
                                  //                             .selectedOccu,
                                  //                     monthlyIncomeText:
                                  //                         newRegistrationController
                                  //                             .selectedMonthlyIncome);
                                  //             setState(() {});
                                  //             // newRegistrationController
                                  //             //     .refreshUi();
                                  //           },
                                  //           filledColor: Colors.white),
                                  //     )
                                  //   ],
                                  // ),
                                  // SizedBox(height: 16.h),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: MyCustomDropdown(
                                  //           isViewProfile: widget.isViewPatient,
                                  //           selectedItem:
                                  //               newRegistrationController
                                  //                   .selectedMonthlyIncome,
                                  //           labelText: 'Monthly Income',
                                  //           items: newRegistrationController
                                  //                   .getMonthyIncomeList
                                  //                   ?.monthlyIncomeList
                                  //                   .map((e) => e.lookupDescEn)
                                  //                   .toList() ??
                                  //               [],
                                  //           hint: 'Select',
                                  //           isRequired: true,
                                  //           senValue: (value) {
                                  //             newRegistrationController
                                  //                     .selectedMonthlyIncomeObj =
                                  //                 newRegistrationController
                                  //                     .getMonthyIncomeList
                                  //                     ?.monthlyIncomeList
                                  //                     .firstWhere((e) =>
                                  //                         e.lookupDescEn ==
                                  //                         value);
                                  //             newRegistrationController
                                  //                     .selectedMonthlyIncome =
                                  //                 value;
                                  //             newRegistrationController
                                  //                     .socEcoStat =
                                  //                 newRegistrationController.getEconomicStatus(
                                  //                     educationText:
                                  //                         newRegistrationController
                                  //                             .selectedEdu,
                                  //                     occupationText:
                                  //                         newRegistrationController
                                  //                             .selectedOccu,
                                  //                     monthlyIncomeText:
                                  //                         newRegistrationController
                                  //                             .selectedMonthlyIncome);
                                  //             // newRegistrationController
                                  //             //     .refreshUi();
                                  //             debugPrint(
                                  //                 "social eco stat ${newRegistrationController.socEcoStat}");
                                  //             setState(() {});
                                  //           },
                                  //           filledColor: Colors.white),
                                  //     ),
                                  //     Expanded(
                                  //       child: MyCustomDropdown(
                                  //           isViewProfile: widget.isViewPatient,
                                  //           selectedItem:
                                  //               newRegistrationController
                                  //                   .selectedReligion,
                                  //           labelText: 'Religion',
                                  //           items: newRegistrationController
                                  //                   .commomDropdownList
                                  //                   ?.religionList
                                  //                   .map((e) =>
                                  //                       e.lookupDetDescEn)
                                  //                   .toList() ??
                                  //               [],
                                  //           hint: 'Select',
                                  //           isRequired: true,
                                  //           senValue: (value) {
                                  //             newRegistrationController
                                  //                     .selectedRelifionObj =
                                  //                 newRegistrationController
                                  //                     .commomDropdownList
                                  //                     ?.religionList
                                  //                     .firstWhere((e) =>
                                  //                         e.lookupDetDescEn ==
                                  //                         value);
                                  //             newRegistrationController
                                  //                 .selectedReligion = value;
                                  //             newRegistrationController
                                  //                 .refreshUi();
                                  //           },
                                  //           filledColor: Colors.white),
                                  //     )
                                  //   ],
                                  // ),
                                  // SizedBox(height: 16.h),
                                  // Column(
                                  //   children: [
                                  //     const Align(
                                  //       alignment: Alignment.centerLeft,
                                  //       child: CustomText(
                                  //           text: 'Socio-Eco Status',
                                  //           fontSize: 16,
                                  //           fontWeight: FontWeight.normal,
                                  //           textColor: Colors.black,
                                  //           textAlign: TextAlign.start),
                                  //     ).paddingOnly(left: 6.w, bottom: 4.h),
                                  //     Container(
                                  //       padding: EdgeInsets.symmetric(
                                  //           vertical: 14.h, horizontal: 6.w),
                                  //       width: double.infinity,
                                  //       decoration: BoxDecoration(
                                  //           borderRadius:
                                  //               const BorderRadius.all(
                                  //                   Radius.circular(12)),
                                  //           color: Colors.white,
                                  //           border: Border.all(
                                  //               color: AppColor.borderColor)),
                                  //       child: CustomText(
                                  //           text: newRegistrationController
                                  //                   .socEcoStat ??
                                  //               '',
                                  //           fontSize: 16.sp,
                                  //           fontWeight: FontWeight.w500,
                                  //           textColor: Colors.black,
                                  //           textAlign: TextAlign.start),
                                  //     ).paddingOnly(
                                  //         top: 0,
                                  //         bottom: 12.h,
                                  //         left: 4.w,
                                  //         right: 4.w),
                                  //   ],
                                  // ),
                                ],
                              ),
                            )
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
                data: ThemeData().copyWith(dividerColor: Colors.transparent,),
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.darkBlue,
                        borderRadius: BorderRadius.circular(10)),
                    child: ExpansionTile(
                      maintainState: true,
                      collapsedIconColor: Colors.white,
                      iconColor: Colors.white,
                      title: Row(children: [
                        Image.asset("assets/home.png"),
                        SizedBox(width: 12.w),
                        Text(
                          "Residential Address",
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: Colors.white,
                              fontFamily: 'Lato'),
                        ),
                      ]),
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.borderColor)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 16.h),
                              CustomTextField(
                                maxLines: 3,
                                isReadOnly: widget.isViewPatient ? true : false,
                                keyBoardType: TextInputType.streetAddress,
                                labelText: 'Address',
                                hintText: 'Enter address',
                                isRequired: true,
                                txtController:
                                    newRegistrationController.addressController,
                                fillColor: Colors.white,
                                fontSize: 16.sp,
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      onChanged: (value) async {
                                        if (widget.isViewPatient == false) {
                                          await newRegistrationController
                                              .getAddressDataFromPinCode(value);
                                          newRegistrationController
                                                  .selectedTownObj =
                                              newRegistrationController
                                                  .townModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.cityId ==
                                                      newRegistrationController
                                                          .pincodeAdressModel
                                                          ?.data
                                                          ?.cityId);
                                          newRegistrationController
                                                  .selectedTownVal =
                                              newRegistrationController
                                                  .selectedTownObj?.cityName;

                                          newRegistrationController
                                                  .selectedTalukaObject =
                                              newRegistrationController
                                                  .talukaModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.talukaID ==
                                                      newRegistrationController
                                                          .pincodeAdressModel
                                                          ?.data
                                                          ?.talukaID);
                                          newRegistrationController
                                                  .selectedTalukaVal =
                                              newRegistrationController
                                                  .selectedTalukaObject
                                                  ?.talukaName;

                                          newRegistrationController
                                                  .selectedDistObj =
                                              newRegistrationController
                                                  .districtModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.districtID ==
                                                      newRegistrationController
                                                          .pincodeAdressModel
                                                          ?.data
                                                          ?.districtID);
                                          newRegistrationController
                                                  .selectedDistVal =
                                              newRegistrationController
                                                  .selectedDistObj
                                                  ?.districtName;

                                          newRegistrationController
                                                  .selectedDivisionObj =
                                              newRegistrationController
                                                  .divisionModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.divId ==
                                                      newRegistrationController
                                                          .pincodeAdressModel
                                                          ?.data
                                                          ?.divID);
                                          newRegistrationController
                                                  .selectedDivVal =
                                              newRegistrationController
                                                  .selectedDivisionObj?.divName;

                                          newRegistrationController
                                                  .selectedStateObj =
                                              newRegistrationController
                                                  .stateModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.stateID ==
                                                      newRegistrationController
                                                          .pincodeAdressModel
                                                          ?.data
                                                          ?.stateID);
                                          newRegistrationController
                                                  .selectedStateVal =
                                              newRegistrationController
                                                  .selectedStateObj?.stateName;
                                          newRegistrationController
                                                  .selectedCountryVal =
                                              newRegistrationController
                                                  .selectedCountry[0];

                                          newRegistrationController.refreshUi();
                                        }
                                      },
                                      maxLines: 1,
                                      isReadOnly:
                                          widget.isViewPatient ? true : false,
                                      keyBoardType: TextInputType.number,
                                      labelText: 'Pin Code',
                                      hintText: 'Enter pin code',
                                      isRequired: true,
                                      txtController: newRegistrationController
                                          .pincodeController,
                                      fillColor: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Expanded(
                                    child: SearchableDropDown(
                                      selectedItem: newRegistrationController
                                          .selectedTownVal,
                                      isViewPatient:
                                          widget.isViewPatient == false
                                              ? true
                                              : false,
                                      list: newRegistrationController
                                              .townModel?.data
                                              ?.map((e) => e.cityName)
                                              .toList() ??
                                          [],
                                      onChanged: (value) {
                                        newRegistrationController
                                                .selectedTownObj =
                                            newRegistrationController
                                                .townModel?.data
                                                ?.firstWhere(
                                                    (e) => e.cityName == value);
                                        newRegistrationController
                                                .selectedTownVal =
                                            newRegistrationController
                                                .selectedTownObj?.cityName;

                                        newRegistrationController.refreshUi();
                                        debugPrint('changing value to: $value');
                                      },
                                      onSearched: (searchdText) {
                                        return searchTown(searchdText);
                                      },
                                      hintText: 'Town',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: SearchableDropDown(
                                      selectedItem: newRegistrationController
                                          .selectedTalukaVal,
                                      isViewPatient:
                                          widget.isViewPatient == false
                                              ? true
                                              : false,
                                      list: newRegistrationController
                                              .talukaModel?.data
                                              ?.map((e) => e.talukaName)
                                              .toList() ??
                                          [],
                                      onChanged: (value) {
                                        newRegistrationController
                                                .selectedTalukaObject =
                                            newRegistrationController
                                                .talukaModel?.data
                                                ?.firstWhere((e) =>
                                                    e.talukaName == value);
                                        newRegistrationController
                                                .selectedTalukaVal =
                                            newRegistrationController
                                                .selectedTalukaObject
                                                ?.talukaName;
                                        newRegistrationController.refreshUi();
                                        debugPrint('changing value to: $value');
                                      },
                                      onSearched: (searchdText) {
                                        return searchTaluka(searchdText);
                                      },
                                      hintText: 'Taluka',
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Expanded(
                                    child: SearchableDropDown(
                                      selectedItem: newRegistrationController
                                          .selectedDistVal,
                                      isViewPatient:
                                          widget.isViewPatient == false
                                              ? true
                                              : false,
                                      list: newRegistrationController
                                              .districtModel?.data
                                              ?.map((e) => e.districtName)
                                              .toList() ??
                                          [],
                                      onChanged: (value) {
                                        newRegistrationController
                                                .selectedDistObj =
                                            newRegistrationController
                                                .districtModel?.data
                                                ?.firstWhere((e) =>
                                                    e.districtName == value);
                                        newRegistrationController
                                                .selectedDistVal =
                                            newRegistrationController
                                                .selectedDistObj?.districtName;
                                        newRegistrationController.refreshUi();
                                        debugPrint('changing value to: $value');
                                      },
                                      onSearched: (searchdText) {
                                        return searchDistrict(searchdText);
                                      },
                                      hintText: 'District',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: SearchableDropDown(
                                      selectedItem: newRegistrationController
                                          .selectedDivVal,
                                      isViewPatient:
                                          widget.isViewPatient == false
                                              ? true
                                              : false,
                                      list: newRegistrationController
                                              .divisionModel?.data
                                              ?.map((e) => e.divName)
                                              .toList() ??
                                          [],
                                      onChanged: (value) {
                                        newRegistrationController
                                                .selectedDivisionObj =
                                            newRegistrationController
                                                .divisionModel?.data
                                                ?.firstWhere(
                                                    (e) => e.divName == value);
                                        newRegistrationController
                                                .selectedDivVal =
                                            newRegistrationController
                                                .selectedDivisionObj?.divName;
                                        newRegistrationController.refreshUi();
                                        debugPrint('changing value to: $value');
                                      },
                                      onSearched: (searchdText) {
                                        return searchDivision(searchdText);
                                      },
                                      hintText: 'Division',
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Expanded(
                                    child: SearchableDropDown(
                                      selectedItem: newRegistrationController
                                          .selectedStateVal,
                                      isViewPatient:
                                          widget.isViewPatient == false
                                              ? true
                                              : false,
                                      list: newRegistrationController
                                              .stateModel?.data
                                              ?.map((e) => e.stateName)
                                              .toList() ??
                                          [],
                                      onChanged: (value) {
                                        newRegistrationController
                                                .selectedStateObj =
                                            newRegistrationController
                                                .stateModel?.data
                                                ?.firstWhere((e) =>
                                                    e.stateName == value);
                                        newRegistrationController
                                                .selectedStateVal =
                                            newRegistrationController
                                                .selectedStateObj?.stateName;
                                        newRegistrationController.refreshUi();
                                        debugPrint('changing value to: $value');
                                      },
                                      onSearched: (searchdText) {
                                        return searchState(searchdText);
                                      },
                                      hintText: 'State',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              MyCustomDropdown(
                                  isViewProfile: widget.isViewPatient,
                                  selectedItem: newRegistrationController
                                      .selectedCountryVal,
                                  labelText: 'Country',
                                  items:
                                      newRegistrationController.selectedCountry,
                                  hint: 'Select',
                                  isRequired: false,
                                  senValue: (value) {
                                    newRegistrationController
                                        .selectedCountryVal = value;
                                    newRegistrationController.refreshUi();
                                  },
                                  filledColor: Colors.white),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),
                      ],
                    ))),
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
                        Image.asset("assets/permanent-address.png"),
                        SizedBox(width: 12.w),
                        Text(
                          "Permanent Address",
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: Colors.white,
                              fontFamily: 'Lato'),
                        ),
                      ]),
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.borderColor)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Visibility(
                                visible: widget.isViewPatient == false,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        activeColor:
                                            AppColor.primaryBackgroundColor,
                                        value:
                                            newRegistrationController.isChecked,
                                        onChanged: (bool? value) {
                                          newRegistrationController.isChecked =
                                              value!;
                                          newRegistrationController.refreshUi();
                                          if (newRegistrationController
                                              .isChecked) {
                                            setResidentialToPermanentAddress();
                                          } else {
                                            resetPerFields();
                                            newRegistrationController
                                                .refreshUi();
                                          }
                                        },
                                      ),
                                      Expanded(
                                        child: CustomText(
                                            text:
                                                "Per. Address Is Same As Per Res.Address",
                                            fontSize: 12.sp,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.grey,
                                            textAlign: TextAlign.start),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              CustomTextField(
                                maxLines: 3,
                                isReadOnly: false,
                                keyBoardType: TextInputType.streetAddress,
                                labelText: 'Address',
                                hintText: 'Enter address',
                                isRequired: false,
                                txtController: newRegistrationController
                                    .perAddressController,
                                fillColor: Colors.white,
                                fontSize: 16.sp,
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      maxLines: 1,
                                      isReadOnly: false,
                                      keyBoardType: TextInputType.number,
                                      labelText: 'Pin Code',
                                      hintText: 'Enter pin code',
                                      isRequired: false,
                                      txtController: newRegistrationController
                                          .perPincodeController,
                                      fillColor: Colors.white,
                                      fontSize: 16.sp,
                                      onChanged: (value) async {
                                        await newRegistrationController
                                            .getAddressDataFromPinCode(value);
                                        newRegistrationController
                                                .perSelectedTownObj =
                                            newRegistrationController
                                                .townModel?.data
                                                ?.firstWhere((e) =>
                                                    e.cityId ==
                                                    newRegistrationController
                                                        .pincodeAdressModel
                                                        ?.data
                                                        ?.cityId);
                                        newRegistrationController
                                                .selectedPerTown =
                                            newRegistrationController
                                                .perSelectedTownObj?.cityName;

                                        newRegistrationController
                                                .perSelectedTalukaObject =
                                            newRegistrationController
                                                .talukaModel?.data
                                                ?.firstWhere((e) =>
                                                    e.talukaID ==
                                                    newRegistrationController
                                                        .pincodeAdressModel
                                                        ?.data
                                                        ?.talukaID);
                                        newRegistrationController
                                                .selectedPerTaluka =
                                            newRegistrationController
                                                .perSelectedTalukaObject
                                                ?.talukaName;

                                        newRegistrationController
                                                .perSelectedDistObj =
                                            newRegistrationController
                                                .districtModel?.data
                                                ?.firstWhere((e) =>
                                                    e.districtID ==
                                                    newRegistrationController
                                                        .pincodeAdressModel
                                                        ?.data
                                                        ?.districtID);
                                        newRegistrationController
                                                .selectedPerDist =
                                            newRegistrationController
                                                .perSelectedDistObj
                                                ?.districtName;

                                        newRegistrationController
                                                .perSelectedDivisionObj =
                                            newRegistrationController
                                                .divisionModel?.data
                                                ?.firstWhere((e) =>
                                                    e.divId ==
                                                    newRegistrationController
                                                        .pincodeAdressModel
                                                        ?.data
                                                        ?.divID);
                                        newRegistrationController
                                                .selectedPerDivision =
                                            newRegistrationController
                                                .perSelectedDivisionObj
                                                ?.divName;

                                        newRegistrationController
                                                .perSelectedStateObj =
                                            newRegistrationController
                                                .stateModel?.data
                                                ?.firstWhere((e) =>
                                                    e.stateID ==
                                                    newRegistrationController
                                                        .pincodeAdressModel
                                                        ?.data
                                                        ?.stateID);
                                        newRegistrationController
                                                .selectedPerState =
                                            newRegistrationController
                                                .perSelectedStateObj?.stateName;
                                        newRegistrationController
                                                .selectedPerCountry =
                                            newRegistrationController
                                                .perSelectedCountry[0];

                                        newRegistrationController.refreshUi();
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Expanded(
                                    child: SearchableDropDown(
                                      selectedItem: newRegistrationController
                                          .selectedPerTown,
                                      isViewPatient:
                                          widget.isViewPatient == false
                                              ? true
                                              : false,
                                      list: newRegistrationController
                                              .townModel?.data
                                              ?.map((e) => e.cityName)
                                              .toList() ??
                                          [],
                                      onChanged: (value) {
                                        newRegistrationController
                                                .perSelectedTownObj =
                                            newRegistrationController
                                                .townModel?.data
                                                ?.firstWhere(
                                                    (e) => e.cityName == value);
                                        newRegistrationController
                                                .selectedPerTown =
                                            newRegistrationController
                                                .perSelectedTownObj?.cityName;
                                        debugPrint('changing value to: $value');
                                      },
                                      onSearched: (searchdText) {
                                        return searchTown(searchdText);
                                      },
                                      hintText: 'Town',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: SearchableDropDown(
                                      selectedItem: newRegistrationController
                                          .selectedPerTaluka,
                                      isViewPatient:
                                          widget.isViewPatient == false
                                              ? true
                                              : false,
                                      list: newRegistrationController
                                              .talukaModel?.data
                                              ?.map((e) => e.talukaName)
                                              .toList() ??
                                          [],
                                      onChanged: (value) {
                                        newRegistrationController
                                                .perSelectedTalukaObject =
                                            newRegistrationController
                                                .talukaModel?.data
                                                ?.firstWhere((e) =>
                                                    e.talukaName == value);
                                        newRegistrationController
                                                .selectedPerTaluka =
                                            newRegistrationController
                                                .perSelectedTalukaObject
                                                ?.talukaName;
                                        newRegistrationController.refreshUi();
                                        debugPrint('changing value to: $value');
                                      },
                                      onSearched: (searchdText) {
                                        return searchTaluka(searchdText);
                                      },
                                      hintText: 'Taluka',
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Expanded(
                                    child: SearchableDropDown(
                                      selectedItem: newRegistrationController
                                          .selectedPerDist,
                                      isViewPatient:
                                          widget.isViewPatient == false
                                              ? true
                                              : false,
                                      list: newRegistrationController
                                              .districtModel?.data
                                              ?.map((e) => e.districtName)
                                              .toList() ??
                                          [],
                                      onChanged: (value) {
                                        newRegistrationController
                                                .perSelectedDistObj =
                                            newRegistrationController
                                                .districtModel?.data
                                                ?.firstWhere((e) =>
                                                    e.districtName == value);
                                        newRegistrationController
                                                .selectedPerDist =
                                            newRegistrationController
                                                .perSelectedDistObj
                                                ?.districtName;
                                        newRegistrationController.refreshUi();
                                        debugPrint('changing value to: $value');
                                      },
                                      onSearched: (searchdText) {
                                        return searchDistrict(searchdText);
                                      },
                                      hintText: 'District',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: SearchableDropDown(
                                      selectedItem: newRegistrationController
                                          .selectedPerDivision,
                                      isViewPatient:
                                          widget.isViewPatient == false
                                              ? true
                                              : false,
                                      list: newRegistrationController
                                              .districtModel?.data
                                              ?.map((e) => e.districtName)
                                              .toList() ??
                                          [],
                                      onChanged: (value) {
                                        newRegistrationController
                                                .perSelectedDivisionObj =
                                            newRegistrationController
                                                .divisionModel?.data
                                                ?.firstWhere(
                                                    (e) => e.divName == value);
                                        newRegistrationController
                                                .selectedPerDivision =
                                            newRegistrationController
                                                .perSelectedDivisionObj
                                                ?.divName;
                                        newRegistrationController.refreshUi();
                                        debugPrint('changing value to: $value');
                                      },
                                      onSearched: (searchdText) {
                                        return searchDivision(searchdText);
                                      },
                                      hintText: 'Division',
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Expanded(
                                    child: SearchableDropDown(
                                      selectedItem: newRegistrationController
                                          .selectedPerState,
                                      isViewPatient:
                                          widget.isViewPatient == false
                                              ? true
                                              : false,
                                      list: newRegistrationController
                                              .districtModel?.data
                                              ?.map((e) => e.districtName)
                                              .toList() ??
                                          [],
                                      onChanged: (value) {
                                        newRegistrationController
                                                .perSelectedStateObj =
                                            newRegistrationController
                                                .stateModel?.data
                                                ?.firstWhere((e) =>
                                                    e.stateName == value);
                                        newRegistrationController
                                                .selectedPerState =
                                            newRegistrationController
                                                .perSelectedStateObj?.stateName;
                                        newRegistrationController.refreshUi();
                                        debugPrint('changing value to: $value');
                                      },
                                      onSearched: (searchdText) {
                                        return searchState(searchdText);
                                      },
                                      hintText: 'State',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              MyCustomDropdown(
                                  isViewProfile: widget.isViewPatient,
                                  selectedItem: newRegistrationController
                                      .selectedPerCountry,
                                  labelText: 'Country',
                                  items: newRegistrationController
                                      .perSelectedCountry,
                                  hint: 'Select',
                                  isRequired: false,
                                  senValue: (value) {
                                    newRegistrationController
                                        .selectedPerCountry = value;
                                  },
                                  filledColor: Colors.white),
                              SizedBox(height: 16.h),
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

                    debugPrint('Form is valid');
                  }
                },
                buttonWidth: 140.w,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  void formatDOB(TextEditingController controller) {
    String input = controller.text.replaceAll('/', ''); // Remove existing '/'
    String formatted = '';

    // Add '/' after the 2nd and 4th characters
    for (int i = 0; i < input.length && i < 8; i++) {
      // Ensure no more than 8 characters are processed
      if (i == 2 || i == 4) {
        formatted += '/';
      }
      formatted += input[i];
    }

    // Limit year to 4 digits only
    if (input.length > 8) {
      formatted +=
          input.substring(8, input.length).replaceAll(RegExp(r'\d'), '');
    }

    // Update the controller's text only if the formatting changes
    if (formatted != controller.text) {
      controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    // Validate if the input is a valid date
    if (formatted.length == 10) {
      // Valid format is dd/MM/yyyy
      try {
        // Parse the formatted string into a DateTime object
        DateTime parsedDate = DateFormat('dd/MM/yyyy').parseStrict(formatted);

        // Reformat it to dd-MM-yyyy and assign to formattedDateDBO
        // newRegistrationController.formattedDateDBO =
        //     DateFormat('dd-MM-yyyy').format(parsedDate);

        newRegistrationController.formattedDateDBO =
            DateFormat('dd/MM/yyyy').format(parsedDate);

        debugPrint(
            "Formatted DOB: ${newRegistrationController.formattedDateDBO}");
      } catch (e) {
        debugPrint("Invalid date entered: $formatted");
        newRegistrationController.formattedDateDBO = null;
      }
    }
  }

  Future<List<String>> searchDistrict(String query) async {
    // Return an empty list if data is null
    return newRegistrationController.districtModel?.data
            ?.where((e) {
              return e.districtName!
                  .toLowerCase()
                  .contains(query.toLowerCase());
            })
            .map((e) => e.districtName ?? "")
            .toList() ??
        [];
  }

  Future<List<String>> searchTaluka(String query) async {
    // Return an empty list if data is null
    return newRegistrationController.talukaModel?.data
            ?.where((e) {
              return e.talukaName!.toLowerCase().contains(query.toLowerCase());
            })
            .map((e) => e.talukaName ?? "")
            .toList() ??
        [];
  }

  Future<List<String>> searchTown(String query) async {
    // Return an empty list if data is null
    return newRegistrationController.townModel?.data
            ?.where((e) {
              return e.cityName!.toLowerCase().contains(query.toLowerCase());
            })
            .map((e) => e.cityName ?? "")
            .toList() ??
        [];
  }

  Future<List<String>> searchDivision(String query) async {
    // Return an empty list if data is null
    return newRegistrationController.divisionModel?.data
            ?.where((e) {
              return e.divName!.toLowerCase().contains(query.toLowerCase());
            })
            .map((e) => e.divName ?? "")
            .toList() ??
        [];
  }

  Future<List<String>> searchState(String query) async {
    // Return an empty list if data is null
    return newRegistrationController.stateModel?.data
            ?.where((e) {
              return e.stateName!.toLowerCase().contains(query.toLowerCase());
            })
            .map((e) => e.stateName ?? "")
            .toList() ??
        [];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != newRegistrationController.selectedDate) {
      // Update the selected date
      newRegistrationController.selectedDate = picked;

      // Format the selected date to dd-MM-yyyy
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      DateFormat formatter1 = DateFormat('dd/MM/yyyy');
      newRegistrationController.formattedDateDBO =
          formatter1.format(newRegistrationController.selectedDate!);

      // Update the controller text
      newRegistrationController.dboController.text =
          formatter1.format(newRegistrationController.selectedDate!);

      // If needed, calculate age or refresh UI
      calculateAge(newRegistrationController.formattedDateDBO ?? "");

      // Refresh UI
      setState(() {});
    } else if (newRegistrationController.dboController.text.isEmpty) {
      // If the user deletes the selected date, reset it properly
      newRegistrationController.dboController.clear();
    }
  }

  Widget buildProfileImage() {
    ImageProvider imageProvider;

    // Check if a new image is selected
    if (newRegistrationController.image != null) {
      imageProvider = FileImage(newRegistrationController.image!);
    }
    // Check if there is an existing profile photo (network image)
    else if (newRegistrationController.patientProfilePhoto?.data != null &&
        newRegistrationController.patientProfilePhoto!.data!.isNotEmpty) {
      String? filePath =
          newRegistrationController.patientProfilePhoto!.data!.last.filePath;
      String imageUrl = filePath != null && filePath.isNotEmpty
          ? ApiConstants.imageBaseUrl + filePath
          : '';

      if (imageUrl.isNotEmpty) {
        imageProvider = CachedNetworkImageProvider(imageUrl);
      } else {
        imageProvider = const AssetImage("assets/profile-placeholder.png");
      }
    }
    // Fallback to placeholder image
    else {
      imageProvider = const AssetImage("assets/profile-placeholder.png");
    }

    return Stack(
      children: [

        CircleAvatar(
          radius: 50,
          backgroundImage: imageProvider,
          onBackgroundImageError: (error, stackTrace) {
            debugPrint("Failed to load image: $error");
          },
        ),
        Positioned(
          right:0 ,top: 0,
          child: Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColor.primaryBackgroundColor,
                  AppColor.secondaryColor
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 15,
                color: Colors.white,
              ),
              onPressed: () async {
                // Get the list of available cameras
                final cameras =
                await availableCameras();

                // Optionally select a default camera (e.g., front camera)
                final defaultCamera =
                cameras.firstWhere(
                      (camera) =>
                  camera.lensDirection ==
                      CameraLensDirection.front,
                );

                // Navigate to the CapturePhoto screen, passing the list of cameras
                Get.to(() => CapturePhoto(
                  cameras: cameras,
                  // Pass all available cameras
                  camera: defaultCamera,
                  // Initial camera (front)
                  callBack: () {
                    pickImageFromCamera();
                  },
                ));
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImageFromDevice() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileSize = await file.length();

      // Check if file size exceeds 500 KB
      if (fileSize > 500 * 1024) {
        // Show message to the user

        CustomMessage.toast("Upload photo below 500KB");

        // Reset the selected image to null
        newRegistrationController.image = null;
        newRegistrationController.userProfilePhoto.file = null;
        newRegistrationController.userProfilePhoto.isSelected = false;
      } else {
        // Proceed with setting the image
        newRegistrationController.image = file;
        newRegistrationController.userProfilePhoto.file = file;
        newRegistrationController.userProfilePhoto.isSelected = true;
      }

      setState(() {}); // Update UI
    } else {
      debugPrint('No image selected.');
    }
  }

  pickImageFromCamera() async {
    if (capturePhotoController.userProfilePhoto.file != null) {
      final file = File(capturePhotoController.userProfilePhoto.file!.path);
      final fileSize = await file.length();

      // Check if file size exceeds 500 KB
      if (fileSize > 500 * 1024) {
        // Show message to the user
        CustomMessage.toast("Upload photo below 500KB");

        // Reset the selected image to null
        newRegistrationController.image = null;
        newRegistrationController.userProfilePhoto.file = null;
        newRegistrationController.userProfilePhoto.isSelected = false;
      } else {
        // Proceed with setting the image
        newRegistrationController.image = file;
        newRegistrationController.userProfilePhoto.file = file;
        newRegistrationController.userProfilePhoto.isSelected = true;
      }

      setState(() {}); // Update UI
    } else {
      debugPrint('No image captured.');
    }
  }

  void calculateAge(String birthDate) {
    // Parse the date in "dd-MM-yyyy" format
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(birthDate);
    // DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(birthDate);
    DateTime today = DateTime.now();

    newRegistrationController.years = today.year - parsedDate.year;
    newRegistrationController.months = today.month - parsedDate.month;
    newRegistrationController.days = today.day - parsedDate.day;

    if (newRegistrationController.days < 0) {
      newRegistrationController.months -= 1;
      newRegistrationController.days +=
          DateTime(today.year, today.month, 0).day; // Previous month's days
    }

    if (newRegistrationController.months < 0) {
      newRegistrationController.years -= 1;
      newRegistrationController.months += 12;
    }
  }

  void setResidentialToPermanentAddress() {
    newRegistrationController.perAddressController.text =
        newRegistrationController.addressController.text;
    newRegistrationController.perPincodeController.text =
        newRegistrationController.pincodeController.text;
    newRegistrationController.selectedPerTown =
        newRegistrationController.selectedTownObj?.cityName ??
            newRegistrationController.selectedTownVal;
    newRegistrationController.selectedPerTaluka =
        newRegistrationController.selectedTalukaObject?.talukaName ??
            newRegistrationController.selectedTalukaVal;
    newRegistrationController.selectedPerDist =
        newRegistrationController.selectedDistObj?.districtName ??
            newRegistrationController.selectedDistVal;
    newRegistrationController.selectedPerDivision =
        newRegistrationController.selectedDivisionObj?.divName ??
            newRegistrationController.selectedDivVal;
    newRegistrationController.selectedPerState =
        newRegistrationController.selectedStateObj?.stateName ??
            newRegistrationController.selectedStateVal;
    newRegistrationController.selectedPerCountry =
        newRegistrationController.selectedCountry[0];

    newRegistrationController.refreshUi();
  }

  void resetPerFields() {
    newRegistrationController.perAddressController.text = "";
    newRegistrationController.perPincodeController.text = "";
    newRegistrationController.selectedPerTown = null;
    newRegistrationController.selectedPerTaluka = null;
    newRegistrationController.selectedPerDist = null;
    newRegistrationController.selectedPerDivision = null;
    newRegistrationController.selectedPerState = null;
    newRegistrationController.selectedPerCountry = null;

    newRegistrationController.refreshUi();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class Pair {
  final String text;
  final IconData icon;

  const Pair(this.text, this.icon);

  @override
  String toString() {
    return text;
  }
}
