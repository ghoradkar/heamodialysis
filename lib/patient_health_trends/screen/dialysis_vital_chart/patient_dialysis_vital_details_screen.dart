import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/patient_health_trends/model/dialysis_vital_patient_list_model.dart';
import 'package:heamodialysis/patient_health_trends/controller/patient_heath_trends_controller.dart';
import 'package:heamodialysis/patient_health_trends/screen/dialysis_vital_chart/vital_chart_screen.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';
import '../../../widgets/patient_card_details.dart';

class PatientDialysisVitalDetailsScreen extends StatefulWidget {
  final DialysisVitalPatientListModel? patientData;

  const PatientDialysisVitalDetailsScreen({super.key, this.patientData});

  @override
  State<PatientDialysisVitalDetailsScreen> createState() =>
      _PatientDialysisVitalDetailsScreenState();
}

class _PatientDialysisVitalDetailsScreenState
    extends State<PatientDialysisVitalDetailsScreen> {
  final PatientController patientController = Get.put(PatientController());
  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());
  bool hasInternet = true;
  var userData;
  bool isExpanded = false;

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
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);

      await newRegistrationController
          .viewPatientData(widget.patientData?.patientId);

      await patientController.getVitalReportList(userData['unitId'].toString(),
          widget.patientData?.patientId, formattedDate, formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: context.l10n.phtVitalChart,
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
      body: GetBuilder<PatientController>(builder: (controller) {
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
                          selectedDate: patientController.fromDateVital,
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
                            selectedDate: patientController.toDateVital,
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
                      await patientController.getVitalReportList(
                          userData['unitId'].toString(),
                          widget.patientData?.patientId.toString(),
                          patientController.fromDateVital.text,
                          patientController.toDateVital.text);
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
            (controller.vitalReportModel?.data != null &&
                    controller.vitalReportModel!.data.isNotEmpty)
                ? Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.vitalReportModel?.data.keys
                                .toList()
                                .length ??
                            0,
                        itemBuilder: (context, index) {
                          final metric = controller.vitalReportModel?.data.keys
                              .toList()[index];
                          final latest = controller.getLatestValue(
                              controller.vitalReportModel!,
                              metric!); // uses helper above
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColor.borderColor),
                                color: Colors.white),
                            child: InkWell(
                              onTap: () {
                                // navigate to chart/detail screen with metric series
                                final series = controller.getSeriesForMetric(
                                    controller.vitalReportModel!, metric);
                                Get.to(() => VitalChartScreen(
                                      metricName: metric,
                                      dates: controller.vitalReportModel,
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
            if (controller.vitalReportModel?.data != null &&
                controller.vitalReportModel!.data.isNotEmpty)
              InkWell(
                onTap: () async {
                  // Parse the input string to DateTime
                  DateTime parsedDateFromD =
                      DateTime.parse(patientController.fromDateVital.text);
                  DateTime parsedDateTOD =
                      DateTime.parse(patientController.toDateVital.text);

                  // Format into dd/MM/yyyy
                  String formattedFromDate =
                      DateFormat('dd/MM/yyyy').format(parsedDateFromD);
                  String formattedTODate =
                      DateFormat('dd/MM/yyyy').format(parsedDateTOD);


                  await patientController.getReport(
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
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formattedFromDate = formatter.format(picked);

      patientController.fromDateVital.text = formattedFromDate;
    }
  }

  selectTo() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);

    if (picked != null) {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formattedFromDate = formatter.format(picked);

      patientController.toDateVital.text = formattedFromDate;
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

//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:heamodialysis/new_registration/new_registration_controller.dart';
// import 'package:heamodialysis/patient_health_trends/model/dialysis_vital_patient_list_model.dart';
// import 'package:heamodialysis/patient_health_trends/patient_heath_trends_controller.dart';
// import 'package:heamodialysis/patient_health_trends/hemoglobin_chart_screen.dart';
// import 'package:heamodialysis/utils/color_constants.dart';
// import 'package:heamodialysis/utils/shared_pref_constants.dart';
// import 'package:heamodialysis/utils/shared_preference.dart';
// import 'package:heamodialysis/widgets/custom_text.dart';
// import 'package:heamodialysis/widgets/date_picker.dart';
// import 'package:intl/intl.dart';
// import '../widgets/patient_card_details.dart';
//
// class PatientDialysisVitalDetailsScreen extends StatefulWidget {
//   final DialysisVitalPatientListModel? patientData;
//
//   const PatientDialysisVitalDetailsScreen({super.key, this.patientData});
//
//   @override
//   State<PatientDialysisVitalDetailsScreen> createState() =>
//       _PatientDialysisVitalDetailsScreenState();
// }
//
// class _PatientDialysisVitalDetailsScreenState
//     extends State<PatientDialysisVitalDetailsScreen> {
//   final PatientController patientController = Get.put(PatientController());
//   final NewRegistrationController newRegistrationController =
//   Get.put(NewRegistrationController());
//   bool hasInternet = true;
//   var userData;
//   bool isExpanded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//   }
//
//   Future<void> getUserData() async {
//     userData = await SharedPref().read(const SharedPrefConstant().kUserData);
//     checkInternetAndLoadData();
//   }
//
//   checkInternetAndLoadData() async {
//     List<ConnectivityResult> connectivityResult =
//     await Connectivity().checkConnectivity();
//
//     hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
//         connectivityResult.contains(ConnectivityResult.wifi));
//     setState(() {});
//
//     if (hasInternet) {
//       DateTime now = DateTime.now();
//       String formattedDate = DateFormat('yyyy-MM-dd').format(now);
//
//       await newRegistrationController
//           .viewPatientData(widget.patientData?.patientId);
//
//       await patientController.getVitalReportList(
//         userData['unitId'].toString(),
//         widget.patientData?.patientId,
//         formattedDate,
//         formattedDate,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF5F5F5),
//       appBar: AppBar(
//         backgroundColor: Color(0xFF00BCD4),
//         elevation: 2,
//         title: CustomText(
//           text: context.l10n.phtPatientVitalChart,
//           fontSize: 18.0,
//           fontFam: 'Lato',
//           fontWeight: FontWeight.w500,
//           textColor: Colors.white,
//           textAlign: TextAlign.start,
//         ),
//         leading: InkWell(
//           onTap: () => Get.back(),
//           child: Icon(Icons.arrow_back, color: Colors.white),
//         ),
//       ),
//       body: GetBuilder<PatientController>(builder: (controller) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Patient Card
//             GetBuilder<NewRegistrationController>(builder: (regController) {
//               return Container(
//                 color: Color(0xFF00BCD4),
//                 padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
//                 child: PatientCardDetails(
//                   isExpand: (value) {
//                     isExpanded = value;
//                     setState(() {});
//                   },
//                   isExpanded: isExpanded,
//                   isFromAddPredialysis: true,
//                   refBy: "",
//                   schemaAdopted: regController
//                       .viewPatientModel?.data?.lookupDetIdPatientType
//                       .toString() ??
//                       '',
//                   patientDetails: regController.viewPatientModel,
//                 ),
//               );
//             }),
//
//             SizedBox(height: 8),
//
//             // Date Range Card
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 16),
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.date_range,
//                           color: Color(0xFF00BCD4), size: 20),
//                       SizedBox(width: 8),
//                       CustomText(
//                         text: context.l10n.phtSelectDateRange,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         textColor: Colors.black87,
//                         textAlign: TextAlign.start,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _dateFieldModern(
//                           label: 'From Date',
//                           controller: patientController.fromDate,
//                           onTap: selectFrom,
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: _dateFieldModern(
//                           label: 'To Date',
//                           controller: patientController.toDate,
//                           onTap: selectTo,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         await patientController.getVitalReportList(
//                           userData['unitId'].toString(),
//                           widget.patientData?.patientId.toString(),
//                           patientController.fromDate.text,
//                           patientController.toDate.text,
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF00BCD4),
//                         padding: EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         elevation: 2,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.search, color: Colors.white, size: 18),
//                           SizedBox(width: 8),
//                           CustomText(
//                             text: context.l10n.phtShowReport,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             textColor: Colors.white,
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 16),
//
//             // Parameters Header
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Color(0xFFE0F7FA),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Icon(
//                       Icons.favorite,
//                       color: Color(0xFF00838F),
//                       size: 20,
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   CustomText(
//                     text: context.l10n.phtVitalParameters,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     textColor: Colors.black87,
//                     textAlign: TextAlign.start,
//                   ),
//                   Spacer(),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Color(0xFFE0F7FA),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: CustomText(
//                       text: "${controller.vitalReportModel?.data.keys.length ?? 0}",
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       textColor: Color(0xFF00838F),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 12),
//
//             // Parameters List
//             Expanded(
//               child: controller.vitalReportModel == null ||
//                   controller.vitalReportModel!.data.isEmpty
//                   ? _buildEmptyState()
//                   : ListView.builder(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 itemCount: controller.vitalReportModel?.data.keys.length ?? 0,
//                 itemBuilder: (context, index) {
//                   final metric = controller.vitalReportModel!.data.keys
//                       .toList()[index];
//                   final latest = controller.getLatestValue(
//                     controller.vitalReportModel!,
//                     metric,
//                   );
//
//                   return _buildParameterCard(
//                     context,
//                     index,
//                     metric,
//                     latest,
//                     controller,
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       }),
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 8,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: ElevatedButton.icon(
//           onPressed: () {
//             // TODO: Implement generate report functionality
//           },
//           icon: Icon(Icons.description, color: Colors.white, size: 20),
//           label: CustomText(
//             text: context.l10n.phtGenerateReport,
//             fontSize: 15,
//             fontWeight: FontWeight.w500,
//             textColor: Colors.white,
//             textAlign: TextAlign.center,
//           ),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Color(0xFF009688),
//             padding: EdgeInsets.symmetric(vertical: 14),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             elevation: 2,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _dateFieldModern({
//     required String label,
//     required TextEditingController controller,
//     required VoidCallback onTap,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomText(
//           text: label,
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//           textColor: Colors.grey[600]!,
//           textAlign: TextAlign.start,
//         ),
//         SizedBox(height: 6),
//         InkWell(
//           onTap: onTap,
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.grey[50],
//               border: Border.all(color: Colors.grey[300]!),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: CustomText(
//                     text: controller.text.isEmpty
//                         ? 'Select date'
//                         : controller.text,
//                     fontSize: 14,
//                     fontWeight: FontWeight.normal,
//                     textColor: controller.text.isEmpty
//                         ? Colors.grey[400]!
//                         : Colors.black87,
//                     textAlign: TextAlign.start,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildParameterCard(
//       BuildContext context,
//       int index,
//       String metric,
//       String? latest,
//       PatientController controller,
//       ) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[200]!),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 6,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: InkWell(
//         onTap: () {
//           final series = controller.getSeriesForMetric(
//             controller.vitalReportModel!,
//             metric,
//           );
//           Get.to(() => VitalChartScreen(
//             metricName: metric,
//             dates: controller.vitalReportModel,
//             series: series,
//           ));
//         },
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: EdgeInsets.all(14),
//           child: Row(
//             children: [
//               // Index Badge
//               Container(
//                 width: 36,
//                 height: 36,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFE0F7FA),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Center(
//                   child: CustomText(
//                     text: (index + 1).toString(),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     textColor: Color(0xFF00838F),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 12),
//
//               // Parameter Info
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: metric,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       textColor: Colors.black87,
//                       textAlign: TextAlign.start,
//                     ),
//                     if (latest != null) ...[
//                       SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Icon(Icons.fiber_manual_record,
//                               size: 8, color: Colors.green),
//                           SizedBox(width: 6),
//                           Expanded(
//                             child: CustomText(
//                               text: context.l10n.phtLatest(latest.toString()),
//                               fontSize: 12,
//                               fontWeight: FontWeight.normal,
//                               textColor: Colors.grey[600]!,
//                               textAlign: TextAlign.start,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//
//               // Trend Icon
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFE0F7FA),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   Icons.trending_up,
//                   size: 18,
//                   color: Color(0xFF00838F),
//                 ),
//               ),
//               SizedBox(width: 8),
//
//               // Arrow
//               Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//                 color: Colors.grey[400],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Color(0xFFE0F7FA),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.analytics_outlined,
//               size: 48,
//               color: Color(0xFF00838F),
//             ),
//           ),
//           SizedBox(height: 20),
//           CustomText(
//             text: context.l10n.phtNoVitalData,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             textColor: Colors.black87,
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 8),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 40),
//             child: CustomText(
//               text: context.l10n.phtSelectDateRangeTap + " "Show Report" to view vital parameters',
//               fontSize: 14,
//               fontWeight: FontWeight.normal,
//               textColor: Colors.grey[600]!,
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   selectFrom() async {
//     final DateTime? picked = await DatePickerHelper.selectDate(context);
//
//     if (picked != null) {
//       DateFormat formatter = DateFormat('yyyy-MM-dd');
//       String formattedFromDate = formatter.format(picked);
//       patientController.fromDate.text = formattedFromDate;
//       setState(() {});
//     }
//   }
//
//   selectTo() async {
//     final DateTime? picked = await DatePickerHelper.selectDate(context);
//
//     if (picked != null) {
//       DateFormat formatter = DateFormat('yyyy-MM-dd');
//       String formattedToDate = formatter.format(picked);
//       patientController.toDate.text = formattedToDate;
//       setState(() {});
//     }
//   }
// }
