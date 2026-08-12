import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/tabular_analysis_blood.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/trend_analysis_tabs_oxygen.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/trend_analysis_tabs_pulse.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/trend_analysis_tabs_temp.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/trend_analysis_tabs_weight.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/edit_nephro_desk.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/clinical_history.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/cover_sheet_nephro.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/edit_nephro_desk.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/clinical_history.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_table.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class CoverSheetNephro extends StatefulWidget {
  final CoverSheetNephroModel? coverSheetNephro;
  final NephroList? patientData;
  final String appbarTitle;

  const CoverSheetNephro({super.key, this.coverSheetNephro, this.patientData, required this.appbarTitle});

  @override
  State<CoverSheetNephro> createState() => _CoverSheetNephroState();
}

class _CoverSheetNephroState extends State<CoverSheetNephro> {
  @override
  Widget build(BuildContext context) {
    final NephroController nephroController = Get.find<NephroController>();

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
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
                    const SizedBox(width: 12),
                    const Text(
                      "Pre-Post-Event Investigation",
                      style: TextStyle(
                          fontSize: 14.0,
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
                          RoundedCornerTable(
                            l1: widget.coverSheetNephro?.prePostEventInvList?.length !=
                                null
                                ? List.generate(
                              widget.coverSheetNephro!
                                  .prePostEventInvList!.length,
                                  (index) => (index + 1).toString(),
                            )
                                : [],
                            l2: widget.coverSheetNephro?.prePostEventInvList
                                ?.map((e) => e.dialysisName)
                                .toList() ??
                                [],
                            l3: widget.coverSheetNephro?.prePostEventInvList
                                ?.map((e) => e.createdDate)
                                .toList() ??
                                [],
                            tableHeader: const [
                              "Sr. No",
                              "Particulars",
                              "Date",
                              "Report"
                            ],
                            lastColumnWidgets:
                            widget.coverSheetNephro?.prePostEventInvList != null
                                ? List.generate(
                              widget.coverSheetNephro!
                                  .prePostEventInvList!.length,
                                  (index) =>
                                  CustomButtonWithoutIcon(
                                    buttonText: 'View Report',
                                    callB: () {
                                      handleButtonPress(
                                          index); // Pass the index here
                                    },
                                    buttonWidth: 70,
                                    primColor:
                                    AppColor.primaryBackgroundColor,
                                    secColor: AppColor.secondaryColor,
                                    textColor: Colors.white,
                                  ),
                            )
                                : [],
                            onButtonPressed: handleButtonPress,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )).paddingSymmetric(horizontal: 10, vertical: 2),
          const SizedBox(
            height: 10,
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
                    const SizedBox(width: 12),
                    const Text(
                      "Prescription Details",
                      style: TextStyle(
                          fontSize: 14.0,
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
                          RoundedCornerTable(
                            l1: nephroController.parsedPrescriptionData != []
                                ? nephroController.parsedPrescriptionData
                                .asMap()
                                .keys
                                .map((index) => (index + 1).toString())
                                .toList()
                                : [],
                            l2: nephroController.parsedPrescriptionData
                                .map((e) =>
                            e['medicineName'] == "null"
                                ? null
                                : e['medicineName'])
                                .toList(),
                            l3: nephroController.parsedPrescriptionData
                                .map((e) =>
                            e['frequency'] == "null"
                                ? null
                                : e['frequency'])
                                .toList(),
                            l4: nephroController.parsedPrescriptionData
                                .map((e) =>
                            e['days'] == "null"
                                ? null
                                : '${e['days']} Days')
                                .toList(),
                            tableHeader: const [
                              "Sr.No",
                              "Drugs",
                              "Frequency",
                              "Duration",
                              "Status"
                            ],
                            lastColumnWidgets: nephroController
                                .parsedPrescriptionData
                                .map((e) =>
                                statusChip(
                                    e['administered_status'] ?? 'Active'))
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )).paddingSymmetric(horizontal: 10, vertical: 2),
          const SizedBox(
            height: 10,
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
                    const SizedBox(width: 12),
                    const Text(
                      "Laboratory Investigation",
                      style: TextStyle(
                          fontSize: 14.0,
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
                          RoundedCornerTable(
                            l1: nephroController.parsedLabInvestData.isNotEmpty
                                ? nephroController.parsedLabInvestData
                                .asMap()
                                .keys
                                .map((index) => (index + 1).toString())
                                .toList()
                                : [],
                            l2: nephroController.parsedLabInvestData
                                .map((e) => e['categoryName'] ?? 'N/A')
                                .toList(),
                            l3: nephroController.parsedLabInvestData
                                .map((e) =>
                            e['createdDate']
                                ?.split(' ')
                                ?.first ??
                                'N/A')
                                .toList(),
                            l4: nephroController.parsedLabInvestData
                                .map((e) =>
                            e['createdDate']
                                ?.split(' ')
                                ?.last ?? 'N/A')
                                .toList(),
                            tableHeader: const [
                              "Sr. No",
                              "Particulars",
                              "Date",
                              "Time"
                            ],
                            lastColumnWidgets: nephroController
                                .parsedLabInvestData
                                .map((e) =>
                                CustomText(
                                  text:
                                  e['createdDate']
                                      ?.split(' ')
                                      ?.last ??
                                      'N/A',
                                  fontSize: 14,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start,
                                ))
                                .toList(),
                            onButtonPressed: (index) {
                              debugPrint('Button pressed at index $index');
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )).paddingSymmetric(horizontal: 10, vertical: 2),
          const SizedBox(
            height: 10,
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
                    const SizedBox(width: 12),
                    const Text(
                      "Diet Details",
                      style: TextStyle(
                          fontSize: 14.0,
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
                          RoundedCornerTable(
                            l1: nephroController.coverSheetNephro?.dietList !=
                                null &&
                                nephroController
                                    .coverSheetNephro!.dietList!.isNotEmpty
                                ? nephroController.coverSheetNephro!.dietList!
                                .asMap()
                                .keys
                                .map((index) => (index + 1).toString())
                                .toList()
                                : [],
                            l2: nephroController.coverSheetNephro?.dietList
                                ?.map((diet) => diet.templateName ?? 'N/A')
                                .toList() ??
                                [],
                            l3: nephroController.coverSheetNephro?.dietList
                                ?.map((diet) =>
                            '${diet
                                .fromDate}') // You can format the date range here
                                .toList() ??
                                [],
                            tableHeader: const [
                              "Sr. No",
                              "Particulars",
                              "To Date",
                              "From Date"
                            ],
                            lastColumnWidgets:
                            nephroController.coverSheetNephro?.dietList
                                ?.map((diet) =>
                                CustomText(
                                  text: diet.toDate ?? 'N/A',
                                  fontSize: 14,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start,
                                ))
                                .toList() ??
                                [],
                            onButtonPressed: handleButtonPress,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )).paddingSymmetric(horizontal: 10, vertical: 2),
          const SizedBox(
            height: 10,
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
                    const SizedBox(width: 12),
                    const Text(
                      "Trend Analysis",
                      style: TextStyle(
                          fontSize: 14.0,
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
                          RoundedCornerTable(
                            l1: List.generate(
                                5, (index) => (index + 1).toString()),
                            l2: const [
                              'Weight',
                              'Pulse',
                              'Oxygen Level',
                              'Temperature',
                              'Blood Pressure',
                            ],
                            tableHeader: const [
                              "Sr. No",
                              "Test Name",
                              "Trend Analysis",
                            ],
                            lastColumnWidgets: [
                              CustomButtonWithoutIcon(
                                buttonText: 'Analyze',
                                callB: () {
                                  debugPrint('Tapped1');

                                  Get.to(() =>
                                      TrendAnalysisTabsWeight(
                                        weight: nephroController
                                            .coverSheetNephro
                                            ?.weightTrendAnalysisList,
                                      ));
                                },
                                buttonWidth: 70,
                                primColor: AppColor.primaryBackgroundColor,
                                secColor: AppColor.secondaryColor,
                                textColor: Colors.white,
                              ),
                              CustomButtonWithoutIcon(
                                buttonText: 'Analyze',
                                callB: () {
                                  debugPrint('Tapped2');

                                  Get.to(() =>
                                      TrendAnalysisTabsPulse(
                                        pulse: nephroController.coverSheetNephro
                                            ?.pulseTrendAnalysisList,
                                      ));
                                },
                                buttonWidth: 70,
                                primColor: AppColor.primaryBackgroundColor,
                                secColor: AppColor.secondaryColor,
                                textColor: Colors.white,
                              ),
                              CustomButtonWithoutIcon(
                                buttonText: 'Analyze',
                                callB: () {
                                  debugPrint('Tapped3');
                                  Get.to(() =>
                                      TrendAnalysisTabsOxygen(
                                        oxygen: nephroController
                                            .coverSheetNephro
                                            ?.oxygenLevelTrendAnalysisList,
                                      ));
                                },
                                buttonWidth: 70,
                                primColor: AppColor.primaryBackgroundColor,
                                secColor: AppColor.secondaryColor,
                                textColor: Colors.white,
                              ),
                              CustomButtonWithoutIcon(
                                buttonText: 'Analyze',
                                callB: () {
                                  debugPrint('Tapped4');
                                  Get.to(() =>
                                      TrendAnalysisTabsTemp(
                                        temp: nephroController.coverSheetNephro
                                            ?.temperatureTrendAnalysisList,
                                      ));
                                },
                                buttonWidth: 70,
                                primColor: AppColor.primaryBackgroundColor,
                                secColor: AppColor.secondaryColor,
                                textColor: Colors.white,
                              ),
                              CustomButtonWithoutIcon(
                                buttonText: 'Analyze',
                                callB: () {
                                  debugPrint('Tapped5');

                                  Get.to(() =>
                                      TabularAnalysisBlood(
                                        blooad: nephroController
                                            .coverSheetNephro
                                            ?.bloodPressureTrendAnalysisList,
                                      ));
                                },
                                buttonWidth: 70,
                                primColor: AppColor.primaryBackgroundColor,
                                secColor: AppColor.secondaryColor,
                                textColor: Colors.white,
                              ),
                            ],
                            onButtonPressed: handleButtonPress,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )).paddingSymmetric(horizontal: 10, vertical: 2),
          const SizedBox(
            height: 10,
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
                    const SizedBox(width: 12),
                    const Text(
                      "Clinical History",
                      style: TextStyle(
                          fontSize: 14.0,
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
                          RoundedCornerTable(
                            l1: nephroController.clinicalHistoryList != null &&
                                nephroController
                                    .clinicalHistoryList!.isNotEmpty
                                ? nephroController.clinicalHistoryList!
                                .asMap()
                                .keys
                                .map((index) => (index + 1).toString())
                                .toList()
                                : [],
                            // l2: nephroController.clinicalHistoryList
                            //         ?.map((e) => getDate(e.createdDatetime ?? e.updatedDateTime))
                            //         .toList() ??
                            //     [],
                            l2: nephroController.clinicalHistoryList
                                ?.map((e) =>
                            e.createdDatetime ?? e.updatedDateTime)
                                .toList() ??
                                [],
                            tableHeader: const [
                              "Sr. No",
                              "Clinical History Date",
                              "Action",
                            ],
                            lastColumnWidgets: List.generate(
                              nephroController.clinicalHistoryList?.length ?? 0,
                                  (index) =>
                                  CustomButtonWithoutIcon(
                                    buttonText: 'Clinical History',
                                    callB: () {
                                      debugPrint('Tapped row $index');
                                      Get.to(Scaffold(
                                          appBar: AppBar(
                                            title: const CustomText(
                                              text: 'Clinical History',
                                              fontSize: 18.0,
                                              fontFam: 'Lato',
                                              fontWeight: FontWeight.w400,
                                              textColor: Colors.black,
                                              textAlign: TextAlign.start,
                                            ),
                                            leading: InkWell(
                                                onTap: () {
                                                  Get.off(EditNephroDesk(
                                                    patientData: widget.patientData,
                                                    appBarTitle:widget.appbarTitle,
                                                  ));
                                                },
                                                child: Image.asset(
                                                    'assets/arrow-left.png')),
                                          ),
                                          body: ClinicalHistory(
                                            isView: true,
                                            patientData: widget.patientData,
                                            clinicalHistoryItem: nephroController
                                                .clinicalHistoryList?[index],
                                          )));
                                    },
                                    buttonWidth: 70,
                                    primColor: AppColor.primaryBackgroundColor,
                                    secColor: AppColor.secondaryColor,
                                    textColor: Colors.white,
                                  ),
                            ),
                            onButtonPressed: handleButtonPress,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )).paddingSymmetric(horizontal: 10, vertical: 2),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void handleButtonPress(int index) {
    // Access the specific item from prePostEventInvList
    final tappedItem = widget.coverSheetNephro!.prePostEventInvList![index];

    // Perform any action based on the tapped index
    debugPrint('Button tapped for item: ${tappedItem.dialysisName}');
    debugPrint('Patient ID: ${tappedItem.patientId}');
  }

  Widget statusChip(status) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.green[100], borderRadius: BorderRadius.circular(4)),
      child: CustomText(
        text: status,
        fontSize: 12,
        fontFam: 'Lato',
        fontWeight: FontWeight.w400,
        textColor: Colors.green,
        textAlign: TextAlign.center,
      ),
    );
  }

  getDate(String? dateTimeString) {
    if (dateTimeString != null && dateTimeString.isNotEmpty) {
      DateTime dateTime =
      DateFormat("MMM d, yyyy h:mm:ss a").parse(dateTimeString);

      // Format to just date
      String formattedDate = DateFormat("MMM d, yyyy").format(dateTime);

      debugPrint(formattedDate);
      return formattedDate;
    } else {
      return '';
    }
  }
}
