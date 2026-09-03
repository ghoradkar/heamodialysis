import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/controller/post_dialysis_controller.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/edit_history_screen.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/access_type_data2.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/access_type_site_data2.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/dialysis_type_data.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/dialyzer_type_data.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/special_dialysis_data.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/model/pre_dialysis/pre_dialysis_data.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/pre_dialysis_list/controller/pre_dialysis_controller.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/pre_dialysis_list/screen/pre_dialysis_screen.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:heamodialysis/widgets/patient_card_details.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class EditPreDialysisScreen extends StatefulWidget {
  final Function callB;
  final PreDialysisData preDialysisData;

  const EditPreDialysisScreen(
      {super.key, required this.callB, required this.preDialysisData});

  @override
  State<EditPreDialysisScreen> createState() => EditPreDialysisScreenState();
}

class EditPreDialysisScreenState extends State<EditPreDialysisScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());
  final ExpansionTileController expansionTileController =
      ExpansionTileController();
  final ExpansionTileController expansionTileController2 =
      ExpansionTileController();

  DateTime? _selectedDate;

  String prefixVal = '';

  String selectedInstitute = '';

  String formattedDateDBO = '';

  String? selectedGender;

  File? image;

  int years = 0;

  int months = 0;

  int days = 0;
  bool isFormValid = false;

  DialysisTypeData? selectedEditPreDialysis;
  SpecialDialysisData? specialDialysisData;
  DialyzerTypeData? dialyzerTypeData;
  AccessTypeSiteData2? accessTypeSiteData;
  AccessTypeData2? selectedAccessType;

  String? selectedProd;

  String? pickedTime;

  final PreDialysisController preDialysisController =
      Get.put(PreDialysisController());
  bool isExpanded = false;
  bool hasInternet = true;

  var userData;

  String? selectedDialysisTypeVal;

  String? selectedAcessTypeValue;

  int? selectedAccessSiteVal;

  String? selectedDialyzerTypeVal;

  final PostDialysisController postDialysisController =
      Get.put(PostDialysisController());

  @override
  void initState() {
    preDialysisController.timeController.clear();
    preDialysisController.dateController.clear();
    preDialysisController.preConditionController.clear();
    preDialysisController.doubleTxtController1.clear();
    preDialysisController.doubleTxtController2.clear();
    preDialysisController.oxygenLevel.clear();
    preDialysisController.preDialyWeightController.clear();
    preDialysisController.dryWeightController.clear();
    preDialysisController.weightGainController.clear();
    preDialysisController.pulseLevel.clear();
    preDialysisController.temperaturController.clear();
    preDialysisController.respiratoryRate.clear();

    checkInternetAndLoadData();
    super.initState();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    preDialysisController.refreshUi();
    if (hasInternet) {
      // await dashboardController.getAllRegisteredPatient();
      getUserData();
      await newRegistrationController
          .viewPatientData(widget.preDialysisData.patientId);
      // await postDialysisController.getPatientDetails(
      //     widget.preDialysisData.patientId.toString(),
      //     widget.preDialysisData.treatmentId.toString());
      await preDialysisController.getDialysisType();
      await preDialysisController.getAccessType();
      // await preDialysisController.getAccessTypeSite();
      await preDialysisController.getDialyzerType();
      await preDialysisController.getSpecialDialysis();
      await preDialysisController.getInterDialyticWeight(
          widget.preDialysisData.patientId.toString(),
          widget.preDialysisData.treatmentId.toString());
      await preDialysisController
          .getViewHistory(widget.preDialysisData.patientId!);
      await preDialysisController.getDialyzerDetails(widget.preDialysisData);
      await newRegistrationController
          .getProfilePhoto(widget.preDialysisData.patientId);
      preDialysisController.refreshUi();
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Edit Pre Dialysis  Details',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.to(const PreDialysisScreen());
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body:
      GetBuilder<PreDialysisController>(
          init: PreDialysisController(),
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ? const EditPreDialysisDetailsShimmer()
                    : SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PatientCardDetails(
                                imagePath: buildProfileImage(),
                                isExpand: (value) {
                                  isExpanded = value;
                                  setState(() {});
                                },
                                isExpanded: isExpanded,
                                isFromAddPredialysis: true,
                                // patientId: widget.preDialysisData.patientId?.toString(),
                                // patientName:
                                // '${widget.preDialysisData.fName ?? ''} ${widget.preDialysisData.lName ?? ''}',
                                // gender: widget.preDialysisData.gender,
                                // refDoc: widget.preDialysisData.referenceDoctorName,
                                // age: widget.preDialysisData.age?.toString(),
                                refBy:
                                    widget.preDialysisData.refByName.toString(),
                                schemaAdopted: widget
                                    .preDialysisData.procedureType
                                    .toString(),
                                patientDetails:
                                    newRegistrationController.viewPatientModel,
                              ).paddingSymmetric(vertical: 10),
                              Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ExpansionTile(
                                      controller: expansionTileController,
                                      // key: const PageStorageKey<String>('pre_dialysis_tile'),

                                      maintainState: true,
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      title: Row(children: [
                                        Image.asset("assets/file-list.png"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const CustomText(
                                          text: "Pre Dialysis Details",
                                          fontSize: 14.0,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(color: Colors.grey)
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              // crossAxisAlignment:
                                              //     CrossAxisAlignment.stretch,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const SizedBox(height: 16),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[50],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .borderColor)),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          // Expanded(
                                                          //   child:
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child:
                                                                MyCustomDropdown(
                                                                    selectedItem:
                                                                        selectedDialysisTypeVal,
                                                                    labelText:
                                                                        'Dialysis Type',
                                                                    items: preDialysisController
                                                                            .editPredialysisDetailsModel
                                                                            ?.data
                                                                            ?.map((e) => e
                                                                                .lookupDetDescEn)
                                                                            .toList() ??
                                                                        [],
                                                                    hint:
                                                                        'Select',
                                                                    isRequired:
                                                                        true,
                                                                    senValue:
                                                                        (value) {
                                                                      selectedEditPreDialysis = preDialysisController
                                                                          .editPredialysisDetailsModel
                                                                          ?.data
                                                                          ?.firstWhere((e) =>
                                                                              e.lookupDetDescEn ==
                                                                              value);
                                                                      selectedDialysisTypeVal =
                                                                          selectedEditPreDialysis?.lookupDetDescEn ??
                                                                              "";
                                                                      preDialysisController
                                                                          .refreshUi();
                                                                    },
                                                                    filledColor:
                                                                        Colors
                                                                            .white),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          // Expanded(
                                                          //   child:
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child:
                                                                MyCustomDropdown(
                                                                    selectedItem:
                                                                        selectedAcessTypeValue,
                                                                    labelText:
                                                                        'Access Type',
                                                                    items: preDialysisController
                                                                            .accessTypeData
                                                                            ?.data2
                                                                            ?.map((e) => e
                                                                                .lookupDetHierDescEn)
                                                                            .toList() ??
                                                                        [],
                                                                    hint:
                                                                        'Select',
                                                                    isRequired:
                                                                        true,
                                                                    senValue:
                                                                        (value) async {
                                                                      selectedAccessSiteVal =
                                                                          null;
                                                                      controller
                                                                          .update();
                                                                      selectedAccessType = preDialysisController
                                                                          .accessTypeData
                                                                          ?.data2
                                                                          ?.firstWhere((e) =>
                                                                              e.lookupDetHierDescEn ==
                                                                              value);
                                                                      selectedAcessTypeValue =
                                                                          selectedAccessType?.lookupDetHierDescEn ??
                                                                              "";
                                                                      String
                                                                          lookupId =
                                                                          selectedAccessType?.lookupDetHierId.toString() ??
                                                                              "";
                                                                      await preDialysisController
                                                                          .getAccessTypeSite(
                                                                              lookupId);
                                                                      preDialysisController
                                                                          .refreshUi();
                                                                    },
                                                                    filledColor:
                                                                        Colors
                                                                            .white),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          // Expanded(
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      8,
                                                                      0,
                                                                      8,
                                                                      8),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            8,
                                                                            8,
                                                                            8),
                                                                    child: Row(
                                                                      children: [
                                                                        const Text(
                                                                          "Access Site",
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                        Text(
                                                                          ' *',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                AppColor.red,
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  DropdownButtonFormField(
                                                                    isExpanded:
                                                                        true,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_outlined,
                                                                      color: AppColor
                                                                          .primaryBackgroundColor,
                                                                    ),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          "Select",
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      hintStyle: const TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          color: Color(
                                                                              0xff999999),
                                                                          fontFamily:
                                                                              "Lato",
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              AppColor.borderColor,
                                                                        ),
                                                                      ),
                                                                      errorBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.red, // Red border on all sides
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              AppColor.borderColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    initialValue:
                                                                        selectedAccessSiteVal,
                                                                    items: preDialysisController
                                                                        .accessTypeSiteModel
                                                                        ?.data2
                                                                        ?.map((item) =>
                                                                            DropdownMenuItem(
                                                                              value: item.lookupDetHierId,
                                                                              child: Text(item.lookupDetHierDescEn ?? ""),
                                                                            ))
                                                                        .toList(),
                                                                    onChanged:
                                                                        (value) {
                                                                      accessTypeSiteData = preDialysisController
                                                                          .accessTypeSiteModel
                                                                          ?.data2
                                                                          ?.firstWhere((e) =>
                                                                              e.lookupDetHierId ==
                                                                              value);
                                                                      selectedAccessSiteVal =
                                                                          accessTypeSiteData
                                                                              ?.lookupDetHierId;
                                                                      preDialysisController
                                                                          .refreshUi();
                                                                    },
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                          null) {
                                                                        return "Access Type is required";
                                                                      }
                                                                      return null;
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          // Expanded(
                                                          //   child:
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child:
                                                                MyCustomDropdown(
                                                                    selectedItem:
                                                                        selectedDialyzerTypeVal,
                                                                    labelText:
                                                                        'Dialyzer Type',
                                                                    items: preDialysisController
                                                                            .dialyzerTypeModel
                                                                            ?.data
                                                                            ?.map((e) => e
                                                                                .lookupDetDescEn)
                                                                            .toList() ??
                                                                        [],
                                                                    hint:
                                                                        'Select',
                                                                    isRequired:
                                                                        true,
                                                                    senValue:
                                                                        (value) async {
                                                                      dialyzerTypeData = preDialysisController
                                                                          .dialyzerTypeModel
                                                                          ?.data
                                                                          ?.firstWhere((e) =>
                                                                              e.lookupDetDescEn ==
                                                                              value);
                                                                      selectedDialyzerTypeVal =
                                                                          dialyzerTypeData?.lookupDetDescEn ??
                                                                              "";
                                                                      await preDialysisController.getFiberBundle(dialyzerTypeData!
                                                                          .lookupDetId
                                                                          .toString());
                                                                      preDialysisController
                                                                          .refreshUi();
                                                                    },
                                                                    filledColor:
                                                                        Colors
                                                                            .white),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      CustomTextField(
                                                        onChanged: (value) {},
                                                        maxLines: 1,
                                                        isReadOnly: true,
                                                        keyBoardType:
                                                            TextInputType.name,
                                                        labelText:
                                                            'Expected Fiber Bundle Volume',
                                                        hintText: 'Enter',
                                                        isRequired: false,
                                                        txtController:
                                                            preDialysisController
                                                                .expectedFiber,
                                                        fillColor: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      const SizedBox(height: 8),
                                                      CustomRadioField(
                                                        isRequired: true,
                                                        radioCallB1: (value) {
                                                          preDialysisController
                                                                  .groupVal1 =
                                                              value;

                                                          setState(() {});

                                                          if (int.parse(
                                                                  preDialysisController
                                                                      .dialyzerReuseNoController
                                                                      .text) >
                                                              1) {
                                                            showAlertDialog(
                                                                () {
                                                                  //cancel button
                                                                  preDialysisController
                                                                          .groupVal1 =
                                                                      CustomRadioButtons
                                                                          .no;
                                                                  preDialysisController
                                                                      .update();
                                                                  Get.back();
                                                                },
                                                                () {
                                                                  //confirmation button
                                                                  // selectedDialysisTypeVal= null;
                                                                  // selectedAcessTypeValue= null;
                                                                  // selectedAccessSiteVal= null;
                                                                  // selectedDialyzerTypeVal= null;
                                                                  preDialysisController
                                                                      .dialyzerBarcodeController
                                                                      .text = "";
                                                                  preDialysisController
                                                                      .dialyzerReuseNoController
                                                                      .text = "1";
                                                                  preDialysisController
                                                                      .dialyzerRemark
                                                                      .text = '';
                                                                  Get.back();
                                                                },
                                                                "Kindly enter discarded remarks before using new dialyser and blood tubing",
                                                                "assets/info.png",
                                                                false,
                                                                () {},
                                                                preDialysisController
                                                                    .confirmationRemarkController,
                                                                (value) {
                                                                  //remark field value
                                                                });
                                                          }
                                                        },
                                                        radioCallB2: (value) {
                                                          preDialysisController
                                                                  .groupVal1 =
                                                              value;
                                                          setState(() {});
                                                        },
                                                        groupVal:
                                                            preDialysisController
                                                                .groupVal1,
                                                        text: "New Dialyzer",
                                                        firstRadioText: 'Yes',
                                                        secondRadioText: 'No',
                                                      ).paddingOnly(left: 8),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          // Expanded(
                                                          //   child:
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child:
                                                                CustomTextField(
                                                              onChanged:
                                                                  (value) {},
                                                              labelText:
                                                                  'Dialyzer Barcode No',
                                                              hintText: 'Enter',
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                              txtController:
                                                                  preDialysisController
                                                                      .dialyzerBarcodeController,
                                                              fillColor:
                                                                  Colors.white,
                                                              isReadOnly: preDialysisController
                                                                          .groupVal1 ==
                                                                      CustomRadioButtons
                                                                          .no
                                                                  ? true
                                                                  : false,
                                                              maxLines: 1,
                                                              isRequired: true,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          // Expanded(
                                                          //   child:
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child:
                                                                CustomTextField(
                                                              labelText:
                                                                  'Dialyzer Reuse No',
                                                              hintText: 'Enter',
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                              txtController:
                                                                  preDialysisController
                                                                      .dialyzerReuseNoController,
                                                              fillColor:
                                                                  Colors.white,
                                                              isReadOnly: true,
                                                              maxLines: 1,
                                                              isRequired: true,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      CustomTextField(
                                                        onChanged: (value) {},
                                                        maxLines: 1,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType.name,
                                                        labelText:
                                                            'Dialyzer Remark',
                                                        hintText: 'Enter',
                                                        isRequired: false,
                                                        txtController:
                                                            preDialysisController
                                                                .dialyzerRemark,
                                                        fillColor: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      CustomRadioField(
                                                        isRequired: true,
                                                        radioCallB1: (value) {
                                                          preDialysisController
                                                                  .groupVal2 =
                                                              value;
                                                          preDialysisController
                                                              .dialyzerTubeReuseNoController
                                                              .text = "1";
                                                          preDialysisController
                                                              .tubeRemark
                                                              .text = "";
                                                          preDialysisController
                                                              .tubeBarcodeController
                                                              .text = "";

                                                          setState(() {});
                                                        },
                                                        radioCallB2: (value) {
                                                          if (preDialysisController
                                                                  .groupVal2 ==
                                                              CustomRadioButtons
                                                                  .yes) {
                                                          } else {
                                                            preDialysisController
                                                                    .groupVal2 =
                                                                value;
                                                            setState(() {});
                                                          }
                                                        },
                                                        groupVal:
                                                            preDialysisController
                                                                .groupVal2,
                                                        text:
                                                            'New Blood Tubing',
                                                        firstRadioText: 'Yes',
                                                        secondRadioText: 'No',
                                                      ).paddingOnly(
                                                          left: 8, top: 6),
                                                      const SizedBox(height: 6),
                                                      Row(
                                                        children: [
                                                          // Expanded(
                                                          //   child:
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child:
                                                                CustomTextField(
                                                              onChanged: () {},
                                                              labelText:
                                                                  'Tube Barcode No',
                                                              hintText: 'Enter',
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                              txtController:
                                                                  preDialysisController
                                                                      .tubeBarcodeController,
                                                              fillColor:
                                                                  Colors.white,
                                                              isReadOnly: preDialysisController
                                                                          .groupVal2 ==
                                                                      CustomRadioButtons
                                                                          .no
                                                                  ? true
                                                                  : false,
                                                              maxLines: 1,
                                                              isRequired: true,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          // Expanded(
                                                          //   child:
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child:
                                                                CustomTextField(
                                                              labelText:
                                                                  'Tube Reuse No',
                                                              hintText: 'Enter',
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                              txtController:
                                                                  preDialysisController
                                                                      .dialyzerTubeReuseNoController,
                                                              fillColor:
                                                                  Colors.white,
                                                              isReadOnly: true,
                                                              maxLines: 1,
                                                              isRequired: true,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      CustomTextField(
                                                        onChanged: (value) {},
                                                        maxLines: 1,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType.name,
                                                        labelText:
                                                            'Blood Tube Remark',
                                                        hintText: 'Enter',
                                                        isRequired: false,
                                                        txtController:
                                                            preDialysisController
                                                                .tubeRemark,
                                                        fillColor: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          // Expanded(
                                                          //   child:
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child:
                                                                MyCustomDropdown(
                                                                    labelText:
                                                                        'Special Dialysis',
                                                                    items: preDialysisController
                                                                            .specialDialysisModel
                                                                            ?.data
                                                                            ?.map((e) => e
                                                                                .lookupDetDescEn)
                                                                            .toList() ??
                                                                        [],
                                                                    hint:
                                                                        'Select',
                                                                    isRequired:
                                                                        false,
                                                                    senValue:
                                                                        (value) {
                                                                      specialDialysisData = preDialysisController
                                                                          .specialDialysisModel
                                                                          ?.data
                                                                          ?.firstWhere((e) =>
                                                                              e.lookupDetDescEn ==
                                                                              value);

                                                                      preDialysisController
                                                                          .refreshUi();
                                                                    },
                                                                    filledColor:
                                                                        Colors
                                                                            .white),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          // Expanded(
                                                          //   child:
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child:
                                                                CustomTextField(
                                                              onChanged:
                                                                  (value) async {
                                                                if ((preDialysisController
                                                                            .getPreDialysisDetailsModel!
                                                                            .data![
                                                                                0]
                                                                            .tubeResueNo! ==
                                                                        1) &&
                                                                    (preDialysisController
                                                                            .getPreDialysisDetailsModel!
                                                                            .data![0]
                                                                            .dialyserResueNo! ==
                                                                        1)) {
                                                                  preDialysisController
                                                                      .weightGainController
                                                                      .text = "NA";
                                                                  preDialysisController
                                                                      .refreshUi();
                                                                } else {
                                                                  await preDialysisController.getInterDialyticWeight(
                                                                      widget
                                                                          .preDialysisData
                                                                          .patientId
                                                                          .toString(),
                                                                      widget
                                                                          .preDialysisData
                                                                          .treatmentId
                                                                          .toString());

                                                                  var val = double
                                                                      .parse(
                                                                          value); // Use double to handle floating-point values
                                                                  // Handle the case where weight might be null
                                                                  var weight =
                                                                      preDialysisController
                                                                              .interDialyticWeight
                                                                              ?.weight ??
                                                                          0.0;
                                                                  var diff =
                                                                      weight -
                                                                          val;

                                                                  // Update the controller text with the difference

                                                                  preDialysisController
                                                                          .weightGainController
                                                                          .text =
                                                                      diff.toString();
                                                                  preDialysisController
                                                                      .refreshUi();
                                                                }
                                                              },
                                                              maxLines: 1,
                                                              isReadOnly: false,
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                              labelText:
                                                                  'Pre Dialysis Weight',
                                                              hintText: 'Enter',
                                                              isRequired: true,
                                                              txtController:
                                                                  preDialysisController
                                                                      .preDialyWeightController,
                                                              fillColor:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          // Expanded(
                                                          //   child:
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child:
                                                                CustomTextField(
                                                              onChanged:
                                                                  (value) {},
                                                              maxLines: 1,
                                                              isReadOnly: true,
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                              labelText:
                                                                  'Interdialytic Gain',
                                                              hintText: 'Enter',
                                                              isRequired: true,
                                                              txtController:
                                                                  preDialysisController
                                                                      .weightGainController,
                                                              fillColor:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          // Expanded(
                                                          //   child:
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child:
                                                                CustomTextField(
                                                              onChanged:
                                                                  (value) {},
                                                              maxLines: 1,
                                                              isReadOnly: false,
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                              labelText:
                                                                  'Dry Weight',
                                                              hintText: 'Enter',
                                                              isRequired: true,
                                                              txtController:
                                                                  preDialysisController
                                                                      .dryWeightController,
                                                              fillColor:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      CustomTextField(
                                                        onChanged: (value) {},
                                                        maxLines: 2,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType.name,
                                                        labelText:
                                                            'Pre HD Condition',
                                                        hintText: 'Enter',
                                                        isRequired: false,
                                                        txtController:
                                                            preDialysisController
                                                                .preConditionController,
                                                        fillColor: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: CustomButton(
                                                          primColor: AppColor
                                                              .primaryBackgroundColor,
                                                          secColor: AppColor
                                                              .secondaryColor,
                                                          textColor:
                                                              Colors.white,
                                                          iconColor:
                                                              Colors.white,
                                                          buttonText:
                                                              'View History',
                                                          path:
                                                              'assets/eye.png',
                                                          callB: () {
                                                            Get.to(() =>
                                                                PatientHistoryScreen(
                                                                  preDialysisData:
                                                                      widget
                                                                          .preDialysisData,
                                                                  historyList:
                                                                      preDialysisController
                                                                              .historyModel
                                                                              ?.data2 ??
                                                                          [],
                                                                ));
                                                          },
                                                          buttonWidth: 140,
                                                        ),
                                                      ).paddingOnly(right: 4),
                                                      const SizedBox(
                                                          height: 12),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),

                              const SizedBox(
                                height: 10,
                              ),
                              // Theme(
                              //     data: ThemeData().copyWith(
                              //         dividerColor: Colors.transparent),
                              //     child:
                              //     Container(
                              //
                              //         decoration: BoxDecoration(
                              //             color: AppColor.darkBlue,
                              //             borderRadius:
                              //                 BorderRadius.circular(10)),
                              //         child: ExpansionTile(
                              //          // key: const PageStorageKey<String>('post_dialysis_tile'),
                              //
                              //           maintainState: true,
                              //           collapsedIconColor: Colors.white,
                              //           iconColor: Colors.white,
                              //           title: Row(children: [
                              //             Image.asset("assets/pulse-line.png"),
                              //             const SizedBox(width: 12),
                              //             const Text(
                              //               "Pre Dialysis Vitals",
                              //               style: TextStyle(
                              //                   fontSize: 14.0,
                              //                   color: Colors.white,
                              //                   fontFamily: 'Lato'),
                              //             ),
                              //           ]),
                              //           children: <Widget>[
                              //             Container(
                              //               padding: const EdgeInsets.all(8),
                              //               decoration: BoxDecoration(
                              //                 color: Colors.white,
                              //                 borderRadius:
                              //                 BorderRadius.circular(10),
                              //                 // border: Border.all(color: Colors.grey)
                              //               ),
                              //               child: SizedBox(
                              //                 height: 400, // ✅ fixed height
                              //                 child: SingleChildScrollView(
                              //                   child:Column(
                              //                 // crossAxisAlignment:
                              //                 // CrossAxisAlignment.stretch,
                              //                 crossAxisAlignment: CrossAxisAlignment.start,
                              //                 mainAxisSize: MainAxisSize.min,
                              //                 children: [
                              //                   const SizedBox(height: 16),
                              //                   Container(
                              //                     decoration: BoxDecoration(
                              //                         color: Colors.grey[50],
                              //                         borderRadius:
                              //                         BorderRadius.circular(
                              //                             10),
                              //                         border: Border.all(
                              //                             color: AppColor
                              //                                 .borderColor)),
                              //                     child: Column(
                              //                       children: [
                              //                         Row(
                              //                           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                           children: [
                              //                             DoubleTextField(
                              //                               labelText:
                              //                                   'Blood Pressure\n(mmHg)',
                              //                               hintText1: 'Bottom',
                              //                               hintText2: 'Top',
                              //                               isRequired: true,
                              //                               keyBoardType:
                              //                                   TextInputType
                              //                                       .number,
                              //                               txtController1:
                              //                                   preDialysisController
                              //                                       .doubleTxtController1,
                              //                               txtController2:
                              //                                   preDialysisController
                              //                                       .doubleTxtController2,
                              //                               fillColor:
                              //                                   Colors.white,
                              //                               isReadOnly: false,
                              //                               maxLines: 1,
                              //                               onChange1:
                              //                                   (value) {},
                              //                               onChange2:
                              //                                   (value) {},
                              //                             ),
                              //                             const SizedBox(
                              //                                 height: 8),
                              //                             // Expanded(
                              //                             //   child:
                              //                             Flexible(
                              //                               fit: FlexFit.loose,
                              //                               child: CustomTextField(
                              //                                 maxLines: 1,
                              //                                 isReadOnly: false,
                              //                                 keyBoardType:
                              //                                     TextInputType
                              //                                         .number,
                              //                                 labelText:
                              //                                     'Pulse\n(Beats/min)',
                              //                                 hintText: 'Enter',
                              //                                 isRequired: true,
                              //                                 txtController:
                              //                                     preDialysisController
                              //                                         .pulseLevel,
                              //                                 fillColor:
                              //                                     Colors.white,
                              //                                 fontSize: 16,
                              //                               ),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                         const SizedBox(height: 8),
                              //                         Row(
                              //                           children: [
                              //                             // Expanded(
                              //                             //   child:
                              //                             Flexible(
                              //                               fit: FlexFit.loose,
                              //                               child:
                              //                                   CustomTextFieldTemp(
                              //                                 onUnitChanged:
                              //                                     (isFahrenheit) {
                              //                                   preDialysisController
                              //                                           .selectedTemp =
                              //                                       isFahrenheit;
                              //                                 },
                              //                                 maxLines: 1,
                              //                                 isReadOnly: false,
                              //                                 keyBoardType:
                              //                                     TextInputType
                              //                                         .number,
                              //                                 labelText:
                              //                                     'Temperature',
                              //                                 hintText: 'Enter',
                              //                                 isRequired: false,
                              //                                 txtController:
                              //                                     preDialysisController
                              //                                         .temperaturController,
                              //                                 fillColor:
                              //                                     Colors.white,
                              //                                 fontSize: 16,
                              //                               ),
                              //                             ),
                              //                             const SizedBox(
                              //                                 height: 8),
                              //                             // Expanded(
                              //                             //   child:
                              //                             Flexible(
                              //                               fit: FlexFit.loose,
                              //                               child: CustomTextField(
                              //                                 onChanged:
                              //                                     (value) {},
                              //                                 maxLines: 1,
                              //                                 isReadOnly: false,
                              //                                 keyBoardType:
                              //                                     TextInputType
                              //                                         .number,
                              //                                 labelText:
                              //                                     'Oxygen Level (%)',
                              //                                 hintText: 'Enter',
                              //                                 isRequired: true,
                              //                                 txtController:
                              //                                     preDialysisController
                              //                                         .oxygenLevel,
                              //                                 fillColor:
                              //                                     Colors.white,
                              //                                 fontSize: 16,
                              //                               ),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                         const SizedBox(
                              //                             height: 10),
                              //                         CustomTextField(
                              //                           onChanged: (value) {},
                              //                           maxLines: 1,
                              //                           isReadOnly: false,
                              //                           keyBoardType:
                              //                               TextInputType.text,
                              //                           labelText:
                              //                               'Respiratory Rate(Breaths/min)',
                              //                           hintText: 'Enter',
                              //                           isRequired: true,
                              //                           txtController:
                              //                               preDialysisController
                              //                                   .respiratoryRate,
                              //                           fillColor: Colors.white,
                              //                           fontSize: 16,
                              //                         ),
                              //                         const SizedBox(
                              //                             height: 16),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                    ],
                              //               ),
                              //             ),
                              //               )) ],
                              //         )
                              //     ),),
                              Theme(
                                data: ThemeData()
                                    .copyWith(dividerColor: Colors.transparent),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.darkBlue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ExpansionTile(
                                    controller: expansionTileController2,
                                    maintainState: true,
                                    collapsedIconColor: Colors.white,
                                    iconColor: Colors.white,
                                    title: Row(
                                      children: [
                                        Image.asset("assets/pulse-line.png"),
                                        const SizedBox(width: 12),
                                        const Text(
                                          "Pre Dialysis Vitals",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: 'Lato',
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        //margin: const EdgeInsets.only(bottom: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[50],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color:
                                                        AppColor.borderColor),
                                              ),
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                children: [
                                                  /// Row 1
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: DoubleTextField(
                                                          labelText:
                                                              'Blood Pressure\n(mmHg)',
                                                          hintText1: 'Bottom',
                                                          hintText2: 'Top',
                                                          isRequired: true,
                                                          keyBoardType:
                                                              TextInputType
                                                                  .number,
                                                          txtController1:
                                                              preDialysisController
                                                                  .doubleTxtController1,
                                                          txtController2:
                                                              preDialysisController
                                                                  .doubleTxtController2,
                                                          fillColor:
                                                              Colors.white,
                                                          maxLines: 1,
                                                          onChange1: (_) {},
                                                          onChange2: (_) {},
                                                          isReadOnly: false,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: CustomTextField(
                                                          maxLines: 1,
                                                          isReadOnly: false,
                                                          keyBoardType:
                                                              TextInputType
                                                                  .number,
                                                          labelText:
                                                              'Pulse\n(Beats/min)',
                                                          hintText: 'Enter',
                                                          isRequired: true,
                                                          txtController:
                                                              preDialysisController
                                                                  .pulseLevel,
                                                          fillColor:
                                                              Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 12),

                                                  /// Row 2
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            CustomTextFieldTemp(
                                                          onUnitChanged:
                                                              (isFahrenheit) {
                                                            preDialysisController
                                                                    .selectedTemp =
                                                                isFahrenheit;
                                                          },
                                                          maxLines: 1,
                                                          isReadOnly: false,
                                                          keyBoardType:
                                                              TextInputType
                                                                  .number,
                                                          labelText:
                                                              'Temperature',
                                                          hintText: 'Enter',
                                                          isRequired: false,
                                                          txtController:
                                                              preDialysisController
                                                                  .temperaturController,
                                                          fillColor:
                                                              Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: CustomTextField(
                                                          maxLines: 1,
                                                          isReadOnly: false,
                                                          keyBoardType:
                                                              TextInputType
                                                                  .number,
                                                          labelText:
                                                              'Oxygen Level (%)',
                                                          hintText: 'Enter',
                                                          isRequired: true,
                                                          txtController:
                                                              preDialysisController
                                                                  .oxygenLevel,
                                                          fillColor:
                                                              Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 12),

                                                  /// Row 3
                                                  CustomTextField(
                                                    maxLines: 1,
                                                    isReadOnly: false,
                                                    keyBoardType:
                                                        TextInputType.text,
                                                    labelText:
                                                        'Respiratory Rate (Breaths/min)',
                                                    hintText: 'Enter',
                                                    isRequired: true,
                                                    txtController:
                                                        preDialysisController
                                                            .respiratoryRate,
                                                    fillColor: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColor.borderColor)),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 16),
                                    const CustomText(
                                      text: 'Start Dialysis',
                                      fontSize: 18.0,
                                      fontFam: 'Lato',
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Expanded(
                                        //   child:
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: CustomDateField(
                                            labelText: 'Date',
                                            hint: 'Select',
                                            isRequired: true,
                                            callB: () {
                                              _selectDate(context);
                                            },
                                            selectedDate: preDialysisController
                                                .dateController,
                                            filledColor: Colors.white,
                                            dontDhowPrefix: false,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        // Expanded(
                                        //   child:
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: CustomDateField(
                                            labelText: 'Time',
                                            hint: 'Select',
                                            isRequired: true,
                                            callB: () {
                                              selectTime(context);
                                            },
                                            selectedDate: preDialysisController
                                                .timeController,
                                            filledColor: Colors.white,
                                            dontDhowPrefix: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CustomButton(
                                        primColor:
                                            AppColor.primaryBackgroundColor,
                                        secColor: AppColor.secondaryColor,
                                        textColor: Colors.white,
                                        iconColor: Colors.white,
                                        buttonText: 'Start',
                                        path: 'assets/check.png',
                                        callB: () {
                                          if (formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            // Form is valid, proceed with further actions
                                            isFormValid = true;

                                            final String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.now());
                                            final String formattedDate1 =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(DateTime.now());

                                            preDialysisController.dateController
                                                .text = formattedDate1;

                                            preDialysisController
                                                    .startDialysisDate =
                                                formattedDate;

                                            String formattedTime1 =
                                                DateFormat('HH:mm:ss')
                                                    .format(DateTime.now());

                                            final String formattedTime =
                                                DateFormat('HH:mm:ss')
                                                    .format(DateTime.now());
                                            preDialysisController.timeController
                                                .text = formattedTime1;
                                            preDialysisController
                                                    .startDialysisTime =
                                                formattedTime;
                                            preDialysisController.refreshUi();
                                            debugPrint('Form is valid');
                                          } else {
                                            // Form is invalid, show errors

                                            debugPrint('Form is invalid');
                                            CustomMessage.toast(
                                                "Please fill mandatory details");
                                          }
                                        },
                                        buttonWidth: 100,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomButton(
                                    primColor: AppColor.primaryBackgroundColor,
                                    secColor: AppColor.secondaryColor,
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                    buttonText: 'Save',
                                    path: 'assets/save-next.png',
                                    isLoading:
                                        (preDialysisController.isSaving ||
                                            preDialysisController.isLoading),
                                    callB: (preDialysisController.isSaving ||
                                            preDialysisController.isLoading)
                                        ? null
                                        : () {
                                            if (formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              // widget.callB();
                                              preDialysisController.isSaving =
                                                  true;
                                              preDialysisController.update();
                                              preDialysisController
                                                      .editReqModel.patientId =
                                                  widget
                                                      .preDialysisData.patientId
                                                      .toString();
                                              preDialysisController.editReqModel
                                                      .treatmentId =
                                                  widget.preDialysisData
                                                      .treatmentId
                                                      .toString();
                                              preDialysisController.editReqModel
                                                      .lookupDetIdDialysisType =
                                                  dialyzerTypeData?.lookupDetId;
                                              preDialysisController.editReqModel
                                                      .lookupDetHierId1AccessType =
                                                  selectedAccessType
                                                      ?.lookupDetHierId;
                                              preDialysisController.editReqModel
                                                      .lookupDetHierId2AccessSite =
                                                  accessTypeSiteData
                                                      ?.lookupDetHierId;

                                              preDialysisController.editReqModel
                                                      .lookupDetIdDialysarType =
                                                  dialyzerTypeData?.lookupDetId;
                                              preDialysisController.editReqModel
                                                      .lookupDetIdSpecialDialysis =
                                                  specialDialysisData
                                                      ?.lookupDetId;
                                              preDialysisController
                                                      .editReqModel.weight =
                                                  preDialysisController
                                                      .preDialyWeightController
                                                      .text;
                                              preDialysisController.editReqModel
                                                      .bloodPressureH =
                                                  controller
                                                      .doubleTxtController1
                                                      .text;
                                              preDialysisController.editReqModel
                                                      .bloodPressureL =
                                                  controller
                                                      .doubleTxtController2
                                                      .text;
                                              if (controller
                                                  .pulseLevel.text.isNotEmpty) {
                                                preDialysisController
                                                        .editReqModel.pulse =
                                                    convertRateToInt(controller
                                                        .pulseLevel.text);
                                              }
                                              preDialysisController.editReqModel
                                                      .temperature =
                                                  controller
                                                      .temperaturController
                                                      .text;

                                              if (controller
                                                  .temperaturController
                                                  .text
                                                  .isNotEmpty) {
                                                preDialysisController
                                                        .editReqModel
                                                        .temperatureUnit =
                                                    (preDialysisController
                                                                    .selectedTemp ==
                                                                null ||
                                                            preDialysisController
                                                                    .selectedTemp ==
                                                                true)
                                                        ? 'F'
                                                        : 'c';
                                              }

                                              preDialysisController.editReqModel
                                                  .dialyzerDiscardedFlag = "N";
                                              preDialysisController.editReqModel
                                                  .heightCm = widget
                                                          .preDialysisData
                                                          .pheight !=
                                                      null
                                                  ? convertRateToInt(widget
                                                      .preDialysisData.pheight
                                                      .toString())
                                                  : 0;
                                              preDialysisController.editReqModel
                                                  .heightInch = widget
                                                      .preDialysisData
                                                      .pheight ??
                                                  0;

                                              preDialysisController.editReqModel
                                                      .respiratoryRate =
                                                  convertRateToInt(
                                                      preDialysisController
                                                          .respiratoryRate
                                                          .text);

                                              preDialysisController.editReqModel
                                                      .dialysisStartTime =
                                                  controller.startDialysisTime;

                                              preDialysisController.editReqModel
                                                      .dialysisStartDate =
                                                  controller.startDialysisDate;

                                              preDialysisController
                                                  .editReqModel.status = 1;
                                              preDialysisController
                                                      .editReqModel.createdBy =
                                                  userData['createdBy']
                                                      .toString();
                                              preDialysisController.editReqModel
                                                      .preHdCondition =
                                                  controller
                                                      .preConditionController
                                                      .text;
                                              preDialysisController
                                                      .editReqModel.dryWeight =
                                                  controller
                                                      .dryWeightController.text;
                                              preDialysisController.editReqModel
                                                      .interDialyticWeightGain =
                                                  controller
                                                      .weightGainController
                                                      .text;
                                              preDialysisController.editReqModel
                                                  .discardreamrk = 123;
                                              preDialysisController.editReqModel
                                                  .dialyserFlag = "";
                                              preDialysisController.editReqModel
                                                      .dialyserBarcodeSerialNo =
                                                  controller
                                                      .dialyzerBarcodeController
                                                      .text;
                                              preDialysisController.editReqModel
                                                      .dialyserResueNo =
                                                  controller
                                                      .dialyzerReuseNoController
                                                      .text;
                                              preDialysisController.editReqModel
                                                      .dialyserRemarks =
                                                  controller
                                                      .dialyzerRemark.text;
                                              preDialysisController
                                                  .editReqModel.tubeFlag = "";
                                              preDialysisController.editReqModel
                                                      .tubeBarcodeSerialNo =
                                                  controller
                                                      .tubeBarcodeController
                                                      .text;
                                              preDialysisController.editReqModel
                                                      .tubeResueNo =
                                                  int.parse(controller
                                                      .dialyzerTubeReuseNoController
                                                      .text);
                                              preDialysisController.editReqModel
                                                      .tubeRemarks =
                                                  controller.tubeRemark.text;
                                              preDialysisController
                                                      .editReqModel.unitId =
                                                  int.parse(userData['unitId']
                                                      .toString());
                                              // preDialysisController
                                              //         .editReqModel.fiberBundle =
                                              //     int.parse(preDialysisController
                                              //         .expectedFiber.text);
                                              preDialysisController.editReqModel
                                                      .fiberBundle =
                                                  preDialysisController
                                                      .fiberBundle
                                                      ?.firstWhere((e) =>
                                                          e.lookupDetHierDescEn ==
                                                          preDialysisController
                                                              .expectedFiber
                                                              .text)
                                                      .lookupDetHierId;

                                              preDialysisController
                                                      .editReqModel.oxyLevel =
                                                  preDialysisController
                                                          .oxygenLevel
                                                          .text
                                                          .isEmpty
                                                      ? int.parse(
                                                          preDialysisController
                                                              .oxygenLevel.text)
                                                      : null;

                                              // preDialysisController.editReqModel
                                              //     .deviceFrom = "Mobile";

                                              preDialysisController
                                                  .editPreDialysis();

                                              debugPrint('Form is valid');
                                            } else {
                                              // Form is invalid, show errors

                                              debugPrint('Form is invalid');
                                              CustomMessage.toast(
                                                  "Please fill madetory details");
                                            }
                                          },
                                    buttonWidth: 100,
                                  ),
                                  CustomButton(
                                    primColor: Colors.grey,
                                    secColor: Colors.grey,
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                    buttonText: 'Reset',
                                    path: 'assets/refresh.png',
                                    callB: () {
                                      selectedDialysisTypeVal = null;
                                      selectedAccessSiteVal = null;
                                      selectedAcessTypeValue = null;
                                      selectedDialyzerTypeVal = null;
                                      preDialysisController
                                          .timeController.text = "";
                                      preDialysisController
                                          .dateController.text = "";
                                      preDialysisController
                                          .preConditionController.text = "";
                                      preDialysisController
                                          .doubleTxtController1.text = "";
                                      preDialysisController
                                          .doubleTxtController2.text = "";
                                      preDialysisController.oxygenLevel.text =
                                          "";
                                      preDialysisController
                                          .preDialyWeightController.text = "";
                                      preDialysisController
                                          .dryWeightController.text = "";
                                      preDialysisController
                                          .weightGainController.text = "";
                                      preDialysisController.pulseLevel.text =
                                          "";
                                      preDialysisController
                                          .temperaturController.text = "";

                                      preDialysisController.refreshUi();
                                    },
                                    buttonWidth: 100,
                                  ),
                                  CustomButton(
                                    primColor: AppColor.red,
                                    secColor: AppColor.red,
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                    buttonText: 'Cancel',
                                    path: 'assets/cancel.png',
                                    callB: () {
                                      Get.back();
                                    },
                                    buttonWidth: 100,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 8),
                        ),
                      )
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }

  buildProfileImage() {
    String? imageUrl;
    // Check if there is an existing profile photo (network image)
    if (newRegistrationController.patientProfilePhoto?.data != null &&
        newRegistrationController.patientProfilePhoto!.data!.isNotEmpty) {
      String? filePath =
          newRegistrationController.patientProfilePhoto!.data!.last.filePath;
      imageUrl = filePath != null && filePath.isNotEmpty
          ? ApiConstants.imageBaseUrl + filePath
          : '';
    }
    return imageUrl;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != _selectedDate) {
      // setState(() {
      _selectedDate = picked;
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      DateFormat formatter1 = DateFormat('dd-MM-yyyy');
      formattedDateDBO = formatter.format(_selectedDate!);
      var formattedDate = formatter1.format(_selectedDate!);
      preDialysisController.dateController.text = formattedDate;
      preDialysisController.startDialysisDate = formattedDateDBO;
      setState(() {});
    }
  }

  selectTime(context) async {
    pickedTime = await DatePickerHelper.selectTime(context);

    if (pickedTime != null) {
      // Ensure pickedTime has seconds (HH:mm:ss)
      if (pickedTime!.length == 5) {
        // Means format is HH:mm
        pickedTime = "$pickedTime:00"; // Add :00 for seconds
      }

      DateTime time = DateFormat('HH:mm:ss').parse(pickedTime!);

      // Convert to AM/PM format (hh:mm:ss a)
      String formattedTime = DateFormat('HH:mm:ss').format(time);

      preDialysisController.timeController.text = formattedTime;
      preDialysisController.startDialysisTime = pickedTime!;

      setState(() {});
    }
  }

  // selectTime(context) async {
  //   pickedTime = await DatePickerHelper.selectTime(context);
  //   if (pickedTime != null) {
  //     DateTime time = DateFormat('HH:mm:ss').parse(pickedTime!);
  //
  //     // String formattedTime = DateFormat('HH:mm').format(time);
  //     String formattedTime = DateFormat('hh:mm:ss a').format(time);
  //
  //     preDialysisController.timeController.text = formattedTime;
  //     preDialysisController.startDialysisTime = pickedTime!;
  //     setState(() {});
  //   }
  // }

  calculateAge(String birthDate) {
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(birthDate);
    DateTime today = DateTime.now();

    years = today.year - parsedDate.year;
    months = today.month - parsedDate.month;
    days = today.day - parsedDate.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(today.year, today.month, 0)
          .day; // Get the number of days in the previous month
    }

    if (months < 0) {
      years -= 1;
      months += 12;
    }
    newRegistrationController.refreshUi();
    // return "$years years, $months months, and $days days";
  }

  showAlertDialog(
      Function cancelCallB,
      Function okCallB,
      String dialogText,
      String path,
      bool isVisible,
      Function? noCallB,
      TextEditingController txtController,
      Function txtFieldValue) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                        text: dialogText,
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black,
                        textAlign: TextAlign.center),
                  ),
                  InkWell(
                      onTap: () {
                        cancelCallB();
                        // Get.off(const DashScreen());
                      },
                      child: Image.asset(
                        "assets/cancel.png",
                        width: 24,
                        height: 24,
                        color: AppColor.secondaryColor,
                      )),
                ],
              ).paddingSymmetric(horizontal: 6, vertical: 8),
              Image.asset(
                path,
                width: 70,
                height: 70,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.borderColor),
                    color: const Color(0xffF8F8F8)),
                child: Column(
                  children: [
                    CustomTextField(
                      txtController: txtController,
                      onChanged: (value) {
                        txtFieldValue(value);
                      },
                      labelText: "Discarded Remarks",
                      hintText: "Discarded Remarks",
                      isRequired: false,
                      keyBoardType: TextInputType.text,
                      fillColor: Colors.white,
                      isReadOnly: false,
                      maxLines: 1,
                      fontSize: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          primColor: AppColor.primaryBackgroundColor,
                          secColor: AppColor.secondaryColor,
                          buttonText: "Confirm",
                          path: 'assets/check.png',
                          callB: () {
                            okCallB();
                          },
                          buttonWidth: 100,
                          textColor: Colors.white,
                          iconColor: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
              ).paddingOnly(top: 8, bottom: 14, left: 14, right: 14)
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  int convertRateToInt(String rate) {
    try {
      double rateAsDouble = double.parse(rate); // Parse the string to a double
      return rateAsDouble
          .toInt(); // Convert to integer by truncating the decimal part
      // If you want to round instead of truncating, use: return rateAsDouble.round();
    } catch (e) {
      debugPrint("Invalid rate value: $rate");
      return 0; // Return a default value in case of invalid input
    }
  }
}
