import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/graphical_analysis_pulse.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/tabular_analysis_pulse.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/cover_sheet_nephro.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/expandable_card.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../../../nephro_desk_patient_list/controller/nephro_controller.dart';
import '../../../../widgets/custom_shimmer_loader.dart';

class TrendAnalysisTabsPulse extends StatefulWidget {
  final List<PulseTrendAnalysisList>? pulse;
  const TrendAnalysisTabsPulse({super.key, this.pulse});

  @override
  State<TrendAnalysisTabsPulse> createState() =>
      _TrendAnalysisTabsPulseState();
}

class _TrendAnalysisTabsPulseState extends State<TrendAnalysisTabsPulse>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isExpanded = false;
  final NephroController nephroController = Get.find<NephroController>();
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;


  final NewRegistrationController newRegistrationController =
  Get.put(NewRegistrationController());
  bool hasInternet = true;

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
  void dispose() {
    tabController.dispose();
    _connectivitySubscription?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable ? Scaffold(
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
            return hasInternet
                ? controller.isLoading
                ?  Center(child: TrendAnalysisShimmer())
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
                TabBar(
                  controller: tabController,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    buildTab(0, "Tabular","assets/graph.png"),
                    buildTab(1, "Graph","assets/user_textfield.png"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children:  [

                      TabularAnalysisPulse(pulse: widget.pulse,),
                      GraphicalAnalysisPulse(pulse: widget.pulse,),
                    ],
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 6)
                : InternetIssue(
              onRetryPressed: () {
                checkInternetAndLoadData();
              },
            );
          }),
    ) : InternetIssue(
      onRetryPressed: () async {
        final result = await _connectivity.checkConnectivity();
        _updateConnectionStatus(result);
      },
    );
  }

  Widget buildTab(int index, String text,String path) {
    bool isSelected = tabController.index == index;
    return Container(
      width: 210,
      // height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 0.8, vertical: 16),
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
          const SizedBox(width: 4,),
          CustomText(
            text: text,
            fontSize: 12.0,
            fontFam: 'Lato',
            fontWeight: FontWeight.normal,
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
    // else if (index == 3) {
    //   return const BorderRadius.only(
    //       topRight: Radius.circular(10), bottomRight: Radius.circular(10));
    // }
  }
}
