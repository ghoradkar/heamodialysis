import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/controller/ro_log_sheet_controller.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/add_ro_log_sheet_request_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/backwash_rinse_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/before_after_hardness_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/post_carbon_chlorid_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/raw_water_tds_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/return_loop_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/ro_log_sheet_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/ro_water_conduct_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/ro_water_tds_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/sand_pre_post_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/softner_available_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/screen/ro_log_sheet_list.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class AddRoLogSheet extends StatefulWidget {
  final RoLogSheetData? roLogSheetData;
  final bool? isEdit;

  const AddRoLogSheet({
    super.key,
    this.roLogSheetData,
    this.isEdit,
  });

  @override
  State<AddRoLogSheet> createState() => _AddRoLogSheetState();
}

class _AddRoLogSheetState extends State<AddRoLogSheet> {
  final RoLogSheetController roMachineIssueLogController =
      Get.put(RoLogSheetController());

  DateTime? _selectedFromDate;

  String? formattedFromDate;

  String? selectedPre;

  String? selectedSoftnerAvailable;
  String? selectedBeforeRegiHardness;
  String? selectedPostCarbonCloride;
  String? selectedRangePsi;
  String? selectedAfterRegiHardness;
  String? selectedRoWaterConductivity;
  String? selectedCheckBy;
  List<CheckBy> checkByList = [CheckBy(l10n.commonActive, 0), CheckBy(l10n.commonInactive, 1)];
  String? selectedPost;

  // String selectedCarbonPost = '0';

  String? selectedRawWaterTdsRange;
  String? selectedRoWaterRange;
  String selectedSoftnerPost = "0";
  String? selectedBackwash;

  // String? selectedBackwashCarbon;
  String? selectedRinse;

  // String? selectedCarbonRinse;
  String? selectedSandDoneBy;
  String? selectedSoftnerDoneBy;

  // String? selectedCarbonDoneBy;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<AddRoLogSheetRequestModel> carbonCommentsList = [];
  List<AddRoLogSheetRequestModel> sofnerCommentsList = [];

  // TextEditingController pincodeController = TextEditingController();
  // TextEditingController addressController = TextEditingController();

  String? pickedTime;

  bool ufCheckedValue = false;
  bool doingCheckedValue = false;

  bool hasInternet = true;

  var userData;

  String? selectedMachineName;
  String? selectedInstName;

  RoWaterConductData? roWConduc;

  void addCard() {
    setState(() {
      carbonCommentsList.add(AddRoLogSheetRequestModel());
    });
  }

  void removeCard(int index) {
    if (carbonCommentsList.length > 1) {
      setState(() {
        carbonCommentsList.removeAt(index);
      });
    }
  }

  void addSoftnerCard() {
    setState(() {
      sofnerCommentsList.add(AddRoLogSheetRequestModel(
          softenerRegenerationTime: DatePickerHelper().getCurrentTime24Hour()));
    });
  }

  void removeSoftnerCard(int index) {
    if (sofnerCommentsList.length > 1) {
      setState(() {
        sofnerCommentsList.removeAt(index);
      });
    }
  }

  @override
  void initState() {
    getUserData();
    if (widget.isEdit != true) {
      carbonCommentsList.add(AddRoLogSheetRequestModel());
      sofnerCommentsList.add(AddRoLogSheetRequestModel(
          softenerRegenerationTime: DatePickerHelper().getCurrentTime24Hour()));
    }
    checkInternetAndLoadData();

    super.initState();
  }

  @override
  void dispose() {
    roMachineIssueLogController.setFieldsBlank();

    super.dispose();
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
      await roMachineIssueLogController.getInstituteList();
      await roMachineIssueLogController.getMachineList(userData['unitId']);
      await roMachineIssueLogController.getSandPrePost();
      await roMachineIssueLogController.getBackwashRinse();
      await roMachineIssueLogController.getSoftnerAvailable();
      await roMachineIssueLogController.getDoneByList(userData['unitId']);
      await roMachineIssueLogController.getBeforeAfterHardness();
      await roMachineIssueLogController.getRawWaterTds();
      await roMachineIssueLogController.getRoWaterTds();
      await roMachineIssueLogController.getPostCarbonChloride();
      await roMachineIssueLogController.getRoWaterConduct();
      await roMachineIssueLogController.getReturnLoopRange();
      // if (userData['unitId'] != "1") {
      if(widget.isEdit == false || widget.isEdit == null) {
        var ins = roMachineIssueLogController.instituteList?.data
            ?.firstWhere((e) => e.unitId == userData['unitId']);
        selectedInstName = ins?.unitName;
        // }
      }
      if (widget.isEdit == true) {
        await roMachineIssueLogController
            .getInitialValueForEdit(widget.roLogSheetData?.roLogSheetId);
      }
    }
    if (widget.isEdit == true) setValues();

