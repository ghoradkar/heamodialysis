import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/consultation_details.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/coversheet.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/post_dialysis.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/pre_dialysis.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class PreDialysisPatientHistory extends StatefulWidget {
  const PreDialysisPatientHistory({super.key});

  @override
  State<PreDialysisPatientHistory> createState() =>
      _PreDialysisPatientHistoryState();
}

class _PreDialysisPatientHistoryState extends State<PreDialysisPatientHistory>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());
  bool hasInternet = true;

  @override
  void initState() {
    checkInternetAndLoadData();

    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      // setState(() {}); // Update the UI when the tab changes
      newRegistrationController.refreshUi();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Patiente History',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              // newRegistrationController.abhaNoController.text = "";
              // newRegistrationController.firstNameController.text = "";
              // newRegistrationController.lastNameController.text = "";
              // newRegistrationController.middleNameController.text = "";
              // newRegistrationController.mobileController.text = "";
              // newRegistrationController.emailController.text = "";
              // newRegistrationController.dboController.text = "";
              // newRegistrationController.pincodeController.text = "";
              Get.back();
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body: GetBuilder<NewRegistrationController>(
          init: NewRegistrationController(),
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ?  Center(child: buildShimmerLoader())
                    : Column(
                        children: [
                          TabBar(
                            controller: tabController,
                            dividerColor: Colors.transparent,
                            indicatorColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            indicatorPadding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            tabs: [
                              buildTab(0, "Consultation\nDetails"),
                              buildTab(1, "Patient\nCoversheet"),
                              buildTab(2, "Pre\nDialysis"),
                              buildTab(3, "Post\nDialysis"),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: const [
                                ConsultationDetails(
                                    // callB: () {
                                    //   tabController.index = 1;
                                    // },
                                    ),
                                Coversheet(
                                    // callB: () {
                                    //   tabController.index = 2;
                                    // },
                                    // idProofListModel: newRegistrationController
                                    //     .idProofListModel?.data ??
                                    //     [],
                                    // viralStatusList: newRegistrationController
                                    //     .viralStatusModel?.data ??
                                    //     [],
                                    ),
                                PreDialysisTab(),
                                PostDialysis(),
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
    );
  }

  Widget buildTab(int index, String text) {
    bool isSelected = tabController.index == index;
    return Container(
      width: 210,
      // height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 0.8, vertical: 6),
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
      child: CustomText(
        text: text,
        fontSize: 12.0,
        fontFam: 'Lato',
        fontWeight: FontWeight.normal,
        textColor: isSelected ? Colors.white : const Color(0xff777777),
        textAlign: TextAlign.center,
      ),
    );
  }

  setBorderRadiusIndexWise(index) {
    if (index == 0) {
      return const BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
    } else if (index == 1) {
      return BorderRadius.zero;
    } else if (index == 3) {
      return const BorderRadius.only(
          topRight: Radius.circular(10), bottomRight: Radius.circular(10));
    }
  }
}
