import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/add_clinical_condition.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/provisional_diag.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/clinical_condition_provisiona_list.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/add_clinical_condition.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/provisional_diag.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

// import '../../../widgets/custom_shimmer_loader.dart';

class ClinicalCondition extends StatefulWidget {
  // final ClinicalConditionList? clinicalConditionList;
  final NephroList? patientData;

  const ClinicalCondition({super.key, this.patientData});

  @override
  State<ClinicalCondition> createState() => _ClinicalConditionState();
}

class _ClinicalConditionState extends State<ClinicalCondition>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final NephroController nephroController = Get.find<NephroController>();

  bool hasInternet = true;

  var userData;

  @override
  void initState() {
    checkInternetAndLoadData();

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      // setState(() {}); // Update the UI when the tab changes
      nephroController.update();
    });
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint('User data retrieved: $userData');
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
    nephroController.update();
    if (hasInternet) {
      await nephroController.getDiagNosisList();
      // await nephroController.getClinicaConditionProvisionalList(widget.patientData!.treatmentId.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NephroController>(
        init: nephroController,
        builder: (controller) {
          return hasInternet
              ? controller.isLoading
                  ?  Center(child: buildShimmerLoader())
                  : Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TabBar(
                          controller: tabController,
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          tabs: [
                            buildTab(0, "Provisional Diagnosis"),
                            buildTab(1, "Confirmed Diagnosis"),
                          ],
                        ).paddingOnly(left: 8, right: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (controller.provisionList
                                    .any((e) => e.isSelected)) {
                                  List<ClinicalConditionProvisionaList>
                                      selectedItems = controller.provisionList
                                          .where((e) => e.isSelected == true)
                                          .toList();

                                  List<int?> idsList =
                                      selectedItems.map((e) => e.id).toList();
                                  String ids = idsList.join(',');
                                  await controller.updateCondtion(
                                      ids,
                                      userData['user_ID'],
                                      "Confirmed",
                                      widget.patientData?.treatmentId);
                                } else if (controller.confirmationList
                                    .any((e) => e.isSelected)) {
                                  List<ClinicalConditionProvisionaList>
                                      selectedItems = controller
                                          .confirmationList
                                          .where((e) => e.isSelected == true)
                                          .toList();

                                  List<int?> idsList =
                                      selectedItems.map((e) => e.id).toList();
                                  String ids = idsList.join(',');

                                  await controller.updateCondtion(
                                      ids,
                                      userData['user_ID'],
                                      "Provisional",
                                      widget.patientData?.treatmentId);
                                } else {
                                  CustomMessage.toast(context.l10n.nephroSelectCheckbox);
                                }
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColor.primaryBackgroundColor,
                                          AppColor.secondaryColor
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomCenter,
                                      )),
                                  child: tabController.index == 0
                                      ? CustomText(
                                          text: context.l10n.nephroConfirmed,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.center,
                                        )
                                      : CustomText(
                                          text: context.l10n.nephroProvisional,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.center,
                                        )),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => AddClinicalCondition(
                                      proLiItem: null,
                                      patientData: widget.patientData,
                                      isEdit: false,
                                    ));
                              },
                              child: Icon(
                                Icons.add_circle_outline,
                                color: AppColor.secondaryColor,
                                size: 30,
                              ),
                            ).paddingOnly(right: 8, top: 8, bottom: 8),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              ProvisionalDiag(
                                patientData: widget.patientData,
                                clinicalConditionProvisionList:
                                    controller.provisionList,
                                check: (ClinicalConditionProvisionaList value) {
                                  controller.provisionalItem = value;
                                },
                              ),
                              ProvisionalDiag(
                                patientData: widget.patientData,
                                clinicalConditionProvisionList:
                                    controller.confirmationList,
                                clinicalConditionList: controller.confirmedList,
                                check: (ClinicalConditionProvisionaList value) {
                                  controller.confirmitem = value;
                                },
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
        });
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
      child: Container(
        height: 30,
        alignment: Alignment.center,
        child: CustomText(
          text: text,
          fontSize: 12.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.normal,
          textColor: isSelected ? Colors.white : const Color(0xff777777),
          textAlign: TextAlign.center,
        ),
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
