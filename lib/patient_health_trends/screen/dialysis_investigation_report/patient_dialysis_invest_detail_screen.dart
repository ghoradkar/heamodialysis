import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/patient_health_trends/screen/dialysis_investigation_report/Invest_chart_screen.dart';
import 'package:heamodialysis/patient_health_trends/model/dialysis_invest_patient_list_model.dart';
import 'package:heamodialysis/patient_health_trends/controller/patient_heath_trends_controller.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';
import '../../../widgets/patient_card_details.dart';
// import '../../widgets/patient_card_details.dart';
// import '../../widgets/custom_shimmer_loader.dart';

class PatientDialysisInvestDetailsScreen extends StatefulWidget {
  final DialysisInvestPatientListModel? patientData;

  const PatientDialysisInvestDetailsScreen({super.key, this.patientData});

  @override
  State<PatientDialysisInvestDetailsScreen> createState() =>
      _PatientDialysisInvestDetailsScreenState();
}

class _PatientDialysisInvestDetailsScreenState
    extends State<PatientDialysisInvestDetailsScreen> {
  final PatientController patientController = Get.put(PatientController());
  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());
  bool hasInternet = true;
  var userData;
  bool isExpanded = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    checkInternetAndLoadData();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    setState(() {});

    if (hasInternet) {
      DateTime now = DateTime.now();

      // Format it as yyyy-MM-dd
      // String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      String formattedDate = DateFormat('dd-MM-yyyy').format(now);

      await newRegistrationController
          .viewPatientData(widget.patientData?.patientId);

      await patientController.getInvestReportList(
          userData['unitId'].toString(),
          widget.patientData?.patientId.toString(),
          formattedDate,
          formattedDate);
    }
    
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: context.l10n.phtInvestigationResultChart,
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
      body:
      isLoading
          ? const PatientDialysisInvestDetailsShimmer()
          : GetBuilder<PatientController>(builder: (controller) {
              return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GetBuilder<NewRegistrationController>(builder: (regController) {
              return PatientCardDetails(
                isExpand: (value) {
                  isExpanded = value;
                  setState(() {});
                },
                isExpanded: isExpanded,
                isFromAddPredialysis: true,

                refBy: "",
                schemaAdopted: regController
                        .viewPatientModel?.data?.lookupDetIdPatientType
                        .toString() ??
                    '',
                // patientDetailsModel: widget.preDialysisData,
                patientDetails: regController.viewPatientModel,
              ).paddingSymmetric(vertical: 12);
            }),
            Card(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomDateField(
                          selectedDate: patientController.fromDateInvest,
                          labelText: context.l10n.dashFromDate,
                          hint: context.l10n.dashFromDate,
                          isRequired: true,
                          callB: () {
                            selectFrom();
                          },
                          filledColor: Colors.white54,
                          dontDhowPrefix: false,
                          isViewProfile: false,
                        ),
                      ),
                      Expanded(
                        child: CustomDateField(
                            selectedDate: patientController.toDateInvest,
                            labelText: context.l10n.dashToDate,
                            hint: context.l10n.dashToDate,
                            isRequired: true,
                            callB: () {
                              selectTo();
                            },
                            filledColor: Colors.white54,
                            dontDhowPrefix: false,
                            isViewProfile: false),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      await patientController.getInvestReportList(
                          userData['unitId'].toString(),
                          widget.patientData?.patientId.toString(),
                          patientController.fromDateInvest.text,
                          patientController.toDateInvest.text);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColor.secondaryColor.withValues(alpha: 0.8),
                              AppColor.primaryBackgroundColor
                                  .withValues(alpha: 0.8)
                              // AppColor.primaryBackgroundColor,
                              // AppColor.secondaryColor
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(6)),
                      child: CustomText(
                          text: context.l10n.phtShowRecord,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          textColor: Colors.white,
                          textAlign: TextAlign.center),
                    ).paddingOnly(top: 8, bottom: 14),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 10),
            Row(
              children: [
                Image.asset(
                  'assets/heartbeat.png',
                  color: AppColor.primaryBackgroundColor,
                  width: 40,
                ).paddingOnly(right: 6),
                CustomText(
                  text: context.l10n.phtVitalParameters,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black,
                  textAlign: TextAlign.start,
                )
              ],
            ).paddingOnly(left: 8),
            // In PatientDialysisInvestDetailsScreen - this part stays the same
            (controller.investReportModel?.data != null &&
                    controller.investReportModel!.data.isNotEmpty)
                ? Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            controller.investReportModel?.data.keys.length ?? 0,
                        itemBuilder: (context, index) {
                          final parameters =
                              controller.investReportModel!.data.keys.toList();
                          final metric = parameters[index];
                          final latest = controller.getLatestValueInvest(
                              controller.investReportModel!, metric);

                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColor.borderColor),
                                color: Colors.white),
                            child: InkWell(
                              onTap: () {
                                final series =
                                    controller.getSeriesForMetricInvest(
                                        controller.investReportModel!, metric);
                                Get.to(() => InvetsChartScreen(
                                  metricName: metric,
                                  dates: controller.investReportModel,
                                  series: series,
                                ));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 6),
                                    decoration: BoxDecoration(
                                        color: AppColor.primaryBackgroundColor
                                            .withValues(alpha: 0.3),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: CustomText(
                                        text: (index + 1).toString(),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        textColor:
                                            AppColor.primaryBackgroundColor,
                                        textAlign: TextAlign.center),
                                  ).paddingOnly(left: 8, right: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: metric,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start,
                                        ),
                                        if (latest != null)
                                          CustomText(
                                              text: context.l10n.phtLatestValue(latest.toString()),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              textColor: Colors.grey,
                                              textAlign: TextAlign.start),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 2),
                                    decoration: BoxDecoration(
                                        color: AppColor.primaryBackgroundColor
                                            .withValues(alpha: 0.3),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Image.asset('assets/trending.png',
                                        color: AppColor.primaryBackgroundColor,
                                        width: 20),
                                  ),
                                  const Icon(Icons.arrow_forward_ios_sharp,
                                      color: Colors.grey)
                                ],
                              ),
                            ),
                          ).paddingSymmetric(vertical: 6);
                        }),
                  )
                : Expanded(
                    child: Center(
                      child: CustomText(
                          text: context.l10n.phtDataNotFound,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          textColor: Colors.grey,
                          textAlign: TextAlign.center),
                    ),
                  ),
            if (controller.investReportModel?.data != null &&
                controller.investReportModel!.data.isNotEmpty)
              InkWell(
                onTap: () async {
                  // Parse the input string to DateTime
                  final inputFormat = DateFormat('dd-MM-yyyy'); // your TextField format
                  final outputFormat = DateFormat('dd/MM/yyyy'); // desired output format

                  DateTime parsedDateFromD = inputFormat.parse(patientController.fromDateInvest.text);
                  DateTime parsedDateTOD = inputFormat.parse(patientController.toDateInvest.text);

                  String formattedFromDate = outputFormat.format(parsedDateFromD);
                  String formattedTODate = outputFormat.format(parsedDateTOD);


                  await patientController.getReportInvest(
                      formattedFromDate,
                      formattedTODate,
                      userData['unitId'].toString(),
                      widget.patientData!.patientId.toString(),
                      userData['user_ID']);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppColor.secondaryColor,
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(
                        colors: [
                          AppColor.secondaryColor.withValues(alpha: 0.8),
                          AppColor.primaryBackgroundColor.withValues(alpha: 0.8)
                          // AppColor.primaryBackgroundColor,
                          // AppColor.secondaryColor
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      )),
                  child: CustomText(
                      text: context.l10n.phtGenerateReport,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      textColor: Colors.white,
                      textAlign: TextAlign.center),
                ).paddingOnly(top: 8, bottom: 14),
              ),
          ],
        ).paddingSymmetric(horizontal: 10);
      }),

    );
  }

  selectFrom() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);

    if (picked != null) {
      // DateFormat formatter = DateFormat('yyyy-MM-dd');
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formattedFromDate = formatter.format(picked);

      patientController.fromDateInvest.text = formattedFromDate;
    }
  }

  selectTo() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);

    if (picked != null) {
      // DateFormat formatter = DateFormat('yyyy-MM-dd');
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formattedFromDate = formatter.format(picked);

      patientController.toDateInvest.text = formattedFromDate;
    }
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
