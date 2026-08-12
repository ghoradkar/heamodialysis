import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/dialysis_event_controller.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/incedent_type_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/common_dropdown_post_dialysis_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/post_dialysis_controller.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/post_dialysis_data.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/access_type_data2.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/access_type_site_data2.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/dialysis_type_data.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/dialyzer_type_data.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/edit_pre_dialysis/model/special_dialysis_data.dart';
import 'package:heamodialysis/discharge_form/controller/session_end_controller.dart';
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

import '../../widgets/custom_shimmer_loader.dart';

class EditPostDialysisScreen extends StatefulWidget {
  final Function callB;
  final PostDialysisData postDialysisData;

  const EditPostDialysisScreen(
      {super.key, required this.callB, required this.postDialysisData});

  @override
  State<EditPostDialysisScreen> createState() => EditPostDialysisScreenState();
}

class EditPostDialysisScreenState extends State<EditPostDialysisScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());
  final DialysisEventController dialysisEventController =
      Get.put(DialysisEventController());
  final SessionEndController dischargeController =
      Get.put(SessionEndController());

   DateTime? _selectedDate;

  String prefixVal = '';

  String selectedInstitute = '';

  String formattedDateDBO = '';

  String? selectedGender;

  File? image;

  int years = 0;

  int months = 0;

  int days = 0;

  DialysisTypeData? selectedEditPreDialysis;
  SpecialDialysisData? specialDialysisData;
  DialyzerTypeData? dialyzerTypeData;
  AccessTypeSiteData2? accessTypeSiteData;
  AccessTypeData2? selectedAccessType;

  String? selectedProd;

  String? pickedTime;

  final PostDialysisController postDialysisController =
      Get.put(PostDialysisController());
  bool isExpanded = false;
  bool hasInternet = true;

  var userData;

  String? formattedStopDate;

  // String? startTime;

  String? stopTIme;

  bool showStopDiaButton = false;

  bool isCelsius = true;

  @override
  void initState() {
    checkInternetAndLoadData();
    super.initState();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));

    resetFields();
    if (hasInternet) {
      getUserData();

      await postDialysisController.getCurrentWeight(
          widget.postDialysisData.patientId.toString(),
          widget.postDialysisData.treatmentId.toString());

      await postDialysisController.getStartTime(
          widget.postDialysisData.patientId.toString(),
          widget.postDialysisData.treatmentId.toString());

      await dischargeController.getPostFlag(
          widget.postDialysisData.patientId.toString(),
          widget.postDialysisData.treatmentId.toString());

      await postDialysisController.getValueToSetInHeprinUsedField(
          widget.postDialysisData.patientId.toString(),
          widget.postDialysisData.treatmentId.toString());
      await newRegistrationController
          .getProfilePhoto(widget.postDialysisData.patientId);
      await dialysisEventController.getIncidentType();

      await postDialysisController.getWeekDays("IROA");
      await postDialysisController.getEpoBrand("EPOB");
      await postDialysisController.getEpoDose("EPOD");
      await postDialysisController.getEpoFrequency("EPOF");
      await postDialysisController.getEpoRoute("EPOR");
      await postDialysisController.getIronPrep("IROP");
      await postDialysisController.getIronDose("IROD");
      await postDialysisController.getIronFreq("IROF");
      await postDialysisController.getIronRoute("IROR");
      await postDialysisController.getIronProtocol("IRPU");
      await postDialysisController.getYesNoEpo("EPOA");
      await postDialysisController.getYesNoIron("IROS");
      await postDialysisController.getYesNoBloodTrans("BLT");

      await newRegistrationController
          .viewPatientData(widget.postDialysisData.patientId);

      postDialysisController.refreshUi();
    }
  }

  resetFields() {
    postDialysisController.weightController.text = "";
    postDialysisController.currentWeightController.text = "";
    postDialysisController.doubleTxtController1.text = "";
    postDialysisController.doubleTxtController2.text = "";
    postDialysisController.pulseLevel.text = "";
    postDialysisController.temperaturController.text = "";
    postDialysisController.oxygenLevel.text = "";
    postDialysisController.rrfUrineController.text = "";
    postDialysisController.heparinController.text = "";
    postDialysisController.caseNarrationController.text = "";
    postDialysisController.finalUFVController.text = "";
    postDialysisController.venousPressureController.text = "";
    postDialysisController.bloodFlowController.text = "";
    postDialysisController.dialyticFlowController.text = "";
    postDialysisController.durationRemark.text = "";
    postDialysisController.actualFiberController.text = "";
    postDialysisController.percentageFiberController.text = "";
    postDialysisController.discardedRemController.text = "";
    postDialysisController.respRateController.text = "";
    postDialysisController.finalKtVController.text = "";
    postDialysisController.cbvController.text = "";
    postDialysisController.selectedDurationRem = null;
    postDialysisController.discardRem?.isSelected = false;
    postDialysisController.selectedEPOBrand = null;
    postDialysisController.selectedEpoDose = null;
    postDialysisController.selectedEpoFreq = null;
    postDialysisController.selectedEpoRoute = null;
    postDialysisController.epoStartDate.text = '';
    postDialysisController.epoIndicator.text = '';
    postDialysisController.lastHgb.text = '';
    postDialysisController.selectedEpoAdminDays = null;
    postDialysisController.saveRequestModel.epoAdminDays = null;

    postDialysisController.selectedIronPrep = null;
    postDialysisController.selectedIronDose = null;
    postDialysisController.selectedIronFreq = null;
    postDialysisController.selectedIronRoute = null;
    postDialysisController.ironStartDate.text = '';
    postDialysisController.selectedIronProtocol = null;
    postDialysisController.ferritinLevel.text = '';
    postDialysisController.tsat.text = '';

    postDialysisController.volume.text = '';
    postDialysisController.bloodTransDate.text = '';
    postDialysisController.refreshUi();
  }

  showStopDateAndTime() {
    DateTime now = DateTime.now();
    // Format the current date as 'dd-MM-yyyy'
    formattedStopDate = DateFormat('dd/MM/yyyy').format(now);
    postDialysisController.isoFormattedStopDate = now.toIso8601String();

    stopTIme = DateFormat('HH:mm:ss').format(now);

    postDialysisController.stopTimeController.text = stopTIme!;
    postDialysisController.stopDateController.text = formattedStopDate!;
    postDialysisController.update();
    calculateTimeDifference(
        postDialysisController.startTime!, stopTIme!, formattedStopDate!);
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

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Post Dialysis Details',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body: GetBuilder<PostDialysisController>(
          init: postDialysisController,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ? Center(child: buildShimmerLoader())
                    : SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PatientCardDetails(
                                imagePath: buildProfileImage(),
                                isExpand: (value) {
                                  isExpanded = value;
                                  setState(() {});
                                },
                                isExpanded: isExpanded,
                                isFromAddPredialysis: true,
                                refBy: widget.postDialysisData.refByName ?? "",
                                schemaAdopted: '',
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
                                           //maintainState: true,
                                          //  key: const PageStorageKey<String>('pre_dialysis_vitals'),
                                          collapsedIconColor: Colors.white,
                                          iconColor: Colors.white,
                                          title: Row(children: [
                                            Image.asset("assets/file-list.png"),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            const CustomText(
                                              text:
                                                  "Post Dialysis Investigation",
                                              fontSize: 14.0,
                                              fontFam: 'Lato',
                                              fontWeight: FontWeight.normal,
                                              textColor: Colors.white,
                                              textAlign: TextAlign.center,
                                            )
                                          ]),
                                          children: <Widget>[
                                       Container(
                                             // height: MediaQuery.of(context).size.height * 0.5,
                                              padding: const EdgeInsets.all(12),
                                              //margin: const EdgeInsets.only(bottom: 2),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: SingleChildScrollView(child:Column(
                                                //crossAxisAlignment: CrossAxisAlignment.start,
                                               // mainAxisSize: MainAxisSize.min,

                                                children: [
                                                  const SizedBox(height: 16),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[50],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: AppColor
                                                                .borderColor)),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                         // mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            // Expanded(
                                                            // Flexible(
                                                            //   child:
                                                                  SizedBox(
                                                                    width:165,
                                                                    child:CustomTextField(
                                                                onChanged:
                                                                     (value) {
                                                                  try {
                                                                    if (value
                                                                        .isEmpty) {
                                                                      return;
                                                                    }

                                                                    var val = double
                                                                        .parse(
                                                                            value);

                                                                    var weight =
                                                                        postDialysisController.currentWeightModel?.weight ??
                                                                            0.0;

                                                                    var diff =
                                                                        weight -
                                                                            val;

                                                                    postDialysisController
                                                                            .currentWeightController
                                                                            .text =
                                                                        diff.toStringAsFixed(
                                                                            2);

                                                                    postDialysisController
                                                                        .refreshUi();
                                                                  } catch (e) {
                                                                    debugPrint(
                                                                        'Error: $e');
                                                                  }
                                                                  // try {
                                                                  //   var val = double
                                                                  //       .parse(
                                                                  //       value);
                                                                  //
                                                                  //   var weight =
                                                                  //       postDialysisController
                                                                  //           .currentWeightModel
                                                                  //           ?.weight ??
                                                                  //           0.0;
                                                                  //   // var diff = val -
                                                                  //   //     weight;
                                                                  //   var diff = weight -
                                                                  //       val;
                                                                  //
                                                                  //   // Update the controller text with the difference
                                                                  //   postDialysisController
                                                                  //       .currentWeightController
                                                                  //       .text =
                                                                  //       diff.toString();
                                                                  //   postDialysisController
                                                                  //       .refreshUi();
                                                                  // } catch (e) {
                                                                  //   // Handle the error for parsing the value
                                                                  //   debugPrint(
                                                                  //       'Error: $e');
                                                                  // }
                                                                },
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                    false,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .number,
                                                                labelText:
                                                                    'Post Dialysis Weight',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    true,
                                                                txtController:
                                                                    controller
                                                                        .weightController,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            // Expanded(
                                                            // child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:150,
                                                              child:CustomTextField(
                                                                onChanged:
                                                                    (value) {},
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                    true,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .number,
                                                                labelText:
                                                                    'Current Wgt Diff',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    true,
                                                                txtController:
                                                                    controller
                                                                        .currentWeightController,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width:150,
                                                              child:DoubleTextField(
                                                              labelText:
                                                                  'Blood Pressure',
                                                              hintText1:
                                                                  'Bottom',
                                                              hintText2: 'Top',
                                                              isRequired: true,
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                              txtController1:
                                                                  controller
                                                                      .doubleTxtController1,
                                                              txtController2:
                                                                  controller
                                                                      .doubleTxtController2,
                                                              fillColor:
                                                                  Colors.white,
                                                              isReadOnly: false,
                                                              maxLines: 1,
                                                              onChange1:
                                                                  (value) {},
                                                              onChange2:
                                                                  (value) {},
                                                            )),
                                                            const SizedBox(
                                                                height: 8),
                                                            // Expanded(
                                                            //   child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:150,
                                                              child:CustomTextField(
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                    false,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .number,
                                                                labelText:
                                                                    'Pulse (Beats/min)',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    false,
                                                                txtController:
                                                                    controller
                                                                        .pulseLevel,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            // Expanded(
                                                            //   child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:150,
                                                              child: CustomTextField(
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                    false,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .number,
                                                                labelText:
                                                                    'Respiratory Rate',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    true,
                                                                txtController:
                                                                    controller
                                                                        .respRateController,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            // Expanded(
                                                            //   child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:160,
                                                              child:CustomTextField(
                                                                onChanged:
                                                                    (value) {},
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                    false,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .number,
                                                                labelText:
                                                                    'Oxygen Level',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    true,
                                                                txtController:
                                                                    controller
                                                                        .oxygenLevel,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 16),
                                                // SizedBox(
                                                //   width:300,
                                                 // child:
                                                  CustomTextFieldTemp(
                                                          onUnitChanged:
                                                              (isFahrenheit) {
                                                            isCelsius =
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
                                                              postDialysisController
                                                                  .temperaturController,
                                                          fillColor:
                                                              Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                        const SizedBox(
                                                            height: 16),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            // Expanded(
                                                            //   child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:155,
                                                              child:CustomTextField(
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                    false,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .number,
                                                                labelText:
                                                                    'RRF Urine Vol',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    false,
                                                                txtController:
                                                                    controller
                                                                        .rrfUrineController,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            // Expanded(
                                                            //   child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:155,
                                                              child:CustomTextField(
                                                                onChanged:
                                                                    (value) {},
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                    false,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .number,
                                                                labelText:
                                                                    'Total Heparin Used',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    true,
                                                                txtController:
                                                                    controller
                                                                        .heparinController,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 16),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            // Expanded(
                                                            //   child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:155,
                                                              child: CustomTextField(
                                                                onChanged:
                                                                    (value) {},
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                    false,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .text,
                                                                labelText:
                                                                    'Case Narration',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    false,
                                                                txtController:
                                                                    controller
                                                                        .caseNarrationController,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            // Expanded(
                                                            //     child:
                                                            // Flexible(
                                                            //     child:
                                                            SizedBox(
                                                                width:155,
                                                                child:  CustomTextField(
                                                              onChanged:
                                                                  (value) {},
                                                              maxLines: 1,
                                                              isReadOnly: false,
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                              labelText:
                                                                  'Final KT/V',
                                                              hintText: 'Enter',
                                                              isRequired: true,
                                                              txtController:
                                                                  controller
                                                                      .finalKtVController,
                                                              fillColor:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            )),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            // Expanded(
                                                            //   child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:155,
                                                              child:CustomTextField(
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                false,
                                                                keyBoardType:
                                                                TextInputType
                                                                    .number,
                                                                labelText:
                                                                'CBV',
                                                                hintText:
                                                                'Enter',
                                                                isRequired:
                                                                false,
                                                                txtController:
                                                                controller
                                                                    .cbvController,
                                                                fillColor:
                                                                Colors
                                                                    .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            // Expanded(
                                                            //   child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:155,

                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[50],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: AppColor
                                                                .borderColor)),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            // Expanded(
                                                            //   child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:160,
                                                              child:CustomTextField(
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                    false,
                                                                keyBoardType:
                                                                    const TextInputType
                                                                        .numberWithOptions(
                                                                        decimal:
                                                                            true),
                                                                labelText:
                                                                    'Final UFV',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    false,
                                                                txtController:
                                                                    controller
                                                                        .finalUFVController,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            // Expanded(
                                                            //   child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:155,
                                                              child:CustomTextField(
                                                                onChanged:
                                                                    (value) {},
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                    false,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .number,
                                                                labelText:
                                                                    'Venous Pressure',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    false,
                                                                txtController:
                                                                    controller
                                                                        .venousPressureController,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            // Expanded(
                                                            //   child:
                                                           // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:150,
                                                              child:CustomTextField(
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                    false,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .number,
                                                                labelText:
                                                                    'Blood Flow(QB)',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    false,
                                                                txtController:
                                                                    controller
                                                                        .bloodFlowController,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            // Expanded(
                                                            //   child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:155,
                                                              child:CustomTextField(
                                                                onChanged:
                                                                    (value) {},
                                                                maxLines: 1,
                                                                isReadOnly:
                                                                    false,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .number,
                                                                labelText:
                                                                    'Dialysate Flow(QD)',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    false,
                                                                txtController:
                                                                    controller
                                                                        .dialyticFlowController,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            // Expanded(
                                                            //     child:
                                                           // Flexible(
                                                            //     child:
                                                            SizedBox(
                                                                width:160,
                                                                child:  CustomTextField(
                                                              onChanged:
                                                                  (value) {},
                                                              maxLines: 1,
                                                              isReadOnly: true,
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                              labelText:
                                                                  'UFR (mL/hr/kg)',
                                                              hintText: 'Enter',
                                                              isRequired: false,
                                                              txtController:
                                                                  controller
                                                                      .urfController,
                                                              fillColor:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            )),
                                                            const SizedBox(
                                                                height: 8),
                                                            // Expanded(
                                                            //   child:
                                                            // Flexible(
                                                            //   child:
                                                            SizedBox(
                                                              width:150,
                                                              child:
                                                              CustomTextField(
                                                                maxLines: 1,
                                                                // isReadOnly: controller
                                                                //         .percentageFiberController
                                                                //         .text
                                                                //         .isNotEmpty
                                                                //     ? false
                                                                //     : true,
                                                                isReadOnly:
                                                                    false,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .text,
                                                                labelText:
                                                                    'Discarded Remark',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    false,
                                                                txtController:
                                                                    controller
                                                                        .discardedRemController,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              )),

                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                    // SizedBox(
                                                    //   width:300,
                                                    //   child:
                                                      CustomTextField(
                                                          onChanged:
                                                              (String value) {
                                                            if (value.isEmpty) {
                                                              controller
                                                                  .percentageFiberController
                                                                  .clear();
                                                              postDialysisController
                                                                      .discardRem
                                                                      ?.isSelected =
                                                                  false;
                                                              controller
                                                                  .discardedRemController
                                                                  .clear();
                                                              controller
                                                                  .update();
                                                            }
                                                          },
                                                          maxLines: 1,
                                                          isReadOnly: false,
                                                          keyBoardType:
                                                              TextInputType
                                                                  .number,
                                                          labelText:
                                                              'Actual Fiber Bundle Volume',
                                                          hintText: 'Enter',
                                                          isRequired: false,
                                                          txtController: controller
                                                              .actualFiberController,
                                                          fillColor:
                                                              Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            // Expanded(
                                                            //   child:
                                                             Flexible(
                                                            //   child:
                                                            // SizedBox(
                                                            //   width:100,
                                                              child:CustomTextField(
                                                                maxLines: 1,
                                                                onTap: () {
                                                                  controller.calculatePercentage(
                                                                      controller
                                                                          .actualFiberController
                                                                          .text,
                                                                      dischargeController
                                                                          .dischargeFlagString);
                                                                  if (controller
                                                                      .percentageFiberController
                                                                      .text
                                                                      .isNotEmpty) {
                                                                    controller
                                                                        .discardRem
                                                                        ?.isSelected = true;
                                                                    controller
                                                                        .update();
                                                                  }
                                                                },
                                                                isReadOnly:
                                                                    true,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .number,
                                                                labelText:
                                                                    'Percentage Fiber Bundle',
                                                                hintText:
                                                                    'Enter',
                                                                isRequired:
                                                                    false,
                                                                txtController:
                                                                    controller
                                                                        .percentageFiberController,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            Checkbox(
                                                              activeColor: AppColor
                                                                  .primaryBackgroundColor,
                                                              value: controller
                                                                  .discardRem
                                                                  ?.isSelected,
                                                              // Boolean value for checkbox state
                                                              onChanged: (bool?
                                                                  newValue) {
                                                                controller
                                                                        .discardRem
                                                                        ?.isSelected =
                                                                    newValue;
                                                                setState(() {});
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                ],
                                              ),
                                            ),
                                       )]))),
                              const SizedBox(
                                height: 10,
                              ),
                              Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ExpansionTile(
                                      maintainState: true,
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      title: Row(children: [
                                        Image.asset("assets/file-list.png"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const CustomText(
                                          text: "EPO Administered",
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
                                              color: Colors.grey[50],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColor.borderColor)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              LookupRadioGroup(
                                                label: "EPO Administered",
                                                isRequired: true,
                                                items: postDialysisController
                                                        .getYesNoEpoList ??
                                                    [],
                                                groupValue:
                                                    postDialysisController
                                                        .epoAdministeredId
                                                        ?.lookupDetId,
                                                onChanged: (id) {
                                                  postDialysisController
                                                      .epoAdministeredId = id;

                                                  postDialysisController
                                                      .update();
                                                },
                                              ),
                                              Visibility(
                                                visible: postDialysisController
                                                    .isEpoYesSelected(),
                                                child: Row(
                                                  children: [
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: MyCustomDropdown(
                                                          selectedItem: controller
                                                              .selectedEPOBrand,
                                                          labelText:
                                                              "EPO Brand Name",
                                                          items: controller
                                                                  .epoBrandList
                                                                  ?.map((e) => e
                                                                      .lookupDetDescEn)
                                                                  .toList() ??
                                                              [],
                                                          hint: "Select",
                                                          isRequired: true,
                                                          senValue: (vaule) {
                                                            controller
                                                                    .selectedEPOBrand =
                                                                vaule;
                                                          },
                                                          filledColor:
                                                              Colors.white),
                                                    ),
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: MyCustomDropdown(
                                                          selectedItem: controller
                                                              .selectedEpoDose,
                                                          labelText: "EPO Dose",
                                                          items: controller
                                                                  .epoDoseList
                                                                  ?.map((e) => e
                                                                      .lookupDetDescEn)
                                                                  .toList() ??
                                                              [],
                                                          hint: "Select",
                                                          isRequired: true,
                                                          senValue: (vaule) {
                                                            controller
                                                                    .selectedEpoDose =
                                                                vaule;
                                                          },
                                                          filledColor:
                                                              Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: postDialysisController
                                                    .isEpoYesSelected(),
                                                child: Row(
                                                  children: [
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: MyCustomDropdown(
                                                          selectedItem: controller
                                                              .selectedEpoFreq,
                                                          labelText:
                                                              "EPO Frequency",
                                                          items: controller
                                                                  .epoFreqList
                                                                  ?.map((e) => e
                                                                      .lookupDetDescEn)
                                                                  .toList() ??
                                                              [],
                                                          hint: "Select",
                                                          isRequired: true,
                                                          senValue: (vaule) {
                                                            controller
                                                                    .selectedEpoFreq =
                                                                vaule;
                                                          },
                                                          filledColor:
                                                              Colors.white),
                                                    ),
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: MyCustomDropdown(
                                                          selectedItem: controller
                                                              .selectedEpoRoute,
                                                          labelText:
                                                              "EPO Route",
                                                          items: controller
                                                                  .epoRouteList
                                                                  ?.map((e) => e
                                                                      .lookupDetDescEn)
                                                                  .toList() ??
                                                              [],
                                                          hint: "Select",
                                                          isRequired: true,
                                                          senValue: (vaule) {
                                                            controller
                                                                    .selectedEpoRoute =
                                                                vaule;
                                                          },
                                                          filledColor:
                                                              Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: postDialysisController
                                                    .isEpoYesSelected(),
                                                child: Row(
                                                  children: [
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: CustomDateField(
                                                        labelText:
                                                            'EPO Start Date',
                                                        hint: 'Select',
                                                        isRequired: false,
                                                        callB: () {
                                                          selectEpoDate();
                                                        },
                                                        selectedDate: controller
                                                            .epoStartDate,
                                                        filledColor:
                                                            Colors.white,
                                                        dontDhowPrefix: true,
                                                      ),
                                                    ),
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: CustomTextField(
                                                        onChanged:
                                                            (String value) {},
                                                        maxLines: 1,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType.text,
                                                        labelText:
                                                            'EPO Indication',
                                                        hintText: 'Enter',
                                                        isRequired: true,
                                                        txtController:
                                                            controller
                                                                .epoIndicator,
                                                        fillColor: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: postDialysisController
                                                    .isEpoYesSelected(),
                                                child: CustomTextField(
                                                  onChanged: (String value) {},
                                                  maxLines: 1,
                                                  isReadOnly: false,
                                                  keyBoardType:
                                                      TextInputType.number,
                                                  labelText:
                                                      'Last Hgb (Hemoglobin):',
                                                  hintText: 'Enter',
                                                  isRequired: false,
                                                  txtController:
                                                      controller.lastHgb,
                                                  fillColor: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Visibility(
                                                  visible:
                                                      postDialysisController
                                                          .isEpoYesSelected(),
                                                  child: DaysCheckboxList(
                                                    weekDaysList:
                                                        postDialysisController
                                                            .weekDaysList,
                                                    preSelectedCsv:
                                                        postDialysisController
                                                            .selectedEpoAdminDays,
                                                    // for edit mode
                                                    onChanged: (csv) {
                                                      // keep this live in controller for Save
                                                      postDialysisController
                                                              .selectedEpoAdminDays =
                                                          csv;

                                                      // if you want to push directly to the request model as the user checks:
                                                      postDialysisController
                                                          .saveRequestModel
                                                          .epoAdminDays = csv;

                                                      postDialysisController
                                                          .update();
                                                    },
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ExpansionTile(
                                      maintainState: true,
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      title: Row(children: [
                                        Image.asset("assets/file-list.png"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const CustomText(
                                          text: "Iron Sucrose",
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
                                              color: Colors.grey[50],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColor.borderColor)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              LookupRadioGroup(
                                                label: "Iron Sucrose",
                                                isRequired: true,
                                                items: postDialysisController
                                                        .getYesNoIronList ??
                                                    [],
                                                groupValue:
                                                    postDialysisController
                                                        .ironSucroseId
                                                        ?.lookupDetId,
                                                onChanged: (id) {
                                                  postDialysisController
                                                      .ironSucroseId = id;

                                                  postDialysisController
                                                      .update();
                                                },
                                              ),
                                              Visibility(
                                                visible: postDialysisController
                                                    .isIronYesSelected(),
                                                child: Row(
                                                  children: [
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: MyCustomDropdown(
                                                          selectedItem: controller
                                                              .selectedIronPrep,
                                                          labelText:
                                                              "Iron Preparation",
                                                          items: controller
                                                                  .ironPrepList
                                                                  ?.map((e) => e
                                                                      .lookupDetDescEn)
                                                                  .toList() ??
                                                              [],
                                                          hint: "Select",
                                                          isRequired: true,
                                                          senValue: (vaule) {
                                                            controller
                                                                    .selectedIronPrep =
                                                                vaule;
                                                          },
                                                          filledColor:
                                                              Colors.white),
                                                    ),
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: MyCustomDropdown(
                                                          selectedItem: controller
                                                              .selectedIronDose,
                                                          labelText:
                                                              "Iron Dose",
                                                          items: controller
                                                                  .ironDoseList
                                                                  ?.map((e) => e
                                                                      .lookupDetDescEn)
                                                                  .toList() ??
                                                              [],
                                                          hint: "Select",
                                                          isRequired: true,
                                                          senValue: (vaule) {
                                                            controller
                                                                    .selectedIronDose =
                                                                vaule;
                                                          },
                                                          filledColor:
                                                              Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: postDialysisController
                                                    .isIronYesSelected(),
                                                child: Row(
                                                  children: [
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: MyCustomDropdown(
                                                          selectedItem: controller
                                                              .selectedIronFreq,
                                                          labelText:
                                                              "Iron Frequency",
                                                          items: controller
                                                                  .ironFreqList
                                                                  ?.map((e) => e
                                                                      .lookupDetDescEn)
                                                                  .toList() ??
                                                              [],
                                                          hint: "Select",
                                                          isRequired: true,
                                                          senValue: (vaule) {
                                                            controller
                                                                    .selectedIronFreq =
                                                                vaule;
                                                          },
                                                          filledColor:
                                                              Colors.white),
                                                    ),
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: MyCustomDropdown(
                                                          selectedItem: controller
                                                              .selectedIronRoute,
                                                          labelText:
                                                              "Iron Route",
                                                          items: controller
                                                                  .ironRouteList
                                                                  ?.map((e) => e
                                                                      .lookupDetDescEn)
                                                                  .toList() ??
                                                              [],
                                                          hint: "Select",
                                                          isRequired: true,
                                                          senValue: (vaule) {
                                                            controller
                                                                    .selectedIronRoute =
                                                                vaule;
                                                          },
                                                          filledColor:
                                                              Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: postDialysisController
                                                    .isIronYesSelected(),
                                                child: Row(
                                                  children: [
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: CustomDateField(
                                                        labelText:
                                                            'Iron Start Date',
                                                        hint: 'Select',
                                                        isRequired: false,
                                                        callB: () {
                                                          selectIronDate();
                                                        },
                                                        selectedDate: controller
                                                            .ironStartDate,
                                                        filledColor:
                                                            Colors.white,
                                                        dontDhowPrefix: true,
                                                      ),
                                                    ),
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: MyCustomDropdown(
                                                          selectedItem: controller
                                                              .selectedIronProtocol,
                                                          labelText:
                                                              "Iron Protocol Used",
                                                          items: controller
                                                                  .ironProtoColList
                                                                  ?.map((e) => e
                                                                      .lookupDetDescEn)
                                                                  .toList() ??
                                                              [],
                                                          hint: "Select",
                                                          isRequired: true,
                                                          senValue: (vaule) {
                                                            controller
                                                                    .selectedIronProtocol =
                                                                vaule;
                                                          },
                                                          filledColor:
                                                              Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: postDialysisController
                                                    .isIronYesSelected(),
                                                child: Row(
                                                  children: [
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: CustomTextField(
                                                        onChanged:
                                                            (String value) {},
                                                        maxLines: 1,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType
                                                                .number,
                                                        labelText:
                                                            'Ferritin Level',
                                                        hintText: 'Enter',
                                                        isRequired: false,
                                                        txtController:
                                                            controller
                                                                .ferritinLevel,
                                                        fillColor: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: CustomTextField(
                                                        onChanged:
                                                            (String value) {},
                                                        maxLines: 1,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType
                                                                .number,
                                                        labelText: 'TSAT (%)',
                                                        hintText: 'Enter',
                                                        isRequired: false,
                                                        txtController:
                                                            controller.tsat,
                                                        fillColor: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                  visible:
                                                      postDialysisController
                                                          .isIronYesSelected(),
                                                  child: DaysCheckboxList(
                                                    weekDaysList:
                                                        postDialysisController
                                                            .weekDaysList,
                                                    preSelectedCsv:
                                                        postDialysisController
                                                            .selectedIronAdminDays,
                                                    // if editing
                                                    onChanged: (csv) {
                                                      // keep it in controller
                                                      postDialysisController
                                                              .selectedIronAdminDays =
                                                          csv;

                                                      // also bind straight to request model
                                                      postDialysisController
                                                          .saveRequestModel
                                                          .ironAdminDays = csv;

                                                      postDialysisController
                                                          .update();
                                                    },
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ExpansionTile(
                                      maintainState: true,
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      title: Row(children: [
                                        Image.asset("assets/file-list.png"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const CustomText(
                                          text:
                                              "Blood Transfusion (Post Dialysis)",
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
                                              color: Colors.grey[50],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColor.borderColor)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              LookupRadioGroup(
                                                label: "Blood Transfusion",
                                                isRequired: true,
                                                items: postDialysisController
                                                        .getYesNoBloodList ??
                                                    [],
                                                groupValue:
                                                    postDialysisController
                                                        .bloodTransId
                                                        ?.lookupDetId,
                                                onChanged: (id) {
                                                  postDialysisController
                                                      .bloodTransId = id;

                                                  postDialysisController
                                                      .update();
                                                },
                                              ),
                                              Visibility(
                                                visible: postDialysisController
                                                    .isBloodTransYesSelected(),
                                                child: Row(
                                                  children: [
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: CustomTextField(
                                                        onChanged:
                                                            (String value) {},
                                                        maxLines: 1,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType
                                                                .number,
                                                        labelText:
                                                            'Volume (mL)',
                                                        hintText: 'Enter',
                                                        isRequired: true,
                                                        txtController:
                                                            controller.volume,
                                                        fillColor: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    // Expanded(
                                                    //   child:
                                                    Flexible(
                                                      child: CustomDateField(
                                                        labelText: 'Date',
                                                        hint: 'Select',
                                                        isRequired: true,
                                                        callB: () {
                                                          selectBlodTranDate();
                                                        },
                                                        selectedDate: controller
                                                            .bloodTransDate,
                                                        filledColor:
                                                            Colors.white,
                                                        dontDhowPrefix: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
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
                                  children: [
                                    const SizedBox(height: 16),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CustomButton(
                                        primColor: AppColor
                                            .primaryBackgroundColor
                                            .withValues(alpha: 0.6),
                                        secColor: AppColor.secondaryColor
                                            .withValues(alpha: 0.6),
                                        textColor: Colors.white,
                                        iconColor: Colors.white,
                                        buttonText: 'Start Dialysis',
                                        path: 'assets/clock.png',
                                        callB: () {
                                          // Get.back();
                                        },
                                        buttonWidth: 160,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Expanded(
                                        //   child:
                                        Flexible(
                                          child: CustomDateField(
                                            labelText: 'Date',
                                            hint: 'Select',
                                            isRequired: true,
                                            callB: () {
                                               //_selectDate(context);
                                            },
                                            selectedDate:
                                                controller.startDateController,
                                            filledColor: Colors.white,
                                            dontDhowPrefix: true,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Expanded(
                                        //   child:
                                        Flexible(
                                          child: CustomDateField(
                                            labelText: 'Time',
                                            hint: 'Select',
                                            isRequired: true,
                                            callB: () {
                                              // selectTime(context);
                                            },
                                            selectedDate:
                                                controller.startTimeController,
                                            filledColor: Colors.white,
                                            dontDhowPrefix: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CustomButton(
                                        primColor:
                                            AppColor.primaryBackgroundColor,
                                        secColor: AppColor.secondaryColor,
                                        textColor: Colors.white,
                                        iconColor: Colors.white,
                                        buttonText: 'Stop Dialysis',
                                        path: 'assets/clock.png',
                                        callB: () {
                                          showStopDiaButton = true;
                                          showStopDateAndTime();
                                        },
                                        buttonWidth: 150,
                                      ),
                                    ),
                                    Visibility(
                                      visible: showStopDiaButton,
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CustomDateField(
                                              labelText: 'Date',
                                              hint: 'Select',
                                              isRequired: false,
                                              callB: () {
                                                // _selectDate(context);
                                              },
                                              selectedDate:
                                                  controller.stopDateController,
                                              filledColor: Colors.white,
                                              dontDhowPrefix: true,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Expanded(
                                            child: CustomDateField(
                                              labelText: 'Time',
                                              hint: 'Select',
                                              isRequired: false,
                                              callB: () {
                                                selectTime(context);
                                              },
                                              selectedDate:
                                                  controller.stopTimeController,
                                              filledColor: Colors.white,
                                              dontDhowPrefix: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Visibility(
                                      visible: showStopDiaButton,
                                      child: Column(
                                        children: [
                                          CustomDateField(
                                            labelText: 'Duration',
                                            hint: 'Select',
                                            isRequired: false,
                                            callB: () {
                                              // selectTime(context);
                                            },
                                            selectedDate:
                                                controller.durationController,
                                            filledColor: Colors.white,
                                            dontDhowPrefix: true,
                                          ),
                                          Visibility(
                                            visible:
                                                controller.isRemarkVisiable,
                                            child: MyCustomDropdown(
                                                selectedItem: controller
                                                    .selectedDurationRem,
                                                labelText:
                                                    "Dialysis Duration Remark",
                                                items: dialysisEventController
                                                    .incidentList
                                                    .map(
                                                        (e) => e.lookupDetValue)
                                                    .toList(),
                                                hint: "Select",
                                                isRequired: true,
                                                senValue: (vaule) {
                                                  controller
                                                          .selectedDurationRem =
                                                      vaule;
                                                },
                                                filledColor: Colors.white),
                                          ),
                                          const SizedBox(height: 8),
                                          Visibility(
                                            visible:
                                                controller.isRemarkVisiable,
                                            child: CustomTextField(
                                              maxLines: 1,
                                              isReadOnly: false,
                                              keyBoardType: TextInputType.text,
                                              labelText:
                                                  'Dialysis Duration Description',
                                              hintText: 'Enter',
                                              isRequired: false,
                                              txtController:
                                                  controller.durationRemark,
                                              fillColor: Colors.white,
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
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
                                        postDialysisController.isSaving ||
                                            postDialysisController.isLoading,
                                    callB: postDialysisController.isSaving ||
                                            postDialysisController.isLoading
                                        ? null
                                        : () async {
                                            if (showStopDiaButton == true) {
                                              if (formKey.currentState
                                                      ?.validate() ??
                                                  false) {
                                                // Form is valid, proceed with further actions
                                                postDialysisController
                                                    .isSaving = true;
                                                postDialysisController.update();

                                                postDialysisController
                                                    .saveRequestModel
                                                    .postDialysisId = 0;
                                                postDialysisController
                                                        .saveRequestModel
                                                        .weight =
                                                    double.parse(
                                                        postDialysisController
                                                            .weightController
                                                            .text);

                                                postDialysisController
                                                        .saveRequestModel
                                                        .bloodPressureH =
                                                    int.parse(
                                                        postDialysisController
                                                            .doubleTxtController1
                                                            .text);
                                                postDialysisController
                                                        .saveRequestModel
                                                        .bloodPressureL =
                                                    int.parse(
                                                        postDialysisController
                                                            .doubleTxtController2
                                                            .text);
                                                postDialysisController
                                                        .saveRequestModel
                                                        .patientId =
                                                    widget.postDialysisData
                                                        .patientId;
                                                postDialysisController
                                                        .saveRequestModel
                                                        .treatmentId =
                                                    widget.postDialysisData
                                                        .treatmentId;
                                                postDialysisController
                                                        .saveRequestModel
                                                        .unitId =
                                                    int.parse(userData['unitId']
                                                        .toString());
                                                if (postDialysisController
                                                    .pulseLevel
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .pulse =
                                                      convertToNumber(
                                                          postDialysisController
                                                              .pulseLevel.text);
                                                }
                                                if (postDialysisController
                                                    .temperaturController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .temperature =
                                                      double.parse(
                                                          postDialysisController
                                                              .temperaturController
                                                              .text);
                                                }
                                                // if (postDialysisController
                                                //     .finalUFVController
                                                //     .text
                                                //     .isNotEmpty) {
                                                //   postDialysisController
                                                //       .saveRequestModel.finalUfv =
                                                //       convertToNumber(
                                                //           postDialysisController
                                                //               .finalUFVController.text);
                                                // }

                                                if (postDialysisController
                                                    .finalUFVController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .finalUfv =
                                                      double.tryParse(
                                                          postDialysisController
                                                              .finalUFVController
                                                              .text);
                                                }

                                                if (postDialysisController
                                                    .venousPressureController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .venousPressure =
                                                      convertToNumber(
                                                          postDialysisController
                                                              .venousPressureController
                                                              .text);
                                                }
                                                if (postDialysisController
                                                    .oxygenLevel
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .respiratoryRate =
                                                      convertToNumber(
                                                          postDialysisController
                                                              .respRateController
                                                              .text);
                                                }

                                                if (postDialysisController
                                                    .dialyticFlowController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .dialyticFlowQd =
                                                      convertToNumber(
                                                          postDialysisController
                                                              .dialyticFlowController
                                                              .text);
                                                }

                                                postDialysisController
                                                    .saveRequestModel
                                                    .createdBy = userData['ui'];

                                                if (postDialysisController
                                                    .heparinController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .herapinIu =
                                                      convertToNumber(
                                                          postDialysisController
                                                              .heparinController
                                                              .text);
                                                }

                                                postDialysisController
                                                        .saveRequestModel
                                                        .caseNarration =
                                                    postDialysisController
                                                        .caseNarrationController
                                                        .text;

                                                postDialysisController
                                                        .saveRequestModel
                                                        .dialysisStopTime =
                                                    postDialysisController
                                                        .stopTimeController
                                                        .text;

                                                if (postDialysisController
                                                    .rrfUrineController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .rrfUrineVolumeMlDay =
                                                      convertToNumber(
                                                          postDialysisController
                                                              .rrfUrineController
                                                              .text);
                                                }

                                                if (postDialysisController
                                                    .durationController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .dialysisDuration =
                                                      postDialysisController
                                                          .durationController
                                                          .text;
                                                }

                                                postDialysisController
                                                        .saveRequestModel
                                                        .postRemark =
                                                    postDialysisController
                                                        .durationRemark.text;
                                                if (postDialysisController
                                                    .currentWeightController
                                                    .text
                                                    .isNotEmpty) {
                                                  String weightText =
                                                      postDialysisController
                                                          .currentWeightController
                                                          .text;
                                                  try {
                                                    // Try to parse the text as a double
                                                    double weightValue =
                                                        double.parse(
                                                            weightText);

                                                    // Check if the double value is actually an integer value
                                                    if (weightValue ==
                                                        weightValue.toInt()) {
                                                      // If it is, assign it as an integer
                                                      postDialysisController
                                                              .saveRequestModel
                                                              .weightDifference =
                                                          weightValue;
                                                    } else {
                                                      // Otherwise, assign it as a double and convert to string
                                                      postDialysisController
                                                              .saveRequestModel
                                                              .weightDifference =
                                                          weightValue;
                                                    }
                                                  } catch (e) {
                                                    // Handle the error if the string cannot be parsed into a double
                                                    debugPrint(
                                                        'Error parsing weight: $e');
                                                  }
                                                }

                                                if (postDialysisController
                                                    .bloodFlowController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .bloodFlowQb =
                                                      convertToNumber(
                                                          postDialysisController
                                                              .bloodFlowController
                                                              .text);
                                                }

                                                if (postDialysisController
                                                    .actualFiberController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .actualFiberBundle =
                                                      int.parse(
                                                          postDialysisController
                                                              .actualFiberController
                                                              .text);
                                                }

                                                if (postDialysisController
                                                    .percentageFiberController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .percentageFiberBundle =
                                                      double.tryParse(
                                                          postDialysisController
                                                              .percentageFiberController
                                                              .text);
                                                }

                                                postDialysisController
                                                    .saveRequestModel
                                                    .dilCeck = controller
                                                        .discardRem!.isSelected!
                                                    ? 1
                                                    : 0;

                                                if (postDialysisController
                                                    .discardedRemController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .disRemark =
                                                      postDialysisController
                                                          .discardedRemController
                                                          .text;
                                                }

                                                if (postDialysisController
                                                    .finalKtVController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .finalKTV =
                                                      postDialysisController
                                                          .finalKtVController
                                                          .text;
                                                }

                                                if (postDialysisController
                                                    .oxygenLevel
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .oxyLevel =
                                                      int.parse(
                                                          postDialysisController
                                                              .oxygenLevel
                                                              .text);
                                                }

                                                if (postDialysisController
                                                        .selectedDurationRem !=
                                                    null) {
                                                  IncedentTypeModel
                                                      selectedObj =
                                                      dialysisEventController
                                                          .incidentList
                                                          .firstWhere((e) =>
                                                              e.lookupDetValue ==
                                                              postDialysisController
                                                                  .selectedDurationRem);
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .diaDurationRemark =
                                                      selectedObj.lookupDetId;
                                                }

                                                if (postDialysisController
                                                    .urfController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .ufv =
                                                      double.parse(
                                                          postDialysisController
                                                              .urfController
                                                              .text);
                                                }

                                                postDialysisController
                                                    .saveRequestModel
                                                    .postDialysisInfusionId = 0;

                                                postDialysisController
                                                        .saveRequestModel
                                                        .dialysisStopDate =
                                                    postDialysisController
                                                                .isoFormattedStopDate !=
                                                            null
                                                        ? convertDateToEpochMillis(
                                                            postDialysisController
                                                                .isoFormattedStopDate!)
                                                        : null;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .status = 0;
                                                postDialysisController
                                                    .saveRequestModel
                                                    .updatedBy = 0;

                                                postDialysisController
                                                        .saveRequestModel
                                                        .causeDuration =
                                                    postDialysisController
                                                        .selectedDurationRem;

                                                postDialysisController
                                                        .saveRequestModel
                                                        .temperatureUnit =
                                                    isCelsius ? "F" : "C";
                                                postDialysisController
                                                    .saveRequestModel
                                                    .remarkFlag = "L";

                                                postDialysisController
                                                        .saveRequestModel
                                                        .epoAdministered =
                                                    postDialysisController
                                                        .epoAdministeredId
                                                        ?.lookupDetId;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .epoBrandName = postDialysisController
                                                            .selectedEPOBrand !=
                                                        null
                                                    ? postDialysisController
                                                        .epoBrandList
                                                        ?.firstWhere((e) =>
                                                            e.lookupDetDescEn ==
                                                            postDialysisController
                                                                .selectedEPOBrand)
                                                        .lookupDetId
                                                    : null;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .epoDose = postDialysisController
                                                            .selectedEPOBrand !=
                                                        null
                                                    ? postDialysisController
                                                        .epoDoseList
                                                        ?.firstWhere((e) =>
                                                            e.lookupDetDescEn ==
                                                            postDialysisController
                                                                .selectedEpoDose)
                                                        .lookupDetId
                                                    : 0;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .epoFrequency = postDialysisController
                                                            .selectedEpoFreq !=
                                                        null
                                                    ? postDialysisController
                                                        .epoFreqList
                                                        ?.firstWhere((e) =>
                                                            e.lookupDetDescEn ==
                                                            postDialysisController
                                                                .selectedEpoFreq)
                                                        .lookupDetId
                                                    : 0;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .epoRoute = postDialysisController
                                                            .selectedEpoRoute !=
                                                        null
                                                    ? postDialysisController
                                                        .epoRouteList
                                                        ?.firstWhere((e) =>
                                                            e.lookupDetDescEn ==
                                                            postDialysisController
                                                                .selectedEpoRoute)
                                                        .lookupDetId
                                                    : 0;

                                                postDialysisController
                                                        .saveRequestModel
                                                        .epoAdminDays =
                                                    postDialysisController
                                                        .selectedEpoAdminDays;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .epoStartDate = controller
                                                        .epoStartDate
                                                        .text
                                                        .isNotEmpty
                                                    ? convertDateToEpochMillis(
                                                        controller
                                                            .epoStartDate.text)
                                                    : null;

                                                postDialysisController
                                                        .saveRequestModel
                                                        .epoIndication =
                                                    controller
                                                        .epoIndicator.text;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .lastHgbHb = controller
                                                        .lastHgb.text.isNotEmpty
                                                    ? int.parse(
                                                        controller.lastHgb.text)
                                                    : null;

                                                postDialysisController
                                                        .saveRequestModel
                                                        .ironSucrose =
                                                    postDialysisController
                                                        .ironSucroseId
                                                        ?.lookupDetId;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .ironPreparation = postDialysisController
                                                            .selectedIronPrep !=
                                                        null
                                                    ? postDialysisController
                                                        .ironPrepList
                                                        ?.firstWhere((e) =>
                                                            e.lookupDetDescEn ==
                                                            postDialysisController
                                                                .selectedIronPrep)
                                                        .lookupDetId
                                                    : null;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .ironDose = postDialysisController
                                                            .selectedIronDose !=
                                                        null
                                                    ? postDialysisController
                                                        .ironDoseList
                                                        ?.firstWhere((e) =>
                                                            e.lookupDetDescEn ==
                                                            postDialysisController
                                                                .selectedIronDose)
                                                        .lookupDetId
                                                    : 0;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .ironFrequency = postDialysisController
                                                            .selectedIronFreq !=
                                                        null
                                                    ? postDialysisController
                                                        .ironFreqList
                                                        ?.firstWhere((e) =>
                                                            e.lookupDetDescEn ==
                                                            postDialysisController
                                                                .selectedIronFreq)
                                                        .lookupDetId
                                                    : 0;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .ironRoute = postDialysisController
                                                            .selectedIronRoute !=
                                                        null
                                                    ? postDialysisController
                                                        .ironRouteList
                                                        ?.firstWhere((e) =>
                                                            e.lookupDetDescEn ==
                                                            postDialysisController
                                                                .selectedIronRoute)
                                                        .lookupDetId
                                                    : 0;

                                                postDialysisController
                                                        .saveRequestModel
                                                        .ironAdminDays =
                                                    postDialysisController
                                                        .selectedIronAdminDays;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .ironStartDate = controller
                                                        .ironStartDate
                                                        .text
                                                        .isNotEmpty
                                                    ? convertDateToEpochMillis(
                                                        controller
                                                            .ironStartDate.text)
                                                    : null;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .ironProtocolUsed = postDialysisController
                                                            .selectedIronProtocol !=
                                                        null
                                                    ? postDialysisController
                                                        .ironProtoColList
                                                        ?.firstWhere((e) =>
                                                            e.lookupDetDescEn ==
                                                            postDialysisController
                                                                .selectedIronProtocol)
                                                        .lookupDetId
                                                    : 0;

                                                postDialysisController
                                                        .saveRequestModel
                                                        .ferritinLevel =
                                                    postDialysisController
                                                            .ferritinLevel
                                                            .text
                                                            .isNotEmpty
                                                        ? int.parse(
                                                            postDialysisController
                                                                .ferritinLevel
                                                                .text)
                                                        : null;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .tsat = postDialysisController
                                                        .tsat.text.isNotEmpty
                                                    ? int.parse(
                                                        postDialysisController
                                                            .tsat.text)
                                                    : null;

                                                postDialysisController
                                                        .saveRequestModel
                                                        .bloodTrans =
                                                    postDialysisController
                                                        .bloodTransId
                                                        ?.lookupDetId;

                                                postDialysisController
                                                        .saveRequestModel
                                                        .captureVolume =
                                                    postDialysisController
                                                            .volume
                                                            .text
                                                            .isNotEmpty
                                                        ? int.parse(
                                                            postDialysisController
                                                                .volume.text)
                                                        : null;

                                                postDialysisController
                                                    .saveRequestModel
                                                    .bloodTransDate = controller
                                                        .bloodTransDate
                                                        .text
                                                        .isNotEmpty
                                                    ? convertDateToEpochMillis(
                                                            controller
                                                                .bloodTransDate
                                                                .text)
                                                        .toString()
                                                    : null;

                                                if (postDialysisController
                                                    .cbvController
                                                    .text
                                                    .isNotEmpty) {
                                                  postDialysisController
                                                          .saveRequestModel
                                                          .cbv =
                                                      double.tryParse(
                                                          postDialysisController
                                                              .cbvController
                                                              .text);
                                                }

                                                await postDialysisController
                                                    .saveEditPostDialysis();
                                                debugPrint('Form is valid');
                                              } else {
                                                // Form is invalid, show errors

                                                debugPrint('Form is invalid');
                                                CustomMessage.toast(
                                                    "Please fill madetory details");
                                              }
                                            } else {
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
                                      postDialysisController
                                          .weightController.text = "";
                                      postDialysisController
                                          .currentWeightController.text = "";
                                      postDialysisController
                                          .doubleTxtController1.text = "";
                                      postDialysisController
                                          .doubleTxtController2.text = "";
                                      postDialysisController.pulseLevel.text =
                                          "";
                                      postDialysisController
                                          .temperaturController.text = "";
                                      postDialysisController.oxygenLevel.text =
                                          "";
                                      postDialysisController
                                          .rrfUrineController.text = "";
                                      postDialysisController
                                          .heparinController.text = "";
                                      postDialysisController
                                          .caseNarrationController.text = "";
                                      postDialysisController
                                          .finalUFVController.text = "";
                                      postDialysisController
                                          .venousPressureController.text = "";
                                      postDialysisController
                                          .bloodFlowController.text = "";
                                      postDialysisController
                                          .dialyticFlowController.text = "";
                                      postDialysisController
                                          .durationRemark.text = "";
                                      postDialysisController.refreshUi();
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

  int? convertDateToEpochMillis(String dateStr) {
    try {
      final DateFormat formatter = DateFormat("yyyy-MM-dd");
      final DateTime parsedDate = formatter.parse(dateStr);

      final utcDate = DateTime.utc(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
      );

      return utcDate.millisecondsSinceEpoch;
    } catch (e) {
      debugPrint("Date parse error: $e");
      return null;
    }
  }

  // int? convertDateToEpochMillis(String dateStr) {
  //   try {
  //     final DateFormat formatter = DateFormat("dd-MM-yyyy");
  //     final DateTime parsedDate = formatter.parse(dateStr);
  //     return parsedDate.millisecondsSinceEpoch;
  //   } catch (e) {
  //     debugPrint("Date parse error: $e");
  //     return null;
  //   }
  // }

  selectEpoDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);

    if (picked != null) {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formattedFromDate = formatter.format(picked);
      postDialysisController.epoStartDate.text = formattedFromDate;
    }
  }

  selectBlodTranDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);

    if (picked != null) {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formattedFromDate = formatter.format(picked);
      postDialysisController.bloodTransDate.text = formattedFromDate;
    }
  }

  selectIronDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);

    if (picked != null) {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formattedFromDate = formatter.format(picked);
      postDialysisController.ironStartDate.text = formattedFromDate;
    }
  }

  dynamic convertToNumber(String input) {
    if (input.contains('.')) {
      return double.parse(input);
    } else {
      return int.parse(input);
    }
  }

  void calculateTimeDifference(
      String startTime, String stopTime, String startDate) {
    // Define date format that includes both date and time
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

    // Ensure startTime and stopTime include seconds
    if (!startTime.contains(':')) startTime = "$startTime:00";
    if (startTime.length == 5) startTime += ":00"; // If format is HH:mm

    if (!stopTime.contains(':')) stopTime = "$stopTime:00";
    if (stopTime.length == 5) stopTime += ":00"; // If format is HH:mm

    debugPrint(
        "Parsing datetime: $startDate $startTime and $startDate $stopTime");

    // Parse start and stop DateTime using only the start date
    DateTime convertedStartTime = dateFormat.parse('$startDate $startTime');
    DateTime convertedStopTime = dateFormat.parse('$startDate $stopTime');

    // Calculate the difference in time (absolute duration for consistency)
    Duration difference;
    String durationText;

    if (convertedStopTime.isBefore(convertedStartTime)) {
      difference = convertedStartTime.difference(convertedStopTime);
      durationText =
          '-${difference.inHours.toString().padLeft(2, '0')}:${(difference.inMinutes % 60).toString().padLeft(2, '0')}:${(difference.inSeconds % 60).toString().padLeft(2, '0')}';
    } else {
      difference = convertedStopTime.difference(convertedStartTime);
      durationText =
          '${difference.inHours.toString().padLeft(2, '0')}:${(difference.inMinutes % 60).toString().padLeft(2, '0')}:${(difference.inSeconds % 60).toString().padLeft(2, '0')}';
    }

    postDialysisController.durationController.text = durationText;

    // Define the duration thresholds
    Duration minDuration = const Duration(hours: 3, minutes: 30);
    Duration maxDuration = const Duration(hours: 4);

    // Check if duration is above 3:30 and up to 4:00
    bool isRemarkVisible =
        !(difference.abs() > minDuration && difference.abs() <= maxDuration);

    // Update remark visibility in UI
    postDialysisController.isRemarkVisiable = isRemarkVisible;

    debugPrint('Duration: $durationText');
    debugPrint(isRemarkVisible ? "Remark visible" : "Remark not visible");

    if (postDialysisController.durationController.text.isNotEmpty) {
      postDialysisController.calculateUFV();
    }

    // Update controller to reflect changes in UI
    postDialysisController.update();
  }

  selectTime(context) async {
    pickedTime = await DatePickerHelper.selectTimeWithSeconds(context);
    postDialysisController.stopTimeController.text = pickedTime!;
    postDialysisController.update();
    calculateTimeDifference(
        postDialysisController.startTime!, pickedTime!, formattedStopDate!);
  }
}

class DaysCheckboxList extends StatefulWidget {
  final List<CommonDropDownPostDialysisModel>? weekDaysList;
  final String? preSelectedCsv;
  final ValueChanged<String>? onChanged;

  const DaysCheckboxList({
    super.key,
    this.weekDaysList,
    this.preSelectedCsv,
    this.onChanged,
  });

  @override
  State<DaysCheckboxList> createState() => _DaysCheckboxListState();
}

class _DaysCheckboxListState extends State<DaysCheckboxList> {
  late Map<int, bool> selectedDays;

  @override
  void initState() {
    super.initState();
    final preSelected = _csvToIds(widget.preSelectedCsv);
    selectedDays = {
      for (var day in (widget.weekDaysList ?? []))
        day.lookupDetId: preSelected.contains(day.lookupDetId)
    };
  }

  Set<int> _csvToIds(String? csv) {
    if (csv == null || csv.trim().isEmpty) return {};
    return csv
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .map(int.parse)
        .toSet();
  }

  String _selectedCsv() {
    return selectedDays.entries
        .where((e) => e.value)
        .map((e) => e.key.toString())
        .join(',');
  }

  void _toggle(int id, bool value) {
    setState(() {
      selectedDays[id] = value;
    });

    widget.onChanged?.call(_selectedCsv());
  }

  @override
  Widget build(BuildContext context) {
    final list =
        widget.weekDaysList ?? const <CommonDropDownPostDialysisModel>[];
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: list.map((day) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              activeColor: AppColor.primaryBackgroundColor,
              value: selectedDays[day.lookupDetId] ?? false,
              onChanged: (v) => _toggle(day.lookupDetId, v ?? false),
            ),
            Text(day.lookupDetDescEn),
          ],
        );
      }).toList(),
    );
  }
}
