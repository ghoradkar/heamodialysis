import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/tabular_analysis_blood.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/trend_analysis_tabs_oxygen.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/trend_analysis_tabs_pulse.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/trend_analysis_tabs_temp.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/trend_analysis_tabs_weight.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/edit_nephro_desk.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/clinical_history.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/clinical_history.dart';
import 'package:heamodialysis/schedular/controller/schedular_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_table.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

import '../../../../widgets/custom_expandable.dart';

class Coversheet extends StatefulWidget {
  // final Function callB;
  // final List<IdProofData> idProofListModel;
  // final List<ViralData> viralStatusList;
  final int? patientId;
  final int? treatmentId;

  const Coversheet({
    super.key,
    this.patientId,
    this.treatmentId,
  });

  @override
  State<Coversheet> createState() => CoversheetState();
}

class CoversheetState extends State<Coversheet> {
  var userData;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  final SchedularController schedularController =
      Get.put(SchedularController());

  final NephroController nephroController = Get.put(NephroController());

  handleButtonPress(int index) {
    // Perform action based on the index
    if (index == 0) {
      debugPrint('Button pressed at index: $index');
    } else if (index == 1) {
      debugPrint('Button pressed at index: $index');
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint(userData['user_ID'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<SchedularController>(builder: (controller) {
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            //
            CustomExpandableContainer(
              leading: 'assets/file-info.png',
              text: context.l10n.dqPrePostEventInvestigation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RoundedCornerTable(
                        l1: schedularController.prePostCoversheetl1,
                        l2: schedularController.prePostCoversheetl2,
                        l3: schedularController.prePostCoversheetl3,
                        tableHeader: [
                          context.l10n.colSrNo,
                          context.l10n.colParticulars,
                          context.l10n.commonDate,
                          context.l10n.colReport
                        ],
                        lastColumnWidgets: schedularController
                            .prePostCoversheetlastColumnWidgets,
                        onButtonPressed: handleButtonPress,
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Theme(
            //     data: ThemeData().copyWith(dividerColor: Colors.transparent),
            //     child: Container(
            //       decoration: BoxDecoration(
            //           color: AppColor.darkBlue,
            //           borderRadius: BorderRadius.circular(10)),
            //       child: ExpansionTile(
            //         maintainState: true,
            //         collapsedIconColor: Colors.white,
            //         iconColor: Colors.white,
            //         title: Row(children: [
            //           Image.asset("assets/file-info.png"),
            //           const SizedBox(width: 12),
            //           Text(
            //             "Pre-Post-Event Investigation",
            //             style: TextStyle(
            //                 fontSize: 14.0,
            //                 color: Colors.white,
            //                 fontFamily: 'Lato'),
            //           ),
            //         ]),
            //         children: <Widget>[
            //           Container(
            //             padding: const EdgeInsets.all(8),
            //             decoration: BoxDecoration(
            //                 color: Colors.grey[50],
            //                 borderRadius: BorderRadius.circular(10),
            //                 border: Border.all(color: AppColor.borderColor)),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.stretch,
            //               children: [
            //                 RoundedCornerTable(
            //                   l1: schedularController.prePostCoversheetl1,
            //                   l2: schedularController.prePostCoversheetl2,
            //                   l3: schedularController.prePostCoversheetl3,
            //                   tableHeader: const [
            //                     "Sr.\nNo",
            //                     "Particulars\n",
            //                     "Date\n",
            //                     "Report\n"
            //                   ],
            //                   lastColumnWidgets: schedularController
            //                       .prePostCoversheetlastColumnWidgets,
            //                   onButtonPressed: handleButtonPress,
            //                 )
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     )),
            SizedBox(
              height: 10,
            ),
            CustomExpandableContainer(
              leading: 'assets/relation.png',
              text: context.l10n.dqPrescriptionDetails,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.borderColor)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        schedularController.coversheetPrescriptionDet
                            ?.listOPDPrescriptionDtoSP !=
                            null
                            ? RoundedCornerTable(
                          l1: schedularController
                              .prescriptionCoversheetl1,
                          l2: schedularController
                              .prescriptionCoversheetl2,
                          l3: schedularController
                              .prescriptionCoversheetl3,
                          l4: schedularController
                              .prescriptionCoversheetl4,
                          l5: schedularController
                              .prescriptionCoversheetl1
                              .map((e) => 'Active')
                              .toList(),
                          tableHeader: [
                            context.l10n.colSrNo,
                            context.l10n.colDrugs,
                            context.l10n.colFreq,
                            context.l10n.dqDuration,
                            context.l10n.commonStatus,
                            context.l10n.colReport
                          ],
                          lastColumnWidgets: schedularController
                              .prescriptionlastColumnWidgets,
                          onButtonPressed: handleButtonPress,
                        )
                            : CustomText(
                          text: context.l10n.commonNoDataFound,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            CustomExpandableContainer(
              leading: 'assets/file-info.png',
              text: context.l10n.dqLaboratoryInvestigation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          l1: schedularController.labCoversheetl1,
                          l2: schedularController.labCoversheetl2,
                          l3: schedularController.labCoversheetl3,
                          l4: schedularController.labCoversheetl4,
                          tableHeader: [
                            context.l10n.colSrNo,
                            context.l10n.colParticulars,
                            context.l10n.commonDate,
                            context.l10n.colPackageName,
                            context.l10n.commonView
                          ],
                          lastColumnWidgets: schedularController.lablastColumnWidgets,
                          onButtonPressed: handleButtonPress,
                        )

                        // schedularController.labInvestigationCoversheet !=
                        //         null
                        //     ? PrescriptionTableData(
                        //         l1: schedularController.labCoversheetl1,
                        //         l2: schedularController.labCoversheetl2,
                        //         l3: schedularController.labCoversheetl3,
                        //         l4: schedularController.labCoversheetl4,
                        //         lastColumnWidgets: List.generate(
                        //           schedularController
                        //                   .labInvestigationCoversheet
                        //                   ?.length ??
                        //               0,
                        //           (index) => (schedularController
                        //                           .labInvestigationCoversheet?[
                        //                               index]
                        //                           .testReportLink !=
                        //                       null &&
                        //                   schedularController
                        //                       .labInvestigationCoversheet![
                        //                           index]
                        //                       .testReportLink!
                        //                       .isNotEmpty)
                        //               ? CustomButtonWithoutIcon(
                        //                   buttonText: context.l10n.commonView,
                        //                   callB: () {
                        //                     debugPrint('Tapped row $index');
                        //                     // Get.to();
                        //                   },
                        //                   buttonWidth: 70,
                        //                   primColor: AppColor
                        //                       .primaryBackgroundColor,
                        //                   secColor: AppColor.secondaryColor,
                        //                   textColor: Colors.white,
                        //                 )
                        //               : CustomText(
                        //                   text: context.l10n.commonProcessing,
                        //                   fontSize: 8,
                        //                   fontWeight: FontWeight.normal,
                        //                   textColor: Colors.black,
                        //                   textAlign: TextAlign.center),
                        //         ),
                        //         tableHeader: const [
                        //           "Sr. No",
                        //           "Particulars\n",
                        //           "Date\n",
                        //           "Packg Name",
                        //           "View"
                        //         ],
                        //         onButtonPressed: handleButtonPress,
                        //       )
                        //     : CustomText(
                        //         text: context.l10n.commonNoDataFound,
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w500,
                        //         textColor: Colors.black,
                        //         textAlign: TextAlign.center,
                        //       )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            CustomExpandableContainer(
              leading: 'assets/file-info.png',
              text: context.l10n.dqDietDetails,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        schedularController.dietDetailsCoversheet
                            ?.getListOfOPDDietDTO !=
                            null
                            ? RoundedCornerTable(
                          l1: schedularController.dietCoversheetl1,
                          l2: schedularController.dietCoversheetl2,
                          l3: schedularController.dietCoversheetl3,
                          l4: schedularController.dietCoversheetl4,
                          tableHeader: [context.l10n.colSrNo, context.l10n.colParticulars, context.l10n.dashFromDate, context.l10n.dashToDate],
                          onButtonPressed: handleButtonPress,
                        )
                            : CustomText(
                          text: context.l10n.commonNoDataFound,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.black,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            GetBuilder<NephroController>(builder: (controller) {

              return CustomExpandableContainer(
                leading: 'assets/file-info.png',
                text: context.l10n.dqTrendAnalysis,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            l1: const ['1', '2', '3', '4', '5'],
                            l2: const [
                              'Weight',
                              'Pulse',
                              'Oxygen Level',
                              'Temp',
                              'Blood Pressure'
                            ],
                            l3: const ['', '', '', '', ''],
                            tableHeader: [context.l10n.colSrNo, context.l10n.dqTestName, context.l10n.dqTrendAnalysis],
                            lastColumnWidgets: [
                              CustomButtonWithoutIcon(
                                buttonText: context.l10n.dqAnalyze,
                                callB: () {
                                  debugPrint('Tapped1');
                                  Get.to(() => TrendAnalysisTabsWeight(
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
                                buttonText: context.l10n.dqAnalyze,
                                callB: () {
                                  debugPrint('Tapped2');
                                  Get.to(TrendAnalysisTabsPulse(
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
                                buttonText: context.l10n.dqAnalyze,
                                callB: () {
                                  debugPrint('Tapped3');
                                  Get.to(TrendAnalysisTabsOxygen(
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
                                buttonText: context.l10n.dqAnalyze,
                                callB: () {
                                  debugPrint('Tapped4');
                                  Get.to(TrendAnalysisTabsTemp(
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
                                buttonText: context.l10n.dqAnalyze,
                                callB: () {
                                  debugPrint('Tapped5');

                                  Get.to(() => TabularAnalysisBlood(
                                    blooad: nephroController
                                        .coverSheetNephro
                                        ?.bloodPressureTrendAnalysisList,
                                  ));
                                },
                                buttonWidth: 70,
                                primColor: AppColor.primaryBackgroundColor,
                                secColor: AppColor.secondaryColor,
                                textColor: Colors.white,
                              )
                            ],
                            onButtonPressed: handleButtonPress,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
                // Theme(
                //   data: ThemeData().copyWith(dividerColor: Colors.transparent),
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: AppColor.darkBlue,
                //         borderRadius: BorderRadius.circular(10)),
                //     child: ExpansionTile(
                //       maintainState: true,
                //       collapsedIconColor: Colors.white,
                //       iconColor: Colors.white,
                //       title: Row(children: [
                //         Image.asset("assets/file-info.png"),
                //         const SizedBox(width: 12),
                //         Text(
                //           "Trend Analysis",
                //           style: TextStyle(
                //               fontSize: 14.0,
                //               color: Colors.white,
                //               fontFamily: 'Lato'),
                //         ),
                //       ]),
                //       children: <Widget>[
                //         Container(
                //           padding: const EdgeInsets.all(8),
                //           decoration: BoxDecoration(
                //               color: Colors.grey[50],
                //               borderRadius: BorderRadius.circular(10),
                //               border: Border.all(color: AppColor.borderColor)),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.stretch,
                //             children: [
                //               RoundedCornerTable(
                //                 l1: const ['1', '2', '3', '4', '5'],
                //                 l2: const [
                //                   'Weight',
                //                   'Pulse',
                //                   'Oxygen Level',
                //                   'Temp',
                //                   'Blood Pressure'
                //                 ],
                //                 l3: const ['', '', '', '', ''],
                //                 tableHeader: const [
                //                   "Sr. No",
                //                   "Test Name",
                //                   "Trend Analysis",
                //                 ],
                //                 lastColumnWidgets: [
                //                   CustomButtonWithoutIcon(
                //                     buttonText: context.l10n.dqAnalyze,
                //                     callB: () {
                //                       debugPrint('Tapped1');
                //                       Get.to(() => TrendAnalysisTabsWeight(
                //                             weight: nephroController
                //                                 .coverSheetNephro
                //                                 ?.weightTrendAnalysisList,
                //                           ));
                //                     },
                //                     buttonWidth: 70,
                //                     primColor: AppColor.primaryBackgroundColor,
                //                     secColor: AppColor.secondaryColor,
                //                     textColor: Colors.white,
                //                   ),
                //                   CustomButtonWithoutIcon(
                //                     buttonText: context.l10n.dqAnalyze,
                //                     callB: () {
                //                       debugPrint('Tapped2');
                //                       Get.to(TrendAnalysisTabsPulse(
                //                         pulse: nephroController.coverSheetNephro
                //                             ?.pulseTrendAnalysisList,
                //                       ));
                //                     },
                //                     buttonWidth: 70,
                //                     primColor: AppColor.primaryBackgroundColor,
                //                     secColor: AppColor.secondaryColor,
                //                     textColor: Colors.white,
                //                   ),
                //                   CustomButtonWithoutIcon(
                //                     buttonText: context.l10n.dqAnalyze,
                //                     callB: () {
                //                       debugPrint('Tapped3');
                //                       Get.to(TrendAnalysisTabsOxygen(
                //                         oxygen: nephroController
                //                             .coverSheetNephro
                //                             ?.oxygenLevelTrendAnalysisList,
                //                       ));
                //                     },
                //                     buttonWidth: 70,
                //                     primColor: AppColor.primaryBackgroundColor,
                //                     secColor: AppColor.secondaryColor,
                //                     textColor: Colors.white,
                //                   ),
                //                   CustomButtonWithoutIcon(
                //                     buttonText: context.l10n.dqAnalyze,
                //                     callB: () {
                //                       debugPrint('Tapped4');
                //                       Get.to(TrendAnalysisTabsTemp(
                //                         temp: nephroController.coverSheetNephro
                //                             ?.temperatureTrendAnalysisList,
                //                       ));
                //                     },
                //                     buttonWidth: 70,
                //                     primColor: AppColor.primaryBackgroundColor,
                //                     secColor: AppColor.secondaryColor,
                //                     textColor: Colors.white,
                //                   ),
                //                   CustomButtonWithoutIcon(
                //                     buttonText: context.l10n.dqAnalyze,
                //                     callB: () {
                //                       debugPrint('Tapped5');
                //
                //                       Get.to(() => TabularAnalysisBlood(
                //                             blooad: nephroController
                //                                 .coverSheetNephro
                //                                 ?.bloodPressureTrendAnalysisList,
                //                           ));
                //                     },
                //                     buttonWidth: 70,
                //                     primColor: AppColor.primaryBackgroundColor,
                //                     secColor: AppColor.secondaryColor,
                //                     textColor: Colors.white,
                //                   )
                //                 ],
                //                 onButtonPressed: handleButtonPress,
                //               )
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ));
            }),
            SizedBox(
              height: 10,
            ),
            CustomExpandableContainer(
              leading: 'assets/file-info.png',
              text: context.l10n.dqClinicalHistory,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          l1: nephroController.clinicalHistoryList !=
                              null &&
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
                          e.createdDatetime ??
                              e.updatedDateTime)
                              .toList() ??
                              [],
                          tableHeader: [context.l10n.colSrNo, context.l10n.colClinicalHistoryDate, context.l10n.nephroAction],
                          lastColumnWidgets: List.generate(
                            nephroController.clinicalHistoryList?.length ??
                                0,
                                (index) => CustomButtonWithoutIcon(
                              buttonText: context.l10n.dqClinicalHistory,
                              callB: () {
                                NephroList p = NephroList(
                                    patientId: widget.patientId,
                                    treatmentId: widget.treatmentId);
                                debugPrint('Tapped row $index');
                                Get.to(Scaffold(
                                    appBar: AppBar(
                                      title: CustomText(
                                        text: context.l10n.dqClinicalHistory,
                                        fontSize: 18.0,
                                        fontFam: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start,
                                      ),
                                      leading: InkWell(
                                          onTap: () {
                                            // Get.off(EditNephroDesk(
                                            //   patientData: p,
                                            //   appBarTitle:
                                            //       "Patient Clinical History",
                                            // ));
                                            Get.back();
                                          },
                                          child: Image.asset(
                                              'assets/arrow-left.png')),
                                    ),
                                    body: ClinicalHistory(
                                      isView: true,
                                      patientData: p,
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
            ),
            SizedBox(
              height: 10,
            ),
            CustomExpandableContainer(
              leading: 'assets/file-info.png',
              text: context.l10n.regUploadDocument,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        schedularController.uploadDocCoversheetl1.isNotEmpty
                            ? RoundedCornerTable(
                          l1: schedularController
                              .uploadDocCoversheetl1,
                          l2: schedularController
                              .uploadDocCoversheetl2,
                          l3: schedularController
                              .uploadDocCoversheetl3,
                          tableHeader: [
                            context.l10n.colSrNo,
                            context.l10n.commonDocument,
                            context.l10n.commonDate,
                            context.l10n.commonView
                          ],
                          lastColumnWidgets: schedularController
                              .uploadDocCoversheetlastColumnWidgets,
                          onButtonPressed: handleButtonPress,
                        )
                            : CustomText(
                          text: context.l10n.commonNoDataFound,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.black,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            CustomExpandableContainer(
              leading: 'assets/file-info.png',
              text: context.l10n.dqInstructionDetails,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        schedularController
                            .instructionCoversheetl1.isNotEmpty
                            ? PrescriptionTableData(
                          l1: schedularController
                              .instructionCoversheetl1,
                          l2: schedularController
                              .instructionCoversheetl2,
                          tableHeader: [
                            context.l10n.colSrNo,
                            context.l10n.colInstructionName,
                          ],
                          onButtonPressed: handleButtonPress,
                        )
                            : CustomText(
                          text: context.l10n.commonNoDataFound,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.black,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),



            GetBuilder<NephroController>(builder: (controller) {
              return CustomExpandableContainer(
                  leading: 'assets/file-info.png',
                  text: context.l10n.dqClinicalCondition,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            nephroController.clinicalConditionL1.isNotEmpty
                                ? PrescriptionTableData(
                              l1: nephroController.clinicalConditionL1,
                              l2: nephroController.clinicalConditionL2,
                              l3: nephroController.clinicalConditionL3,
                              l4: nephroController.clinicalConditionL4,
                              tableHeader: [
                                context.l10n.colSrNo,
                                context.l10n.nephroDiagnosisType,
                                context.l10n.commonDate,
                                context.l10n.colType
                              ],
                              onButtonPressed: handleButtonPress,
                            )
                                : CustomText(
                              text: context.l10n.commonNoDataFound,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textColor: Colors.black,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
            }),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      }),
    );
  }

  Widget statusChip() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.green[100], borderRadius: BorderRadius.circular(4)),
      child: CustomText(
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
