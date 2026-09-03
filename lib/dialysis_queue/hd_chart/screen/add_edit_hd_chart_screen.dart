import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/controller/hd_chart_controller.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/hd_chart_list_model.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/model/hd_chart_payload.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import '../../../widgets/custom_shimmer_loader.dart';
import '../../../widgets/patient_card_details.dart';

class AddEditHdChartScreen extends StatefulWidget {
  final HdChartListModel hdChartListModel;

  const AddEditHdChartScreen({super.key, required this.hdChartListModel});

  @override
  State<AddEditHdChartScreen> createState() => _AddEditHdChartScreenState();
}

class _AddEditHdChartScreenState extends State<AddEditHdChartScreen> {
  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());
  final HdChartController hdChartController = Get.find();
  String? pickedTime;

  bool isExpanded = false;
  bool hasInternet = true;

  var userData;

  @override
  void initState() {
    hdChartController.demoRows.clear();
    hdChartController.hdChartCardData.clear();
    checkInternetAndLoadData();
    super.initState();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));

    if (hasInternet) {
      await getUserData();

      await hdChartController.getTableData(
          widget.hdChartListModel.patientId.toString(),
          widget.hdChartListModel.treatmentId.toString());

      if (widget.hdChartListModel.hdChartTreatCount != 0) {
        await hdChartController.getFirstTableData(
            widget.hdChartListModel.patientId.toString(),
            widget.hdChartListModel.treatmentId.toString());

        await hdChartController.getSecondTableData(
            widget.hdChartListModel.patientId.toString(),
            widget.hdChartListModel.treatmentId.toString());

        hdChartController.bolusDose.text =
            hdChartController.firstTableDataModel?.bolusDose ?? '';
        hdChartController.infusionDose.text =
            hdChartController.firstTableDataModel?.infusionDose ?? '';
        hdChartController.airDetLineClampController.text =
            hdChartController.firstTableDataModel?.airDetectorLineClamp ?? '';
        hdChartController.alarmLimSet.text =
            hdChartController.firstTableDataModel?.alarmLimitSet ?? '';
        hdChartController.hepPumpOn.text =
            hdChartController.firstTableDataModel?.heparinPumpOn ?? '';
        hdChartController.ctrlKtV.text =
            hdChartController.firstTableDataModel?.ktV ?? '';
        hdChartController.dialysateFlow.text =
            hdChartController.firstTableDataModel?.dialysateFlow.toString() ??
                '';
        hdChartController.dialysateTemp.text =
            hdChartController.firstTableDataModel?.dialysateTemp.toString() ??
                '';
        hdChartController.injection.text =
            hdChartController.firstTableDataModel?.injectionEpoIron ?? '';
        hdChartController.concentrateNa.text =
            hdChartController.firstTableDataModel?.concentrate ?? '';
        hdChartController.conductivity.text =
            hdChartController.firstTableDataModel?.conductivity != null
                ? hdChartController.firstTableDataModel!.conductivity.toString()
                : '';
        hdChartController.update();
      } else {
        hdChartController.hdChartCardData.add(HdChartRow(
          unitId: userData['unitId'],
          patientId: widget.hdChartListModel.patientId,
          treatmentId: widget.hdChartListModel.treatmentId,
        ));
      }

      hdChartController.demoRows.addAll([
        DialysisRow(
          pre: DialysisCell(
              'Pre-Dialysis Weight (kgs)',
              hdChartController.hdChartTableData?.preDialysisWeight
                      .toString() ??
                  '-'),
          post: DialysisCell('UF Target Achieved (Ltrs)',
              hdChartController.hdChartTableData?.ufTarget.toString() ?? '-'),
          safety: DialysisCell('Air Detector / Line Clamp', null,
              showTextField: true,
              enabled: true,
              controller: hdChartController.airDetLineClampController,
              placeholder: 'jj'),
        ),
        DialysisRow(
          pre: DialysisCell('Dry Weight (kgs)',
              hdChartController.hdChartTableData?.dryWeight.toString() ?? '-'),
          post: DialysisCell(
              'Post Dialysis Weight (kgs)',
              hdChartController.hdChartTableData?.postDialysisWeight
                      .toString() ??
                  '-'),
          safety: DialysisCell('Alarm Limit Set', null,
              showTextField: true,
              enabled: true,
              controller: hdChartController.alarmLimSet,
              placeholder: ''),
        ),
        DialysisRow(
          pre: DialysisCell(
              'Intradialytic Weight (kgs)',
              hdChartController.hdChartTableData?.intraDialyticWeight
                      .toString() ??
                  '-'),
          post: DialysisCell(
              'Weight Loss',
              hdChartController.hdChartTableData?.weightDifference.toString() ??
                  '-'),
          safety: DialysisCell('Heparin Pump on', null,
              showTextField: true,
              enabled: true,
              controller: hdChartController.hepPumpOn,
              placeholder: ''),
        ),
        DialysisRow(
          pre: DialysisCell('UF Target (Ltrs)',
              hdChartController.hdChartTableData?.ufTarget.toString() ?? '-'),
          post: DialysisCell('kt / v', null,
              showTextField: true,
              enabled: true,
              controller: hdChartController.ctrlKtV,
              placeholder: ''),
          safety: DialysisCell('Dialysate Flow (ml/min)', null,
              showTextField: true,
              enabled: true,
              controller: hdChartController.dialysateFlow,
              placeholder: '',
              keyboardType: TextInputType.number),
        ),

        // ——— thick divider ———
        DialysisRow(
          pre: DialysisCell('Pulse (bpm)',
              hdChartController.hdChartTableData?.prePulse.toString() ?? '-'),
          post: DialysisCell('Injection EPO / Iron', null,
              showTextField: true,
              enabled: true,
              controller: hdChartController.injection,
              placeholder: ''),
          safety: DialysisCell(
              'Dialysate Temp (°C)',
              showTextField: true,
              null,
              enabled: true,
              controller: hdChartController.dialysateTemp,
              placeholder: '',
              keyboardType: TextInputType.number),
        ),
        DialysisRow(
          pre: DialysisCell(
              'Respiratory Rate (rpm)',
              hdChartController.hdChartTableData?.respiratoryRate.toString() ??
                  '-'),
          post: DialysisCell('BP (mmHg)',
              '${hdChartController.hdChartTableData?.postBloodPressureH.toString() ?? '-'}/${hdChartController.hdChartTableData?.postBloodPressureL.toString()}'),
          safety: DialysisCell(
              'Concentrate Na+ (mmol / L)',
              showTextField: true,
              null,
              enabled: true,
              controller: hdChartController.concentrateNa,
              placeholder: '',
              keyboardType: TextInputType.number),
        ),
        DialysisRow(
          pre: DialysisCell('BP (mmHg)',
              '${hdChartController.hdChartTableData?.preBloodPressureH.toString() ?? '-'}/${hdChartController.hdChartTableData?.preBloodPressureL.toString()}'),
          post: DialysisCell(
              'Temperature (°F)',
              hdChartController.hdChartTableData?.postDialysisTemperature
                      .toString() ??
                  '-'),
          safety: DialysisCell('Conductivity (mho)', null,
              showTextField: true,
              enabled: true,
              controller: hdChartController.conductivity,
              placeholder: '',
              keyboardType: TextInputType.number),
        ),
        DialysisRow(
          pre: DialysisCell(
              'Pt. Temperature (°F)',
              hdChartController.hdChartTableData?.preDialysisTemperature
                      .toString() ??
                  '-'),
          post: DialysisCell('Pulse (bpm)',
              hdChartController.hdChartTableData?.postPulse.toString() ?? '-'),
          safety: const DialysisCell('', null, enabled: false),
        ),
        DialysisRow(
          pre: DialysisCell('HD Started By',
              hdChartController.hdChartTableData?.hdStartedBy ?? '-'),
          post: DialysisCell('HD Completed By',
              hdChartController.hdChartTableData?.hdCompletedBy ?? '-'),
          safety: const DialysisCell('', null, enabled: false),
        ),
      ]);

      await newRegistrationController
          .viewPatientData(widget.hdChartListModel.patientId);
      hdChartController.update();
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  void addCard() {
    setState(() {
      hdChartController.hdChartCardData.add(HdChartRow(
        unitId: userData['unitId'],
        patientId: widget.hdChartListModel.patientId,
        treatmentId: widget.hdChartListModel.treatmentId,
      ));
    });
  }

  removeCard(int index) async {
    if (hdChartController.hdChartCardData.length > 1) {
      if (hdChartController.hdChartCardData[index].treatmentHdChartId == null) {
        hdChartController.hdChartCardData.removeAt(index);
      } else {
        await hdChartController.deleteTableRow(hdChartController
            .hdChartCardData[index].treatmentHdChartId
            .toString());
        hdChartController.hdChartCardData.removeAt(index);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'HD Chart',
          fontSize: 18.sp,
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
      body: hasInternet
          ? hdChartController.isLoading
              ? Center(child: buildShimmerLoader())
              : GetBuilder<HdChartController>(builder: (controller) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 1.w, right: 10.w, top: 0, bottom: 6.h),
                          child: PatientCardDetails(
                            imagePath: buildProfileImage(),
                            isExpand: (value) {
                              isExpanded = value;
                              setState(() {});
                            },
                            isExpanded: isExpanded,
                            isFromAddPredialysis: true,
                            refBy: "",
                            schemaAdopted: '',
                            patientDetails:
                                newRegistrationController.viewPatientModel,
                          ).paddingSymmetric(vertical: 10.h),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: 10.w, right: 10.w, top: 0, bottom: 6.h),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: Colors.white70,
                        //         border: Border.all(color: AppColor.borderColor),
                        //         borderRadius: BorderRadius.circular(12)),
                        //     child: Row(
                        //       children: [
                        //         Expanded(
                        //             child: CustomTextField(
                        //           maxLines: 1,
                        //           isReadOnly: false,
                        //           keyBoardType: TextInputType.text,
                        //           labelText: 'Bolus Dose',
                        //           hintText: 'Enter',
                        //           isRequired: false,
                        //           txtController: hdChartController.bolusDose,
                        //           fillColor: Colors.white,
                        //           fontSize: 16.sp,
                        //         )),
                        //         Expanded(
                        //             child: CustomTextField(
                        //           maxLines: 1,
                        //           isReadOnly: false,
                        //           keyBoardType: TextInputType.text,
                        //           labelText: 'Infusion Dose',
                        //           hintText: 'Enter',
                        //           isRequired: false,
                        //           txtController: hdChartController.infusionDose,
                        //           fillColor: Colors.white,
                        //           fontSize: 16.sp,
                        //         )),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 7.w, right: 7.w, top: 0, bottom: 6.h),
                          child: DialysisSummaryTable(
                            rows: hdChartController.demoRows,
                            thickDividersAfter: const {3, 4, 5, 6},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.w, right: 10.w, top: 2.h, bottom: 6.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              ...hdChartController.hdChartCardData
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key;
                                HdChartRow? cardData = entry.value;
                                return HDCardData(
                                  hdChartRow: cardData,
                                  index: index,
                                  // selectTime: () async {
                                  //   pickedTime =
                                  //       await DatePickerHelper.selectTime(
                                  //           context);
                                  //   // hdChartController.time.text = pickedTime!;
                                  //   cardData.hdTimeNew = pickedTime!;
                                  //   hdChartController.update();
                                  // },
                                  addCard: () {
                                    // if (selectedDiaFreq != null) {
                                    //   int.parse(selectedDiaFreq!) >
                                    //       (cardList.length)
                                    //       ? addCard()
                                    //       : null;
                                    addCard();
                                  },
                                  removeCard: () async {
                                    await removeCard(index);
                                  },
                                  hdChartListModel: widget.hdChartListModel,
                                );
                              }),
                              SizedBox(
                                height: 10.h,
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: hdChartController.isSaving ||
                                  hdChartController.isLoading
                              ? null
                              : () async {
                                  hdChartController.isSaving = true;
                                  hdChartController.update();
                                  var firstTableData = {
                                    "patientHdChartId": widget
                                        .hdChartListModel.patientHdChartId,
                                    "unitId": userData['unitId'],
                                    "patientId":
                                        widget.hdChartListModel.patientId,
                                    "treatmentId":
                                        widget.hdChartListModel.treatmentId,
                                    "patientNameOnDialyserCheck": null,
                                    "patientNameOnTubingCheck": null,
                                    "machineRinseDone": null,
                                    "machineSelfTestDone": null,
                                    "bolusDose":
                                        hdChartController.bolusDose.text,
                                    "infusionDose":
                                        hdChartController.infusionDose.text,
                                    "ktV": hdChartController.ctrlKtV.text,
                                    "injectionEpoIron":
                                        hdChartController.injection.text,
                                    "airDetectorLineClamp": hdChartController
                                        .airDetLineClampController.text,
                                    "alarmLimitSet":
                                        hdChartController.alarmLimSet.text,
                                    "heparinPumpOn":
                                        hdChartController.hepPumpOn.text,
                                    "dialysateFlow": hdChartController
                                            .dialysateFlow.text.isNotEmpty
                                        ? double.tryParse(hdChartController
                                            .dialysateFlow.text)
                                        : null,
                                    "dialysateTemp": hdChartController
                                            .dialysateTemp.text.isNotEmpty
                                        ? double.tryParse(hdChartController
                                            .dialysateTemp.text)
                                        : null,
                                    "concentrate": hdChartController
                                            .concentrateNa.text.isNotEmpty
                                        ? double.tryParse(hdChartController
                                            .concentrateNa.text)
                                        : null,
                                    "conductivity": hdChartController
                                            .conductivity.text.isNotEmpty
                                        ? double.tryParse(
                                            hdChartController.conductivity.text)
                                        : null,
                                    "status": null,
                                    "createdBy": null,
                                    "createdDate": null,
                                    "updatedBy": null,
                                    "updatedDate": null,
                                    "macId": null,
                                    "ipAddress": null,
                                    "deviceFrom": null,
                                    "patientCondition": null,
                                    "listOfData": null,
                                    "userId": userData['user_ID']
                                  };

                                  HdChartPayload hdChart = HdChartPayload(
                                      unitId: userData['unitId'],
                                      userId: userData['user_ID'],
                                      listOfData:
                                          hdChartController.hdChartCardData);

                                  await hdChartController
                                      .saveFirstTableData(firstTableData);
                                  await hdChartController
                                      .saveSecondTableData(hdChart);
                                  hdChartController.clearAllFields();
                                  hdChartController.isSaving = false;

                                  hdChartController.bolusDose.text =
                                      hdChartController
                                              .firstTableDataModel?.bolusDose ??
                                          '';
                                  hdChartController.infusionDose.text =
                                      hdChartController.firstTableDataModel
                                              ?.infusionDose ??
                                          '';
                                  hdChartController.airDetLineClampController
                                      .text = hdChartController
                                          .firstTableDataModel
                                          ?.airDetectorLineClamp ??
                                      '';
                                  hdChartController.alarmLimSet.text =
                                      hdChartController.firstTableDataModel
                                              ?.alarmLimitSet ??
                                          '';
                                  hdChartController.hepPumpOn.text =
                                      hdChartController.firstTableDataModel
                                              ?.heparinPumpOn ??
                                          '';
                                  hdChartController.ctrlKtV.text =
                                      hdChartController
                                              .firstTableDataModel?.ktV ??
                                          '';
                                  hdChartController.dialysateFlow.text =
                                      hdChartController.firstTableDataModel
                                              ?.dialysateFlow
                                              .toString() ??
                                          '';
                                  hdChartController.dialysateTemp.text =
                                      hdChartController.firstTableDataModel
                                              ?.dialysateTemp
                                              .toString() ??
                                          '';
                                  hdChartController.injection.text =
                                      hdChartController.firstTableDataModel
                                              ?.injectionEpoIron ??
                                          '';
                                  hdChartController.concentrateNa.text =
                                      hdChartController.firstTableDataModel
                                              ?.concentrate ??
                                          '';
                                  hdChartController.conductivity.text =
                                      hdChartController.firstTableDataModel
                                                  ?.conductivity !=
                                              null
                                          ? hdChartController
                                              .firstTableDataModel!.conductivity
                                              .toString()
                                          : '';

                                  hdChartController.update();
                                  Get.defaultDialog(
                                    title: "Success",
                                    middleText: "Data Saved Successfully!",
                                    textConfirm: "OK",
                                    onConfirm: () {
                                      Get.back(); // popup close
                                      Get.back(); // screen back (single navigation)
                                    },
                                  );
                                },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              alignment: Alignment.center,
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColor.primaryBackgroundColor,
                                    AppColor.secondaryColor
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: hdChartController.isSaving ||
                                      controller.isLoading
                                  ? SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: const CircularProgressIndicator(
                                          color: Colors.white, strokeWidth: 2),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/save-next.png'),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        CustomText(
                                            text: "Save",
                                            fontSize: 16.sp,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.normal,
                                            textColor: Colors.white,
                                            textAlign: TextAlign.start),
                                      ],
                                    )),
                        )
                      ],
                    ),
                  );
                })
          : InternetIssue(
              onRetryPressed: () {
                checkInternetAndLoadData();
              },
            ),
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
}