    // roMachineIssueLogController.update();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: context.l10n.roAddLogSheet,
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              // Get.back();
              Get.to(const RoLogSheetList());
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body: GetBuilder<RoLogSheetController>(
          init: roMachineIssueLogController,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ?  Center(child: buildShimmerLoader())
                    : SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColor.borderColor)),
                                child: Column(
                                  children: [
                                    MyCustomDropdown(
                                      selectedItem: selectedInstName,
                                      isViewProfile: userData['unitId'] == 1
                                          ? false:true,
                                      labelText: context.l10n.colInstituteName,
                                      items: controller.instituteList?.data
                                              ?.map((e) => e.unitName)
                                              .toList() ??
                                          [],
                                      hint: context.l10n.regHintSelect,
                                      isRequired: false,
                                      senValue: (value) {
                                        selectedInstName = value;
                                        roMachineIssueLogController.update();
                                      },
                                      filledColor: Colors.white,
                                    ),
                                    MyCustomDropdown(
                                      selectedItem: selectedMachineName,
                                      labelText: context.l10n.machMachineName,
                                      items: controller
                                              .getMachineNameModel?.data
                                              ?.map((e) => e.machineName)
                                              .toList() ??
                                          [],
                                      hint: context.l10n.regHintSelect,
                                      isRequired: false,
                                      senValue: (value) {
                                        selectedMachineName = value;
                                        roMachineIssueLogController.update();
                                      },
                                      filledColor: Colors.white,
                                    ),
                                    CustomDateField(
                                      labelText: context.l10n.commonDate,
                                      hint: context.l10n.dashSelectDate,
                                      isRequired: false,
                                      callB: () {
                                        selectFromDate();
                                      },
                                      selectedDate: roMachineIssueLogController
                                          .dateController,
                                      filledColor: Colors.white,
                                      dontDhowPrefix: false,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ExpansionTile(
                                      maintainState: true,
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      title: Row(children: [
                                        Image.asset(
                                            "assets/user_textfield.png"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        CustomText(
                                          text: context.l10n.roSand,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.start,
                                        )
                                      ]),
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(color: Colors.grey)
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 8),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: CustomText(
                                                    text: context.l10n.roSandFilterPressurePsi,
                                                    fontSize: 16,
                                                    fontFam: "Lato",
                                                    fontWeight: FontWeight.bold,
                                                    textColor: Colors.black,
                                                    textAlign: TextAlign.start),
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: MyCustomDropdown(
                                                        selectedItem:
                                                            selectedPre,
                                                        labelText: context.l10n.roPre,
                                                        items: roMachineIssueLogController
                                                                .sandFilterPrePostModel
                                                                ?.data
                                                                ?.map((e) => e
                                                                    .lookupDetDescEn)
                                                                .toList() ??
                                                            [],
                                                        hint: context.l10n.regHintSelect,
                                                        isRequired: false,
                                                        senValue: (value) {
                                                          selectedPre = value;
                                                          calculateSandDifference();
                                                          roMachineIssueLogController
                                                              .update();
                                                        },
                                                        filledColor:
                                                            Colors.white),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: MyCustomDropdown(
                                                        selectedItem:
                                                            selectedPost,
                                                        labelText: context.l10n.roPost,
                                                        items: roMachineIssueLogController
                                                                .sandFilterPrePostModel
                                                                ?.data
                                                                ?.map((e) => e
                                                                    .lookupDetValue)
                                                                .toList() ??
                                                            [],
                                                        hint: context.l10n.regHintSelect,
                                                        isRequired: false,
                                                        senValue: (value) {
                                                          selectedPost = value;
                                                          calculateSandDifference();

                                                          roMachineIssueLogController
                                                              .update();
                                                        },
                                                        filledColor:
                                                            Colors.white),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: CustomTextField(
                                                        fontSize: 16,
                                                        onChanged: (value) {},
                                                        maxLines: 1,
                                                        isReadOnly: true,
                                                        keyBoardType:
                                                            TextInputType
                                                                .number,
                                                        labelText: context.l10n.roDifference,
                                                        hintText: context.l10n.regHintEnter,
                                                        isRequired: false,
                                                        txtController:
                                                            roMachineIssueLogController
                                                                .difference,
                                                        fillColor:
                                                            Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              const SizedBox(height: 12),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: CustomText(
                                                    text: context.l10n.roSandFilter,
                                                    fontSize: 16,
                                                    fontFam: "Lato",
                                                    fontWeight: FontWeight.bold,
                                                    textColor: Colors.black,
                                                    textAlign: TextAlign.start),
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: MyCustomDropdown(
                                                        selectedItem:
                                                            selectedBackwash,
                                                        labelText: context.l10n.roBackwash,
                                                        items: roMachineIssueLogController
                                                                .getBackWashAndRinseModel
                                                                ?.data
                                                                ?.map((e) => e
                                                                    .lookupDetValue)
                                                                .toList() ??
                                                            [],
                                                        hint: context.l10n.regHintSelect,
                                                        isRequired: false,
                                                        senValue: (value) {
                                                          selectedBackwash =
                                                              value;
                                                          roMachineIssueLogController
                                                              .update();
                                                        },
                                                        filledColor:
                                                            Colors.white),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: MyCustomDropdown(
                                                        selectedItem:
                                                            selectedRinse,
                                                        labelText: context.l10n.roRinse,
                                                        items: roMachineIssueLogController
                                                                .getBackWashAndRinseModel
                                                                ?.data
                                                                ?.map((e) => e
                                                                    .lookupDetDescEn)
                                                                .toList() ??
                                                            [],
                                                        hint: context.l10n.regHintSelect,
                                                        isRequired: false,
                                                        senValue: (value) {
                                                          selectedRinse = value;
                                                          roMachineIssueLogController
                                                              .update();
                                                        },
                                                        filledColor:
                                                            Colors.white),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: MyCustomDropdown(
                                                        selectedItem:
                                                            selectedSandDoneBy,
                                                        labelText: context.l10n.roDoneBy,
                                                        items: roMachineIssueLogController
                                                                .doneByModel
                                                                ?.data
                                                                ?.map((e) =>
                                                                    e.username)
                                                                .toList() ??
                                                            [],
                                                        hint: context.l10n.regHintSelect,
                                                        isRequired: false,
                                                        senValue: (value) {
                                                          selectedSandDoneBy =
                                                              value;
                                                          roMachineIssueLogController
                                                              .update();
                                                        },
                                                        filledColor:
                                                            Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ExpansionTile(
                                      maintainState: true,
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      title: Row(children: [
                                        Image.asset(
                                            "assets/user_textfield.png"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        CustomText(
                                          text: context.l10n.roCarbon,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.start,
                                        )
                                      ]),
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(color: Colors.grey)
                                          ),
                                          child: Column(
                                            children: [
                                              ...carbonCommentsList
                                                  .asMap()
                                                  .entries
                                                  .map((entry) {
                                                int index = entry.key;
                                                AddRoLogSheetRequestModel
                                                    cardData = entry.value;
                                                return customCard(
                                                    index, cardData);
                                              }),
                                              ...[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        addCard();
                                                      },
                                                      icon: const Icon(Icons
                                                          .add_circle_outline),
                                                      color: Colors.green,
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        removeCard(
                                                            carbonCommentsList
                                                                    .length -
                                                                1);
                                                      },
                                                      icon: const Icon(Icons
                                                          .remove_circle_outline),
                                                      color: AppColor.red,
                                                    )
                                                  ],
                                                )
                                              ]
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ExpansionTile(
                                      maintainState: true,
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      title: Row(children: [
                                        Image.asset(
                                            "assets/user_textfield.png"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        CustomText(
                                          text: context.l10n.roSoftner,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.start,
                                        )
                                      ]),
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(color: Colors.grey)
                                          ),
                                          child: Column(
                                            children: [
                                              MyCustomDropdown(
                                                  selectedItem:
                                                      selectedSoftnerAvailable,
                                                  labelText:
                                                      context.l10n.roSoftenerAvailable,
                                                  items: roMachineIssueLogController
                                                          .softnerAvailableModel
                                                          ?.data
                                                          ?.map((e) =>
                                                              e.lookupDetDescEn)
                                                          .toList() ??
                                                      [],
                                                  hint: context.l10n.regHintSelect,
                                                  isRequired: false,
                                                  senValue: (value) {
                                                    selectedSoftnerAvailable =
                                                        value;
                                                    roMachineIssueLogController
                                                        .update();
                                                  },
                                                  filledColor: Colors.white),
                                              ...sofnerCommentsList
                                                  .asMap()
                                                  .entries
                                                  .map((entry) {
                                                int index = entry.key;
                                                AddRoLogSheetRequestModel
                                                    cardData = entry.value;
                                                return customSoftnerCard(
                                                  index,
                                                  cardData,
                                                );
                                              }),
                                              ...[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        addSoftnerCard();
                                                      },
                                                      icon: const Icon(Icons
                                                          .add_circle_outline),
                                                      color: Colors.green,
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        removeSoftnerCard(
                                                            sofnerCommentsList
                                                                    .length -
                                                                1);
                                                      },
                                                      icon: const Icon(Icons
                                                          .remove_circle_outline),
                                                      color: AppColor.red,
                                                    )
                                                  ],
                                                )
                                              ]
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ExpansionTile(
                                      maintainState: true,
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      title: Row(children: [
                                        Image.asset(
                                            "assets/user_textfield.png"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        CustomText(
                                          text: context.l10n.roHardnessPostSoftenerPpm,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.start,
                                        )
                                      ]),
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(color: Colors.grey)
                                          ),
                                          child: Column(
                                            children: [
                                              MyCustomDropdown(
                                                  selectedItem:
                                                      selectedBeforeRegiHardness,
                                                  labelText:
                                                      context.l10n.roBeforeRegenerationHardnessPpm,
                                                  items: roMachineIssueLogController
                                                          .beforAfterHardnessModel
                                                          ?.data
                                                          ?.map((e) =>
                                                              e.lookupDetValue)
                                                          .toList() ??
                                                      [],
                                                  hint: context.l10n.regHintSelect,
                                                  isRequired: false,
                                                  senValue: (value) {
                                                    selectedBeforeRegiHardness =
                                                        value;
                                                    roMachineIssueLogController
                                                        .selectedRange = value!;
                                                    roMachineIssueLogController
                                                            .errorMessage =
                                                        null; // Clear error message on range change
                                                    roMachineIssueLogController
                                                        .commentsHardnessSotnerController
                                                        .clear(); // Clear text field on range change
                                                    roMachineIssueLogController
                                                        .update();
                                                  },
                                                  filledColor: Colors.white),
                                              const SizedBox(height: 8),
                                              CustomTextField(
                                                  fontSize: 16,
                                                  onChanged: (value) {
                                                    // roMachineIssueLogController
                                                    //         .errorMessage =
                                                    //     validateValue(
                                                    //         value,
                                                    //         roMachineIssueLogController
                                                    //             .selectedRange);
                                                    // roMachineIssueLogController
                                                    //     .update();
                                                  },
                                                  // errorM:
                                                  //     roMachineIssueLogController
                                                  //         .errorMessage,
                                                  maxLines: 1,
                                                  isReadOnly: false,
                                                  keyBoardType:
                                                      TextInputType.text,
                                                  labelText: context.l10n.commonComments,
                                                  hintText: context.l10n.regHintEnter,
                                                  isRequired: false,
                                                  txtController:
                                                      roMachineIssueLogController
                                                          .commentsHardnessSotnerController,
                                                  fillColor: Colors.white),
                                              const SizedBox(height: 8),
                                              MyCustomDropdown(
                                                  selectedItem:
                                                      selectedAfterRegiHardness,
                                                  labelText:
                                                      context.l10n.roAfterRegenerationHardnessPpm,
                                                  items: roMachineIssueLogController
                                                          .beforAfterHardnessModel
                                                          ?.data
                                                          ?.map((e) =>
                                                              e.lookupDetDescEn)
                                                          .toList() ??
                                                      [],
                                                  hint: context.l10n.regHintSelect,
                                                  isRequired: false,
                                                  senValue: (value) {
                                                    selectedAfterRegiHardness =
                                                        value;
                                                    roMachineIssueLogController
                                                            .selectedRange2 =
                                                        value!;
                                                    roMachineIssueLogController
                                                            .errorMessage1 =
                                                        null; // Clear error message on range change
                                                    roMachineIssueLogController
                                                        .commentsAfterRegiHardnessController
                                                        .clear();
                                                    roMachineIssueLogController
                                                        .update();
                                                  },
                                                  filledColor: Colors.white),
                                              const SizedBox(height: 8),
                                              CustomTextField(
                                                  fontSize: 16,
                                                  onChanged: (value) {
                                                    // roMachineIssueLogController
                                                    //         .errorMessage1 =
                                                    //     validateValue(
                                                    //         value,
                                                    //         roMachineIssueLogController
                                                    //             .selectedRange2);
                                                    // roMachineIssueLogController
                                                    //     .update();
                                                  },
                                                  maxLines: 1,
                                                  // errorM:
                                                  //     roMachineIssueLogController
                                                  //         .errorMessage1,
                                                  isReadOnly: false,
                                                  keyBoardType:
                                                      TextInputType.text,
                                                  labelText: context.l10n.commonComments,
                                                  hintText: context.l10n.regHintEnter,
                                                  isRequired: false,
                                                  txtController:
                                                      roMachineIssueLogController
                                                          .commentsAfterRegiHardnessController,
                                                  fillColor: Colors.white),
                                              const SizedBox(height: 8),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ExpansionTile(
                                      maintainState: true,
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      title: Row(children: [
                                        Image.asset(
                                            "assets/user_textfield.png"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        CustomText(
                                          text: context.l10n.roWater,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.start,
                                        )
                                      ]),
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(color: Colors.grey)
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 8),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: CustomText(
                                                    text: context.l10n.roRawWaterTds,
                                                    fontSize: 16,
                                                    fontFam: "Lato",
                                                    fontWeight: FontWeight.bold,
                                                    textColor: Colors.black,
                                                    textAlign: TextAlign.start),
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: MyCustomDropdown(
                                                        selectedItem:
                                                            selectedRawWaterTdsRange,
                                                        labelText: context.l10n.roRange,
                                                        items: roMachineIssueLogController
                                                                .rawWaterTdsModel
                                                                ?.data
                                                                ?.map((e) => e
                                                                    .lookupDetDescEn)
                                                                .toList() ??
                                                            [],
                                                        hint: context.l10n.regHintSelect,
                                                        isRequired: false,
                                                        senValue: (value) {
                                                          selectedRawWaterTdsRange =
                                                              value;
                                                          roMachineIssueLogController
                                                                  .selectedRange3 =
                                                              value!;
                                                          roMachineIssueLogController
                                                                  .errorMessage3 =
                                                              null; // Clear error message on range change
                                                          roMachineIssueLogController
                                                              .value
                                                              .clear();
                                                          roMachineIssueLogController
                                                              .update();
                                                        },
                                                        filledColor:
                                                            Colors.white),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: CustomTextField(
                                                        fontSize: 16,
                                                        onChanged: (value) {
                                                          roMachineIssueLogController
                                                                  .errorMessage3 =
                                                              validateValue(
                                                                  value,
                                                                  roMachineIssueLogController
                                                                      .selectedRange3);
                                                          roMachineIssueLogController
                                                              .update();
                                                        },
                                                        errorM:
                                                            roMachineIssueLogController
                                                                .errorMessage3,
                                                        maxLines: 1,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType
                                                                .number,
                                                        labelText: context.l10n.commonValue,
                                                        hintText: context.l10n.regHintEnter,
                                                        isRequired: false,
                                                        txtController:
                                                            roMachineIssueLogController
                                                                .value,
                                                        fillColor:
                                                            Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: CustomText(
                                                    text: context.l10n.roRoWaterTds,
                                                    fontSize: 16,
                                                    fontFam: "Lato",
                                                    fontWeight: FontWeight.bold,
                                                    textColor: Colors.black,
                                                    textAlign: TextAlign.start),
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: MyCustomDropdown(
                                                        selectedItem:
                                                            selectedRoWaterRange,
                                                        labelText: context.l10n.roRange,
                                                        items: roMachineIssueLogController
                                                                .roWaterTdsModel
                                                                ?.data
                                                                ?.map((e) => e
                                                                    .lookupDetDescEn)
                                                                .toList() ??
                                                            [],
                                                        hint: context.l10n.regHintSelect,
                                                        isRequired: false,
                                                        senValue: (value) {
                                                          selectedRoWaterRange =
                                                              value;
                                                          roMachineIssueLogController
                                                                  .selectedRange4 =
                                                              value!;
                                                          roMachineIssueLogController
                                                                  .errorMessage4 =
                                                              null; // Clear error message on range change
                                                          roMachineIssueLogController
                                                              .value1
                                                              .clear();

                                                          roMachineIssueLogController
                                                              .update();
                                                        },
                                                        filledColor:
                                                            Colors.white),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: CustomTextField(
                                                        fontSize: 16,
                                                        onChanged: (value) {
                                                          roMachineIssueLogController
                                                                  .errorMessage4 =
                                                              validateValue(
                                                                  value,
                                                                  roMachineIssueLogController
                                                                      .selectedRange4);
                                                          roMachineIssueLogController
                                                              .update();
                                                        },
                                                        maxLines: 1,
                                                        errorM:
                                                            roMachineIssueLogController
                                                                .errorMessage4,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType
                                                                .number,
                                                        labelText: context.l10n.commonValue,
                                                        hintText: context.l10n.regHintEnter,
                                                        isRequired: false,
                                                        txtController:
                                                            roMachineIssueLogController
                                                                .value1,
                                                        fillColor:
                                                            Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: CustomTextField(
                                                        fontSize: 16,
                                                        onChanged: (value) {},
                                                        maxLines: 1,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType
                                                                .number,
                                                        labelText:
                                                            context.l10n.roPreMembranePressure,
                                                        hintText: context.l10n.regHintEnter,
                                                        isRequired: false,
                                                        txtController:
                                                            roMachineIssueLogController
                                                                .preMembranePressure,
                                                        fillColor:
                                                            Colors.white),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: CustomTextField(
                                                        fontSize: 16,
                                                        onChanged: (value) {
                                                          calculateWaterDifference();
                                                        },
                                                        maxLines: 1,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType
                                                                .number,
                                                        labelText:
                                                            context.l10n.roRejectPressure,
                                                        hintText: context.l10n.regHintEnter,
                                                        isRequired: false,
                                                        txtController:
                                                            roMachineIssueLogController
                                                                .rejectedPressure,
                                                        fillColor:
                                                            Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: CustomTextField(
                                                        fontSize: 16,
                                                        onChanged: (value) {},
                                                        maxLines: 1,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType
                                                                .number,
                                                        labelText: context.l10n.roDifference,
                                                        hintText: context.l10n.regHintEnter,
                                                        isRequired: false,
                                                        txtController:
                                                            roMachineIssueLogController
                                                                .difference1,
                                                        fillColor:
                                                            Colors.white),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: CustomTextField(
                                                        fontSize: 16,
                                                        onChanged: (value) {},
                                                        maxLines: 1,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType
                                                                .number,
                                                        labelText:
                                                            context.l10n.roPermeateFlowLph,
                                                        hintText: context.l10n.regHintEnter,
                                                        isRequired: false,
                                                        txtController:
                                                            roMachineIssueLogController
                                                                .lph,
                                                        fillColor:
                                                            Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ExpansionTile(
                                      maintainState: true,
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      title: Row(children: [
                                        Image.asset(
                                            "assets/user_textfield.png"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        CustomText(
                                          text: context.l10n.roCarbonChlorideWaterConductivity,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.start,
                                        )
                                      ]),
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(color: Colors.grey)
                                          ),
                                          child: Column(
                                            children: [
                                              MyCustomDropdown(
                                                  selectedItem:
                                                      selectedPostCarbonCloride,
                                                  labelText:
                                                      context.l10n.roPostCarbonChloridePpm,
                                                  items: roMachineIssueLogController
                                                          .postCarbonChloridModel
                                                          ?.data
                                                          ?.map((e) =>
                                                              e.lookupDetDescEn)
                                                          .toList() ??
                                                      [],
                                                  hint: context.l10n.regHintSelect,
                                                  isRequired: false,
                                                  senValue: (value) {
                                                    selectedPostCarbonCloride =
                                                        value;
                                                    roMachineIssueLogController
                                                            .selectedRange5 =
                                                        value!;
                                                    roMachineIssueLogController
                                                            .errorMessage5 =
                                                        null; // Clear error message on range change
                                                    roMachineIssueLogController
                                                        .commentsCarbonChlorideController
                                                        .clear();
                                                    roMachineIssueLogController
                                                        .update();
                                                  },
                                                  filledColor: Colors.white),
                                              const SizedBox(height: 8),
                                              CustomTextField(
                                                  fontSize: 16,
                                                  onChanged: (value) {
                                                    // roMachineIssueLogController
                                                    //         .errorMessage5 =
                                                    //     validateValue(
                                                    //         value,
                                                    //         roMachineIssueLogController
                                                    //             .selectedRange5);
                                                    // roMachineIssueLogController
                                                    //     .update();
                                                  },
                                                  // errorM:
                                                  //     roMachineIssueLogController
                                                  //         .errorMessage5,
                                                  maxLines: 1,
                                                  isReadOnly: false,
                                                  keyBoardType:
                                                      TextInputType.text,
                                                  labelText: context.l10n.commonComments,
                                                  hintText: context.l10n.regHintEnter,
                                                  isRequired: false,
                                                  txtController:
                                                      roMachineIssueLogController
                                                          .commentsCarbonChlorideController,
                                                  fillColor: Colors.white),
                                              const SizedBox(height: 8),
                                              MyCustomDropdown(
                                                  selectedItem:
                                                      selectedRoWaterConductivity,
                                                  labelText:
                                                      context.l10n.roRoWaterConductivity,
                                                  items: roMachineIssueLogController
                                                          .roWaterConductivityModel
                                                          ?.data
                                                          ?.map((e) =>
                                                              e.lookupDetValue)
                                                          .toList() ??
                                                      [],
                                                  hint: context.l10n.regHintSelect,
                                                  isRequired: false,
                                                  senValue: (value) {
                                                    selectedRoWaterConductivity =
                                                        value;
                                                    RoWaterConductData?
                                                        roWater =
                                                        roMachineIssueLogController
                                                            .roWaterConductivityModel
                                                            ?.data
                                                            ?.firstWhere((e) =>
                                                                e.lookupDetValue ==
                                                                selectedRoWaterConductivity);
                                                    roMachineIssueLogController
                                                            .addRoLogSheetRequestModel
                                                            .lookupDetIdRoWaterConductivity =
                                                        roWater?.lookupDetId;
                                                    roMachineIssueLogController
                                                            .selectedRange6 =
                                                        value!;
                                                    roMachineIssueLogController
                                                            .errorMessage6 =
                                                        null; // Clear error message on range change
                                                    roMachineIssueLogController
                                                        .commentsRoWaterController
                                                        .clear();
                                                    roMachineIssueLogController
                                                        .update();
                                                  },
                                                  filledColor: Colors.white),
                                              const SizedBox(height: 8),
                                              CustomTextField(
                                                  fontSize: 16,
                                                  onChanged: (value
                                                      ) {
                                                    roMachineIssueLogController
                                                            .addRoLogSheetRequestModel
                                                            .roWaterConductivityValue =
                                                        int.parse(
                                                            roMachineIssueLogController
                                                                .commentsRoWaterController
                                                                .text);
                                                    // roMachineIssueLogController
                                                    //         .errorMessage6 =
                                                    //     validateValue(
                                                    //         value,
                                                    //         roMachineIssueLogController
                                                    //             .selectedRange6);
                                                    roMachineIssueLogController
                                                        .update();
                                                  },
                                                  // errorM:
                                                  //     roMachineIssueLogController
                                                  //         .errorMessage6,
                                                  maxLines: 1,
                                                  isReadOnly: false,
                                                  keyBoardType:
                                                      TextInputType.text,
                                                  labelText: context.l10n.commonComments,
                                                  hintText: context.l10n.regHintEnter,
                                                  isRequired: false,
                                                  txtController:
                                                      roMachineIssueLogController
                                                          .commentsRoWaterController,
                                                  fillColor: Colors.white),
                                              const SizedBox(height: 8),
                                              CustomTextField(
                                                  fontSize: 16,
                                                  onChanged: (value) {},
                                                  maxLines: 1,
                                                  isReadOnly: false,
                                                  keyBoardType:
                                                      TextInputType.number,
                                                  labelText: context.l10n.roRejectFlowLph,
                                                  hintText: context.l10n.regHintEnter,
                                                  isRequired: false,
                                                  txtController:
                                                      roMachineIssueLogController
                                                          .rejectedFlow,
                                                  fillColor: Colors.white),
                                              const SizedBox(height: 8),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ExpansionTile(
                                      maintainState: true,
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      title: Row(children: [
                                        Image.asset(
                                            "assets/user_textfield.png"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        CustomText(
                                          text: context.l10n.roPump,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.start,
                                        )
                                      ]),
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(color: Colors.grey)
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child:
                                                            CustomCheckboxGroup(
                                                      title: context.l10n.roRawWaterPump,
                                                      firstValue:
                                                          roMachineIssueLogController
                                                              .rwpFirstCheckBox,
                                                      secondValue:
                                                          roMachineIssueLogController
                                                              .rwpSecondCheckBox,
                                                      onChangedFirst: (value) {
                                                        roMachineIssueLogController
                                                                .rwpFirstCheckBox =
                                                            value ?? false;
                                                        setState(() {});
                                                      },
                                                      onChangedSecond: (value) {
                                                        roMachineIssueLogController
                                                                .rwpSecondCheckBox =
                                                            value ?? false;
                                                        setState(() {});
                                                      },
                                                    )),
                                                    Expanded(
                                                        child:
                                                            CustomCheckboxGroup(
                                                      title:
                                                          context.l10n.roHighPressurePump,
                                                      firstValue:
                                                          roMachineIssueLogController
                                                              .hppFirstCheckBox,
                                                      secondValue:
                                                          roMachineIssueLogController
                                                              .hppSecondCheckBox,
                                                      onChangedFirst: (value) {
                                                        roMachineIssueLogController
                                                                .hppFirstCheckBox =
                                                            value ?? false;
                                                        setState(() {});
                                                      },
                                                      onChangedSecond: (value) {
                                                        roMachineIssueLogController
                                                                .hppSecondCheckBox =
                                                            value ?? false;
                                                        setState(() {});
                                                      },
                                                    ))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child:
                                                            CustomCheckboxGroup(
                                                      title: context.l10n.roTransferPump,
                                                      firstValue:
                                                          roMachineIssueLogController
                                                              .tpFirstCheckBox,
                                                      secondValue:
                                                          roMachineIssueLogController
                                                              .tpSecondCheckBox,
                                                      onChangedFirst: (value) {
                                                        roMachineIssueLogController
                                                                .tpFirstCheckBox =
                                                            value ?? false;
                                                        setState(() {});
                                                      },
                                                      onChangedSecond: (value) {
                                                        roMachineIssueLogController
                                                                .tpSecondCheckBox =
                                                            value ?? false;
                                                        setState(() {});
                                                      },
                                                    )),
                                                    Expanded(
                                                        child:
                                                            CustomCheckboxGroup(
                                                      title: context.l10n.roUvLamp,
                                                      firstValue:
                                                          roMachineIssueLogController
                                                              .uvLampFirstCheckBox,
                                                      secondValue:
                                                          roMachineIssueLogController
                                                              .uvLampSecondCheckBox,
                                                      onChangedFirst: (value) {
                                                        roMachineIssueLogController
                                                                .uvLampFirstCheckBox =
                                                            value ?? false;
                                                        setState(() {});
                                                      },
                                                      onChangedSecond: (value) {
                                                        roMachineIssueLogController
                                                                .uvLampSecondCheckBox =
                                                            value ?? false;
                                                        setState(() {});
                                                      },
                                                    ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ExpansionTile(
                                      maintainState: true,
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      title: Row(children: [
                                        Image.asset(
                                            "assets/user_textfield.png"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        CustomText(
                                          text: context.l10n.roReturnLoopPressure,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.start,
                                        )
                                      ]),
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(color: Colors.grey)
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CheckboxListTile(
                                                      title: Text(context.l10n.roUfMicronFilter),
                                                      value: ufCheckedValue,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          ufCheckedValue =
                                                              newValue ?? false;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: CheckboxListTile(
                                                      title: Text(context.l10n.roDosingSystem),
                                                      value: doingCheckedValue,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          doingCheckedValue =
                                                              newValue ?? false;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: MyCustomDropdown(
                                                        selectedItem:
                                                            selectedRangePsi,
                                                        labelText: context.l10n.roRange,
                                                        items: roMachineIssueLogController
                                                                .returnLoopRangeModel
                                                                ?.data
                                                                ?.map((e) => e
                                                                    .lookupDetDescEn)
                                                                .toList() ??
                                                            [],
                                                        hint: context.l10n.regHintSelect,
                                                        isRequired: false,
                                                        senValue: (value) {
                                                          selectedRangePsi =
                                                              value;
                                                          roMachineIssueLogController
                                                              .update();
                                                        },
                                                        filledColor:
                                                            Colors.white),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: CustomTextField(
                                                        fontSize: 16,
                                                        onChanged: (value) {},
                                                        maxLines: 1,
                                                        isReadOnly: false,
                                                        keyBoardType:
                                                            TextInputType
                                                                .number,
                                                        labelText: context.l10n.commonValue,
                                                        hintText: context.l10n.regHintEnter,
                                                        isRequired: false,
                                                        txtController:
                                                            roMachineIssueLogController
                                                                .valuePsiController,
                                                        fillColor:
                                                            Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              MyCustomDropdown(
                                                  selectedItem: selectedCheckBy,
                                                  labelText: context.l10n.roCheckedBy,
                                                  items: checkByList
                                                      .map((e) => e.title)
                                                      .toList(),
                                                  hint: context.l10n.regHintSelect,
                                                  isRequired: false,
                                                  senValue: (value) {
                                                    selectedCheckBy = value;
                                                    roMachineIssueLogController
                                                        .update();
                                                  },
                                                  filledColor: Colors.white),
                                              const SizedBox(height: 8),
                                              CustomTextField(
                                                  fontSize: 16,
                                                  onChanged: (value) {},
                                                  maxLines: 1,
                                                  isReadOnly: false,
                                                  keyBoardType:
                                                      TextInputType.text,
                                                  labelText: context.l10n.commonComments,
                                                  hintText: context.l10n.regHintEnter,
                                                  isRequired: false,
                                                  txtController:
                                                      roMachineIssueLogController
                                                          .commentsReturnLoopController,
                                                  fillColor: Colors.white),
                                              const SizedBox(height: 8),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomButton(
                                    isLoading: false,
                                    buttonText: context.l10n.commonSave,
                                    path: 'assets/save-ro-disinfec.png',
                                    callB: () {
                                      if (widget.isEdit == true) {
                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .roLogSheetId =
                                            widget.roLogSheetData?.roLogSheetId;
                                        MachineData? machine = controller
                                            .getMachineNameModel?.data
                                            ?.firstWhere((e) =>
                                                e.machineName ==
                                                selectedMachineName);

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .roMachineMasterId =
                                            machine?.roMachineMasterId;

                                        SandPrePostData? sand =
                                            roMachineIssueLogController
                                                .sandFilterPrePostModel?.data
                                                ?.firstWhere((e) =>
                                                    e.lookupDetDescEn ==
                                                    selectedPre);

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .lookupDetIdSfpPre =
                                            sand?.lookupDetId.toString();

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .lookupDetIdSfpPost =
                                            sand?.lookupDetId.toString();

                                        if (roMachineIssueLogController
                                            .difference.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .sfpDifference =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .difference.text);
                                        }

                                        if (selectedBackwash != null) {
                                          BackWashRinseData? backwash =
                                              roMachineIssueLogController
                                                  .getBackWashAndRinseModel
                                                  ?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetValue ==
                                                      selectedBackwash);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdSandFilterBackwash =
                                              backwash?.lookupDetId;

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdSandFilterRinse =
                                              backwash?.lookupDetId;
                                        }

                                        List<String>? parts =
                                            formattedFromDate?.split('-');
                                        DateTime dateTime = DateTime(
                                            int.parse(parts![2]),
                                            int.parse(parts[1]),
                                            int.parse(parts[0]));

                                        // Format the DateTime as "yyyy-MM-dd"
                                        String convetedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(dateTime);

                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .logSheetDate = convetedDate;

                                        if (selectedSandDoneBy != null) {
                                          DoneByData? sandDoneB =
                                              roMachineIssueLogController
                                                  .doneByModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.username ==
                                                      selectedSandDoneBy);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .sandFilterDoneBy =
                                              sandDoneB?.userid;
                                        }

                                        if (selectedBeforeRegiHardness !=
                                            null) {
                                          BeforAfterHardData?
                                              beforAfterHardData =
                                              roMachineIssueLogController
                                                  .beforAfterHardnessModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetValue ==
                                                      selectedBeforeRegiHardness);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdBeforeRegenerationHardness =
                                              beforAfterHardData?.lookupDetId;

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .beforeRegenerationHardnessValue =
                                              beforAfterHardData?.lookupDetId;

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdAfterRegenerationHardness =
                                              beforAfterHardData?.lookupDetId;

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .afterRegenerationHardnessValue =
                                              beforAfterHardData?.lookupDetId;
                                        }

                                        if (selectedRawWaterTdsRange != null) {
                                          RawWaterTdsData? rawWater =
                                              roMachineIssueLogController
                                                  .rawWaterTdsModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetDescEn ==
                                                      selectedRawWaterTdsRange);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdRawWaterTds =
                                              rawWater?.lookupDetId;
                                        }

                                        if (roMachineIssueLogController
                                            .value.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .rawWaterTdsValue =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .value.text);
                                        }

                                        if (selectedRoWaterRange != null) {
                                          RoWaterTdsData? roWater =
                                              roMachineIssueLogController
                                                  .roWaterTdsModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetDescEn ==
                                                      selectedRoWaterRange);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdRoWaterTds =
                                              roWater?.lookupDetId;
                                        }

                                        if (roMachineIssueLogController
                                            .value1.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .roWaterTdsValue =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .value1.text);
                                        }

                                        if (roMachineIssueLogController
                                            .preMembranePressure
                                            .text
                                            .isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .preMembranePressure =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .preMembranePressure
                                                      .text);
                                        }

                                        if (roMachineIssueLogController
                                            .rejectedPressure.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .rejectPressure =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .rejectedPressure.text);
                                        }

                                        if (roMachineIssueLogController
                                            .difference1.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .ppmPressureDifference =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .difference1.text);
                                        }

                                        if (roMachineIssueLogController
                                            .lph.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .premeateFlowLph =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .lph.text);
                                        }

                                        if (roMachineIssueLogController
                                            .rwpFirstCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .rawWaterPump1 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .rawWaterPump1 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .rwpSecondCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .rawWaterPump2 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .rawWaterPump2 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .hppFirstCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .highPressurePump1 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .highPressurePump1 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .hppSecondCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .highPressurePump2 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .highPressurePump2 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .tpFirstCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .transferPump1 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .transferPump1 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .tpSecondCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .transferPump2 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .transferPump2 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .uvLampFirstCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .uvLamp1 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .uvLamp1 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .uvLampSecondCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .uvLamp2 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .uvLamp2 = 0;
                                        }

                                        if (ufCheckedValue) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .ufMicronFilter = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .ufMicronFilter = 0;
                                        }

                                        if (doingCheckedValue) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .dosingSystem = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .dosingSystem = 0;
                                        }

                                        if (selectedRangePsi != null) {
                                          ReturnLoopData? returnLoopData =
                                              roMachineIssueLogController
                                                  .returnLoopRangeModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetDescEn ==
                                                      selectedRangePsi);
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdReturnLoopPressure =
                                              returnLoopData?.lookupDetId;
                                        }

                                        if (roMachineIssueLogController
                                            .valuePsiController
                                            .text
                                            .isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .returnLoopPressureValue =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .valuePsiController.text);
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .returnLoopPressureValue = 0;
                                        }

                                        if (selectedCheckBy != null) {
                                          var checkB = checkByList.firstWhere(
                                              (e) =>
                                                  e.title == selectedCheckBy);
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .checkedBy = checkB.id;
                                        }

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .comments =
                                            roMachineIssueLogController
                                                .commentsReturnLoopController
                                                .text;

                                        String detIdCfpPre = "";
                                        String detIdCfpPost = "";
                                        String carbonDiff = "";
                                        String carbonBackW = "";
                                        String carbonRinse = "";
                                        String carbonDone = "";
                                        String carbonComments = "";
                                        String carbonFilterID = "";

                                        // Iterate over the list and concatenate the keys with #
                                        for (var item in carbonCommentsList) {
                                          detIdCfpPre +=
                                              "${item.lookupDetIdCfpPre}#";
                                          detIdCfpPost +=
                                              "${item.lookupDetIdCfpPost}#";
                                          carbonDiff +=
                                              "${item.cfpDifference}#";
                                          carbonBackW +=
                                              "${item.lookupDetIdCarbonFilterBackwash}#";
                                          carbonRinse +=
                                              "${item.lookupDetIdCarbonFilterRinse}#";
                                          carbonDone +=
                                              "${item.carbonFilterDoneBy}#";
                                          carbonComments +=
                                              "${item.cfpComments}#";
                                          carbonFilterID +=
                                              "${item.carbonFilterPressureId}#";
                                        }

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .carbonFilterPressureId =
                                            carbonFilterID;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .lookupDetIdCfpPre = detIdCfpPre;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .lookupDetIdCfpPost = detIdCfpPost;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .cfpDifference = carbonDiff;
                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .lookupDetIdCarbonFilterBackwash =
                                            carbonBackW;
                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .lookupDetIdCarbonFilterRinse =
                                            carbonRinse;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .carbonFilterDoneBy = carbonDone;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .cfpComments = carbonComments;

                                        String detIdSpPre = "";
                                        String detIdSpPost = "";
                                        String spDiff = "";
                                        String softenerTime = "";
                                        String softenerDoneBy = "";
                                        String spComments = "";
                                        String spPressureId = "";

                                        // Iterate over the list and concatenate the keys with #
                                        for (var item in sofnerCommentsList) {
                                          detIdSpPre +=
                                              "${item.lookupDetIdSpPre}#";
                                          detIdSpPost +=
                                              "${item.lookupDetIdSpPost}#";
                                          spDiff += "${item.spDifference}#";
                                          softenerTime +=
                                              "${item.softenerRegenerationTime}#";
                                          softenerDoneBy +=
                                              "${item.softenerRegenerationDoneBy}#";
                                          spComments += "${item.spComments}#";
                                          spPressureId +=
                                              "${item.softenerPressureId}#";
                                        }

                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .softenerPressureId = spPressureId;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .lookupDetIdSpPre = detIdSpPre;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .lookupDetIdSpPost = detIdSpPost;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .spDifference = spDiff;
                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .softenerRegenerationTime =
                                            softenerTime;
                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .softenerRegenerationTime =
                                            softenerTime;
                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .softenerRegenerationDoneBy =
                                            softenerDoneBy;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .spComments = spComments;

                                        if (selectedPostCarbonCloride != null) {
                                          PostCarbonChloridData?
                                              postCarbonChData =
                                              roMachineIssueLogController
                                                  .postCarbonChloridModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetDescEn ==
                                                      selectedPostCarbonCloride);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdPostCarbonChlorine =
                                              postCarbonChData?.lookupDetId;
                                        }

                                        if (roMachineIssueLogController
                                            .commentsCarbonChlorideController
                                            .text
                                            .isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .postCarbonChlorineValue =
                                              double.tryParse(
                                                      roMachineIssueLogController
                                                          .commentsCarbonChlorideController
                                                          .text)
                                                  ?.toInt();
                                        }

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .roWaterConductivityValue =
                                            int.parse(
                                                roMachineIssueLogController
                                                    .commentsRoWaterController
                                                    .text);

                                        if (selectedRoWaterConductivity !=
                                            null) {
                                          // RoWaterConductData? roWaterConduct =
                                          //     roMachineIssueLogController
                                          //         .roWaterConductivityModel
                                          //         ?.data
                                          //         ?.firstWhere((e) =>
                                          //             e.lookupDetValue ==
                                          //                 roWConduc?.lookupDetValue);
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdPostCarbonChlorine =
                                              roWConduc?.lookupDetId;
                                        }

                                        if (roMachineIssueLogController
                                            .rejectedFlow.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .rejectFlowLph =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .rejectedFlow.text);
                                        }

                                        if (selectedSoftnerAvailable != null) {
                                          SoftnerAvailableData? softnerA =
                                              roMachineIssueLogController
                                                  .softnerAvailableModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetDescEn ==
                                                      selectedSoftnerAvailable);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdSoftenerAvailable =
                                              softnerA?.lookupDetId;
                                        }

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .unitId =
                                            int.parse(userData['unitId']);

                                        if (selectedInstName != null) {
                                          InstituteDataModel? inst =
                                              roMachineIssueLogController
                                                  .instituteList?.data
                                                  ?.firstWhere((e) =>
                                                      e.unitName ==
                                                      selectedInstName);

                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .createdBy = inst?.unitId;
                                        }

                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .srnId = 0;

                                        roMachineIssueLogController
                                            .addEditROLogSheet(true);
                                      } else {
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .roLogSheetId = 0;
                                        MachineData? machine = controller
                                            .getMachineNameModel?.data
                                            ?.firstWhere((e) =>
                                                e.machineName ==
                                                selectedMachineName);

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .roMachineMasterId =
                                            machine?.roMachineMasterId;

                                        SandPrePostData? sand =
                                            roMachineIssueLogController
                                                .sandFilterPrePostModel?.data
                                                ?.firstWhere((e) =>
                                                    e.lookupDetDescEn ==
                                                    selectedPre);

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .lookupDetIdSfpPre =
                                            sand?.lookupDetId.toString();

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .lookupDetIdSfpPost =
                                            sand?.lookupDetId.toString();

                                        if (roMachineIssueLogController
                                            .difference.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .sfpDifference =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .difference.text);
                                        }

                                        if (selectedBackwash != null) {
                                          BackWashRinseData? backwash =
                                              roMachineIssueLogController
                                                  .getBackWashAndRinseModel
                                                  ?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetValue ==
                                                      selectedBackwash);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdSandFilterBackwash =
                                              backwash?.lookupDetId;

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdSandFilterRinse =
                                              backwash?.lookupDetId;
                                        }

                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .logSheetDate = formattedFromDate;

                                        if (selectedSandDoneBy != null) {
                                          DoneByData? sandDoneB =
                                              roMachineIssueLogController
                                                  .doneByModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.username ==
                                                      selectedSandDoneBy);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .sandFilterDoneBy =
                                              sandDoneB?.userid;
                                        }

                                        if (selectedBeforeRegiHardness !=
                                            null) {
                                          BeforAfterHardData?
                                              beforAfterHardData =
                                              roMachineIssueLogController
                                                  .beforAfterHardnessModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetValue ==
                                                      selectedBeforeRegiHardness);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdBeforeRegenerationHardness =
                                              beforAfterHardData?.lookupDetId;

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .beforeRegenerationHardnessValue =
                                              beforAfterHardData?.lookupDetId;

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdAfterRegenerationHardness =
                                              beforAfterHardData?.lookupDetId;

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .afterRegenerationHardnessValue =
                                              beforAfterHardData?.lookupDetId;
                                        }

                                        if (selectedRawWaterTdsRange != null) {
                                          RawWaterTdsData? rawWater =
                                              roMachineIssueLogController
                                                  .rawWaterTdsModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetDescEn ==
                                                      selectedRawWaterTdsRange);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdRawWaterTds =
                                              rawWater?.lookupDetId;
                                        }

                                        if (roMachineIssueLogController
                                            .value.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .rawWaterTdsValue =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .value.text);
                                        }

                                        if (selectedRoWaterRange != null) {
                                          RoWaterTdsData? roWater =
                                              roMachineIssueLogController
                                                  .roWaterTdsModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetDescEn ==
                                                      selectedRoWaterRange);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdRoWaterTds =
                                              roWater?.lookupDetId;
                                        }

                                        if (roMachineIssueLogController
                                            .value1.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .roWaterTdsValue =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .value1.text);
                                        }

                                        if (roMachineIssueLogController
                                            .preMembranePressure
                                            .text
                                            .isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .preMembranePressure =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .preMembranePressure
                                                      .text);
                                        }

                                        if (roMachineIssueLogController
                                            .rejectedPressure.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .rejectPressure =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .rejectedPressure.text);
                                        }

                                        if (roMachineIssueLogController
                                            .difference1.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .ppmPressureDifference =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .difference1.text);
                                        }

                                        if (roMachineIssueLogController
                                            .lph.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .premeateFlowLph =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .lph.text);
                                        }

                                        if (roMachineIssueLogController
                                            .rwpFirstCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .rawWaterPump1 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .rawWaterPump1 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .rwpSecondCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .rawWaterPump2 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .rawWaterPump2 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .hppFirstCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .highPressurePump1 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .highPressurePump1 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .hppSecondCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .highPressurePump2 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .highPressurePump2 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .tpFirstCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .transferPump1 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .transferPump1 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .tpSecondCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .transferPump2 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .transferPump2 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .uvLampFirstCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .uvLamp1 = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .uvLamp1 = 0;
                                        }

                                        if (roMachineIssueLogController
                                            .uvLampSecondCheckBox) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .uvLamp2 = 1;
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .uvLamp2 = 0;
                                        }

                                        if (ufCheckedValue) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .ufMicronFilter = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .ufMicronFilter = 0;
                                        }

                                        if (doingCheckedValue) {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .dosingSystem = 1;
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .dosingSystem = 0;
                                        }

                                        if (selectedRangePsi != null) {
                                          ReturnLoopData? returnLoopData =
                                              roMachineIssueLogController
                                                  .returnLoopRangeModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetDescEn ==
                                                      selectedRangePsi);
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdReturnLoopPressure =
                                              returnLoopData?.lookupDetId;
                                        }

                                        if (roMachineIssueLogController
                                            .valuePsiController
                                            .text
                                            .isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .returnLoopPressureValue =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .valuePsiController.text);
                                        } else {
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .returnLoopPressureValue = 0;
                                        }

                                        if (selectedCheckBy != null) {
                                          var checkB = checkByList.firstWhere(
                                              (e) =>
                                                  e.title == selectedCheckBy);
                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .checkedBy = checkB.id;
                                        }

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .comments =
                                            roMachineIssueLogController
                                                .commentsReturnLoopController
                                                .text;

                                        String detIdCfpPre = "";
                                        String detIdCfpPost = "";
                                        String carbonDiff = "";
                                        String carbonBackW = "";
                                        String carbonRinse = "";
                                        String carbonDone = "";
                                        String carbonComments = "";
                                        String carbonFilterID = "";

                                        // Iterate over the list and concatenate the keys with #
                                        for (var item in carbonCommentsList) {
                                          detIdCfpPre +=
                                              "${item.lookupDetIdCfpPre}#";
                                          detIdCfpPost +=
                                              "${item.lookupDetIdCfpPost}#";
                                          carbonDiff +=
                                              "${item.cfpDifference}#";
                                          carbonBackW +=
                                              "${item.lookupDetIdCarbonFilterBackwash}#";
                                          carbonRinse +=
                                              "${item.lookupDetIdCarbonFilterRinse}#";
                                          carbonDone +=
                                              "${item.carbonFilterDoneBy}#";
                                          carbonComments +=
                                              "${item.cfpComments}#";
                                          carbonFilterID += "0#";
                                        }

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .carbonFilterPressureId =
                                            carbonFilterID;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .lookupDetIdCfpPre = detIdCfpPre;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .lookupDetIdCfpPost = detIdCfpPost;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .cfpDifference = carbonDiff;
                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .lookupDetIdCarbonFilterBackwash =
                                            carbonBackW;
                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .lookupDetIdCarbonFilterRinse =
                                            carbonRinse;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .carbonFilterDoneBy = carbonDone;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .cfpComments = carbonComments;

                                        String detIdSpPre = "";
                                        String detIdSpPost = "";
                                        String spDiff = "";
                                        String softenerTime = "";
                                        String softenerDoneBy = "";
                                        String spComments = "";
                                        String spPressureId = "";

                                        // Iterate over the list and concatenate the keys with #
                                        for (var item in sofnerCommentsList) {
                                          detIdSpPre +=
                                              "${item.lookupDetIdSpPre}#";
                                          detIdSpPost +=
                                              "${item.lookupDetIdSpPost}#";
                                          spDiff += "${item.spDifference}#";
                                          softenerTime +=
                                              "${item.softenerRegenerationTime}#";
                                          softenerDoneBy +=
                                              "${item.softenerRegenerationDoneBy}#";
                                          spComments += "${item.spComments}#";
                                          spPressureId += "0#";
                                        }

                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .softenerPressureId = spPressureId;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .lookupDetIdSpPre = detIdSpPre;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .lookupDetIdSpPost = detIdSpPost;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .spDifference = spDiff;
                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .softenerRegenerationTime =
                                            softenerTime;
                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .softenerRegenerationTime =
                                            softenerTime;
                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .softenerRegenerationDoneBy =
                                            softenerDoneBy;
                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .spComments = spComments;

                                        if (selectedPostCarbonCloride != null) {
                                          PostCarbonChloridData?
                                              postCarbonChData =
                                              roMachineIssueLogController
                                                  .postCarbonChloridModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetDescEn ==
                                                      selectedPostCarbonCloride);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdPostCarbonChlorine =
                                              postCarbonChData?.lookupDetId;
                                        }

                                        if (roMachineIssueLogController
                                            .commentsCarbonChlorideController
                                            .text
                                            .isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .postCarbonChlorineValue =
                                              double.tryParse(
                                                      roMachineIssueLogController
                                                          .commentsCarbonChlorideController
                                                          .text)
                                                  ?.toInt();
                                        }

                                        if (selectedRoWaterConductivity !=
                                            null) {
                                          RoWaterConductData? roWaterConduct =
                                              roMachineIssueLogController
                                                  .roWaterConductivityModel
                                                  ?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetValue ==
                                                      selectedRoWaterConductivity);
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdRoWaterConductivity =
                                              roWaterConduct?.lookupDetId;
                                        }

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .roWaterConductivityValue =
                                            int.parse(
                                                roMachineIssueLogController
                                                    .commentsRoWaterController
                                                    .text);

                                        if (roMachineIssueLogController
                                            .rejectedFlow.text.isNotEmpty) {
                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .rejectFlowLph =
                                              int.parse(
                                                  roMachineIssueLogController
                                                      .rejectedFlow.text);
                                        }

                                        if (selectedSoftnerAvailable != null) {
                                          SoftnerAvailableData? softnerA =
                                              roMachineIssueLogController
                                                  .softnerAvailableModel?.data
                                                  ?.firstWhere((e) =>
                                                      e.lookupDetDescEn ==
                                                      selectedSoftnerAvailable);

                                          roMachineIssueLogController
                                                  .addRoLogSheetRequestModel
                                                  .lookupDetIdSoftenerAvailable =
                                              softnerA?.lookupDetId;
                                        }

                                        roMachineIssueLogController
                                                .addRoLogSheetRequestModel
                                                .unitId =
                                           userData['unitId'];

                                        if (selectedInstName != null) {
                                          InstituteDataModel? inst =
                                              roMachineIssueLogController
                                                  .instituteList?.data
                                                  ?.firstWhere((e) =>
                                                      e.unitName ==
                                                      selectedInstName);

                                          roMachineIssueLogController
                                              .addRoLogSheetRequestModel
                                              .createdBy = inst?.unitId;
                                        }

                                        roMachineIssueLogController
                                            .addRoLogSheetRequestModel
                                            .srnId = 0;

                                        roMachineIssueLogController
                                            .addEditROLogSheet(false);
                                      }
                                    },
                                    buttonWidth: 100,
                                    primColor: AppColor.primaryBackgroundColor,
                                    secColor: AppColor.secondaryColor,
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                  ),
                                  CustomButton(
                                    buttonText: context.l10n.commonReset,
                                    path: 'assets/refresh.png',
                                    callB: () {},
                                    buttonWidth: 100,
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
                                    buttonWidth: 100,
                                    primColor: AppColor.red,
                                    secColor: AppColor.red,
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                  ),
                                ],
                              ).paddingOnly(top: 20, bottom: 20)
                            ],
                          ).paddingOnly(left: 8, right: 8),
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

  void calculateSandDifference() {
    if (selectedPre != "0" && selectedPost != "0") {
      var diff = int.parse(selectedPre ?? "0") - int.parse(selectedPost ?? "0");
      roMachineIssueLogController.difference.text = diff.toString();
      roMachineIssueLogController.update();
    }
  }

  String? validateValue(String value, String? caseString) {
    double? enteredValue = double.tryParse(value);
    if (enteredValue != null) {
      switch (caseString) {
        case '<0.5':
          if (enteredValue >= 0.5) {
            return l10n.roValueLessThan('0.5');
          }
          break;
        case '>0.5':
          if (enteredValue <= 0.5) {
            return l10n.roValueGreaterThan('0.5');
          }
          break;
        case '<20':
          if (enteredValue >= 20) {
            return l10n.roValueLessThan('20');
          }
          break;
        case '<30':
          if (enteredValue >= 30) {
            return l10n.roValueLessThan('30');
          }
          break;
        case '>30':
          if (enteredValue <= 30) {
            return l10n.roValueGreaterThan('30');
          }
          break;
        case '20-100':
          if (enteredValue < 20 || enteredValue > 100) {
            return l10n.roValueBetween('20', '100');
          }
          break;
        case '1-200':
          if (enteredValue < 1 || enteredValue > 200) {
            return l10n.roValueBetween('1', '200');
          }
          break;
        case '101-200':
          if (enteredValue < 101 || enteredValue > 200) {
            return l10n.roValueBetween('101', '200');
          }
          break;
        case '201-400':
          if (enteredValue < 201 || enteredValue > 400) {
            return l10n.roValueBetween('201', '400');
          }
          break;
        case '401-600':
          if (enteredValue < 401 || enteredValue > 600) {
            return l10n.roValueBetween('401', '600');
          }
          break;
        case '601-1000': // Updated this case to a more logical range
          if (enteredValue < 601 || enteredValue > 1000) {
            return l10n.roValueBetween('601', '1000');
          }
          break;
        case '>200':
          if (enteredValue <= 200) {
            return l10n.roValueGreaterThan('200');
          }
          break;
        case '>1000':
          if (enteredValue <= 1000) {
            return l10n.roValueGreaterThan('1000');
          }
          break;
        default:
          return null; // No validation errors
      }
      return null; // No errors detected for this case
    } else {
      return l10n.roEnterValidNumber; // Handle invalid input
    }
  }

  void calculateCarbonDifference(
      int? index, AddRoLogSheetRequestModel cardData) {
    if (cardData.lookupDetDesCfpPre != null &&
        cardData.lookupDetDesCfpPost != null) {
      var diff = int.parse(cardData.lookupDetDesCfpPre ?? "0") -
          int.parse(cardData.lookupDetDesCfpPost ?? "0");
      cardData.cfpDifference = diff.toString();
      // updateCardData1(index ?? 0, diff.toString(), "cfpDifference");

      roMachineIssueLogController.update();
    }
  }

  void calculateWaterDifference() {
    var diff = int.parse(roMachineIssueLogController.preMembranePressure.text) -
        int.parse(roMachineIssueLogController.rejectedPressure.text);
    roMachineIssueLogController.difference1.text = diff.toString();
    roMachineIssueLogController.update();
  }

  void calculateSoftnerDifference(
      int? index, AddRoLogSheetRequestModel cardData) {
    if (cardData.lookupDetDescrSpPre != null &&
        cardData.lookupDetDescrSpPost != null) {
      var diff = int.parse(cardData.lookupDetDescrSpPre ?? "0") -
          int.parse(cardData.lookupDetDescrSpPost ?? "0");
      cardData.spDifference = diff.toString();
      // roMachineIssueLogController.differenceSoftner.text = diff.toString();
      // updateCardData2(index ?? 0, diff.toString(), "spDifference");
      setState(() {});
      // roMachineIssueLogController.update();
    }
  }

  // showMessage(BuildContext context, String input, String? valueToCheck) {
  //   String? message = _parseInputAndGenerateMessage(input, valueToCheck);
  //   return message;
  // }
  //
  // String? _parseInputAndGenerateMessage(String input, String? valueToCheck) {
  //   double valueToBeCheck = 0.0;
  //   if (valueToCheck != null && valueToCheck != "") {
  //     valueToBeCheck = double.parse(valueToCheck);
  //
  //     if (input.contains('-')) {
  //       // Range like "601-1000" or "0-14"
  //       List<String> rangeParts = input.split('-');
  //       double start = double.parse(rangeParts[0]);
  //       double end = double.parse(rangeParts[1]);
  //
  //       if (valueToBeCheck >= start && valueToBeCheck <= end) {
  //         return 'The value is within the range $start to $end.';
  //       } else {
  //         return 'The value is not within the range $start to $end.';
  //       }
  //     } else if (input.startsWith('>')) {
  //       // Greater than condition like ">1000"
  //       double threshold = double.parse(input.substring(1));
  //       if (valueToBeCheck > threshold) {
  //         return 'The value is greater than $threshold.';
  //       } else {
  //         return 'The value is not greater than $threshold.';
  //       }
  //     } else if (input.startsWith('<')) {
  //       // Less than condition like "<0.5"
  //       double threshold = double.parse(input.substring(1));
  //       if (valueToBeCheck < threshold) {
  //         return 'The value is less than $threshold.';
  //       } else {
  //         return 'The value is not less than $threshold.';
  //       }
  //     } else {
  //       // return 'Invalid input range.';
  //       return null;
  //     }
  //   }
  //   return null;
  // }

  selectFromDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != _selectedFromDate) {
      // setState(() {
      _selectedFromDate = picked;
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      formattedFromDate = formatter.format(_selectedFromDate!);
      roMachineIssueLogController.dateController.text = formattedFromDate!;
      setState(() {});
      // calculateAge(formattedDateDBO);
      // });
      // newRegistrationController.refreshUi();
    }
  }

  selectTime(int? index, AddRoLogSheetRequestModel cardData) async {
    pickedTime = await DatePickerHelper.selectTime(context);
    cardData.softenerRegenerationTime = pickedTime!;
    // roMachineIssueLogController.timeController.text = pickedTime!;
    // updateCardData2(index ?? 0, cardData.softenerRegenerationTime,
    //     "softenerRegenerationTime");
    setState(() {});
  }

  Widget customCard(int index, AddRoLogSheetRequestModel cardData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
            text: context.l10n.roCarbonFilterPressure,
            fontSize: 16,
            fontFam: "Lato",
            fontWeight: FontWeight.bold,
            textColor: Colors.black,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: MyCustomDropdown(
                selectedItem: cardData.lookupDetDesCfpPre,
                // selectedItem: selectedCarbonPre,
                labelText: context.l10n.roPre,
                items: roMachineIssueLogController.sandFilterPrePostModel?.data
                        ?.map((e) => e.lookupDetDescEn)
                        .toList() ??
                    [],
                hint: context.l10n.regHintSelect,
                isRequired: false,
                senValue: (value) {
                  cardData.lookupDetDesCfpPre = value;
                  SandPrePostData? carbon = roMachineIssueLogController
                      .sandFilterPrePostModel?.data
                      ?.firstWhere((e) =>
                          e.lookupDetDescEn == cardData.lookupDetDesCfpPre);
                  cardData.lookupDetIdCfpPre = carbon?.lookupDetId.toString();
                  calculateCarbonDifference(index, cardData);
                },
                filledColor: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: MyCustomDropdown(
                // selectedItem: selectedCarbonPost,
                selectedItem: cardData.lookupDetDesCfpPost,
                labelText: context.l10n.roPost,
                items: roMachineIssueLogController.sandFilterPrePostModel?.data
                        ?.map((e) => e.lookupDetDescEn)
                        .toList() ??
                    [],
                hint: context.l10n.regHintSelect,
                isRequired: false,
                senValue: (value) {
                  cardData.lookupDetDesCfpPost = value;
                  var post = roMachineIssueLogController
                      .sandFilterPrePostModel?.data
                      ?.firstWhere((e) => e.lookupDetDescEn == value);
                  cardData.lookupDetIdCfpPost = post?.lookupDetId.toString();

                  calculateCarbonDifference(index, cardData);
                  // updateCardData1(
                  //     index, selectedCarbonPost, 'lookupDetIdCfpPost');
                  // roMachineIssueLogController.update();
                },
                filledColor: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                fontSize: 16,
                // key: ValueKey("${index}carbonDiff"),
                key: UniqueKey(),
                onChanged: (value) {
                  // cardData.cfpDifference = value;
                  // roMachineIssueLogController.update();
                },
                maxLines: 1,
                isReadOnly: true,
                keyBoardType: TextInputType.number,
                labelText: context.l10n.roDifference,
                hintText: context.l10n.regHintEnter,
                isRequired: false,
                // txtController: roMachineIssueLogController.differenceCarbon,
                initialValue: cardData.cfpDifference,
                fillColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
            text: context.l10n.roCarbonFilter,
            fontSize: 16,
            fontFam: "Lato",
            fontWeight: FontWeight.bold,
            textColor: Colors.black,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: MyCustomDropdown(
                // selectedItem: selectedBackwashCarbon,
                selectedItem: cardData.lookupDetIdCarbonFilterBackwashDes,
                labelText: context.l10n.roBackwash,
                items: roMachineIssueLogController
                        .getBackWashAndRinseModel?.data
                        ?.map((e) => e.lookupDetValue)
                        .toList() ??
                    [],
                hint: context.l10n.regHintSelect,
                isRequired: false,
                senValue: (value) {
                  cardData.lookupDetIdCarbonFilterBackwashDes = value;
                  BackWashRinseData? backW = roMachineIssueLogController
                      .getBackWashAndRinseModel?.data
                      ?.firstWhere((e) => e.lookupDetValue == value);
                  cardData.lookupDetIdCarbonFilterBackwash =
                      backW?.lookupDetId.toString();
                  // updateCardData1(index, backW?.lookupDetId,
                  //     "lookupDetIdCarbonFilterBackwash");
                  roMachineIssueLogController.update();
                },
                filledColor: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: MyCustomDropdown(
                selectedItem: cardData.lookupDetIdCarbonFilterRinseDes,
                // selectedItem: selectedCarbonRinse,
                labelText: context.l10n.roRinse,
                items: roMachineIssueLogController
                        .getBackWashAndRinseModel?.data
                        ?.map((e) => e.lookupDetDescEn)
                        .toList() ??
                    [],
                hint: context.l10n.regHintSelect,
                isRequired: false,
                senValue: (value) {
                  cardData.lookupDetIdCarbonFilterRinseDes = value;
                  BackWashRinseData? rinse = roMachineIssueLogController
                      .getBackWashAndRinseModel?.data
                      ?.firstWhere((e) => e.lookupDetDescEn == value);
                  cardData.lookupDetIdCarbonFilterRinse =
                      rinse?.lookupDetId.toString();
                  // updateCardData1(index, rinse?.lookupDetId,
                  //     "lookupDetIdCarbonFilterRinse");
                  roMachineIssueLogController.update();
                },
                filledColor: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: MyCustomDropdown(
                // selectedItem: selectedCarbonDoneBy,
                selectedItem: cardData.carbonFilterDoneByDes,
                labelText: context.l10n.roDoneBy,
                items: roMachineIssueLogController.doneByModel?.data
                        ?.map((e) => e.username)
                        .toList() ??
                    [],
                hint: context.l10n.regHintSelect,
                isRequired: false,
                senValue: (value) {
                  cardData.carbonFilterDoneByDes = value;
                  DoneByData? doneB = roMachineIssueLogController
                      .doneByModel?.data
                      ?.firstWhere((e) => e.username == value);
                  cardData.carbonFilterDoneBy = doneB?.userid.toString();
                  roMachineIssueLogController.update();
                },
                filledColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        CustomTextField(
          fontSize: 16,
          key: ValueKey('${index}carbon'),
          onChanged: (value) {
            // updateCardData1(index, value!, "cfpComments");
            cardData.cfpComments = value;
            debugPrint(cardData.cfpComments);
          },
          maxLines: 1,
          isReadOnly: false,
          keyBoardType: TextInputType.text,
          labelText: context.l10n.commonComments,
          hintText: context.l10n.regHintEnter,
          isRequired: false,
          // txtController: roMachineIssueLogController.commentsController,
          initialValue: cardData.cfpComments,
          fillColor: Colors.white,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget customSoftnerCard(int index, AddRoLogSheetRequestModel cardData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
              text: context.l10n.roSoftenerPressure,
              fontSize: 16,
              fontFam: "Lato",
              fontWeight: FontWeight.bold,
              textColor: Colors.black,
              textAlign: TextAlign.start),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: MyCustomDropdown(
                  // selectedItem: selectedSoftnerAvailable,
                  selectedItem: cardData.lookupDetDescrSpPre,
                  labelText: context.l10n.roPre,
                  items: roMachineIssueLogController
                          .sandFilterPrePostModel?.data
                          ?.map((e) => e.lookupDetDescEn)
                          .toList() ??
                      [],
                  hint: context.l10n.regHintSelect,
                  isRequired: false,
                  senValue: (value) {
                    cardData.lookupDetDescrSpPre = value;
                    cardData.lookupDetIdSoftenerAvailableDes = value;
                    // cardData.lookupDetDescrSpPre = value;
                    var pre = roMachineIssueLogController
                        .sandFilterPrePostModel?.data
                        ?.firstWhere((e) => e.lookupDetDescEn == value);
                    cardData.lookupDetIdSpPre = pre?.lookupDetId.toString();
                    calculateSoftnerDifference(index, cardData);
                    // updateCardData2(index, value, "lookupDetIdSpPre");

                    // roMachineIssueLogController.update();
                  },
                  filledColor: Colors.white),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: MyCustomDropdown(
                  // selectedItem: selectedSoftnerPost,
                  selectedItem: cardData.lookupDetDescrSpPost,
                  labelText: context.l10n.roPost,
                  items: roMachineIssueLogController
                          .sandFilterPrePostModel?.data
                          ?.map((e) => e.lookupDetValue)
                          .toList() ??
                      [],
                  hint: context.l10n.regHintSelect,
                  isRequired: false,
                  senValue: (value) {
                    cardData.lookupDetDescrSpPost = value;
                    var post = roMachineIssueLogController
                        .sandFilterPrePostModel?.data
                        ?.firstWhere((e) => e.lookupDetValue == value);
                    cardData.lookupDetIdSpPost = post?.lookupDetId.toString();
                    calculateSoftnerDifference(index, cardData);
                  },
                  filledColor: Colors.white),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: CustomTextField(
                  fontSize: 16,
                  key: UniqueKey(),
                  // key: ValueKey("${index}softnerDiff"),
                  onChanged: (value) {
                    // cardData.spDifference = value;
                  },
                  maxLines: 1,
                  isReadOnly: true,
                  keyBoardType: TextInputType.number,
                  labelText: context.l10n.roDifference,
                  hintText: context.l10n.regHintEnter,
                  isRequired: false,
                  // txtController: roMachineIssueLogController.differenceSoftner,
                  initialValue: cardData.spDifference,
                  fillColor: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
              text: context.l10n.roSoftenerRegistration,
              fontSize: 16,
              fontFam: "Lato",
              fontWeight: FontWeight.bold,
              textColor: Colors.black,
              textAlign: TextAlign.start),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: CustomDateField(
                // initialValue: roMachineIssueLogController.timeController.text,
                initialValue: cardData.softenerRegenerationTime,
                labelText: context.l10n.commonTime,
                hint: context.l10n.regHintSelect,
                isRequired: false,
                callB: () {
                  selectTime(index, cardData);
                },
                // selectedDate: roMachineIssueLogController.timeController,
                filledColor: Colors.white,
                dontDhowPrefix: false,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: MyCustomDropdown(
                  selectedItem: cardData.softenerRegenerationDoneByDescrip,
                  labelText: context.l10n.roDoneBy,
                  items: roMachineIssueLogController.doneByModel?.data
                          ?.map((e) => e.username)
                          .toList() ??
                      [],
                  hint: context.l10n.regHintSelect,
                  isRequired: false,
                  senValue: (value) {
                    cardData.softenerRegenerationDoneByDescrip = value;
                    DoneByData? doneB = roMachineIssueLogController
                        .doneByModel?.data
                        ?.firstWhere((e) => e.username == value);
                    cardData.softenerRegenerationDoneBy =
                        doneB?.userid.toString();
                    roMachineIssueLogController.update();

                    roMachineIssueLogController.update();
                  },
                  filledColor: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 8),
        CustomTextField(
            fontSize: 16,
            onChanged: (value) {
              // updateCardData2(index, value!, "spComments");
              cardData.spComments = value;
            },
            maxLines: 1,
            isReadOnly: false,
            keyBoardType: TextInputType.text,
            labelText: context.l10n.commonComments,
            hintText: context.l10n.regHintEnter,
            isRequired: false,
            // txtController:
            //     roMachineIssueLogController.softnerCommentsController,

            initialValue: cardData.spComments,
            fillColor: Colors.white),
        const SizedBox(height: 16),
      ],
    );
  }

  void setValues() {
    var ins = roMachineIssueLogController.instituteList?.data?.firstWhere(
        (e) => e.unitId == widget.roLogSheetData?.unitMasterDto?.unitId);
    selectedInstName = ins?.unitName;
    var machine = roMachineIssueLogController.getMachineNameModel?.data
        ?.firstWhere((e) =>
            e.roMachineMasterId ==
            widget.roLogSheetData?.roMachineMaster?.roMachineMasterId);
    selectedMachineName = machine?.machineName;
    roMachineIssueLogController.dateController.text =
        widget.roLogSheetData?.logSheetDate != null
            ? dateConversion(widget.roLogSheetData?.logSheetDate)
            : "";
    formattedFromDate = widget.roLogSheetData?.logSheetDate != null
        ? dateConversion(widget.roLogSheetData?.logSheetDate)
        : "";
    if (widget.roLogSheetData!.lookupDetIdSfpPre != null &&
        widget.roLogSheetData!.lookupDetIdSfpPost != null) {
      var pre = roMachineIssueLogController.sandFilterPrePostModel?.data
          ?.firstWhere(
              (e) => e.lookupDetId == widget.roLogSheetData!.lookupDetIdSfpPre);
      selectedPre = pre?.lookupDetDescEn;
      selectedPre = pre?.lookupDetDescEn;

      var post = roMachineIssueLogController.sandFilterPrePostModel?.data
          ?.firstWhere((e) =>
              e.lookupDetId == widget.roLogSheetData!.lookupDetIdSfpPost);
      selectedPost = post?.lookupDetDescEn;
    }

    roMachineIssueLogController.difference.text =
        widget.roLogSheetData?.sfpDifference.toString() ?? "";
    var backW = roMachineIssueLogController.getBackWashAndRinseModel?.data
        ?.firstWhere((e) =>
            e.lookupDetId ==
            widget.roLogSheetData?.lookupDetIdSandFilterBackwash);
    selectedBackwash = backW?.lookupDetDescEn;

    var rinse = roMachineIssueLogController.getBackWashAndRinseModel?.data
        ?.firstWhere((e) =>
            e.lookupDetId == widget.roLogSheetData?.lookupDetIdSandFilterRinse);

    selectedRinse = rinse?.lookupDetDescEn;
    var doneB = roMachineIssueLogController.doneByModel?.data?.firstWhere(
        (e) => e.userid == int.parse(widget.roLogSheetData!.sandFilterDoneBy!));
    selectedSandDoneBy = doneB?.username;

    var beforeH = roMachineIssueLogController.beforAfterHardnessModel?.data
        ?.firstWhere((e) =>
            e.lookupDetId ==
            widget.roLogSheetData!.lookupDetIdBeforeRegenerationHardness);

    selectedBeforeRegiHardness = beforeH?.lookupDetDescEn;
    roMachineIssueLogController.commentsHardnessSotnerController.text =
        widget.roLogSheetData!.beforeRegenerationHardnessValue.toString();

    var afterH = roMachineIssueLogController.beforAfterHardnessModel?.data
        ?.firstWhere((e) =>
            e.lookupDetId ==
            widget.roLogSheetData!.lookupDetIdAfterRegenerationHardness);

    selectedAfterRegiHardness = afterH?.lookupDetDescEn;

    roMachineIssueLogController.commentsAfterRegiHardnessController.text =
        widget.roLogSheetData!.lookupDetIdAfterRegenerationHardness.toString();
    var range1 = roMachineIssueLogController.rawWaterTdsModel?.data?.firstWhere(
        (e) => e.lookupDetId == widget.roLogSheetData?.lookupDetIdRawWaterTds);
    selectedRawWaterTdsRange = range1?.lookupDetDescEn;
    roMachineIssueLogController.value.text =
        widget.roLogSheetData?.rawWaterTdsValue != null
            ? widget.roLogSheetData!.rawWaterTdsValue.toString()
            : "";

    var range2 = roMachineIssueLogController.roWaterTdsModel?.data?.firstWhere(
        (e) => e.lookupDetId == widget.roLogSheetData?.lookupDetIdRoWaterTds);
    selectedRoWaterRange = range2?.lookupDetDescEn;
    roMachineIssueLogController.value1.text =
        widget.roLogSheetData?.roWaterTdsValue != null
            ? widget.roLogSheetData!.roWaterTdsValue.toString()
            : "";
    roMachineIssueLogController.preMembranePressure.text =
        widget.roLogSheetData!.preMembranePressure!.toStringAsFixed(0);
    roMachineIssueLogController.rejectedPressure.text =
        widget.roLogSheetData!.rejectPressure!.toStringAsFixed(0);
    roMachineIssueLogController.difference1.text =
        widget.roLogSheetData!.ppmPressureDifference!.toStringAsFixed(0);
    roMachineIssueLogController.lph.text =
        widget.roLogSheetData!.ppmPressureDifference!.toStringAsFixed(0);

    var carbCh = roMachineIssueLogController.postCarbonChloridModel?.data
        ?.firstWhere(
            (e) =>
                e.lookupDetId ==
                widget.roLogSheetData?.lookupDetIdPostCarbonChlorine,
            orElse: () => PostCarbonChloridData());
    selectedPostCarbonCloride = carbCh?.lookupDetDescEn;
    roMachineIssueLogController.commentsCarbonChlorideController.text =
        widget.roLogSheetData!.postCarbonChlorineValue.toString();
    roWConduc = roMachineIssueLogController.roWaterConductivityModel?.data
        ?.firstWhere(
            (e) =>
                e.lookupDetId ==
                widget.roLogSheetData!.lookupDetIdRoWaterConductivity,
            orElse: () => RoWaterConductData());

    selectedRoWaterConductivity = roWConduc?.lookupDetDescEn;

    roMachineIssueLogController.commentsRoWaterController.text =
        widget.roLogSheetData!.roWaterConductivityValue.toString();
    roMachineIssueLogController.rejectedFlow.text =
        widget.roLogSheetData!.rejectFlowLph.toString();
    roMachineIssueLogController.rwpFirstCheckBox =
        widget.roLogSheetData?.rawWaterPump1 == "1" ? true : false;
    roMachineIssueLogController.rwpSecondCheckBox =
        widget.roLogSheetData?.rawWaterPump2 == "1" ? true : false;
    roMachineIssueLogController.hppFirstCheckBox =
        widget.roLogSheetData?.highPressurePump1 == "1" ? true : false;
    roMachineIssueLogController.hppSecondCheckBox =
        widget.roLogSheetData?.highPressurePump2 == "1" ? true : false;
    roMachineIssueLogController.tpFirstCheckBox =
        widget.roLogSheetData?.transferPump1 == "1" ? true : false;
    roMachineIssueLogController.tpSecondCheckBox =
        widget.roLogSheetData?.transferPump2 == "1" ? true : false;
    roMachineIssueLogController.uvLampFirstCheckBox =
        widget.roLogSheetData?.uvLamp1 == "1" ? true : false;
    roMachineIssueLogController.uvLampSecondCheckBox =
        widget.roLogSheetData?.uvLamp2 == "1" ? true : false;
    ufCheckedValue =
        widget.roLogSheetData?.ufMicronFilter == "1" ? true : false;
    doingCheckedValue =
        widget.roLogSheetData?.dosingSystem == "1" ? true : false;

    var rangeReturnL = roMachineIssueLogController.returnLoopRangeModel?.data
        ?.firstWhere((e) =>
            e.lookupDetId ==
            widget.roLogSheetData?.lookupDetIdReturnLoopPressure);
    selectedRangePsi = rangeReturnL?.lookupDetDescEn;

    roMachineIssueLogController.valuePsiController.text =
        widget.roLogSheetData!.returnLoopPressureValue.toString();
    roMachineIssueLogController.commentsReturnLoopController.text =
        widget.roLogSheetData?.comments ?? "";
    var checkedB = checkByList.firstWhere(
      (e) => e.id == int.parse(widget.roLogSheetData?.checkedBy ?? "0"),
    );
    selectedCheckBy = checkedB.title;

    if (widget.isEdit == true) {
      String? carbonString =
          roMachineIssueLogController.initialValueEditModel?.carbonString;

      String? convertedString = carbonString?.replaceAll("\$", "+");

      // Split by '-' to separate the objects
      List<String>? objectStrings = convertedString?.split('+');

      // Remove any empty strings in case the split adds an empty element
      objectStrings?.removeWhere((element) => element.isEmpty);
      for (String objectString in objectStrings!) {
        List<String> values = objectString.split('#');
        carbonCommentsList.add(AddRoLogSheetRequestModel(
            carbonFilterPressureId: values[0],
            lookupDetIdCfpPre: values[1],
            lookupDetDesCfpPre: roMachineIssueLogController
                .sandFilterPrePostModel?.data
                ?.firstWhere((e) => e.lookupDetId == int.parse(values[1]))
                .lookupDetDescEn,
            lookupDetIdCfpPost: values[2],
            lookupDetDesCfpPost: roMachineIssueLogController
                .sandFilterPrePostModel?.data
                ?.firstWhere((e) => e.lookupDetId == int.parse(values[2]))
                .lookupDetDescEn,
            cfpDifference: values[3],
            lookupDetIdCarbonFilterBackwash: values[4],
            lookupDetIdCarbonFilterBackwashDes: roMachineIssueLogController
                .getBackWashAndRinseModel?.data
                ?.firstWhere((e) => e.lookupDetId == int.parse(values[4]))
                .lookupDetDescEn,
            lookupDetIdCarbonFilterRinse: values[5],
            lookupDetIdCarbonFilterRinseDes: roMachineIssueLogController
                .getBackWashAndRinseModel?.data
                ?.firstWhere((e) => e.lookupDetId == int.parse(values[5]))
                .lookupDetDescEn,
            carbonFilterDoneBy: values[6],
            cfpComments: values[7]));
      }

      String? softnerString =
          roMachineIssueLogController.initialValueEditModel?.softString;

      String? convertedSoftnerString = softnerString?.replaceAll("\$", "+");

      // Split by '-' to separate the objects
      List<String>? softnerObjectStrings = convertedSoftnerString?.split('+');

      // Remove any empty strings in case the split adds an empty element
      softnerObjectStrings?.removeWhere((element) => element.isEmpty);
      for (String softnerObjectStrings in softnerObjectStrings!) {
        List<String> values = softnerObjectStrings.split('#');
        sofnerCommentsList.add(AddRoLogSheetRequestModel(
          softenerPressureId: values[0],
          lookupDetIdSpPre: values[1],
          lookupDetDescrSpPre: roMachineIssueLogController
              .sandFilterPrePostModel?.data
              ?.firstWhere((e) => e.lookupDetId == int.parse(values[1]))
              .lookupDetDescEn,
          lookupDetIdSpPost: values[2],
          lookupDetDescrSpPost: roMachineIssueLogController
              .sandFilterPrePostModel?.data
              ?.firstWhere((e) => e.lookupDetId == int.parse(values[2]))
              .lookupDetDescEn,
          spDifference: values[3],
          softenerRegenerationTime: values[4].split(' ')[1].split('.')[0],
          softenerRegenerationDoneBy: values[5],
          softenerRegenerationDoneByDescrip: roMachineIssueLogController
              .doneByModel?.data
              ?.firstWhere((e) => e.userid == int.parse(values[5]),
                  orElse: () => DoneByData())
              .username,
          spComments: values[6],
          lookupDetIdSoftenerAvailable: int.parse(values[7]),
        ));
        var available = roMachineIssueLogController.softnerAvailableModel?.data
            ?.firstWhere(
                (e) =>
                    e.lookupDetId ==
                    int.parse(roMachineIssueLogController
                        .initialValueEditModel?.lookupDetIdSoftenerAvailable),
                orElse: () => SoftnerAvailableData());
        selectedSoftnerAvailable = available?.lookupDetDescEn;
      }
    }

    roMachineIssueLogController.update();
  }

  dateConversion(inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  }

// void updateCardData2(int index, dynamic value, String field) {
//   setState(() {
//     String? existingValue;
//
//     // Retrieve the current value for the field
//     switch (field) {
//       case 'lookupDetIdSpPre':
//         existingValue = roMachineIssueLogController
//             .addRoLogSheetRequestModel.lookupDetIdSpPre;
//         break;
//       case 'lookupDetIdSpPost':
//         existingValue = roMachineIssueLogController
//             .addRoLogSheetRequestModel.lookupDetIdSpPost;
//         break;
//       case 'spDifference':
//         existingValue = roMachineIssueLogController
//             .addRoLogSheetRequestModel.spDifference;
//         break;
//       case 'softenerRegenerationTime':
//         existingValue = roMachineIssueLogController
//             .addRoLogSheetRequestModel.softenerRegenerationTime;
//         break;
//       case 'softenerRegenerationDoneBy':
//         existingValue = roMachineIssueLogController
//             .addRoLogSheetRequestModel.softenerRegenerationDoneBy;
//         break;
//
//       case 'spComments':
//         existingValue =
//             roMachineIssueLogController.addRoLogSheetRequestModel.spComments;
//         break;
//     }
//
//     // Concatenate the new value with `?` as the separator and ensure the final string ends with `#`
//     String updatedValue =
//         "${existingValue ?? ""}${existingValue?.isNotEmpty ?? false ? "?" : ""}$value#";
//     updatedValue = updatedValue.replaceAll(
//         RegExp(r'\?+#$'), '#'); // Ensure only one `#` at the end
//
//     // Assign the updated value back to the appropriate field
//     switch (field) {
//       case 'lookupDetIdSpPre':
//         carbonCommentsList[index].lookupDetIdSpPre = updatedValue;
//         roMachineIssueLogController
//             .addRoLogSheetRequestModel.lookupDetIdSpPre = updatedValue;
//         break;
//       case 'lookupDetIdSpPost':
//         carbonCommentsList[index].lookupDetIdSpPost = updatedValue;
//         roMachineIssueLogController
//             .addRoLogSheetRequestModel.lookupDetIdSpPost = updatedValue;
//         break;
//       case 'spDifference':
//         carbonCommentsList[index].spDifference = updatedValue;
//         roMachineIssueLogController.addRoLogSheetRequestModel.spDifference =
//             updatedValue;
//         break;
//       case 'softenerRegenerationTime':
//         carbonCommentsList[index].softenerRegenerationTime = updatedValue;
//         roMachineIssueLogController.addRoLogSheetRequestModel
//             .softenerRegenerationTime = updatedValue;
//         break;
//       case 'softenerRegenerationDoneBy':
//         carbonCommentsList[index].softenerRegenerationDoneBy = updatedValue;
//         roMachineIssueLogController.addRoLogSheetRequestModel
//             .softenerRegenerationDoneBy = updatedValue;
//         break;
//       case 'spComments':
//         carbonCommentsList[index].spComments = updatedValue;
//         roMachineIssueLogController.addRoLogSheetRequestModel.spComments =
//             updatedValue;
//         break;
//     }
//   });
// }
//
// void updateCardData1(int index, dynamic value, String field) {
//   setState(() {
//     String? existingValue;
//
//     // Retrieve the current value for the field
//     switch (field) {
//       case 'lookupDetIdCfpPre':
//         existingValue = roMachineIssueLogController
//             .addRoLogSheetRequestModel.lookupDetIdCfpPre;
//         break;
//       case 'lookupDetIdCfpPost':
//         existingValue = roMachineIssueLogController
//             .addRoLogSheetRequestModel.lookupDetIdCfpPost;
//         break;
//       case 'cfpDifference':
//         existingValue = roMachineIssueLogController
//             .addRoLogSheetRequestModel.cfpDifference;
//         break;
//       case 'lookupDetIdCarbonFilterBackwash':
//         existingValue = roMachineIssueLogController
//             .addRoLogSheetRequestModel.lookupDetIdCarbonFilterBackwash;
//         break;
//       case 'lookupDetIdCarbonFilterRinse':
//         existingValue = roMachineIssueLogController
//             .addRoLogSheetRequestModel.lookupDetIdCarbonFilterRinse;
//         break;
//       case 'carbonFilterDoneBy':
//         existingValue = roMachineIssueLogController
//             .addRoLogSheetRequestModel.carbonFilterDoneBy;
//         break;
//       case 'cfpComments':
//         existingValue =
//             roMachineIssueLogController.addRoLogSheetRequestModel.cfpComments;
//         break;
//     }
//
//     // Concatenate the new value with `?` as the separator and ensure the final string ends with `#`
//     String updatedValue =
//         "${existingValue ?? ""}${existingValue?.isNotEmpty ?? false ? "?" : ""}$value#";
//     updatedValue = updatedValue.replaceAll(
//         RegExp(r'\?+#$'), '#'); // Ensure only one `#` at the end
//
//     // Assign the updated value back to the appropriate field
//     switch (field) {
//       case 'lookupDetIdCfpPre':
//         carbonCommentsList[index].lookupDetIdCfpPre = updatedValue;
//         roMachineIssueLogController
//             .addRoLogSheetRequestModel.lookupDetIdCfpPre = updatedValue;
//         break;
//       case 'lookupDetIdCfpPost':
//         carbonCommentsList[index].lookupDetIdCfpPost = updatedValue;
//         roMachineIssueLogController
//             .addRoLogSheetRequestModel.lookupDetIdCfpPost = updatedValue;
//         break;
//       case 'cfpDifference':
//         carbonCommentsList[index].cfpDifference = updatedValue;
//         roMachineIssueLogController.addRoLogSheetRequestModel.cfpDifference =
//             updatedValue;
//         break;
//       case 'lookupDetIdCarbonFilterBackwash':
//         carbonCommentsList[index].lookupDetIdCarbonFilterBackwash =
//             updatedValue;
//         roMachineIssueLogController.addRoLogSheetRequestModel
//             .lookupDetIdCarbonFilterBackwash = updatedValue;
//         break;
//       case 'lookupDetIdCarbonFilterRinse':
//         carbonCommentsList[index].lookupDetIdCarbonFilterRinse = updatedValue;
//         roMachineIssueLogController.addRoLogSheetRequestModel
//             .lookupDetIdCarbonFilterRinse = updatedValue;
//         break;
//       case 'carbonFilterDoneBy':
//         carbonCommentsList[index].carbonFilterDoneBy = updatedValue;
//         roMachineIssueLogController
//             .addRoLogSheetRequestModel.carbonFilterDoneBy = updatedValue;
//         break;
//       case 'cfpComments':
//         carbonCommentsList[index].cfpComments = updatedValue;
//         roMachineIssueLogController.addRoLogSheetRequestModel.cfpComments =
//             updatedValue;
//         break;
//     }
//   });
// }
}

class CheckBy {
  String? title;
  int? id;

  CheckBy(this.title, this.id);
}

class CarbonComments {
  String? productName;

  CarbonComments({
    this.productName,
  });

  // Optional: method to convert the object to JSON, useful for API calls
  Map<String, dynamic> toJson() => {
        'productName': productName,
      };
}
