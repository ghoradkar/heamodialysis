import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/clinical_history_list.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/nephro_table.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_expandable.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

// import '../../../widgets/custom_expandable.dart';
// import '../../../widgets/custom_shimmer_loader.dart';

class ClinicalHistory extends StatefulWidget {
  final NephroList? patientData;
  final ClinicalHistoryList? clinicalHistoryItem;
  final bool? isView;

  const ClinicalHistory(
      {super.key, this.patientData, this.isView, this.clinicalHistoryItem});

  @override
  State<ClinicalHistory> createState() => _ClinicalHistoryState();
}

class _ClinicalHistoryState extends State<ClinicalHistory> {
  final NephroController nephroController = Get.find<NephroController>();
  var userData;

  @override
  void initState() {
    // addCard();
    nephroController.checkBoxListClinicalHistory?.clear();
    if (widget.isView != true) {
      nephroController.checkBoxListClinicalHistory = List.generate(
          nephroController.addDetailsList?.length ?? 0 + 1, (_) => false);
    }
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    if (widget.isView == true) {
      await nephroController.getClinicalHistoryTableData(
          widget.patientData?.patientId,
          nephroController.treatmentIdModel?[0][0].toString(),
          widget.clinicalHistoryItem,
          widget.isView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<NephroController>(
          init: nephroController,
          builder: (controller) {
            return nephroController.isLoading
                ? Center(child: buildShimmerLoader())
                : Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomExpandableContainer(
                        leading: 'assets/file-info.png',
                        text: 'General Info',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 8.w),
                              decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColor.borderColor)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MyCustomDropdown(
                                          selectedItem:
                                              nephroController.selectedDiet,
                                          isViewProfile: widget.isView == true
                                              ? true
                                              : false,
                                          labelText: 'Diet',
                                          items: nephroController
                                                  .dietListClinicalHistory
                                                  ?.map(
                                                      (e) => e.lookupDetDescEn)
                                                  .toList() ??
                                              [],
                                          hint: "Select",
                                          isRequired: false,
                                          senValue: (value) {
                                            nephroController.selectedDiet =
                                                value;
                                          },
                                          filledColor: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: MyCustomDropdown(
                                          selectedItem: nephroController
                                              .selectedAlcoholCon,
                                          isViewProfile: widget.isView == true
                                              ? true
                                              : false,
                                          labelText: 'Alcohol Consumption',
                                          items: nephroController.alcoholList,
                                          hint: "Select",
                                          isRequired: false,
                                          senValue: (value) {
                                            nephroController
                                                .selectedAlcoholCon = value;
                                          },
                                          filledColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MyCustomDropdown(
                                          selectedItem: nephroController
                                              .selectedAlcoholCurrentStat,
                                          isViewProfile: widget.isView == true
                                              ? true
                                              : false,
                                          labelText: 'Alcohol Current Stat',
                                          items: nephroController
                                                  .currentStatList
                                                  ?.map(
                                                      (e) => e.lookupDetDescEn)
                                                  .toList() ??
                                              [],
                                          hint: "Select",
                                          isRequired: false,
                                          senValue: (value) {
                                            nephroController
                                                    .selectedAlcoholCurrentStat =
                                                value;
                                          },
                                          filledColor: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Alcohol Duration',
                                          hintText: 'Enter',
                                          isRequired: false,
                                          keyBoardType: TextInputType.number,
                                          txtController:
                                              nephroController.alcoholDuration,
                                          fillColor: Colors.white,
                                          isReadOnly: false,
                                          maxLines: 1,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MyCustomDropdown(
                                          selectedItem:
                                              nephroController.selectedSmoking,
                                          isViewProfile: widget.isView == true
                                              ? true
                                              : false,
                                          labelText: 'Smoking',
                                          items: nephroController.smokingList,
                                          hint: "Select",
                                          isRequired: false,
                                          senValue: (value) {
                                            nephroController.selectedSmoking =
                                                value;
                                          },
                                          filledColor: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: MyCustomDropdown(
                                          selectedItem:
                                              nephroController.selectedTobaco,
                                          isViewProfile: widget.isView == true
                                              ? true
                                              : false,
                                          labelText: 'Tobacco Consumption',
                                          items: nephroController.tobacoList,
                                          hint: "Select",
                                          isRequired: false,
                                          senValue: (value) {
                                            nephroController.selectedTobaco =
                                                value;
                                          },
                                          filledColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MyCustomDropdown(
                                          selectedItem: nephroController
                                              .selectedSmokingCurrentStat,
                                          isViewProfile: widget.isView == true
                                              ? true
                                              : false,
                                          labelText: 'Smoking Current Stat',
                                          items: nephroController
                                                  .currentStatList
                                                  ?.map(
                                                      (e) => e.lookupDetDescEn)
                                                  .toList() ??
                                              [],
                                          hint: "Select",
                                          isRequired: false,
                                          senValue: (value) {
                                            nephroController
                                                    .selectedSmokingCurrentStat =
                                                value;
                                          },
                                          filledColor: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Smoking Duration',
                                          hintText: 'Enter',
                                          isRequired: false,
                                          keyBoardType: TextInputType.number,
                                          txtController:
                                              nephroController.smokingDuration,
                                          fillColor: Colors.white,
                                          isReadOnly: false,
                                          maxLines: 1,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MyCustomDropdown(
                                          selectedItem: nephroController
                                              .selectedTobaccoCurrentStat,
                                          isViewProfile: widget.isView == true
                                              ? true
                                              : false,
                                          labelText: 'Tobacco Current Stat',
                                          items: nephroController
                                                  .currentStatList
                                                  ?.map(
                                                      (e) => e.lookupDetDescEn)
                                                  .toList() ??
                                              [],
                                          hint: "Select",
                                          isRequired: false,
                                          senValue: (value) {
                                            nephroController
                                                    .selectedTobaccoCurrentStat =
                                                value;
                                          },
                                          filledColor: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Tobacco Duration',
                                          hintText: 'Enter',
                                          isRequired: false,
                                          keyBoardType: TextInputType.number,
                                          txtController:
                                              nephroController.tobaccoDuration,
                                          fillColor: Colors.white,
                                          isReadOnly: false,
                                          maxLines: 1,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  MyCustomDropdown(
                                    selectedItem:
                                        nephroController.selectediLLicit,
                                    isViewProfile:
                                        widget.isView == true ? true : false,
                                    labelText: 'Illicit Drug',
                                    items: nephroController.illicitList,
                                    hint: "Select",
                                    isRequired: false,
                                    senValue: (value) {
                                      nephroController.selectediLLicit = value;
                                    },
                                    filledColor: Colors.white,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MyCustomDropdown(
                                          selectedItem: nephroController
                                              .selectedDrugCurrentStat,
                                          isViewProfile: widget.isView == true
                                              ? true
                                              : false,
                                          labelText: 'Drug Current Stat',
                                          items: nephroController
                                                  .currentStatList
                                                  ?.map(
                                                      (e) => e.lookupDetDescEn)
                                                  .toList() ??
                                              [],
                                          hint: "Select",
                                          isRequired: false,
                                          senValue: (value) {
                                            nephroController
                                                    .selectedDrugCurrentStat =
                                                value;
                                          },
                                          filledColor: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Drug Duration',
                                          hintText: 'Enter',
                                          isRequired: false,
                                          keyBoardType: TextInputType.number,
                                          txtController:
                                              nephroController.drugDuration,
                                          fillColor: Colors.white,
                                          isReadOnly: false,
                                          maxLines: 1,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomTextField(
                                    labelText: 'Remark',
                                    hintText: 'Enter',
                                    isRequired:
                                        widget.isView == true ? true : false,
                                    keyBoardType: TextInputType.text,
                                    txtController: nephroController.remark,
                                    fillColor: Colors.white,
                                    isReadOnly: false,
                                    maxLines: 1,
                                    fontSize: 12.sp,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 10.w, vertical: 2.h),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomExpandableContainer(
                        leading: 'assets/file-info.png',
                        text: 'ON EXAMINATION',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 8.w),
                              decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColor.borderColor)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          maxLines: 1,
                                          isReadOnly: widget.isView == true
                                              ? true
                                              : false,
                                          keyBoardType: TextInputType.number,
                                          labelText: 'Temperature',
                                          hintText: 'Enter',
                                          isRequired: false,
                                          txtController: nephroController.temp,
                                          fillColor: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: CustomTextField(
                                          onChanged: (value) {},
                                          maxLines: 1,
                                          isReadOnly: widget.isView == true
                                              ? true
                                              : false,
                                          keyBoardType: TextInputType.number,
                                          labelText: 'Pulse',
                                          hintText: 'Enter',
                                          isRequired: false,
                                          txtController: nephroController.pulse,
                                          fillColor: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  //  SizedBox(height: 8.h),
                                  DoubleTextField(
                                    labelText: 'Blood Pressure',
                                    hintText1: 'Bottom',
                                    hintText2: 'Top',
                                    isRequired:
                                        widget.isView == true ? true : false,
                                    keyBoardType: TextInputType.number,
                                    txtController1: nephroController.topBlood,
                                    txtController2:
                                        nephroController.bottomBlood,
                                    fillColor: Colors.white,
                                    isReadOnly: false,
                                    maxLines: 1,
                                    onChange1: (value) {},
                                    onChange2: (value) {},
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomTextField(
                                    maxLines: 1,
                                    isReadOnly:
                                        widget.isView == true ? true : false,
                                    keyBoardType: TextInputType.number,
                                    labelText: 'Blood Glucose',
                                    hintText: 'Enter',
                                    isRequired: false,
                                    txtController:
                                        nephroController.bloodGlocuse,
                                    fillColor: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                  CustomTextField(
                                    maxLines: 1,
                                    isReadOnly:
                                        widget.isView == true ? true : false,
                                    keyBoardType: TextInputType.text,
                                    labelText: 'Past Surgical History',
                                    hintText: 'Enter',
                                    isRequired: false,
                                    txtController:
                                        nephroController.pasrSurgicalH,
                                    fillColor: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomTextField(
                                    maxLines: 1,
                                    isReadOnly:
                                        widget.isView == true ? true : false,
                                    keyBoardType: TextInputType.text,
                                    labelText:
                                        'Any allergies or adverse drug reactions?',
                                    hintText: 'Enter',
                                    isRequired: false,
                                    txtController: nephroController.allergies,
                                    fillColor: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                  SizedBox(height: 8.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 10.w, vertical: 2.h),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomExpandableContainer(
                        leading: 'assets/file-info.png',
                        text: 'SYSTEMATIC EXAMINATIONS',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 8.w),
                              decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColor.borderColor)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CustomTextField(
                                    maxLines: 1,
                                    isReadOnly:
                                        widget.isView == true ? true : false,
                                    keyBoardType: TextInputType.text,
                                    labelText: 'Special Instructions',
                                    hintText: 'Enter',
                                    isRequired: false,
                                    txtController: nephroController.specialInst,
                                    fillColor: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomTextField(
                                    maxLines: 1,
                                    isReadOnly:
                                        widget.isView == true ? true : false,
                                    keyBoardType: TextInputType.text,
                                    labelText: 'Treatment Plan',
                                    hintText: 'Enter',
                                    isRequired: false,
                                    txtController: nephroController.treatmentP,
                                    fillColor: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                  SizedBox(height: 8.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 10.w, vertical: 2.h),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomExpandableContainer(
                        leading: 'assets/file-info.png',
                        text: 'Add Details',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColor.borderColor)),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    NephroTable(
                                      readOnly:
                                          widget.isView == true ? true : false,
                                      l1: nephroController.addDetailsList
                                              ?.map(
                                                  (e) => e.descriptionEn ?? '')
                                              .toList() ??
                                          [],
                                      // l2: const ['DM', 'HTM', 'BA/COPD'],
                                      l3: [
                                        nephroController
                                            .diabetesMellitusDuration,
                                        nephroController.hypertensionDuration,
                                        nephroController.dyslipidemiaDuration,
                                        nephroController
                                            .chronicHeartDiseaseDuration,
                                        nephroController
                                            .chronicLiverDiseaseDuratin,
                                        nephroController.strokeDuration,
                                        nephroController.tuberculosisDuration,
                                        nephroController.hIVDuration,
                                        nephroController.hBVDuration,
                                        nephroController.hcvTreatedDuration,
                                        nephroController
                                            .mentalHealthDisorderDuration,
                                        nephroController
                                            .chronicLungDiseaseDuration,
                                        nephroController.hcvUntreatedDuration,
                                      ],
                                      l4: nephroController
                                              .checkBoxListClinicalHistory ??
                                          [],
                                      tableHeader: const [
                                        "Comorbidities",
                                        "Duration",
                                        "Yes/No",
                                        "Relation"
                                      ],
                                      onButtonPressed: handleButtonPress,
                                      relationList: nephroController
                                              .relationList
                                              ?.map((e) =>
                                                  e.lookupDetDescEn ?? '')
                                              .toList() ??
                                          [],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 7.w, vertical: 2.h),
                      SizedBox(
                        height: 10.h,
                      ),
                      Visibility(
                        visible: widget.isView != true,
                        child: CustomButton(
                          primColor: AppColor.primaryBackgroundColor,
                          secColor: AppColor.secondaryColor,
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          buttonText: 'Save',
                          path: 'assets/save-next.png',
                          callB: () async {
                            var body = {
                              "clinicalHistoryId": null,
                              "patientId": widget.patientData?.patientId,
                              "treatmentId": widget.patientData?.treatmentId,
                              "lookupDetIdDiet": nephroController
                                  .dietListClinicalHistory
                                  ?.firstWhere((e) =>
                                      e.lookupDetDescEn ==
                                      nephroController.selectedDiet)
                                  .lookupDetId,
                              "alcoholConsumption":
                                  nephroController.selectedAlcoholCon == "Yes"
                                      ? "Y"
                                      : "N",
                              "smoking":
                                  nephroController.selectedSmoking == "Yes"
                                      ? "Y"
                                      : "N",
                              "tobaccoConsumption":
                                  nephroController.selectedTobaco == "Yes"
                                      ? "Y"
                                      : "N",
                              "illicitDrug":
                                  nephroController.selectediLLicit == "Yes"
                                      ? "Y"
                                      : "N",
                              "remark": nephroController.remark.text,
                              "temperature": nephroController.temp.text,
                              "pulse":
                                  convertToNumber(nephroController.pulse.text),
                              "bp": null,
                              "bloodGlucose": convertToNumber(
                                  nephroController.bloodGlocuse.text),
                              "pastSurgicalHistory":
                                  nephroController.pasrSurgicalH.text,
                              "specialInstructions":
                                  nephroController.specialInst.text,
                              "treatmentPlan": nephroController.treatmentP.text,
                              "allergiesReactions":
                                  nephroController.allergies.text,
                              "status": null,
                              "createdBy": userData['ui'],
                              "createdDatetime": null,
                              "updatedBy": null,
                              "updatedDatetime": null,
                              "deletedBy": null,
                              "deletedDatetime": null,
                              "listCliniComorNewBean": [
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "Diabetes Mellitus",
                                  "durationYear": nephroController
                                          .diabetesMellitusDuration
                                          .text
                                          .isNotEmpty
                                      ? convertToNumber(nephroController
                                          .diabetesMellitusDuration.text)
                                      : null,
                                  "comorFlag":
                                      nephroController.checkBoxValues.first ==
                                              true
                                          ? "Y"
                                          : "N",
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": null,
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere((e) =>
                                          e.descriptionEn ==
                                          "Diabetes Mellitus")
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow.first
                                          .contains(item
                                              .lookupDetDescEn)) // Filter matching items
                                      .map((item) =>
                                          item.lookupDetId) // Extract IDs
                                      .toList(),
                                  "listOfData": null
                                },
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "Hypertension",
                                  "durationYear": nephroController
                                          .hypertensionDuration.text.isNotEmpty
                                      ? convertToNumber(nephroController
                                          .hypertensionDuration.text)
                                      : null,
                                  "comorFlag":
                                      nephroController.checkBoxValues[1] == true
                                          ? "Y"
                                          : "N",
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": null,
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere((e) =>
                                          e.descriptionEn == 'Hypertension')
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow[1]
                                          .contains(item
                                              .lookupDetDescEn)) // Filter matching items
                                      .map((item) =>
                                          item.lookupDetId) // Extract IDs
                                      .toList(),
                                  "listOfData": null
                                },
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "Dyslipidemia",
                                  "durationYear": nephroController
                                          .dyslipidemiaDuration.text.isNotEmpty
                                      ? convertToNumber(nephroController
                                          .dyslipidemiaDuration.text)
                                      : null,
                                  "comorFlag":
                                      nephroController.checkBoxValues[2] == true
                                          ? "Y"
                                          : "N",
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": null,
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere((e) =>
                                          e.descriptionEn == 'Dyslipidemia')
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow[2]
                                          .contains(item
                                              .lookupDetDescEn)) // Filter matching items
                                      .map((item) =>
                                          item.lookupDetId) // Extract IDs
                                      .toList(),
                                  "listOfData": null
                                },
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "Chronic Heart Disease",
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": null,
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "comorFlag":
                                      nephroController.checkBoxValues[3] == true
                                          ? "Y"
                                          : "N",
                                  "durationYear": nephroController
                                          .chronicHeartDiseaseDuration
                                          .text
                                          .isNotEmpty
                                      ? convertToNumber(nephroController
                                          .chronicHeartDiseaseDuration.text)
                                      : null,
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere((e) =>
                                          e.descriptionEn ==
                                          'Chronic Heart Disease')
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow[3]
                                          .contains(item
                                              .lookupDetDescEn)) // Filter matching items
                                      .map((item) =>
                                          item.lookupDetId) // Extract IDs
                                      .toList(),
                                  "listOfData": null
                                },
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "Chronic Liver Disease",
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": null,
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "comorFlag":
                                      nephroController.checkBoxValues[4] == true
                                          ? "Y"
                                          : "N",
                                  "durationYear": nephroController
                                          .chronicLiverDiseaseDuratin
                                          .text
                                          .isNotEmpty
                                      ? convertToNumber(nephroController
                                          .chronicLiverDiseaseDuratin.text)
                                      : null,
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere((e) =>
                                          e.descriptionEn ==
                                          'Chronic Liver Disease')
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow[4]
                                          .contains(item
                                              .lookupDetDescEn)) // Filter matching items
                                      .map((item) =>
                                          item.lookupDetId) // Extract IDs
                                      .toList(),
                                  "listOfData": null
                                },
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "Stroke",
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": null,
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "comorFlag":
                                      nephroController.checkBoxValues[5] == true
                                          ? "Y"
                                          : "N",
                                  "durationYear": nephroController
                                          .strokeDuration.text.isNotEmpty
                                      ? convertToNumber(
                                          nephroController.strokeDuration.text)
                                      : null,
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere(
                                          (e) => e.descriptionEn == 'Stroke')
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow[5]
                                          .contains(item
                                              .lookupDetDescEn)) // Filter matching items
                                      .map((item) =>
                                          item.lookupDetId) // Extract IDs
                                      .toList(),
                                  "listOfData": null
                                },
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "Tuberculosis",
                                  "durationYear": nephroController
                                          .tuberculosisDuration.text.isNotEmpty
                                      ? convertToNumber(nephroController
                                          .tuberculosisDuration.text)
                                      : null,
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": null,
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "comorFlag":
                                      nephroController.checkBoxValues[6] == true
                                          ? "Y"
                                          : "N",
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere((e) =>
                                          e.descriptionEn == 'Tuberculosis')
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow[6]
                                          .contains(item
                                              .lookupDetDescEn)) // Filter matching items
                                      .map((item) =>
                                          item.lookupDetId) // Extract IDs
                                      .toList(),
                                  "listOfData": null
                                },
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "HIV",
                                  "durationYear": nephroController
                                          .hIVDuration.text.isNotEmpty
                                      ? convertToNumber(
                                          nephroController.hIVDuration.text)
                                      : null,
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": null,
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "comorFlag":
                                      nephroController.checkBoxValues[7] == true
                                          ? "Y"
                                          : "N",
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere(
                                          (e) => e.descriptionEn == 'HIV')
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow[7]
                                          .contains(item
                                              .lookupDetDescEn)) // Filter matching items
                                      .map((item) =>
                                          item.lookupDetId) // Extract IDs
                                      .toList(),
                                  "listOfData": null
                                },
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "HBV",
                                  "durationYear": nephroController
                                          .hBVDuration.text.isNotEmpty
                                      ? convertToNumber(
                                          nephroController.hBVDuration.text)
                                      : null,
                                  "comorFlag":
                                      nephroController.checkBoxValues[8] == true
                                          ? "Y"
                                          : "N",
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": userData['ui'],
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere(
                                          (e) => e.descriptionEn == 'HBV')
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow[8]
                                          .contains(item
                                              .lookupDetDescEn)) // Filter matching items
                                      .map((item) =>
                                          item.lookupDetId) // Extract IDs
                                      .toList(),
                                  "listOfData": null
                                },
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "HCV Treated",
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": null,
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "comorFlag":
                                      nephroController.checkBoxValues[8] == true
                                          ? "Y"
                                          : "N",
                                  "durationYear": nephroController
                                          .hcvTreatedDuration.text.isNotEmpty
                                      ? convertToNumber(nephroController
                                          .hcvTreatedDuration.text)
                                      : null,
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere((e) =>
                                          e.descriptionEn == 'HCV Treated')
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow[9]
                                          .contains(item
                                              .lookupDetDescEn)) // Filter matching items
                                      .map((item) =>
                                          item.lookupDetId) // Extract IDs
                                      .toList(),
                                  "listOfData": null
                                },
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "Mental Health Disorder",
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": null,
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "comorFlag":
                                      nephroController.checkBoxValues[10] ==
                                              true
                                          ? "Y"
                                          : "N",
                                  "durationYear": nephroController
                                          .mentalHealthDisorderDuration
                                          .text
                                          .isNotEmpty
                                      ? convertToNumber(nephroController
                                          .mentalHealthDisorderDuration.text)
                                      : null,
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere((e) =>
                                          e.descriptionEn ==
                                          'Mental Health Disorder')
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow[10]
                                          .contains(item
                                              .lookupDetDescEn)) // Filter matching items
                                      .map((item) =>
                                          item.lookupDetId) // Extract IDs
                                      .toList(),
                                  "listOfData": null
                                },
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "Chronic Lung Disease",
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": null,
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "comorFlag":
                                      nephroController.checkBoxValues[11] ==
                                              true
                                          ? "Y"
                                          : "N",
                                  "durationYear": nephroController
                                          .chronicLungDiseaseDuration
                                          .text
                                          .isNotEmpty
                                      ? convertToNumber(nephroController
                                          .chronicLungDiseaseDuration.text)
                                      : null,
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere((e) =>
                                          e.descriptionEn ==
                                          'Chronic Lung Disease')
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow[11]
                                          .contains(item.lookupDetDescEn))
                                      .map((item) => item.lookupDetId)
                                      .toList(),
                                  "listOfData": null
                                },
                                {
                                  "clinicalComorbiditiesId": null,
                                  "patientId": widget.patientData?.patientId,
                                  "treatmentId":
                                      widget.patientData?.treatmentId,
                                  "comorbidities": "HCV Untreated",
                                  "lookupDetIdRelation": null,
                                  "status": null,
                                  "createdBy": null,
                                  "createdDatetime": null,
                                  "updatedBy": null,
                                  "updatedDatetime": null,
                                  "deletedBy": null,
                                  "deletedDatetime": null,
                                  "comorFlag":
                                      nephroController.checkBoxValues[12] ==
                                              true
                                          ? "Y"
                                          : "N",
                                  "durationYear": nephroController
                                          .hcvTreatedDuration.text.isNotEmpty
                                      ? convertToNumber(nephroController
                                          .hcvUntreatedDuration.text)
                                      : null,
                                  "lookupDetIdComorbidities": nephroController
                                      .addDetailsList
                                      ?.firstWhere((e) =>
                                          e.descriptionEn == 'HCV Untreated')
                                      .lookDetId,
                                  "multiRelaId": nephroController.relationList
                                      ?.where((item) => nephroController
                                          .selectedItemsPerRow[12]
                                          .contains(item
                                              .lookupDetDescEn)) // Filter matching items
                                      .map((item) =>
                                          item.lookupDetId) // Extract IDs
                                      .toList(),
                                  "listOfData": null
                                },
                              ],
                              "bloodPressureH":
                                  int.parse(nephroController.topBlood.text),
                              "bloodPressureL":
                                  int.parse(nephroController.bottomBlood.text),
                              "temperatureUnit": "F",

                              ///need to add fields
                              "chiefComplaints": "",

                              ///need to add fields
                              "alcoholDuration": nephroController
                                      .alcoholDuration.text.isNotEmpty
                                  ? int.parse(
                                      nephroController.alcoholDuration.text)
                                  : null,

                              ///need to add fields
                              // "alcoholCurrentStatus": 748,
                              "alcoholCurrentStatus": nephroController
                                  .currentStatList
                                  ?.firstWhere(
                                      (e) =>
                                          e.lookupDetDescEn ==
                                          nephroController.selectedAlcoholCon,
                                      orElse: () => RelationListM())
                                  .lookupDetId,

                              ///need to add fields
                              "smokingDuration": nephroController
                                      .smokingDuration.text.isNotEmpty
                                  ? int.parse(
                                      nephroController.smokingDuration.text)
                                  : null,

                              ///need to add fields
                              // "smokingCurrentStatus": 748,
                              "smokingCurrentStatus": nephroController
                                  .currentStatList
                                  ?.firstWhere(
                                      (e) =>
                                          e.lookupDetDescEn ==
                                          nephroController
                                              .selectedSmokingCurrentStat,
                                      orElse: () => RelationListM())
                                  .lookupDetId,

                              ///need to add fields
                              "tobaccoDuration": nephroController
                                      .tobaccoDuration.text.isNotEmpty
                                  ? int.parse(
                                      nephroController.tobaccoDuration.text)
                                  : null,

                              ///need to add fields
                              "tobaccoCurentStatus": nephroController
                                  .currentStatList
                                  ?.firstWhere(
                                      (e) =>
                                          e.lookupDetDescEn ==
                                          nephroController
                                              .selectedTobaccoCurrentStat,
                                      orElse: () => RelationListM())
                                  .lookupDetId,
                              // "tobaccoCurentStatus": 749,

                              ///need to add fields
                              "illicitDrugDuration":
                                  nephroController.drugDuration.text.isNotEmpty
                                      ? int.parse(
                                          nephroController.drugDuration.text)
                                      : null,

                              ///need to add fields
                              "illicitDrugCurrentStatus": nephroController
                                  .currentStatList
                                  ?.firstWhere(
                                      (e) =>
                                          e.lookupDetDescEn ==
                                          nephroController
                                              .selectedDrugCurrentStat,
                                      orElse: () => RelationListM())
                                  .lookupDetId
                              // "illicitDrugCurrentStatus": 749

                              ///need to add fields
                            };

                            debugPrint(jsonEncode(body));

                            await nephroController.saveClinicalHistory(
                                body,
                                widget.patientData?.patientId,
                                nephroController.treatmentIdModel?[0][0]
                                    .toString(),
                                nephroController.addDetailsList!);
                          },
                          buttonWidth: 140.w,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  );
          }),
    );
  }

  dynamic convertToNumber(String input) {
    if (input.contains('.')) {
      return double.parse(input);
    } else {
      return int.parse(input);
    }
  }

  handleButtonPress(int index) {
    // Perform action based on the index
    if (index == 0) {
      debugPrint('Button pressed at index: $index');
    } else if (index == 1) {
      debugPrint('Button pressed at index: $index');
    }
  }

  Widget statusChip() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.green[100], borderRadius: BorderRadius.circular(4)),
      child: const CustomText(
        text: 'Active',
        fontSize: 12,
        fontFam: 'Lato',
        fontWeight: FontWeight.w400,
        textColor: Colors.green,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class AddDetailsTable {
  String? descriptionEn;
  String? descriptionRg;
  int? lookDetId;
  String? lookupDetValue;

  AddDetailsTable({
    this.descriptionEn,
    this.descriptionRg,
    this.lookDetId,
    this.lookupDetValue,
  });

  factory AddDetailsTable.fromJson(Map<String, dynamic> json) {
    return AddDetailsTable(
      descriptionEn: json['descriptionEn'] as String?,
      descriptionRg: json['descriptionRg'] as String?,
      lookDetId: json['lookDetId'] as int?,
      lookupDetValue: json['lookupDetValue'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descriptionEn': descriptionEn,
      'descriptionRg': descriptionRg,
      'lookDetId': lookDetId,
      'lookupDetValue': lookupDetValue,
    };
  }
}

class RelationListM {
  int? lookupDetId;
  String? lookupDetValue;
  String? lookupDetDescEn;
  String? lookupDetParentName;

  RelationListM(
      {this.lookupDetId,
      this.lookupDetValue,
      this.lookupDetDescEn,
      this.lookupDetParentName});

  Map<String, dynamic> toJson() => {
        "lookupDetId": lookupDetId,
        "lookupDetValue": lookupDetValue,
        "lookupDetDescEn": lookupDetDescEn,
        "lookupDetParentName": lookupDetParentName,
      };

  factory RelationListM.fromJson(Map<String, dynamic> json) => RelationListM(
        lookupDetId: json["lookupDetId"],
        lookupDetValue: json["lookupDetValue"],
        lookupDetDescEn: json["lookupDetDescEn"],
        lookupDetParentName: json["lookupDetParentName"],
      );
}

class DietListM {
  int? lookupDetId;
  String? lookupDetValue;
  String? lookupDetDescEn;
  String? lookupDetParentName;

  DietListM(
      {this.lookupDetId,
      this.lookupDetValue,
      this.lookupDetDescEn,
      this.lookupDetParentName});
}

class PatientRelationListM {
  String? centerPatientId;
  int? age;
  int? ageMonths;
  int? ageDays;
  int? talukaId;
  int? townId;
  int? districtId;
  int? divisionId;
  int? stateId;
  int? countryId;
  int? areaCode;
  int? unitId;
  String? deleted;
  String? organDonarFlag;
  String? imageName;
  String? aadharImageName;
  String? blockFlag;
  String? blockNarration1;
  String? blockNarration2;
  String? blockNarration3;
  String? blockUserName1;
  String? blockUserName2;
  String? blockUserName3;
  int? blockUserId1;
  int? blockUserId2;
  int? blockUserId3;
  int? relationId;
  int? pertalukaId;
  int? pertownId;
  int? perdistrictId;
  int? perstateId;
  int? perDivisionId;
  int? percountryId;
  int? perareaCode;
  String? oldPatientId;
  int? maritalStatusId;
  int? nationalityId;
  int? religionId;
  int? languageId;
  int? bloodGroupId;
  int? identityProofId;
  int? annualIncomeId;
  String? occupation;
  String? education;
  String? ivfTreatFlag;
  String? healthId;
  String? healthIdNumber;
  String? legacyUHIDNumber;
  int? departmentId;
  int? patientStatus;
  int? treatmentId;
  int? count;

  List<RelationListM>? relationList;
  List<RelationListM>? dietList;
  List<RelationListM>? currentStatusList;

  int? lookupDetIdOcc;
  int? lookUpDetRelationId;
  int? parentPatientId;
  int? relationMappingId;
  int? lookupDetIdRel;
  int? lookupDetIdEdu;
  int? lookupDetIdEco;

  PatientRelationListM({
    this.centerPatientId,
    this.age,
    this.ageMonths,
    this.ageDays,
    this.talukaId,
    this.townId,
    this.districtId,
    this.divisionId,
    this.stateId,
    this.countryId,
    this.areaCode,
    this.unitId,
    this.deleted,
    this.organDonarFlag,
    this.imageName,
    this.aadharImageName,
    this.blockFlag,
    this.blockNarration1,
    this.blockNarration2,
    this.blockNarration3,
    this.blockUserName1,
    this.blockUserName2,
    this.blockUserName3,
    this.blockUserId1,
    this.blockUserId2,
    this.blockUserId3,
    this.relationId,
    this.pertalukaId,
    this.pertownId,
    this.perdistrictId,
    this.perstateId,
    this.perDivisionId,
    this.percountryId,
    this.perareaCode,
    this.oldPatientId,
    this.maritalStatusId,
    this.nationalityId,
    this.religionId,
    this.languageId,
    this.bloodGroupId,
    this.identityProofId,
    this.annualIncomeId,
    this.occupation,
    this.education,
    this.ivfTreatFlag,
    this.healthId,
    this.healthIdNumber,
    this.legacyUHIDNumber,
    this.departmentId,
    this.patientStatus,
    this.treatmentId,
    this.count,
    this.relationList,
    this.dietList,
    this.currentStatusList,
    this.lookupDetIdOcc,
    this.lookUpDetRelationId,
    this.parentPatientId,
    this.relationMappingId,
    this.lookupDetIdRel,
    this.lookupDetIdEdu,
    this.lookupDetIdEco,
  });

  factory PatientRelationListM.fromJson(Map<String, dynamic> json) =>
      PatientRelationListM(
        centerPatientId: json["centerPatientId"],
        age: json["age"],
        ageMonths: json["ageMonths"],
        ageDays: json["ageDays"],
        talukaId: json["talukaId"],
        townId: json["townId"],
        districtId: json["districtId"],
        divisionId: json["divisionId"],
        stateId: json["stateId"],
        countryId: json["countryId"],
        areaCode: json["areaCode"],
        unitId: json["unitId"],
        deleted: json["deleted"],
        organDonarFlag: json["organDonarFlag"],
        imageName: json["imageName"],
        aadharImageName: json["aadharImageName"],
        blockFlag: json["blockFlag"],
        blockNarration1: json["blockNarration1"],
        blockNarration2: json["blockNarration2"],
        blockNarration3: json["blockNarration3"],
        blockUserName1: json["blockUserName1"],
        blockUserName2: json["blockUserName2"],
        blockUserName3: json["blockUserName3"],
        blockUserId1: json["blockUserId1"],
        blockUserId2: json["blockUserId2"],
        blockUserId3: json["blockUserId3"],
        relationId: json["relationId"],
        pertalukaId: json["pertalukaId"],
        pertownId: json["pertownId"],
        perdistrictId: json["perdistrictId"],
        perstateId: json["perstateId"],
        perDivisionId: json["perDivisionId"],
        percountryId: json["percountryId"],
        perareaCode: json["perareaCode"],
        oldPatientId: json["oldPatientId"],
        maritalStatusId: json["maritalStatusId"],
        nationalityId: json["nationalityId"],
        religionId: json["religionId"],
        languageId: json["languageId"],
        bloodGroupId: json["bloodGroupId"],
        identityProofId: json["identityProofId"],
        annualIncomeId: json["annualIncomeId"],
        occupation: json["occupation"],
        education: json["education"],
        ivfTreatFlag: json["ivfTreatFlag"],
        healthId: json["healthId"],
        healthIdNumber: json["healthIdNumber"],
        legacyUHIDNumber: json["legacyUHIDNumber"],
        departmentId: json["departmentId"],
        patientStatus: json["patientStatus"],
        treatmentId: json["treatmentId"],
        count: json["count"],
        relationList: (json["relationList"] as List?)
            ?.map((e) => RelationListM.fromJson(e))
            .toList(),
        dietList: (json["dietList"] as List?)
            ?.map((e) => RelationListM.fromJson(e))
            .toList(),
        currentStatusList: (json["currentStatusList"] as List?)
            ?.map((e) => RelationListM.fromJson(e))
            .toList(),
        lookupDetIdOcc: json["lookupDetIdOcc"],
        lookUpDetRelationId: json["lookUpDetRelationId"],
        parentPatientId: json["parentPatientId"],
        relationMappingId: json["relationMappingId"],
        lookupDetIdRel: json["lookupDetIdRel"],
        lookupDetIdEdu: json["lookupDetIdEdu"],
        lookupDetIdEco: json["lookupDetIdEco"],
      );

  Map<String, dynamic> toJson() => {
        "centerPatientId": centerPatientId,
        "age": age,
        "ageMonths": ageMonths,
        "ageDays": ageDays,
        "talukaId": talukaId,
        "townId": townId,
        "districtId": districtId,
        "divisionId": divisionId,
        "stateId": stateId,
        "countryId": countryId,
        "areaCode": areaCode,
        "unitId": unitId,
        "deleted": deleted,
        "organDonarFlag": organDonarFlag,
        "imageName": imageName,
        "aadharImageName": aadharImageName,
        "blockFlag": blockFlag,
        "blockNarration1": blockNarration1,
        "blockNarration2": blockNarration2,
        "blockNarration3": blockNarration3,
        "blockUserName1": blockUserName1,
        "blockUserName2": blockUserName2,
        "blockUserName3": blockUserName3,
        "blockUserId1": blockUserId1,
        "blockUserId2": blockUserId2,
        "blockUserId3": blockUserId3,
        "relationId": relationId,
        "pertalukaId": pertalukaId,
        "pertownId": pertownId,
        "perdistrictId": perdistrictId,
        "perstateId": perstateId,
        "perDivisionId": perDivisionId,
        "percountryId": percountryId,
        "perareaCode": perareaCode,
        "oldPatientId": oldPatientId,
        "maritalStatusId": maritalStatusId,
        "nationalityId": nationalityId,
        "religionId": religionId,
        "languageId": languageId,
        "bloodGroupId": bloodGroupId,
        "identityProofId": identityProofId,
        "annualIncomeId": annualIncomeId,
        "occupation": occupation,
        "education": education,
        "ivfTreatFlag": ivfTreatFlag,
        "healthId": healthId,
        "healthIdNumber": healthIdNumber,
        "legacyUHIDNumber": legacyUHIDNumber,
        "departmentId": departmentId,
        "patientStatus": patientStatus,
        "treatmentId": treatmentId,
        "count": count,
        "relationList": relationList?.map((e) => e.toJson()).toList(),
        "dietList": dietList?.map((e) => e.toJson()).toList(),
        "currentStatusList": currentStatusList?.map((e) => e.toJson()).toList(),
        "lookupDetIdOcc": lookupDetIdOcc,
        "lookUpDetRelationId": lookUpDetRelationId,
        "parentPatientId": parentPatientId,
        "relationMappingId": relationMappingId,
        "lookupDetIdRel": lookupDetIdRel,
        "lookupDetIdEdu": lookupDetIdEdu,
        "lookupDetIdEco": lookupDetIdEco,
      };
}
