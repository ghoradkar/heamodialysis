import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/screen/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/controller/ro_desinfection_details_controller.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screen/add_edit_ro_desinfec_details.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/ro_maintenance_card_list.dart';

import '../../../utils/status_update_screen.dart';
import '../../../widgets/custom_shimmer_loader.dart';

class RoDisinfectionDetails extends StatefulWidget {
  const RoDisinfectionDetails({super.key});

  @override
  State<RoDisinfectionDetails> createState() => _RoDisinfectionDetailsState();
}

class _RoDisinfectionDetailsState extends State<RoDisinfectionDetails> {

  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  final RoDesinfectionDetailsController roMaintDetailsController =
      Get.put(RoDesinfectionDetailsController());

  List<String> cardItemDetailsList = [
    "RO Machine Name",
    "Unit",
    "Type of Disinfection Used",
    "Inspection Date",
    "Next Inspection Date",
    "Done By",
    "Comments"
  ];
  bool hasInternet = true;

  var userData;

  @override
  void initState() {
    getUserData();
    checkInternetAndLoadData();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    super.initState();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));

    roMaintDetailsController.update();
    if (hasInternet) {
      await roMaintDetailsController.getRoMaintenanceDetAndSearchList(
          userData['unitId'] == "1"
              ? 0
              : int.parse(userData['unitId'].toString()),
          "");
      await roMaintDetailsController.getInstituteList();
    }
    var ins = roMaintDetailsController.instituteList?.data?.firstWhere(
        (e) => e.unitId == int.parse(userData['unitId'].toString()));
    roMaintDetailsController.dropDownValue = ins;

    roMaintDetailsController.update();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
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
    _connectivitySubscription?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable ? Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'RO Disinfection Details',
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
              Get.to(() => const AddRoDesinfectionDetails());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset("assets/add-pre-dialysis.png"),
            ),
          ),
          const SizedBox(
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
                              const CustomText(
                                      text: "Search",
                                      fontSize: 16,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start)
                                  .paddingSymmetric(vertical: 4),
                              InkWell(
                                  onTap: () {
                                    // roMaintDetailsController.dropDownValue =
                                    //     null;
                                    roMaintDetailsController
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
                              const CustomText(
                                      text: "Institute Name",
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
                                  value: roMaintDetailsController.dropDownValue,
                                  hint: const Text("select"),
                                  onChanged: int.parse(userData['unitId'].toString()) == 1
                                      ? (InstituteDataModel? newValue) {
                                          setState(() {
                                            roMaintDetailsController
                                                .dropDownValue = newValue!;
                                          });
                                        }
                                      : null,
                                  items: roMaintDetailsController
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
                                  underline: const SizedBox(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: AppColor.primaryBackgroundColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                text: "Machine Name",
                                fontSize: 16,
                                fontFam: "Lato",
                                fontWeight: FontWeight.normal,
                                textColor: Color(0xff515151),
                                textAlign: TextAlign.start),
                          ).paddingOnly(top: 10, bottom: 4),
                          TextField(
                              controller:
                                  roMaintDetailsController.valueController,
                              decoration: const InputDecoration(
                                labelText: 'Please enter special no.',
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
                                          const CustomText(
                                              text: "Cancel",
                                              fontSize: 16,
                                              fontFam: "Lato",
                                              fontWeight: FontWeight.normal,
                                              textColor: Colors.white,
                                              textAlign: TextAlign.start),
                                        ],
                                      )),
                                ),
                              ).paddingOnly(top: 20),
                              const SizedBox(
                                width: 14,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    roMaintDetailsController
                                        .getRoMaintenanceDetAndSearchList(
                                            roMaintDetailsController
                                                    .dropDownValue?.unitId ??
                                                int.parse(userData['unitId']),
                                            roMaintDetailsController
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
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          CustomText(
                                              text: "Search",
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
          const SizedBox(
            width: 2,
          ),
        ],
      ),
      body: GetBuilder<RoDesinfectionDetailsController>(
          init: RoDesinfectionDetailsController(),
          builder: (controller) {
            if (controller.isLoading) {
              return Center(child: SessionEndPatientsShimmer());
            }
            final roList = controller.roMaintenanceDetailsModel?.data ?? [];
            if (roList.isEmpty) {
              return CommonStatusScreen(
                title: "No Data Found",
                description: "We are unable to find the data that\nyou are looking for",
                img: "assets/no_Data_Found.png",
                buttonText: "Go Back",
                onPressed: () {
                  Get.back();
                },

              );
            }
            return  RoMaintenanceCardList(
                        roList:
                            controller.roMaintenanceDetailsModel?.data ?? [],

                        cardItemDetailsList: cardItemDetailsList,
                        path1: "assets/edit.png",
                        path2: "assets/delete-bin.png",
                        callB1: (index) {
                          Get.to(() => AddRoDesinfectionDetails(
                                proLiItem: controller
                                    .roMaintenanceDetailsModel?.data?[index],
                                isEdit: true,
                              ));
                        },
                        callB2: (index) {
                          controller.deleteDesinfectionDet(
                              controller.roMaintenanceDetailsModel?.data?[index]
                                  .roDisinfectionDetailsId,
                              userData['unitId'] == "1"
                                  ? 0
                                  : int.parse(userData['unitId']));
                        },
                        isMachineIssueLog: false,
                      );

          }),
    ) : InternetIssue(
      onRetryPressed: () async {
        final result = await _connectivity.checkConnectivity();
        _updateConnectionStatus(result);
      },
    );
  }
}
