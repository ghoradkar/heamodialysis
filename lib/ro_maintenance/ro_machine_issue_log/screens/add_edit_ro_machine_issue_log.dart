import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/controller/ro_machine_issue_log_controller.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/problem_resolve/problem_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/ro_machine_issue_log/ro_issue_log_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/screens/ro_machine_issue_log.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class AddRoMachineIssueLog extends StatefulWidget {
  final RoIssueLogData? proLiItem;
  final bool? isEdit;

  const AddRoMachineIssueLog({super.key, this.proLiItem, this.isEdit});

  @override
  State<AddRoMachineIssueLog> createState() => AddRoMachineIssueLogState();
}

class AddRoMachineIssueLogState extends State<AddRoMachineIssueLog> {
  final RoMachineIssueLogController roMachineIssueController =
      Get.put(RoMachineIssueLogController());

  DateTime? selectedIssueDate;
  DateTime? selectedInfoDate;

  String formattedDate1 = '';
  String formattedDate2 = '';

  bool hasInternet = true;

  var userData;

  InstituteDataModel? ins;

  MachineData? mac;

  ProblemData? prob;

  // DisinfectData? desIn;

  // DoneByData? don;

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    checkInternetAndLoadData();
    super.initState();
  }

  getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    roMachineIssueController.update();
    if (hasInternet) {
      await roMachineIssueController.getInstituteList();
      await roMachineIssueController
          .getProblemResolvedList(userData['unitId']);
      await roMachineIssueController
          .getMachineList(userData['unitId']);
    }
    // setState(() {});

    if (widget.isEdit == false || widget.isEdit == null) {
      var ins = roMachineIssueController.instituteList?.data
          ?.firstWhere((e) => e.unitId == userData['unitId']);
      roMachineIssueController.initialInsti = ins?.unitName;
      roMachineIssueController.selectedInsti = ins;
    }

    roMachineIssueController.update();

    if (widget.isEdit == true && widget.proLiItem != null) {
      // String date1 =
      // dateConversion(widget.proLiItem!.fIssueDate!);
      // String date2 = dateConversion(
      //     widget.proLiItem!.fInformationDate!);

      String date1 = widget.proLiItem!.fIssueDate!;
      String date2 = widget.proLiItem!.fInformationDate!;
      ins = roMachineIssueController.instituteList?.data?.firstWhereOrNull(
          (e) => e.unitName == widget.proLiItem?.unitMasterDto?.unitName);
      if (ins != null) {
        roMachineIssueController.initialInsti =
            widget.proLiItem?.unitMasterDto?.unitName;
      } else {
        roMachineIssueController.initialInsti =
            roMachineIssueController.instituteList?.data?.first.unitName;
      }

      mac = roMachineIssueController.getMachineNameModel?.data
          ?.firstWhereOrNull((e) =>
              e.machineName ==
              widget.proLiItem?.tmRoMachineMaster?.machineName);
      if (mac != null) {
        roMachineIssueController.initialMachine =
            widget.proLiItem?.tmRoMachineMaster?.machineName;
      } else {
        roMachineIssueController.initialMachine = roMachineIssueController
            .getMachineNameModel?.data?.first.machineName;
      }

      prob = roMachineIssueController.problemResolvedModel?.data
          ?.firstWhereOrNull((e) =>
              e.lookupDetDescEn ==
              widget.proLiItem?.tmCmLookupDet?.lookupDetDescEn);
      if (prob != null) {
        roMachineIssueController.initialProblemSolved =
            widget.proLiItem?.tmCmLookupDet?.lookupDetDescEn;
      } else {
        roMachineIssueController.initialProblemSolved = roMachineIssueController
            .problemResolvedModel?.data?.first.lookupDetDescEn;
      }

      // don = roMaintDetailsController.doneByModel?.data
      //     ?.firstWhere((e) => e.username == widget.proLiItem?.doneBy);
      // if (don != null) {
      //   roMaintDetailsController.initialDoneBy = widget.proLiItem?.doneBy;
      // } else {
      //   roMaintDetailsController.initialDoneBy = null;
      // }

      roMachineIssueController.infoDateController.text = date1;
      roMachineIssueController.issueDateController.text = date2;
      roMachineIssueController.commentController.text =
          widget.proLiItem?.comments ?? "";
      roMachineIssueController.issueDescController.text =
          widget.proLiItem?.issueDescription ?? "";
      roMachineIssueController.informToController.text =
          widget.proLiItem?.informedTo ?? "";
      roMachineIssueController.informByController.text =
          widget.proLiItem?.informedBy ?? "";
      roMachineIssueController.callAttendedByController.text =
          widget.proLiItem?.callAttendedBy ?? "";
      roMachineIssueController.correctionActionController.text =
          widget.proLiItem?.correctiveAction ?? "";
      setState(() {});
    } else {
      roMachineIssueController.issueDescController.text = "";
      roMachineIssueController.informByController.text = "";
      roMachineIssueController.informToController.text = "";
      roMachineIssueController.callAttendedByController.text = "";
      roMachineIssueController.correctionActionController.text = "";
      roMachineIssueController.initialProblemSolved = null;
    }
  }

  dateConversion(inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.isEdit == true
              ? "Edit RO Machine Issue Logs"
              : 'Add RO Machine Issue Logs',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              roMachineIssueController.initialInsti = null;
              roMachineIssueController.initialMachine = null;
              roMachineIssueController.initialProblemSolved = null;
              roMachineIssueController.infoDateController.text = "";
              roMachineIssueController.issueDateController.text = "";
              roMachineIssueController.commentController.text = "";
              roMachineIssueController.issueDescController.text = "";
              roMachineIssueController.informByController.text = "";
              roMachineIssueController.informToController.text = "";
              roMachineIssueController.callAttendedByController.text = "";
              roMachineIssueController.correctionActionController.text = "";
              Get.to(const RoMachineIssueLogs());
              // Get.back();
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body: GetBuilder<RoMachineIssueLogController>(
          init: RoMachineIssueLogController(),
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ?  Center(child: buildShimmerLoader())
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            MyCustomDropdown(
                              labelText: 'Institute Name',
                              isViewProfile:
                                 userData['unitId'] == 1
                                      ? false
                                      : true,
                              items: controller.instituteList?.data
                                      ?.map((e) => e.unitName)
                                      .toList() ??
                                  [],
                              hint: 'Select',
                              isRequired: false,
                              senValue: (value) {
                                roMachineIssueController.selectedInsti =
                                    controller.instituteList?.data?.firstWhere(
                                        (e) => e.unitName == value);
                                roMachineIssueController.initialInsti =
                                    roMachineIssueController
                                        .selectedInsti?.unitName;
                                controller.update();
                              },
                              filledColor: Colors.white,
                              selectedItem:
                                  roMachineIssueController.initialInsti,
                            ),
                            MyCustomDropdown(
                              selectedItem:
                                  roMachineIssueController.initialMachine,
                              labelText: 'Machine Name',
                              items: controller.getMachineNameModel?.data
                                      ?.map((e) => e.machineName)
                                      .toList() ??
                                  [],
                              hint: 'Select',
                              isRequired: false,
                              senValue: (value) {
                                roMachineIssueController.selectedMachine =
                                    controller.getMachineNameModel?.data
                                        ?.firstWhere(
                                            (e) => e.machineName == value);
                                roMachineIssueController.initialMachine =
                                    roMachineIssueController
                                        .selectedMachine?.machineName;
                                controller.update();
                              },
                              filledColor: Colors.white,
                            ),
                            CustomDateField(
                              labelText: 'Issue Date',
                              hint: 'Select Date',
                              isRequired: false,
                              callB: () {
                                pickInspectionDate(context);
                              },
                              selectedDate:
                                  roMachineIssueController.issueDateController,
                              filledColor: Colors.white,
                              dontDhowPrefix: false,
                            ),
                            CustomTextField(
                              fontSize: 16,
                              labelText: 'Issue Description',
                              hintText: 'Enter',
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController:
                                  roMachineIssueController.issueDescController,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 1,
                            ),
                            CustomTextField(
                              fontSize: 16,
                              labelText: 'Informed To',
                              hintText: 'Enter',
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController:
                                  roMachineIssueController.informToController,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 1,
                            ),
                            CustomTextField(
                              fontSize: 16,
                              labelText: 'Informed By',
                              hintText: 'Enter',
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController:
                                  roMachineIssueController.informByController,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 1,
                            ),
                            CustomDateField(
                              labelText: 'Information Date',
                              hint: 'Select Date',
                              isRequired: false,
                              callB: () {
                                pickNextInspecDate(context);
                              },
                              selectedDate:
                                  roMachineIssueController.infoDateController,
                              filledColor: Colors.white,
                              dontDhowPrefix: false,
                            ),
                            CustomTextField(
                              fontSize: 16,
                              labelText: 'Call Attended By',
                              hintText: 'Enter',
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController: roMachineIssueController
                                  .callAttendedByController,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 1,
                            ),
                            CustomTextField(
                              fontSize: 16,
                              labelText: 'Correction Action',
                              hintText: 'Enter',
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController: roMachineIssueController
                                  .correctionActionController,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 1,
                            ),
                            MyCustomDropdown(
                              selectedItem:
                                  roMachineIssueController.initialProblemSolved,
                              labelText: 'Problem Resolved',
                              items: roMachineIssueController
                                      .problemResolvedModel?.data
                                      ?.map((e) => e.lookupDetDescEn)
                                      .toList() ??
                                  [],
                              hint: 'Select',
                              isRequired: false,
                              senValue: (value) {
                                roMachineIssueController.initialProblemSolved =
                                    value;
                                roMachineIssueController.selectedProblem =
                                    roMachineIssueController
                                        .problemResolvedModel?.data
                                        ?.firstWhere(
                                            (e) => e.lookupDetDescEn == value);
                                controller.update();
                              },
                              filledColor: Colors.white,
                            ),
                            CustomTextField(
                              fontSize: 16,
                              labelText: 'Comments',
                              hintText: 'Enter Comments',
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController:
                                  roMachineIssueController.commentController,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                  isLoading: controller.isLoading,
                                  buttonText: 'Save',
                                  path: 'assets/save-ro-disinfec.png',
                                  callB: controller.isLoading
                                      ? null
                                      : () async {
                                          if (widget.isEdit == true) {
                                            controller.addEditMachineIssueLogReq
                                                    ?.roMachineIssueLogsId =
                                                widget.proLiItem
                                                    ?.roMachineIssueLogsId;

                                            controller.addEditMachineIssueLogReq
                                                    ?.roMachineMasterId =
                                                roMachineIssueController
                                                        .selectedMachine
                                                        ?.roMachineMasterId ??
                                                    mac?.roMachineMasterId;

                                            // controller.addEditMachineIssueLogReq
                                            //         ?.issueDate =
                                            //     formattedDate1.isEmpty
                                            //         ? sendConvertedDateToAPI(roMachineIssueController
                                            //             .issueDateController.text)
                                            //         : sendConvertedDateToAPI(formattedDate1);

                                            controller.addEditMachineIssueLogReq
                                                    ?.issueDate =
                                                formattedDate1.isEmpty
                                                    ? roMachineIssueController
                                                        .issueDateController
                                                        .text
                                                    : formattedDate1;

                                            controller.addEditMachineIssueLogReq
                                                    ?.issueDescription =
                                                controller
                                                    .issueDescController.text;

                                            controller.addEditMachineIssueLogReq
                                                    ?.informedTo =
                                                controller
                                                    .informToController.text;

                                            controller.addEditMachineIssueLogReq
                                                    ?.informedBy =
                                                controller
                                                    .informByController.text;

                                            // controller.addEditMachineIssueLogReq
                                            //         ?.informationDate =
                                            //     formattedDate2.isEmpty
                                            //         ? sendConvertedDateToAPI(roMachineIssueController
                                            //             .infoDateController.text)
                                            //         : sendConvertedDateToAPI(formattedDate2);

                                            controller.addEditMachineIssueLogReq
                                                    ?.informationDate =
                                                formattedDate2.isEmpty
                                                    ? roMachineIssueController
                                                        .infoDateController.text
                                                    : formattedDate2;

                                            controller.addEditMachineIssueLogReq
                                                    ?.callAttendedBy =
                                                controller
                                                    .callAttendedByController
                                                    .text;

                                            controller.addEditMachineIssueLogReq
                                                    ?.correctiveAction =
                                                controller
                                                    .correctionActionController
                                                    .text;

                                            controller.addEditMachineIssueLogReq
                                                    ?.lookupDetId =
                                                roMachineIssueController
                                                        .selectedProblem
                                                        ?.lookupDetId ??
                                                    prob?.lookupDetId;

                                            controller.addEditMachineIssueLogReq
                                                    ?.comments =
                                                controller
                                                    .commentController.text;

                                            controller.addEditMachineIssueLogReq
                                                ?.createdBy = 1;

                                            controller.addEditMachineIssueLogReq
                                                    ?.unitId =
                                                roMachineIssueController
                                                        .selectedInsti
                                                        ?.unitId ??
                                                    ins?.unitId;

                                            await controller
                                                .addEditRoMachineIssueLog();
                                          } else {
                                            controller.addEditMachineIssueLogReq
                                                ?.roMachineIssueLogsId = 0;

                                            controller.addEditMachineIssueLogReq
                                                    ?.roMachineMasterId =
                                                roMachineIssueController
                                                    .selectedMachine
                                                    ?.roMachineMasterId;

                                            // controller.addEditMachineIssueLogReq
                                            //     ?.issueDate = sendConvertedDateToAPI(formattedDate1);

                                            controller.addEditMachineIssueLogReq
                                                ?.issueDate = formattedDate1;

                                            controller.addEditMachineIssueLogReq
                                                    ?.issueDescription =
                                                controller
                                                    .issueDescController.text;

                                            controller.addEditMachineIssueLogReq
                                                    ?.informedTo =
                                                controller
                                                    .informToController.text;

                                            controller.addEditMachineIssueLogReq
                                                    ?.informedBy =
                                                controller
                                                    .informByController.text;

                                            // controller.addEditMachineIssueLogReq
                                            //     ?.informationDate = sendConvertedDateToAPI(formattedDate2);

                                            controller.addEditMachineIssueLogReq
                                                    ?.informationDate =
                                                formattedDate2;

                                            controller.addEditMachineIssueLogReq
                                                    ?.callAttendedBy =
                                                controller
                                                    .callAttendedByController
                                                    .text;

                                            controller.addEditMachineIssueLogReq
                                                    ?.correctiveAction =
                                                controller
                                                    .correctionActionController
                                                    .text;

                                            controller.addEditMachineIssueLogReq
                                                    ?.lookupDetId =
                                                roMachineIssueController
                                                    .selectedProblem
                                                    ?.lookupDetId;

                                            controller.addEditMachineIssueLogReq
                                                    ?.comments =
                                                controller
                                                    .commentController.text;

                                            controller.addEditMachineIssueLogReq
                                                    ?.createdBy =

                                                    userData['unitId'];

                                            controller.addEditMachineIssueLogReq
                                                    ?.unitId =
                                                roMachineIssueController
                                                    .selectedInsti?.unitId;

                                            await controller
                                                .addEditRoMachineIssueLog();
                                          }
                                        },
                                  buttonWidth: 100,
                                  primColor: AppColor.primaryBackgroundColor,
                                  secColor: AppColor.secondaryColor,
                                  textColor: Colors.white,
                                  iconColor: Colors.white,
                                ),
                                CustomButton(
                                  buttonText: 'Reset',
                                  path: 'assets/refresh.png',
                                  callB: () {
                                    roMachineIssueController.selectedInsti =
                                        null;
                                    roMachineIssueController.initialInsti =
                                        null;
                                    roMachineIssueController.selectedMachine =
                                        null;
                                    roMachineIssueController.initialMachine =
                                        null;
                                    roMachineIssueController
                                        .initialProblemSolved = null;
                                    roMachineIssueController.selectedProblem =
                                        null;
                                    controller.issueDateController.text = "";
                                    controller.issueDescController.text = "";
                                    controller.informToController.text = "";
                                    controller.informByController.text = "";
                                    controller.commentController.text = "";
                                    controller.infoDateController.text = "";
                                    controller.callAttendedByController.text =
                                        "";
                                    controller.correctionActionController.text =
                                        "";

                                    // controller.update();
                                    setState(() {});
                                  },
                                  buttonWidth: 100,
                                  primColor: Colors.grey,
                                  secColor: Colors.grey,
                                  textColor: Colors.white,
                                  iconColor: Colors.white,
                                ),
                                CustomButton(
                                  buttonText: 'Cancel',
                                  path: 'assets/cancel.png',
                                  callB: () {
                                    Get.back();
                                  },
                                  buttonWidth: 100,
                                  primColor:AppColor.red,
                                  secColor: AppColor.red,
                                  textColor: Colors.white,
                                  iconColor: Colors.white,
                                ),
                              ],
                            ).paddingOnly(top: 20, bottom: 20)
                          ],
                        ),
                      )
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }

  Future<void> pickInspectionDate(BuildContext context) async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != selectedIssueDate) {
      // setState(() {
      selectedIssueDate = picked;
      DateFormat formatter = DateFormat('yyyy/MM/dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      formattedDate1 = formatter.format(selectedIssueDate!);
      roMachineIssueController.issueDateController.text = formattedDate1;

      // });
      roMachineIssueController.update();
    }
  }

  Future<void> pickNextInspecDate(BuildContext context) async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != selectedInfoDate) {
      // setState(() {
      selectedInfoDate = picked;
      DateFormat formatter = DateFormat('yyyy/MM/dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      formattedDate2 = formatter.format(selectedInfoDate!);
      roMachineIssueController.infoDateController.text = formattedDate2;

      // });
      roMachineIssueController.update();
    }
  }

  sendConvertedDateToAPI(date) {
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(date);

    // Format the parsed date to the desired format
    String formattedDate = DateFormat('yyyy/MM/dd').format(parsedDate);
    return formattedDate;
  }
}
