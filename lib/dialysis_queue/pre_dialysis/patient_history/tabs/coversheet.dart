import 'package:flutter/material.dart';
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
            const SizedBox(
              height: 20,
            ),
            //
            CustomExpandableContainer(
              leading: 'assets/file-info.png',
              text: 'Pre-Post-Event Investigation',
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
                        tableHeader: const [
                          "Sr.\nNo",
                          "Particulars\n",
                          "Date\n",
                          "Report\n"
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
            //           const Text(
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
            const SizedBox(
              height: 10,
            ),
            CustomExpandableContainer(
              leading: 'assets/relation.png',
              text: 'Prescription Details',
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
                          tableHeader: const [
                            "Sr.\nNo",
                            "Drugs\n",
                            "Freq\n",
                            "Duration\n",
                            "Status\n",
                            "Report\n"
                          ],
                          lastColumnWidgets: schedularController
                              .prescriptionlastColumnWidgets,
                          onButtonPressed: handleButtonPress,
                        )
                            : const CustomText(
                          text: "No Data found",
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

            const SizedBox(
              height: 10,
            ),
            CustomExpandableContainer(
              leading: 'assets/file-info.png',
              text: 'Laboratory Investigation',
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
                          tableHeader: const [
                            "Sr. No",
                            "Particulars\n",
                            "Date\n",
                            "Packg Name",
                            "View\n"
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
                        //                   buttonText: 'View',
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
                        //               : const CustomText(
                        //                   text: "Processing",
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
                        //     : const CustomText(
                        //         text: "No Data found",
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

            const SizedBox(
              height: 10,
            ),
            CustomExpandableContainer(
              leading: 'assets/file-info.png',
              text: 'Diet Details',
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
                          tableHeader: const [
                            "Sr. No",
                            "Particulars",
                            "From Date",
                            "To Date"
                          ],
                          onButtonPressed: handleButtonPress,
                        )
                            : const CustomText(
                          text: "No Data found",
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

            const SizedBox(
              height: 10,
            ),

            GetBuilder<NephroController>(builder: (controller) {

              return CustomExpandableContainer(
                leading: 'assets/file-info.png',
                text: 'Trend Analysis',
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
                                buttonText: 'Analyze',
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
                                buttonText: 'Analyze',
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
                                buttonText: 'Analyze',
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
                                buttonText: 'Analyze',
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
                //         const Text(
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
                //                     buttonText: 'Analyze',
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
                //                     buttonText: 'Analyze',
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
                //                     buttonText: 'Analyze',
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
                //                     buttonText: 'Analyze',
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
                //                     buttonText: 'Analyze',
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
            const SizedBox(
              height: 10,
            ),
            CustomExpandableContainer(
              leading: 'assets/file-info.png',
              text: 'Clinical History',
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
                          tableHeader: const [
                            "Sr.No",
                            "Clinical History Date",
                            "Action",
                          ],
                          lastColumnWidgets: List.generate(
                            nephroController.clinicalHistoryList?.length ??
                                0,
                                (index) => CustomButtonWithoutIcon(
                              buttonText: 'Clinical History',
                              callB: () {
                                NephroList p = NephroList(
                                    patientId: widget.patientId,
                                    treatmentId: widget.treatmentId);
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
            const SizedBox(
              height: 10,
            ),
            CustomExpandableContainer(
              leading: 'assets/file-info.png',
              text: 'Upload Document',
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
                          tableHeader: const [
                            "Sr. No",
                            "Document\n",
                            "Date\n",
                            "View\n"
                          ],
                          lastColumnWidgets: schedularController
                              .uploadDocCoversheetlastColumnWidgets,
                          onButtonPressed: handleButtonPress,
                        )
                            : const CustomText(
                          text: "No Data found",
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
            const SizedBox(
              height: 10,
            ),

            CustomExpandableContainer(
              leading: 'assets/file-info.png',
              text: 'Instruction Details',
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
                          tableHeader: const [
                            "Sr.\nNo",
                            "Instruction\nName",
                          ],
                          onButtonPressed: handleButtonPress,
                        )
                            : const CustomText(
                          text: "No Data found",
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
            const SizedBox(
              height: 10,
            ),



            GetBuilder<NephroController>(builder: (controller) {
              return CustomExpandableContainer(
                  leading: 'assets/file-info.png',
                  text: 'Clinical Condition',
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
                              tableHeader: const [
                                "Sr.\nNo",
                                "Diagnosis\nType",
                                "Date\n",
                                "Type\n"
                              ],
                              onButtonPressed: handleButtonPress,
                            )
                                : const CustomText(
                              text: "No Data found",
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
