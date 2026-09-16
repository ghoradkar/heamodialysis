import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/coversheet.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/graphical_analysis_weight.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/tabular_analysis_weight.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/cover_sheet_nephro.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/expandable_card.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../../../nephro_desk_patient_list/controller/nephro_controller.dart';
import '../../../../widgets/custom_shimmer_loader.dart';
import '../../../../widgets/custom_tabs_widget.dart';

class TrendAnalysisTabsWeight extends StatefulWidget {
  final List<WeightTrendAnalysisList>? weight;
  const TrendAnalysisTabsWeight({super.key, this.weight});

  @override
  State<TrendAnalysisTabsWeight> createState() =>
      _TrendAnalysisTabsWeightState();
}

class _TrendAnalysisTabsWeightState extends State<TrendAnalysisTabsWeight>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  final NephroController nephroController = Get.find<NephroController>();
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;




  late TabController tabController;

  final NewRegistrationController newRegistrationController =
  Get.put(NewRegistrationController());
  bool hasInternet = true;
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    checkInternetAndLoadData();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      // setState(() {}); // Update the UI when the tab changes
      newRegistrationController.refreshUi();
    });
    super.initState();
  }



  Future<void> _initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  // Update connection status handler
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final isConnected = results.any(
          (result) =>
      result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi,
    );

    setState(() {
      _isNetworkAvailable = isConnected;
    });
  }




  @override
  void dispose() {
    tabController.dispose();
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    newRegistrationController.refreshUi();
    if (hasInternet) {}
  }

  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable ?  Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: context.l10n.dqTrendAnalysis,
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
      body: GetBuilder<NewRegistrationController>(
          init: NewRegistrationController(),
          builder: (controller) {
            return controller.isLoading
                ? Center(child: TrendAnalysisShimmer())
                : Column(
              children: [
                ExpandableCardDetails(
                  patientData: nephroController.patientDet?.first,
                  isExpand: (value) {
                    isExpanded = value;
                    setState(() {});
                  },
                  isExpanded: isExpanded,
                  currentStat: nephroController.currentStat,
                ).paddingSymmetric(vertical: 10.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     // buildButton(currentPage: 1, 0, 'Cover Sheet'),
                //     buildButton(index: 0, currentPage: currentPage, text: context.l10n.dqCoverSheet,onTap: () => changeTab(0)),
                //      buildButton(index: 1, currentPage: currentPage, text: context.l10n.dqClinicalHistory,onTap: () => changeTab(1)),
                //      buildButton(index: 2, currentPage: currentPage, text: context.l10n.dqClinicalCondition,onTap: () => changeTab(2)),
                //      buildButton(index: 3, currentPage: currentPage, text: context.l10n.dqDiagnosticInv,onTap: () => changeTab(3)),
                //
                //   ],
                // ),
                // SizedBox(height: 8.h),
                // // Second row of buttons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     // buildButton(currentPage: 1, 0, 'Cover Sheet'),
                //     buildButton(index: 4, currentPage: currentPage, text: context.l10n.dqPrescription,onTap: () => changeTab(4),),
                //     buildButton(index: 5, currentPage: currentPage, text: context.l10n.dqInstruction,onTap: () => changeTab(5)),
                //     buildButton(index: 6, currentPage: currentPage, text: context.l10n.dqDiet,onTap: () => changeTab(6)),
                //     buildButton(index: 7, currentPage: currentPage, text: context.l10n.regUploadDocument,onTap: () => changeTab(7)),
                //   ],
                // ),
                // Expanded(
                //   child: PageView(
                //     controller: pageController,
                //     onPageChanged: (int pageIndex) {
                //       setState(() {
                //         currentPage =
                //             pageIndex; // Update the current page on swipe
                //       });
                //     },
                //     children: [
                //       // CoverSheetNephro(
                //       //   coverSheetNephro: nephroController.coverSheetNephro,
                //       //   patientData: widget.patientData,
                //       //   appbarTitle: widget.appBarTitle,
                //       // ),
                //       Coversheet(
                //         patientId: widget.patientData?.patientId,
                //         treatmentId: widget.patientData?.treatmentId,
                //       ),
                //       ClinicalHistory(
                //         patientData: widget.patientData,
                //       ),
                //       ClinicalCondition(
                //         patientData: widget.patientData,
                //       ),
                //       DiagnosticInv(
                //         packageList: nephroController.packageList,
                //         onAdd: () {},
                //         patientData: widget.patientData,
                //         choosePackageListModel:
                //         nephroController.choosePackageListModel,
                //       ),
                //       // LabInvestigation(choosePackageListModel: nephroController.choosePackageListModel,),
                //       Prescription(
                //         patientData: widget.patientData,
                //       ),
                //       Instructions(
                //         patientData: widget.patientData,
                //       ),
                //       DietScreen(
                //         patientData: widget.patientData,
                //       ),
                //       UploadDocument(patientData: widget.patientData),
                //     ],
                //   ),
                // ),
                SizedBox(height: 11.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     _buildButton(4, 'Prescription'),
                //     _buildButton(5, 'Instruction'),
                //     _buildButton(6, 'Diet'),
                //     _buildButton(7, 'Upload Document'),
                //   ],
                // ),
                TabBar(
                  controller: tabController,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    buildTab(0, "Tabular","assets/user_textfield.png"),
                    buildTab(1, "Graph","assets/graph.png"),

                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children:  [

                      TabularAnalysisWeight(weight: widget.weight,),
                       GraphicalAnalysisWeight(weight: widget.weight,),
                    ],
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 6);
          }),

    ) : InternetIssue(
      onRetryPressed: () async {
        final result = await _connectivity.checkConnectivity();
        _updateConnectionStatus(result);
      },
    );
  }
  void goToPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      currentPage = pageIndex;
    });
  }

  Widget buildTab(int index, String text,String path) {
    bool isSelected = tabController.index == index;
    return Container(
      width: 210,
      // height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 0.8, vertical: 17),
      decoration: BoxDecoration(
        // color: isSelected ? Colors.blue.shade200 : Colors.transparent,
          gradient: isSelected
              ? LinearGradient(
            colors: [
              AppColor.primaryBackgroundColor,
              AppColor.secondaryColor
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          )
              : const LinearGradient(
            colors: [
              Colors.transparent,
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
          borderRadius: setBorderRadiusIndexWise(index),
          border: Border.all(color: const Color(0xffE1E1E1))),
      // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(path,color: isSelected ? Colors.white:Colors.grey,),
          const SizedBox(width: 8,),
          CustomText(
            text: text,
            fontSize: 12.0,
            fontFam: 'Lato',
            fontWeight: FontWeight.w400,
            textColor: isSelected ? Colors.white : const Color(0xff777777),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  setBorderRadiusIndexWise(index) {
    if (index == 0) {
      return const BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
    } else if (index == 1) {
      // return BorderRadius.zero;
      return const BorderRadius.only(
          topRight: Radius.circular(10), bottomRight: Radius.circular(10));
    }

  }

  void changeTab(int index) {
    setState(() {
      currentPage = index;
    });

    if (index < tabController.length) {
      tabController.animateTo(index);
    }
  }

}
