import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/controller/ro_log_sheet_controller.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/screens/add_ro_log_sheet.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/screens/ro_log_sheet_card.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class RoLogSheetList extends StatefulWidget {
  const RoLogSheetList({super.key});

  @override
  State<RoLogSheetList> createState() => _RoLogSheetListState();
}

class _RoLogSheetListState extends State<RoLogSheetList> {
  final RoLogSheetController roMachineIssueLogController =
      Get.put(RoLogSheetController());
  String? pickedTime;

  List<String> cardItemDetailsList = [
    "RO Machine Name",
    "Date",
    "Sand Filter Pressure",
    "Pre",
    "Post",
    "Sand Filter",
    "Backwash",
    "Rinse"
  ];
  bool hasInternet = true;

  var userData;

  DateTime? _selectedFromDate;
  DateTime? _selectedToDate;

  String? formattedFromDate;
  String? formattedToDate;

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
      // DateTime now = DateTime.now();
      // DateFormat formatter = DateFormat('yyyy-MM-dd');
      // String formattedDate = formatter.format(now);
      await roMachineIssueLogController.getRoMachineIssueLogAndSearchList(
          userData['unitId'] == "1" ? 0 : userData['unitId'], '', '');
      // await roMachineIssueLogController
      //     .getRoMachineIssueLogAndSearchList(0);
      await roMachineIssueLogController.getInstituteList();
    }
    // setState(() {});
    var ins = roMachineIssueLogController.instituteList?.data
        ?.firstWhere((e) => e.unitId == int.parse(userData['unitId'].toString()));
    roMachineIssueLogController.dropDownValue = ins;
    roMachineIssueLogController.update();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'RO Log Sheet',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              // Get.off(const RegisteredPatientList());
              // Get.back();
              Get.to(const InstituteWiseDashboardScreen());
            },
            child: Image.asset('assets/arrow-left.png')),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const AddRoLogSheet());
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
                                  value:
                                      roMachineIssueLogController.dropDownValue,
                                  hint: const Text("select"),
                                  onChanged:
                                      int.parse(userData['unitId']) == 1
                                          ? (InstituteDataModel? newValue) {
                                              setState(() {
                                                roMachineIssueLogController
                                                    .dropDownValue = newValue!;
                                              });
                                            }
                                          : null,
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
                                  underline: const SizedBox(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: AppColor.primaryBackgroundColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDateField(
                                  labelText: 'From Date',
                                  hint: 'Select Date',
                                  isRequired: false,
                                  callB: () {
                                    selectFromDate();
                                  },
                                  selectedDate: roMachineIssueLogController
                                      .fromDateController,
                                  filledColor: Colors.white,
                                  dontDhowPrefix: false,
                                ),
                              ),
                              Expanded(
                                child: CustomDateField(
                                  labelText: 'To Date',
                                  hint: 'Select Date',
                                  isRequired: false,
                                  callB: () {
                                    selectToDate();
                                  },
                                  selectedDate: roMachineIssueLogController
                                      .toDateController,
                                  filledColor: Colors.white,
                                  dontDhowPrefix: false,
                                ),
                              )
                            ],
                          ),
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
                                    roMachineIssueLogController
                                        .getRoMachineIssueLogAndSearchList(
                                            roMachineIssueLogController
                                                    .dropDownValue?.unitId ??
                                                int.parse(
                                                    userData['unitId']),
                                            formattedFromDate,
                                            formattedToDate);
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
      body: GetBuilder<RoLogSheetController>(
          init: RoLogSheetController(),
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                ?  Center(child: buildShimmerLoader())
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.roLogSheetModel?.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RoLogSheetCard(
                            index: index,
                            roList: controller.roLogSheetModel?.data![index],
                            cardItemDetailsList: cardItemDetailsList,
                            path1: "assets/edit.png",
                            path2: "assets/delete-bin.png",
                            callB1: (index) {
                              Get.to(() => AddRoLogSheet(
                                    roLogSheetData: controller
                                        .roLogSheetModel!.data![index],
                                    isEdit: true,
                                  ));
                            },
                            callB2: (index) {
                              controller.deleteLogSheet(
                                  controller.roLogSheetModel!.data![index]
                                      .roLogSheetId,
                                  userData['unitId'] == "1"
                                      ? 0
                                      : userData['unitId']);
                            },
                          );
                        },
                      )
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }

  selectFromDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != _selectedFromDate) {
      // setState(() {
      _selectedFromDate = picked;
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      formattedFromDate = formatter.format(_selectedFromDate!);
      roMachineIssueLogController.fromDateController.text = formattedFromDate!;
      setState(() {});
      // calculateAge(formattedDateDBO);
      // });
      // newRegistrationController.refreshUi();
    }
  }

  selectToDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != _selectedToDate) {
      // setState(() {
      _selectedToDate = picked;
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      formattedToDate = formatter.format(_selectedToDate!);
      roMachineIssueLogController.toDateController.text = formattedToDate!;
      setState(() {});
      // calculateAge(formattedDateDBO);
      // });
      // newRegistrationController.refreshUi();
    }
  }
}
