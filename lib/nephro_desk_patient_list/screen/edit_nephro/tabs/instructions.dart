import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/add_edit_inst.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/inst_table.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/status_dialog.dart';


class Instructions extends StatefulWidget {
  final NephroList? patientData;

  const Instructions({super.key, this.patientData});

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions>
    with SingleTickerProviderStateMixin {
  final NephroController nephroController = Get.find<NephroController>();
  late TabController tabController;

  var userData;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      // setState(() {}); // Update the UI when the tab changes
      nephroController.update();
    });
    nephroController.checkboxStates = List.generate(
      nephroController.defaultInstructionList != null
          ? (nephroController.defaultInstructionList!.length)
          : 0,
      (_) => false,
    );
    nephroController.deleteButton = List.generate(
      nephroController.defaultInstructionList?.length ?? 0,
      (_) => '',
    );

    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: nephroController,
      builder: (controller) {
        return Column(
          children: [
            TabBar(
              controller: tabController,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              tabs: [
                buildTab(0, context.l10n.nephroIndividualInstructions),
                buildTab(1, context.l10n.nephroInstructions),
              ],
            ).paddingOnly(left: 8, right: 8, top: 10),
            Visibility(
              visible: tabController.index == 0,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    buttonText: context.l10n.commonSave,
                    path: 'assets/add_entry.png',
                    callB: () async {

                      var objects = nephroController.defaultInstructionList ?? [];
                      List<int> ids = nephroController.checkboxStates
                          .asMap()
                          .entries
                          .where((entry) => entry.value)
                          .map((entry) => objects[entry.key].reportInstructionID!)
                          .toList();

                      if (nephroController.checkboxStates
                          .any((e) => e == true)) {
                        var body = {
                          "treatmentId":
                              widget.patientData?.treatmentId.toString(),
                          "individualTreatmentInstructionCheckboxIDArray":
                          ids,
                          "unitId": userData['unitId'].toString(),
                          "userId": userData['user_ID']
                        };

                        await controller.saveInstructions(context,
                            body,
                            widget.patientData?.treatmentId.toString(),
                            widget.patientData?.patientId.toString());
                        // ✅ RESET CHECKBOXES AFTER SAVE
                        nephroController.checkboxStates = List.generate(
                          nephroController.defaultInstructionList?.length ?? 0,
                              (_) => false,
                        );

                        nephroController.defaultInstructionList
                            ?.forEach((e) => e.isSelected = false);

                        nephroController.update();
                      } else {
                        CustomMessage.toast(context.l10n.nephroSelectCheckbox);
                      }
                    },
                    buttonWidth: 80,
                    primColor: AppColor.primaryBackgroundColor,
                    secColor: AppColor.secondaryColor,
                    textColor: Colors.white,
                    iconColor: Colors.white,
                  ).paddingSymmetric(vertical: 10, horizontal: 10),
                  CustomButton(
                    buttonText: context.l10n.nephroAddNewInstruction,
                    path: 'assets/save-ro-disinfec.png',
                    callB: () {
                      Get.to(AddEditInst(
                        isEdit: false,
                        patientData: widget.patientData,
                      ));
                    },
                    buttonWidth: 205,
                    primColor: AppColor.primaryBackgroundColor,
                    secColor: AppColor.secondaryColor,
                    textColor: Colors.white,
                    iconColor: Colors.white,
                  ).paddingSymmetric(vertical: 10, horizontal: 10),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: [
                InstTable(
                  l1: nephroController.checkboxStates,
                  l2: nephroController.defaultInstructionList
                          ?.map((e) => e.reportInstruction!)
                          .toList() ??
                      [],
                  l3: List.generate(
                      nephroController.defaultInstructionList?.length ?? 0,
                      (index) => (index + 1).toString()),
                  tableHeader: [
                    context.l10n.colSrNo,
                    context.l10n.dqInstruction,
                    context.l10n.nephroAction,
                    context.l10n.commonEdit,
                    context.l10n.commonDelete
                  ],
                  // Correct order
                  onButtonPressed: handleButtonPress,
                  onEdit: (index) {
                    Get.to(AddEditInst(
                      isEdit: true,
                      patientData: widget.patientData,
                    ));
                  },
                  // onDelete: (index) async {
                  //   await controller.deleteIndivisualInst(
                  //       userData['user_ID'],
                  //       nephroController
                  //           .defaultInstructionList?[index].reportInstructionID,
                  //       widget.patientData?.treatmentId,
                  //       widget.patientData?.patientId,
                  //       userData['unitId'].toString()
                  //   );
                  //
                  //   nephroController.checkboxStates = List.generate(
                  //     nephroController.defaultInstructionList?.length ?? 0,
                  //         (_) => false,
                  //   );
                  //
                  //   nephroController.defaultInstructionList
                  //       ?.forEach((e) => e.isSelected = false);
                  //
                  //   nephroController.update();
                  // },
                  onDelete: (index) {
                    showCustomSnackBar(
                      topTitle: context.l10n.nephroDeleteInstruction,
                      img: 'assets/check 1.png',
                      title: context.l10n.nephroDeleteInstructionConfirm,
                      onPress1: () {
                        // No pressed → just close
                        Get.back(); // Close dialog
                      },
                      onPress2: () async {
                        // Yes pressed → delete the instruction
                        Get.back(); // Close dialog first

                        // await controller.deleteIndivisualInst(
                        //   userData['user_ID'],
                        //   nephroController.defaultInstructionList?[index].reportInstructionID,
                        //   widget.patientData?.treatmentId,
                        //   widget.patientData?.patientId,
                        //   userData['unitId'].toString(),
                        // );

                        await controller.deleteIndivisualInst(
                                userData['user_ID'],
                                nephroController
                                    .defaultInstructionList?[index].reportInstructionID,
                                widget.patientData?.treatmentId,
                                widget.patientData?.patientId,
                                userData['unitId'].toString()
                            );
                       // Reset checkboxes after deletion
                        nephroController.checkboxStates = List.generate(
                          nephroController.defaultInstructionList?.length ?? 0,
                              (_) => false,
                        );

                        nephroController.defaultInstructionList
                            ?.forEach((e) => e.isSelected = false);

                        nephroController.update();
                      },
                      buttonTitle: context.l10n.commonNo,
                      buttonTitle2: context.l10n.commonYes,
                      context: context,
                    );
                  },

                  onChecked: (List value) {
                    int index = value.first;
                    bool selectedValue = value[1];

                    // Update the local state
                    setState(() {
                      nephroController.checkboxStates[index] = selectedValue;
                    });

                    // Update the controller state
                    if (nephroController.defaultInstructionList != null &&
                        index <
                            nephroController.defaultInstructionList!.length) {
                      nephroController.defaultInstructionList![index]
                          .isSelected = selectedValue;
                    }
                    nephroController.update();
                  },
                  l4: nephroController.checkboxStates,
                  l5: List.generate(
                      nephroController.defaultInstructionList?.length ?? 0,
                      (index) => (index + 1).toString()
                  ),
                ),
                InstructionsTable(
                    l1: nephroController.deleteButton,
                    l2: nephroController.instructionsList
                            ?.map((e) => e.reportInstruction!)
                            .toList() ??
                        [],
                    l3: List.generate(
                        nephroController.instructionsList?.length ?? 0,
                        (index) => (index + 1).toString()),
                    tableHeader: [
                      context.l10n.colSrNo,
                      context.l10n.colInstructionName,
                      context.l10n.nephroAction
                    ],
                    // Correct order
                    onButtonPressed: handleButtonPress,
                    onAdd: () {
                      Get.to(AddEditInst(
                        isEdit: false,
                        patientData: widget.patientData,
                      ));
                    },
                    onChecked: (value) async {
                      showCustomSnackBar(
                        topTitle: context.l10n.nephroDeleteInstruction,
                        img: 'assets/check 1.png',
                        title: context.l10n.nephroDeleteInstructionConfirm,
                        buttonTitle: context.l10n.commonNo,
                        buttonTitle2: context.l10n.commonYes,
                        onPress1: () {
                          Get.back(); // close popup
                        },
                        onPress2: () async {
                          Get.back(); // close popup first

                          await controller.deleteInstruction(
                              userData['user_ID'],
                              nephroController.instructionsList?[value]
                                  .idindividualtreatmentinstruction,
                              widget.patientData?.treatmentId.toString(),
                              widget.patientData?.patientId.toString());

                          // Optional: refresh UI if needed
                          nephroController.update();
                        },

                        context: context,
                      );
                      // await controller.deleteInstruction(
                      //     userData['user_ID'],
                      //     nephroController.instructionsList?[value]
                      //         .idindividualtreatmentinstruction,
                      //     widget.patientData?.treatmentId.toString(),
                      //     widget.patientData?.patientId.toString());
                    }
                    ),
              ],
            ))
          ],
        );
      },
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

  handleButtonPress(int index) {
    // Perform action based on the index
    if (index == 0) {
      debugPrint('Button pressed at index: $index');
    } else if (index == 1) {
      debugPrint('Button pressed at index: $index');
    }
  }
}