class HDCardData extends StatefulWidget {
  // final Function? selectTime;
  final HdChartRow hdChartRow;
  final int index;
  final Function addCard;
  final Function removeCard;
  final HdChartListModel hdChartListModel;

  const HDCardData(
      {super.key,
      // this.selectTime,
      required this.hdChartRow,
      required this.index,
      required this.addCard,
      required this.removeCard,
      required this.hdChartListModel});

  @override
  State<HDCardData> createState() => HDCardDataState();
}

class HDCardDataState extends State<HDCardData> {
  final HdChartController hdChartController = Get.find();

  late final TextEditingController timeCtrl;
  late final TextEditingController bpL;
  late final TextEditingController bpH;
  late final TextEditingController pulseCtrl;
  late final TextEditingController apCtrl;
  late final TextEditingController vpCtrl;
  late final TextEditingController tmpCtrl;
  late final TextEditingController ufrCtrl;
  late final TextEditingController ufAchievedCtrl;
  late final TextEditingController bfrCtrl;
  late final TextEditingController condCtrl;
  late final TextEditingController cbvCtrl;
  late final TextEditingController ktvCtrl;
  late final TextEditingController remarkCtrl;

  @override
  void initState() {
    super.initState();
    final r = widget.hdChartRow;
    timeCtrl = TextEditingController(
        text: widget.hdChartListModel.hdChartTreatCount != 0
            ? widget.hdChartRow.hdTime
            : widget.hdChartRow.hdTimeNew ?? '');
    bpL = TextEditingController(text: widget.hdChartRow.hdBpL ?? '');
    bpH = TextEditingController(text: widget.hdChartRow.hdBp ?? '');
    pulseCtrl = TextEditingController(text: _asStr(r.hdPulse));
    apCtrl = TextEditingController(text: _asStr(r.hdAp));
    vpCtrl = TextEditingController(text: _asStr(r.hdVp));
    tmpCtrl = TextEditingController(text: _asStr(r.hdTmp));
    ufrCtrl = TextEditingController(text: _asStr(r.hdUfr));
    ufAchievedCtrl = TextEditingController(text: r.hdAchieved ?? '');
    bfrCtrl = TextEditingController(text: _asStr(r.hdBfr));
    condCtrl = TextEditingController(text: _asStr(r.hdCond));
    cbvCtrl = TextEditingController(text: _asStr(r.hdCbv));
    ktvCtrl = TextEditingController(text: _asStr(r.hdKtv));
    remarkCtrl = TextEditingController(text: r.hdRemark ?? '');

    // Push text back to model
    timeCtrl.addListener(() {
      widget.hdChartRow.hdTimeNew = timeCtrl.text;
    });
    bpL.addListener(() {
      widget.hdChartRow.hdBpL = bpL.text;
    });
    bpH.addListener(() {
      widget.hdChartRow.hdBp = bpH.text;
    });
    pulseCtrl.addListener(() => r.hdPulse = _toInt(pulseCtrl.text));
    apCtrl.addListener(() => r.hdAp = _toInt(apCtrl.text));
    vpCtrl.addListener(() => r.hdVp = _toInt(vpCtrl.text));
    tmpCtrl.addListener(() => r.hdTmp = _toInt(tmpCtrl.text));
    ufrCtrl.addListener(() => r.hdUfr = _toInt(ufrCtrl.text));
    ufAchievedCtrl.addListener(() => r.hdAchieved = ufAchievedCtrl.text);
    bfrCtrl.addListener(() => r.hdBfr = _toInt(bfrCtrl.text));
    condCtrl.addListener(() => r.hdCond = _toInt(condCtrl.text));
    cbvCtrl.addListener(() => r.hdCbv = _toInt(cbvCtrl.text));
    ktvCtrl.addListener(() => r.hdKtv = _toInt(ktvCtrl.text));
    remarkCtrl.addListener(() => r.hdRemark = remarkCtrl.text);
  }

