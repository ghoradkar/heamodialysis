import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/screen/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/controller/ro_machine_issue_log_controller.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/screen/add_edit_ro_machine_issue_log.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/ro_maintenance_card_list.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class RoMachineIssueLogs extends StatefulWidget {
  const RoMachineIssueLogs({super.key});

  @override
  State<RoMachineIssueLogs> createState() => _RoMachineIssueLogsState();
}

class _RoMachineIssueLogsState extends State<RoMachineIssueLogs> {
  final RoMachineIssueLogController roMachineIssueLogController =
      Get.put(RoMachineIssueLogController());

  List<String> _cardItemDetailsList(BuildContext context) => [
        context.l10n.roMachineName,
        context.l10n.commonUnit,
        context.l10n.roInformedTo,
        context.l10n.roInformedBy,
        context.l10n.roIssueDate,
        context.l10n.roInformationDate,
        context.l10n.commonComments
      ];
  bool hasInternet = true;

  var userData;

  @override
  void initState() {
    getUserData();
    checkInternetAndLoadData();
    super.initState();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    roMachineIssueLogController.update();
    if (hasInternet) {
      // await dashboardController.getAllRegisteredPatient();
      await roMachineIssueLogController.getRoMachineIssueLogAndSearchList(
          userData['unitId'] == "1" ? 0 : userData['unitId'],
          "");
      await roMachineIssueLogController.getInstituteList();
    }

    var ins = roMachineIssueLogController.instituteList?.data
        ?.firstWhere((e) => e.unitId == userData['unitId']);
    roMachineIssueLogController.dropDownValue = ins;
    // setState(() {});
    roMachineIssueLogController.update();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: context.l10n.roMachineIssueLogs,
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.off(const InstituteWiseDashboardScreen());
            },
            child: Image.asset('assets/arrow-left.png')),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const AddRoMachineIssueLog());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset("assets/add-pre-dialysis.png"),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isDismissible: false,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(
                                0, 0.5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                      text: context.l10n.commonSearch,
                                      fontSize: 16,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start)
                                  .paddingSymmetric(vertical: 4),
                              InkWell(
                                  onTap: () {
                                    // roMachineIssueLogController.dropDownValue =
                                    //     null;
                                    roMachineIssueLogController
                                        .valueController.text = "";
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    "assets/cancel.png",
                                    width: 30,
                                    height: 30,
                                    color: AppColor.primaryBackgroundColor,
                                  )),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                      text: context.l10n.colInstituteName,
                                      fontSize: 16,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.normal,
                                      textColor: Color(0xff515151),
                                      textAlign: TextAlign.start)
                                  .paddingOnly(top: 10, bottom: 4),
                              Container(
                                // width: 180,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFE1E1E1)),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: DropdownButton<InstituteDataModel>(
                                  isExpanded: true,
                                  value:
                                      roMachineIssueLogController.dropDownValue,
                                  hint: Text("select"),
                                  onChanged:  int.parse(userData['unitId']) == 1
                                      ?(InstituteDataModel? newValue) {

                                    setState(() {
                                      roMachineIssueLogController
                                          .dropDownValue = newValue!;
                                    });
                                  }:null,
                                  items: roMachineIssueLogController
                                      .instituteList?.data
                                      ?.map<
                                              DropdownMenuItem<
                                                  InstituteDataModel>>(
                                          (InstituteDataModel value) {
                                    return DropdownMenuItem<InstituteDataModel>(
                                      value: value,
                                      child: Text(value.unitName ?? ""),
                                    );
                                  }).toList(),
                                  underline: SizedBox(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: AppColor.primaryBackgroundColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                text: context.l10n.machMachineName,
                                fontSize: 16,
                                fontFam: "Lato",
                                fontWeight: FontWeight.normal,
                                textColor: Color(0xff515151),
                                textAlign: TextAlign.start),
                          ).paddingOnly(top: 10, bottom: 4),
                          TextField(
                              controller:
                                  roMachineIssueLogController.valueController,
                              decoration: InputDecoration(
                                labelText: context.l10n.roSpecialNo,
                                labelStyle: TextStyle(color: Color(0xFFE1E1E1)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFE1E1E1)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFE1E1E1)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      alignment: Alignment.center,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.red,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset("assets/cancel.png"),
                                          CustomText(
                                              text: context.l10n.commonCancel,
                                              fontSize: 16,
                                              fontFam: "Lato",
                                              fontWeight: FontWeight.normal,
                                              textColor: Colors.white,
                                              textAlign: TextAlign.start),
                                        ],
                                      )),
                                ),
                              ).paddingOnly(top: 20),
                              SizedBox(
                                width: 14,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    roMachineIssueLogController
                                        .getRoMachineIssueLogAndSearchList(
                                            // dropDownValue?.lookupDetValue ??
                                            //     "",
                                            // roMaintDetailsController.valueController.text,
                                            roMachineIssueLogController
                                                    .dropDownValue?.unitId ??
                                                int.parse(
                                                    userData['unitId']),
                                            roMachineIssueLogController
                                                .valueController.text);
                                    Get.back();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      alignment: Alignment.center,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColor.primaryBackgroundColor,
                                            AppColor.secondaryColor
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          CustomText(
                                              text: context.l10n.commonSearch,
                                              fontSize: 16,
                                              fontFam: "Lato",
                                              fontWeight: FontWeight.normal,
                                              textColor: Colors.white,
                                              textAlign: TextAlign.start),
                                        ],
                                      )),
                                ),
                              ).paddingOnly(top: 20),
                            ],
                          )
                        ],
                      ),
                    );
                  });
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset("assets/filter-line.png"),
            ),
          ),
          SizedBox(
            width: 2,
          ),
        ],
      ),
      body: GetBuilder<RoMachineIssueLogController>(
          init: RoMachineIssueLogController(),
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                ?  Center(child: buildShimmerLoader())
                    : RoMaintenanceCardList(
                        roList: controller.roMachineIssueLogModel?.data ?? [],
                        cardItemDetailsList: _cardItemDetailsList(context),
                        path1: "assets/edit.png",
                        path2: "assets/delete-bin.png",
                        callB1: (index) {
                          Get.to(() => AddRoMachineIssueLog(
                                proLiItem: controller
                                    .roMachineIssueLogModel?.data?[index],
                                isEdit: true,
                              ));
                        },
                        callB2: (index) {
                          controller.deleteMachineIssueLog(
                              controller.roMachineIssueLogModel?.data?[index]
                                  .roMachineIssueLogsId,
                              userData['unitId'] == "1" ? 0 : int.parse(userData['unitId']));
                        },
                        isMachineIssueLog: true,
                      )
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }
}
