import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/coversheet.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/nephro_controller.dart';
import 'package:heamodialysis/schedular/model/schedular_consultation_details.dart';
import 'package:heamodialysis/schedular/model/schedular_post_dialysis.dart';
import 'package:heamodialysis/schedular/model/schedular_pre_dialysis.dart';
import 'package:heamodialysis/schedular/schedular_controller/schedular_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../widgets/custom_shimmer_loader.dart';

class DialysisQueue extends StatefulWidget {
  final int? treatmentId;
  final int? patientId;

  const DialysisQueue({super.key, this.treatmentId, this.patientId});

  @override
  State<DialysisQueue> createState() => _DialysisQueueState();
}

class _DialysisQueueState extends State<DialysisQueue>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  bool hasInternet = true;

  final SchedularController schedularController =
      Get.put(SchedularController());

  final NephroController nephroController = Get.put(NephroController());

  var userData;

  @override
  void initState() {
    getUserData();
    checkInternetAndLoadData();

    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      // setState(() {}); // Update the UI when the tab changes
      schedularController.refreshUi();
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
    schedularController.refreshUi();
    if (hasInternet) {
      await schedularController.getConsultation(widget.treatmentId);
      await schedularController.getPreDialysisSchedular(widget.treatmentId);
      await schedularController.getPostDialysisSchedular(widget.treatmentId);
      await schedularController.getPrePostCoversheet(
          widget.patientId.toString(),
          userData['unitId'].toString(),
          widget.treatmentId!,
          userData['ui']);

      await schedularController.getPrescriptionDet(
          widget.treatmentId.toString(),
          userData['unitId'].toString(),
          widget.patientId.toString(),
          userData['ui'].toString());

      await schedularController.getLabInvest(widget.patientId.toString());

      await schedularController.getDietDetails(widget.treatmentId.toString());

      await nephroController.getCoverSheetNephro(widget.patientId.toString(),
          widget.treatmentId.toString(), userData['unitId'].toString());

      await nephroController.getClinicalHistoryList(
          widget.patientId.toString(), widget.treatmentId.toString());
      await schedularController.getUploadedDocList(widget.patientId.toString(),
          widget.treatmentId.toString(), userData['unitId'].toString());
      await schedularController.getInstructions(
          widget.treatmentId.toString(), widget.patientId.toString());

      await nephroController.getClinicaConditionProvisionalList(
          widget.treatmentId.toString());


    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint(userData['ui'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Patient History',
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
      body: GetBuilder<SchedularController>(builder: (controller) {
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
                          children: [
                            SchedularConsultationDetails(
                              consultationModel:
                                  schedularController.consultationModel,
                              // callB: () {
                              //   tabController.index = 1;
                              // },
                            ),
                            Coversheet(
                              patientId: widget.patientId,
                              treatmentId: widget.treatmentId,
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
                            SchedularPreDialysisTab(
                              schedularPreDialysisHistory: schedularController
                                  .schedularPreDialysisHistory,
                            ),
                            SchedularPostDialysis(
                              postDialysisSchedular:
                                  schedularController.postDialysisSchedular,
                            ),
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