  @override
  void dispose() {
    timeCtrl.dispose();
    bpL.dispose();
    bpH.dispose();
    pulseCtrl.dispose();
    apCtrl.dispose();
    vpCtrl.dispose();
    tmpCtrl.dispose();
    ufrCtrl.dispose();
    ufAchievedCtrl.dispose();
    bfrCtrl.dispose();
    condCtrl.dispose();
    cbvCtrl.dispose();
    ktvCtrl.dispose();
    remarkCtrl.dispose();
    super.dispose();
  }

  String _asStr(int? v) => v?.toString() ?? '';
  int? _toInt(String s) => s.trim().isEmpty ? null : int.tryParse(s);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 1, top: 0, bottom: 6),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white70,
            border: Border.all(color: AppColor.borderColor),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 140,
                  child: CustomDateField(
                    // if CustomDateField supports controller:
                    selectedDate: timeCtrl,
                    labelText: 'Time',
                    hint: 'Select',
                    isRequired: false,
                    callB: () async {
                      final picked = await DatePickerHelper.selectTime(context);
                      if (picked != null) {
                        timeCtrl.text = picked;
                        setState(() {});
                      }
                    },
                    filledColor: Colors.white,
                    dontDhowPrefix: false,
                  ),
                ),
                Expanded(
                  child: DoubleTextField(
                    labelText: 'BP(mmHg)',
                    hintText1: 'Bottom',
                    hintText2: 'Top',
                    isRequired: false,
                    keyBoardType: TextInputType.number,
                    txtController1: bpH,
                    txtController2: bpL,

                    // if DoubleTextField supports controllers, pass them.
                    // Otherwise keep your onChange and set model values there.
                    onChange1: (v) {
                      // widget.hdChartRow.hdBp = v
                    },
                    onChange2: (v) {
                      // widget.hdChartRow.hdBpL = v
                    },
                    fillColor: Colors.white,
                    isReadOnly: false,
                    maxLines: 1,
                  ),
                ),
              ],
            ),

            // Now use controllers (no initialValue, no UniqueKey)
            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                  maxLines: 1,
                  isReadOnly: false,
                  keyBoardType: TextInputType.number,
                  labelText: 'Pulse',
                  hintText: 'Enter',
                  isRequired: false,
                  txtController: pulseCtrl,
                  fillColor: Colors.white,
                  fontSize: 16.sp,
                )),
                Expanded(
                    child: CustomTextField(
                  maxLines: 1,
                  isReadOnly: false,
                  keyBoardType: TextInputType.number,
                  labelText: 'AP',
                  hintText: 'Enter',
                  isRequired: false,
                  txtController: apCtrl,
                  fillColor: Colors.white,
                  fontSize: 16.sp,
                )),
              ],
            ),

            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                  maxLines: 1,
                  isReadOnly: false,
                  keyBoardType: TextInputType.number,
                  labelText: 'VP',
                  hintText: 'Enter',
                  isRequired: false,
                  txtController: vpCtrl,
                  fillColor: Colors.white,
                  fontSize: 16.sp,
                )),
                Expanded(
                    child: CustomTextField(
                  maxLines: 1,
                  isReadOnly: false,
                  keyBoardType: TextInputType.number,
                  labelText: 'TMP',
                  hintText: 'Enter',
                  isRequired: false,
                  txtController: tmpCtrl,
                  fillColor: Colors.white,
                  fontSize: 16.sp,
                )),
              ],
            ),

            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                  maxLines: 1,
                  isReadOnly: false,
                  keyBoardType: TextInputType.number,
                  labelText: 'UFR',
                  hintText: 'Enter',
                  isRequired: false,
                  txtController: ufrCtrl,
                  fillColor: Colors.white,
                  fontSize: 16.sp,
                )),
                Expanded(
                    child: CustomTextField(
                  maxLines: 1,
                  isReadOnly: false,
                  keyBoardType: TextInputType.text,
                  labelText: 'UF Achieved',
                  hintText: 'Enter',
                  isRequired: false,
                  txtController: ufAchievedCtrl,
                  fillColor: Colors.white,
                  fontSize: 16.sp,
                )),
              ],
            ),

            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                  maxLines: 1,
                  isReadOnly: false,
                  keyBoardType: TextInputType.number,
                  labelText: 'BFR',
                  hintText: 'Enter',
                  isRequired: false,
                  txtController: bfrCtrl,
                  fillColor: Colors.white,
                  fontSize: 16.sp,
                )),
                Expanded(
                    child: CustomTextField(
                  maxLines: 1,
                  isReadOnly: false,
                  keyBoardType: TextInputType.number,
                  labelText: 'Cond',
                  hintText: 'Enter',
                  isRequired: false,
                  txtController: condCtrl,
                  fillColor: Colors.white,
                  fontSize: 16.sp,
                )),
              ],
            ),

            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                  maxLines: 1,
                  isReadOnly: false,
                  keyBoardType: TextInputType.number,
                  labelText: 'CBV',
                  hintText: 'Enter',
                  isRequired: false,
                  txtController: cbvCtrl,
                  fillColor: Colors.white,
                  fontSize: 16.sp,
                )),
                Expanded(
                    child: CustomTextField(
                  maxLines: 1,
                  isReadOnly: false,
                  keyBoardType: TextInputType.number,
                  labelText: 'kt/v',
                  hintText: 'Enter',
                  isRequired: false,
                  txtController: ktvCtrl,
                  fillColor: Colors.white,
                  fontSize: 16.sp,
                )),
              ],
            ),

            CustomTextField(
              maxLines: 3,
              isReadOnly: false,
              keyBoardType: TextInputType.text,
              labelText: 'Remark',
              hintText: 'Enter',
              isRequired: false,
              txtController: remarkCtrl,
              fillColor: Colors.white,
              fontSize: 16.sp,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    widget.addCard();
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.green,
                ),
                IconButton(
                  onPressed: () {
                    widget.removeCard();
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                  color: AppColor.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class HDCardData extends StatefulWidget {
//   final Function? selectTime;
//   final HdChartRow hdChartRow;
//   final int index;
//   final Function addCard;
//   final Function removeCard;
//
//   const HDCardData(
//       {super.key,
//       this.selectTime,
//       required this.hdChartRow,
//       required this.index,
//       required this.addCard,
//       required this.removeCard});
//
//   @override
//   State<HDCardData> createState() => _HDCardDataState();
// }
//
// class _HDCardDataState extends State<HDCardData> {
//   final HdChartController hdChartController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 6),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white70,
//             border: Border.all(color: AppColor.borderColor),
//             borderRadius: BorderRadius.circular(12)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomDateField(
//                     key: UniqueKey(),
//                     labelText: 'Time',
//                     hint: 'Select',
//                     isRequired: false,
//                     callB: () {
//                       widget.selectTime!();
//                     },
//                     initialValue: widget.hdChartRow.hdTimeNew,
//                     filledColor: Colors.white,
//                     dontDhowPrefix: false,
//                   ),
//                 ),
//                 Expanded(
//                   child: DoubleTextField(
//                     key: UniqueKey(),
//                     labelText: 'Blood Pressure\n(mmHg)',
//                     hintText1: 'Bottom',
//                     hintText2: 'Top',
//                     isRequired: true,
//                     keyBoardType: TextInputType.text,
//                     txtControllerInitial1: widget.hdChartRow.hdBp,
//                     txtControllerInitial2: widget.hdChartRow.hdBpL,
//                     fillColor: Colors.white,
//                     isReadOnly: false,
//                     maxLines: 1,
//                     onChange1: (value) {
//                       widget.hdChartRow.hdBp = value;
//                       // hdChartController.update();
//                     },
//                     onChange2: (value) {
//                       widget.hdChartRow.hdBpL = value;
//                       // hdChartController.update();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextField(
//                     key: UniqueKey(),
//                     maxLines: 1,
//                     onChanged: (value) {
//                       widget.hdChartRow.hdPulse = value;
//                     },
//                     isReadOnly: false,
//                     keyBoardType: TextInputType.text,
//                     labelText: 'Pulse',
//                     hintText: 'Enter',
//                     isRequired: false,
//                     initialValue: widget.hdChartRow.hdPulse != null
//                         ? widget.hdChartRow.hdPulse.toString()
//                         : '',
//                     fillColor: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomTextField(
//                     key: UniqueKey(),
//                     maxLines: 1,
//                     onChanged: (value) {
//                       widget.hdChartRow.hdAp = value;
//                     },
//                     isReadOnly: false,
//                     keyBoardType: TextInputType.text,
//                     labelText: 'AP',
//                     hintText: 'Enter',
//                     isRequired: false,
//                     initialValue: widget.hdChartRow.hdAp != null
//                         ? widget.hdChartRow.hdAp.toString()
//                         : '',
//
//                     fillColor: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextField(
//                     key: UniqueKey(),
//                     maxLines: 1,
//                     onChanged: (value) {
//                       widget.hdChartRow.hdVp = value;
//                     },
//                     isReadOnly: false,
//                     keyBoardType: TextInputType.text,
//                     labelText: 'VP',
//                     hintText: 'Enter',
//                     isRequired: false,
//                     initialValue: widget.hdChartRow.hdVp != null
//                         ? widget.hdChartRow.hdVp.toString()
//                         : '',
//
//                     fillColor: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomTextField(
//                     key: UniqueKey(),
//                     maxLines: 1,
//                     onChanged: (value) {
//                       widget.hdChartRow.hdTmp = value;
//                     },
//                     isReadOnly: false,
//                     keyBoardType: TextInputType.text,
//                     labelText: 'TMP',
//                     hintText: 'Enter',
//                     isRequired: false,
//                     initialValue: widget.hdChartRow.hdTmp != null
//                         ? widget.hdChartRow.hdTmp.toString()
//                         : '',
//
//                     fillColor: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextField(
//                     key: UniqueKey(),
//                     maxLines: 1,
//                     onChanged: (value) {
//                       widget.hdChartRow.hdUfr = value;
//                     },
//                     isReadOnly: false,
//                     keyBoardType: TextInputType.text,
//                     labelText: 'UFR',
//                     hintText: 'Enter',
//                     isRequired: false,
//                     initialValue: widget.hdChartRow.hdUfr != null
//                         ? widget.hdChartRow.hdUfr.toString()
//                         : '',
//
//                     fillColor: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomTextField(
//                     key: UniqueKey(),
//                     maxLines: 1,
//                     onChanged: (value) {
//                       widget.hdChartRow.hdAchieved = value;
//                     },
//                     isReadOnly: false,
//                     keyBoardType: TextInputType.text,
//                     labelText: 'UF Achieved',
//                     hintText: 'Enter',
//                     isRequired: false,
//                     initialValue: widget.hdChartRow.hdAchieved,
//                     fillColor: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextField(
//                     key: UniqueKey(),
//                     maxLines: 1,
//                     onChanged: (value) {
//                       widget.hdChartRow.hdBfr = value;
//                     },
//                     isReadOnly: false,
//                     keyBoardType: TextInputType.text,
//                     labelText: 'BFR',
//                     hintText: 'Enter',
//                     isRequired: false,
//                     initialValue: widget.hdChartRow.hdBfr != null
//                         ? widget.hdChartRow.hdBfr.toString()
//                         : '',
//                     fillColor: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomTextField(
//                     key: UniqueKey(),
//                     maxLines: 1,
//                     onChanged: (value) {
//                       widget.hdChartRow.hdCond = value;
//                     },
//                     isReadOnly: false,
//                     keyBoardType: TextInputType.text,
//                     labelText: 'Cond',
//                     hintText: 'Enter',
//                     isRequired: false,
//                     initialValue: widget.hdChartRow.hdCond != null
//                         ? widget.hdChartRow.hdCond.toString()
//                         : '',
//
//                     fillColor: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextField(
//                     key: UniqueKey(),
//                     maxLines: 1,
//                     onChanged: (value) {
//                       widget.hdChartRow.hdCbv = value;
//                     },
//                     isReadOnly: false,
//                     keyBoardType: TextInputType.text,
//                     labelText: 'CBV',
//                     hintText: 'Enter',
//                     isRequired: false,
//                     initialValue: widget.hdChartRow.hdCbv != null
//                         ? widget.hdChartRow.hdCbv.toString()
//                         : '',
//                     fillColor: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomTextField(
//                     key: UniqueKey(),
//                     maxLines: 1,
//                     onChanged: (value) {
//                       widget.hdChartRow.hdKtv = value;
//                     },
//                     isReadOnly: false,
//                     keyBoardType: TextInputType.text,
//                     labelText: 'kt/v  ',
//                     hintText: 'Enter',
//                     isRequired: false,
//                     initialValue: widget.hdChartRow.hdKtv != null
//                         ? widget.hdChartRow.hdKtv.toString()
//                         : '',
//
//                     fillColor: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             CustomTextField(
//               key: UniqueKey(),
//               maxLines: 3,
//               onChanged: (value) {
//                 widget.hdChartRow.hdKtv = value;
//               },
//               isReadOnly: false,
//               keyBoardType: TextInputType.text,
//               labelText: 'Remark',
//               hintText: 'Enter',
//               isRequired: false,
//               initialValue: widget.hdChartRow.hdRemark,
//               fillColor: Colors.white,
//               fontSize: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     widget.addCard();
//                   },
//                   icon: const Icon(Icons.add_circle_outline),
//                   color: Colors.green,
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     widget.removeCard();
//                   },
//                   icon: const Icon(Icons.remove_circle_outline),
//                   color: AppColor.red,
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// ======= styles (tweak here) =======

const _pillRadius = 12.0;
const _fieldRadius = 8.0;
const _fieldHeight = 40.0;
const _border = Color(0xFFEAEAEA);
const _disabledFill = Color(0xFFF4F4F4);

// ======= DATA MODELS =======

/// A single cell in the table.
class DialysisCell {
  final String title;

  /// Initial display value (if not using a controller).
  final String? value;

  /// If true → show a TextField; if false → show the big value text.
  final bool showTextField;

  /// If showTextField is true, `enabled` toggles editability & greys the field.
  final bool enabled;

  /// Placeholder inside the TextField (defaults to title if null).
  final String? placeholder;

  /// Optional controller (recommended for editable cells).
  final TextEditingController? controller;

  /// Keyboard, input formatters, and onChanged for TextField cells.
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  const DialysisCell(
    this.title,
    this.value, {
    this.showTextField = false,
    this.enabled = true,
    this.placeholder,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onChanged,
  });
}

/// One row = 3 columns.
class DialysisRow {
  final DialysisCell pre;
  final DialysisCell post;
  final DialysisCell safety;

  const DialysisRow({
    required this.pre,
    required this.post,
    required this.safety,
  });
}

// ======= TABLE =======

class DialysisSummaryTable extends StatelessWidget {
  final List<DialysisRow> rows;

  /// If you want thick separators after specific indices, use this.
  final Set<int> thickDividersAfter;

  const DialysisSummaryTable({
    super.key,
    required this.rows,
    this.thickDividersAfter = const {},
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
          border: Border.all(color: const Color(0xFFECECEC)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              color: const Color(0xFF257BAB),
              padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 8.w),
              child: const Row(
                children: [
                  HeaderCell(text: 'Pre-dialysis'),
                  HeaderCell(text: 'Post-dialysis'),
                  HeaderCell(text: 'Safety Checks'),
                ],
              ),
            ),

            // Body rows
            ...List.generate(rows.length, (i) {
              final r = rows[i];
              // final last = i == rows.length - 1;

              return Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
                    child: Row(
                      children: [
                        PillCell(cell: r.pre, leftMost: true, showTitle: true),
                        PillCell(
                            cell: r.post, showTitle: !r.post.showTextField),
                        PillCell(
                            cell: r.safety, rightMost: true, showTitle: false),
                      ],
                    ),
                  ),
                  Container(
                      height: 1, color: Colors.grey.withValues(alpha: 0.3)),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class HeaderCell extends StatelessWidget {
  final String text;

  const HeaderCell({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class PillCell extends StatelessWidget {
  final DialysisCell cell;
  final bool leftMost;
  final bool rightMost;
  final bool showTitle;

  const PillCell({
    super.key,
    required this.cell,
    this.leftMost = false,
    this.rightMost = false,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          left: leftMost ? 0 : 2,
          right: rightMost ? 0 : 2,
        ),
        padding: EdgeInsets.symmetric(vertical: 0.h),
        child: Container(
          padding: EdgeInsets.only(left: 2.w, right: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_pillRadius),
            border: Border.all(color: Colors.white30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              if (showTitle &&
                  !cell.showTextField &&
                  cell.value != null &&
                  cell.value!.isNotEmpty)
                Text(
                  cell.title,
                  style: TextStyle(
                    color: AppColor.textGrey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (showTitle &&
                  !cell.showTextField &&
                  cell.value != null &&
                  cell.value!.isNotEmpty)
                SizedBox(height: 2.h),

              // value or input
              _CellValue(cell: cell),
            ],
          ),
        ),
      ),
    );
  }
}

// ======= VALUE or TEXTFIELD =======

class _CellValue extends StatelessWidget {
  final DialysisCell cell;
  //

  const _CellValue({required this.cell});

  InputBorder _outline(bool enabled) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(_fieldRadius),
        borderSide:
            BorderSide(color: _border.withValues(alpha: enabled ? 1 : 0.8)),
      );

  @override
  Widget build(BuildContext context) {
    // Show a TextField (enabled/disabled) if requested.
    if (cell.showTextField) {
      final hintText = cell.placeholder ?? cell.title;

      // If controller is provided → use TextField; if not, use TextFormField with initialValue.
      final baseDecoration = InputDecoration(
        isDense: true,
        hintText: hintText,
        filled: true,
        fillColor: cell.enabled ? Colors.white : _disabledFill,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        enabledBorder: _outline(true),
        focusedBorder: _outline(true),
        disabledBorder: _outline(false),
        hintStyle: TextStyle(
          fontSize: 10.sp,
          color: Colors.grey[600],
        ),
      );

      final field = (cell.controller != null)
          ? TextField(
              controller: cell.controller,
              enabled: cell.enabled,
              keyboardType: cell.keyboardType,
              inputFormatters: cell.inputFormatters,
              onChanged: cell.onChanged,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: (cell.controller?.text.isNotEmpty ?? false)
                    ? Colors.black
                    : Colors.grey[600],
              ),
              decoration: baseDecoration.copyWith(
                hintText: cell.title,
                //  FIX: Show controller text value
                labelText: (cell.controller?.text.isEmpty ?? true)
                    ? null
                    : cell.controller?.text,
              ),
            )
          : TextFormField(
              initialValue: cell.value ?? '',
              enabled: cell.enabled,
              keyboardType: cell.keyboardType,
              inputFormatters: cell.inputFormatters,
              onChanged: cell.onChanged,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
              decoration: baseDecoration.copyWith(
                // hintText: cell.title,
                hintStyle: const TextStyle(color: Colors.grey),
                //  labelText: cell.value?.isNotEmpty ?? false ? cell.value : null,
              ),
            );

      return ConstrainedBox(
        constraints: const BoxConstraints(minHeight: _fieldHeight),
        child: field,
      );
    }

    // Display-only (big value text)
    return Text(
      cell.value ?? '',
      style: TextStyle(
        color: const Color(0xFF484848),
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
