import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/consumable_entry/model/add_consumable_entry_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_list_model.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/controller/ro_machine_issue_log_controller.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/problem_resolve/problem_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';

class AddConsumable extends StatefulWidget {
  // final RoIssueLogData? proLiItem;
  final DialysisEventListModel? preDialysisData;

  const AddConsumable({super.key, required this.preDialysisData});

  @override
  State<AddConsumable> createState() => AddConsumableState();
}

class AddConsumableState extends State<AddConsumable> {
  final RoMachineIssueLogController roMachineIssueController = Get.put(RoMachineIssueLogController());

  DateTime? selectedIssueDate;
  DateTime? selectedInfoDate;

  String formattedDate1 = '';
  String formattedDate2 = '';

  bool hasInternet = true;

  var userData;

  InstituteDataModel? ins;

  MachineData? mac;

  ProblemData? prob;
  List<AddConsumableEntryModel> cardList = [];
  List<String> selectedProdList = [];

  // DisinfectData? desIn;

  // DoneByData? don;

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    // if (widget.isEdit != true) {
    cardList.add(AddConsumableEntryModel());
    // }
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
          .getProductNameList(userData['unitId'].toString());
      await roMachineIssueController
          .getProblemResolvedList(int.parse(userData['unitId'].toString()));
      await roMachineIssueController
          .getMachineList(int.parse(userData['unitId'].toString()));
    }
    // setState(() {});
    roMachineIssueController.update();
  }

  void addCard() {
    setState(() {
      cardList.add(AddConsumableEntryModel());
    });
  }

  void removeCard(int index) {
    if (cardList.length > 1) {
      setState(() {
        cardList.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  CustomText(
          text: context.l10n.dqAddEntryConsumable,
          fontSize: 18.sp,
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

              Get.back();
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
                            ...cardList.asMap().entries.map((entry) {
                              int index = entry.key;
                              AddConsumableEntryModel cardData = entry.value;
                              return addConsumableCard(index, cardData);
                            }),
                            ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      addCard();
                                    },
                                    icon: const Icon(Icons.add_circle_outline),
                                    color: Colors.green,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      removeCard(cardList.length - 1);
                                    },
                                    icon:
                                        const Icon(Icons.remove_circle_outline),
                                    color: AppColor.red,
                                  )
                                ],
                              )
                            ],
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                  isLoading: roMachineIssueController.isLoading,
                                  buttonText: context.l10n.commonSave,
                                  path: 'assets/save-ro-disinfec.png',
                                  callB: roMachineIssueController.isLoading
                                      ? null
                                      : () async {
                                          // debugPrint(cardList.length.toString());
                                          //
                                          // String detPhysicalConsumedId = "";
                                          // String detItemId = "";
                                          // String detIdCfpConsumedQty = "";
                                          // String detUsedQty = "";
                                          // String detConsumRemark = "";
                                          // String detItenName = "";
                                          // String detBatchNo = "";
                                          // String detExpDate = "";
                                          // String detOrderNo = "";
                                          //
                                          // // Iterate over the list and concatenate the keys with #
                                          // for (var item in cardList) {
                                          //   detItemId += "${item.itemId}#";
                                          //   detIdCfpConsumedQty +=
                                          //       "${item.consumedQuantity}#";
                                          //   detUsedQty +=
                                          //       "${item.usedQuantity}#";
                                          //   detConsumRemark +=
                                          //       "${item.remark}#";
                                          //   detItenName += "${item.itenName}#";
                                          //   detBatchNo += "${item.batchNo}#";
                                          //   detExpDate += "${item.expiryDate}#";
                                          //   detOrderNo += "${item.orderNo}#";
                                          //   detPhysicalConsumedId += "0#";
                                          // }
                                          //
                                          // roMachineIssueController
                                          //         .addConsumableEntryModel
                                          //         .physicalConsumableDetId =
                                          //     detPhysicalConsumedId;
                                          // roMachineIssueController
                                          //     .addConsumableEntryModel
                                          //     .itemId = detItemId;
                                          // roMachineIssueController
                                          //         .addConsumableEntryModel
                                          //         .consumedQuantity =
                                          //     detIdCfpConsumedQty;
                                          //
                                          // roMachineIssueController
                                          //     .addConsumableEntryModel
                                          //     .usedQuantity = detUsedQty;
                                          //
                                          // roMachineIssueController
                                          //     .addConsumableEntryModel
                                          //     .remark = detConsumRemark;
                                          //
                                          // roMachineIssueController
                                          //     .addConsumableEntryModel
                                          //     .itenName = detItenName;
                                          //
                                          // roMachineIssueController
                                          //     .addConsumableEntryModel
                                          //     .batchNo = detBatchNo;
                                          //
                                          // roMachineIssueController
                                          //     .addConsumableEntryModel
                                          //     .expiryDate = detExpDate;
                                          //
                                          // roMachineIssueController
                                          //     .addConsumableEntryModel
                                          //     .orderNo = detOrderNo;
                                          //
                                          // roMachineIssueController
                                          //         .addConsumableEntryModel
                                          //         .patientId =
                                          //     widget.preDialysisData?.patientId
                                          //         .toString();
                                          // roMachineIssueController
                                          //         .addConsumableEntryModel
                                          //         .treatmentId =
                                          //     widget
                                          //         .preDialysisData?.treatmentId
                                          //         .toString();
                                          // roMachineIssueController
                                          //     .addConsumableEntryModel
                                          //     .consumableModeFlag = "P";
                                          // roMachineIssueController
                                          //     .addConsumableEntryModel
                                          //     .unitId = userData['unitId'].toString();
                                          // roMachineIssueController
                                          //         .addConsumableEntryModel
                                          //         .userId =
                                          //     userData['user_ID'].toString();
                                          //
                                          // roMachineIssueController
                                          //     .saveAddConsumableEntry(roMachineIssueController,widget.preDialysisData?.patientId);
                                          // debugPrint(roMachineIssueController
                                          //     .addConsumableEntryModel.itenName);

                                          debugPrint(
                                              "Card List Count: ${cardList.length}");

                                          final model = roMachineIssueController
                                              .addConsumableEntryModel;

                                          // Initialize empty lists to join later
                                          List<String> detItemId = [];
                                          List<String> detConsumedQty = [];
                                          List<String> detUsedQty = [];
                                          List<String> detRemark = [];
                                          List<String> detItemName = [];
                                          List<String> detBatchNo = [];
                                          List<String> detExpiryDate = [];
                                          List<String> detOrderNo = [];
                                          List<String> detPhysicalConsumedId =
                                              [];

                                          for (var item in cardList) {
                                            detItemId
                                                .add(item.itemId.toString());
                                            detConsumedQty.add(item
                                                .consumedQuantity
                                                .toString());
                                            detUsedQty.add(
                                                item.usedQuantity.toString());
                                            detRemark.add(item.remark ?? '');
                                            detItemName
                                                .add(item.itenName ?? '');
                                            detBatchNo.add(item.batchNo ?? '');
                                            detExpiryDate
                                                .add(item.expiryDate ?? '');
                                            detOrderNo.add(item.orderNo ?? '');
                                            detPhysicalConsumedId.add("0");
                                          }

                                          model.itemId = detItemId.join('#');
                                          model.consumedQuantity =
                                              detConsumedQty.join('#');
                                          model.usedQuantity =
                                              detUsedQty.join('#');
                                          model.remark = detRemark.join('#');
                                          model.itenName =
                                              detItemName.join('#');
                                          model.batchNo = detBatchNo.join('#');
                                          model.expiryDate =
                                              detExpiryDate.join('#');
                                          model.orderNo = detOrderNo.join('#');
                                          model.physicalConsumableDetId =
                                              detPhysicalConsumedId.join('#');

                                          // Set other properties
                                          model.patientId = widget
                                              .preDialysisData?.patientId
                                              ?.toString();
                                          model.treatmentId = widget
                                              .preDialysisData?.treatmentId
                                              ?.toString();
                                          model.consumableModeFlag = "P";
                                          model.unitId =
                                              userData['unitId'].toString();
                                          model.userId =
                                              userData['user_ID'].toString();

                                          // Save
                                          await roMachineIssueController
                                              .saveAddConsumableEntry(
                                            roMachineIssueController,
                                            widget.preDialysisData?.patientId,
                                          );


                                          debugPrint(
                                              "Saved ItenName: ${model.itenName}");
                                        },
                                  buttonWidth: 100.w,
                                  primColor: AppColor.primaryBackgroundColor,
                                  secColor: AppColor.secondaryColor,
                                  textColor: Colors.white,
                                  iconColor: Colors.white,
                                ),
                                CustomButton(
                                  buttonText: context.l10n.commonReset,
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
                                    roMachineIssueController
                                        .issueDateController.text = "";
                                    roMachineIssueController
                                        .issueDescController.text = "";
                                    roMachineIssueController
                                        .informToController.text = "";
                                    roMachineIssueController
                                        .informByController.text = "";
                                    roMachineIssueController
                                        .commentController.text = "";
                                    roMachineIssueController
                                        .infoDateController.text = "";
                                    roMachineIssueController
                                        .callAttendedByController.text = "";
                                    roMachineIssueController
                                        .correctionActionController.text = "";

                                    // controller.update();
                                    setState(() {});
                                  },
                                  buttonWidth: 100.w,
                                  primColor: Colors.grey,
                                  secColor: Colors.grey,
                                  textColor: Colors.white,
                                  iconColor: Colors.white,
                                ),
                                CustomButton(
                                  buttonText: context.l10n.commonCancel,
                                  path: 'assets/cancel.png',
                                  callB: () {
                                    Get.back();
                                  },
                                  buttonWidth: 100.w,
                                  primColor: AppColor.red,
                                  secColor: AppColor.red,
                                  textColor: Colors.white,
                                  iconColor: Colors.white,
                                ),
                              ],
                            ).paddingOnly(top: 20.h, bottom: 20.h)
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

  Widget addConsumableCard(int index, AddConsumableEntryModel cardData) {
    return Card(
      child: Column(
        children: [
          MyCustomDropdown(
            key: UniqueKey(),
            selectedItem: cardData.itenName,
            labelText: context.l10n.dqProductName,
            items: roMachineIssueController.productNameListModel
                    ?.map((e) => e.itemName)
                    .toList() ??
                [],
            hint: context.l10n.regHintSelect,
            isRequired: false,
            senValue: (value) async {
              if (value != null && selectedProdList.contains(value)) {
                CustomMessage.toast(context.l10n.dqProductShouldNotSame);
              } else {
                roMachineIssueController.selectedProdName =
                    roMachineIssueController.productNameListModel
                        ?.firstWhere((e) => e.itemName == value);

                cardData.itenName = value;
                selectedProdList.add(value);
                cardData.itemId = roMachineIssueController
                    .selectedProdName?.itemId
                    .toString();
                await roMachineIssueController.getBatchNoList(
                    userData['unitId'].toString(),
                    roMachineIssueController.selectedProdName?.itemId);
              }

              roMachineIssueController.update();
            },
            filledColor: Colors.white,
            // selectedItem: roMachineIssueController.initialInsti,
          ),
          MyCustomDropdown(
            key: UniqueKey(),
            selectedItem: cardData.batchNo,
            // selectedItem: roMachineIssueController.initialMachine,
            labelText: context.l10n.dqBatchNo,
            items: roMachineIssueController.batchNoListModel
                    ?.map((e) => e.batchNumber)
                    .toList() ??
                [],
            hint: context.l10n.regHintSelect,
            isRequired: false,
            senValue: (value) async {
              roMachineIssueController.selectdBatchNo = value;
              await roMachineIssueController.getExpiryList(
                  userData['unitId'].toString(),
                  roMachineIssueController.selectedProdName?.itemId,
                  value);
              cardData.batchNo = value;
              roMachineIssueController.update();
            },
            filledColor: Colors.white,
          ),
          MyCustomDropdown(
            key: UniqueKey(),
            selectedItem: cardData.expiryDate,
            // selectedItem: roMachineIssueController.initialMachine,
            labelText: context.l10n.dqExpiryDate,
            items: roMachineIssueController.expiryDatelst
                    ?.map((e) => e.batchNumber)
                    .toList() ??
                [],
            hint: context.l10n.regHintSelect,
            isRequired: false,
            senValue: (value) async {
              // roMachineIssueController.selectedMachine =
              //     roMachineIssueController.getMachineNameModel?.data
              //         ?.firstWhere((e) => e.machineName == value);
              cardData.expiryDate = value;
              await roMachineIssueController.getOrderListList(
                  userData['unitId'].toString(),
                  roMachineIssueController.selectedProdName?.itemId,
                  roMachineIssueController.selectdBatchNo,
                  value);
              roMachineIssueController.update();
            },
            filledColor: Colors.white,
          ),
          MyCustomDropdown(
            key: UniqueKey(),
            selectedItem: cardData.orderNo,
            // selectedItem: roMachineIssueController.initialMachine,
            labelText: context.l10n.dqOrderId,
            items: roMachineIssueController.orderIdlst
                    ?.map((e) => e.batchNumber)
                    .toList() ??
                [],
            hint: context.l10n.regHintSelect,
            isRequired: false,
            senValue: (value) {
              roMachineIssueController.selectdOrderNo = value;
              cardData.orderNo = value;
              roMachineIssueController.update();
            },
            filledColor: Colors.white,
          ),
          CustomTextField(
            key: UniqueKey(),
            initialValue: cardData.usedQuantity,
            onChanged: (value) {
              cardData.usedQuantity = value;
            },
            labelText: context.l10n.dqAvailableQuantity,
            hintText: context.l10n.regHintEnter,
            isRequired: false,
            keyBoardType: TextInputType.text,
            // txtController: roMachineIssueController.issueDescController,
            fillColor: Colors.white,
            isReadOnly: false,
            maxLines: 1,
            fontSize: 16.sp,
          ),
          CustomTextField(
            key: UniqueKey(),
            onChanged: (value) {
              cardData.consumedQuantity = value;
            },
            initialValue: cardData.consumedQuantity,
            labelText: context.l10n.dqConsumedQuantity,
            hintText: context.l10n.regHintEnter,
            isRequired: false,
            keyBoardType: TextInputType.text,
            // txtController: roMachineIssueController.informToController,
            fillColor: Colors.white,
            isReadOnly: false,
            maxLines: 1,
            fontSize: 16.sp,
          ),
          CustomTextField(
            key: UniqueKey(),
            onChanged: (value) {
              cardData.remark = value;
            },
            initialValue: cardData.remark,
            labelText: context.l10n.commonRemarks,
            hintText: context.l10n.regHintEnter,
            isRequired: false,
            keyBoardType: TextInputType.text,
            // txtController: roMachineIssueController.commentController,
            fillColor: Colors.white,
            isReadOnly: false,
            maxLines: 3,
            fontSize: 16.sp,
          ),
        ],
      ),
    );
  }

  Future<void> pickInspectionDate(
      BuildContext context, AddConsumableEntryModel cardData) async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != selectedIssueDate) {
      // setState(() {
      selectedIssueDate = picked;
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      formattedDate1 = formatter.format(selectedIssueDate!);
      // roMachineIssueController.issueDateController.text = formattedDate1;
      cardData.expiryDate = formattedDate1;
      // });
      roMachineIssueController.update();
    }
  }

  Future<void> pickNextInspecDate(BuildContext context) async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != selectedInfoDate) {
      // setState(() {
      selectedInfoDate = picked;
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      formattedDate2 = formatter.format(selectedInfoDate!);
      roMachineIssueController.infoDateController.text = formattedDate2;

      // });
      roMachineIssueController.update();
    }
  }
}
