import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/controller/daily_ro_logsheet_controller.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/model/daily_ro_log_sheet_save_model.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/model/daily_ro_logsheet_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/disinfect_type/disinfect_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class AddEditDailyRoLogSheet extends StatefulWidget {
  final DailyRoLogSheetModel? proLiItem;
  final bool? isEdit;

  const AddEditDailyRoLogSheet({super.key, this.proLiItem, this.isEdit});

  @override
  State<AddEditDailyRoLogSheet> createState() => _AddEditDailyRoLogSheetState();
}

class _AddEditDailyRoLogSheetState extends State<AddEditDailyRoLogSheet> {
  final DailyRoLogSheetController roMaintDetailsController = Get.find();

  DateTime? selectedInspection;
  DateTime? selectedNextInspection;

  String formattedDate1 = '';
  String formattedDate2 = '';

  bool hasInternet = true;

  var userData;

  InstituteDataModel? ins;

  MachineData? mac;

  DisinfectData? desIn;

  DoneByData? don;

  @override
  void initState() {
    // TODO: implement initState
    roMaintDetailsController.uploadImage.clear();
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
    roMaintDetailsController.update();
    if (hasInternet) {
      await getUserData();
    }

    if (widget.isEdit == true && widget.proLiItem != null) {
      await roMaintDetailsController.getRoById(widget.proLiItem!.id!);
      roMaintDetailsController.rawWaterTDS.text = roMaintDetailsController.roDet
              ?.firstWhere((e) => e.parameter == "Raw Water TDS")
              .values ??
          '';
      roMaintDetailsController.postSoftnerTDS.text = roMaintDetailsController
              .roDet
              ?.firstWhere((e) => e.parameter == "Post Softener TDS")
              .values ??
          '';
      roMaintDetailsController.postMembraneTDS.text = roMaintDetailsController
              .roDet
              ?.firstWhere((e) => e.parameter == "Post Membrane TDS")
              .values ??
          '';
      roMaintDetailsController.postMixbedTDS.text = roMaintDetailsController
              .roDet
              ?.firstWhere((e) => e.parameter == "Post Mixbed TDS")
              .values ??
          '';
      roMaintDetailsController.loopLineTDS.text = roMaintDetailsController.roDet
              ?.firstWhere((e) => e.parameter == "Loopline TDS")
              .values ??
          '';
      roMaintDetailsController.postSoftnerHardness.text =
          roMaintDetailsController.roDet
                  ?.firstWhere((e) => e.parameter == "Post Softener Hardness")
                  .values ??
              '';
      roMaintDetailsController.carbonChlorine.text = roMaintDetailsController
              .roDet
              ?.firstWhere((e) => e.parameter == "Post Carbon Filter Chlorine")
              .values ??
          '';
      roMaintDetailsController.rejectFlow.text = roMaintDetailsController.roDet
              ?.firstWhere((e) => e.parameter == "Reject Flow")
              .values ??
          '';
      roMaintDetailsController.productPermeateFlow.text =
          roMaintDetailsController.roDet
                  ?.firstWhere((e) => e.parameter == "Product / Permeate Flow")
                  .values ??
              '';

      RadioDet rinse = RadioDet(
          roMaintDetailsController.roDet
                      ?.firstWhere((e) => e.parameter == "Rinse Done")
                      .values ==
                  '1'
              ? "Yes"
              : "No",
          roMaintDetailsController.roDet
              ?.firstWhere((e) => e.parameter == "Rinse Done")
              .values);
      roMaintDetailsController.selectedRinseWash = rinse;

      RadioDet backwash = RadioDet(
          roMaintDetailsController.roDet
                      ?.firstWhere((e) => e.parameter == "Backwash Done")
                      .values ==
                  '1'
              ? "Yes"
              : "No",
          roMaintDetailsController.roDet
              ?.firstWhere((e) => e.parameter == "Backwash Done")
              .values);
      roMaintDetailsController.selectedbackWash = backwash;
      roMaintDetailsController.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.isEdit == true
              ? "Edit Daily RO Log Sheet"
              : 'Add Daily RO Log Sheet',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              roMaintDetailsController.rawWaterTDS.text = "";
              roMaintDetailsController.postSoftnerTDS.text = "";
              roMaintDetailsController.postMembraneTDS.text = "";
              roMaintDetailsController.postMixbedTDS.text = "";
              roMaintDetailsController.loopLineTDS.text = "";
              roMaintDetailsController.postSoftnerHardness.text = "";
              roMaintDetailsController.carbonChlorine.text = "";
              roMaintDetailsController.rejectFlow.text = "";
              roMaintDetailsController.productPermeateFlow.text = "";

              Get.back();
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body: GetBuilder<DailyRoLogSheetController>(builder: (controller) {
        return hasInternet
            ? controller.isLoading
                ?  Center(child: buildShimmerLoader())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                            children: [
                          Table(
                            columnWidths: const {
                              0: FlexColumnWidth(0.8),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(3),
                            },
                            border: TableBorder(
                              horizontalInside: BorderSide(color: Colors.grey.shade300),
                              verticalInside: BorderSide(color: Colors.grey.shade300),
                              top: BorderSide(color: Colors.grey.shade300),
                              bottom: BorderSide(color: Colors.grey.shade300),
                            ),
                            children: [

                              /// ---------- HEADER ----------
                              _tableHeader(),
                              _textRow("1", "Raw Water TDS", "ppm", roMaintDetailsController.rawWaterTDS),
                              _textRow("2", "Post Softener TDS", "ppm", roMaintDetailsController.postSoftnerTDS),
                              _textRow("3", "Post Membrane TDS", "ppm", roMaintDetailsController.postMembraneTDS),
                              _textRow("4", "Post Mixbed TDS", "ppm", roMaintDetailsController.postMixbedTDS),
                              _textRow("5", "Loopline TDS", "ppm", roMaintDetailsController.loopLineTDS),
                              _textRow("6", "Post Softener Hardness", "ppm", roMaintDetailsController.postSoftnerHardness),
                              _textRow("7", "Post Carbon Filter Chlorine", "ppm", roMaintDetailsController.carbonChlorine),
                              _textRow("8", "Reject Flow", "lph", roMaintDetailsController.rejectFlow),
                              _textRow("9", "Product / Permeate Flow", "lph", roMaintDetailsController.productPermeateFlow),

                              // _radioRow(
                              //   "10",
                              //   "Backwash Done",
                              //   roMaintDetailsController.backwashDone ?? [],
                              //   roMaintDetailsController.selectedbackWash,
                              //       (val) {
                              //     roMaintDetailsController.selectedbackWash = val;
                              //     roMaintDetailsController.update();
                              //   },
                              // ),
                              //
                              // _radioRow(
                              //   "11",
                              //   "Rinse Done",
                              //   roMaintDetailsController.rinseDone ?? [],
                              //   roMaintDetailsController.selectedRinseWash,
                              //       (val) {
                              //     roMaintDetailsController.selectedRinseWash = val;
                              //     roMaintDetailsController.update();
                              //   },
                              // ),
                            ],
                          )



                        ]),
                        // CustomTextField(
                        //   labelText: 'Raw Water TDS (ppm)',
                        //   hintText: 'Enter',
                        //   isRequired: false,
                        //   keyBoardType: TextInputType.text,
                        //   txtController: roMaintDetailsController.rawWaterTDS,
                        //   fillColor: Colors.white,
                        //   isReadOnly: false,
                        //   fontSize: 16,
                        //   maxLines: 1,
                        // ),
                        // CustomTextField(
                        //   labelText: 'Post Softener TDS (ppm)',
                        //   hintText: 'Enter',
                        //   isRequired: false,
                        //   keyBoardType: TextInputType.text,
                        //   txtController:
                        //       roMaintDetailsController.postSoftnerTDS,
                        //   fillColor: Colors.white,
                        //   isReadOnly: false,
                        //   maxLines: 1,
                        //   fontSize: 16,
                        // ),
                        // CustomTextField(
                        //   labelText: 'Post Membrane TDS (ppm)',
                        //   hintText: 'Enter',
                        //   isRequired: false,
                        //   keyBoardType: TextInputType.text,
                        //   txtController:
                        //       roMaintDetailsController.postMembraneTDS,
                        //   fillColor: Colors.white,
                        //   isReadOnly: false,
                        //   maxLines: 1,
                        //   fontSize: 16,
                        // ),
                        // CustomTextField(
                        //   labelText: 'Post Mixbed TDS (ppm)',
                        //   hintText: 'Enter',
                        //   isRequired: false,
                        //   keyBoardType: TextInputType.text,
                        //   txtController: roMaintDetailsController.postMixbedTDS,
                        //   fillColor: Colors.white,
                        //   isReadOnly: false,
                        //   maxLines: 1,
                        //   fontSize: 16,
                        // ),
                        // CustomTextField(
                        //   labelText: 'Loopline TDS (ppm)',
                        //   hintText: 'Enter',
                        //   isRequired: false,
                        //   keyBoardType: TextInputType.text,
                        //   txtController: roMaintDetailsController.loopLineTDS,
                        //   fillColor: Colors.white,
                        //   isReadOnly: false,
                        //   maxLines: 1,
                        //   fontSize: 16,
                        // ),
                        // CustomTextField(
                        //   labelText: 'Post Softener Hardness (ppm)',
                        //   hintText: 'Enter',
                        //   isRequired: false,
                        //   keyBoardType: TextInputType.text,
                        //   txtController:
                        //       roMaintDetailsController.postSoftnerHardness,
                        //   fillColor: Colors.white,
                        //   isReadOnly: false,
                        //   maxLines: 1,
                        //   fontSize: 16,
                        // ),
                        // CustomTextField(
                        //   labelText: 'Post Carbon Filter Chlorine (ppm)',
                        //   hintText: 'Enter',
                        //   isRequired: false,
                        //   keyBoardType: TextInputType.text,
                        //   txtController:
                        //       roMaintDetailsController.carbonChlorine,
                        //   fillColor: Colors.white,
                        //   isReadOnly: false,
                        //   maxLines: 1,
                        //   fontSize: 16,
                        // ),
                        // CustomTextField(
                        //   labelText: 'Reject Flow (lph)',
                        //   hintText: 'Enter',
                        //   isRequired: false,
                        //   keyBoardType: TextInputType.text,
                        //   txtController: roMaintDetailsController.rejectFlow,
                        //   fillColor: Colors.white,
                        //   isReadOnly: false,
                        //   maxLines: 1,
                        //   fontSize: 16,
                        // ),
                        // CustomTextField(
                        //   labelText: 'Product / Permeate Flow (lph)',
                        //   hintText: 'Enter',
                        //   isRequired: false,
                        //   keyBoardType: TextInputType.text,
                        //   txtController:
                        //       roMaintDetailsController.productPermeateFlow,
                        //   fillColor: Colors.white,
                        //   isReadOnly: false,
                        //   maxLines: 1,
                        //   fontSize: 16,
                        // ),
                        LookupRadioGroup(
                          label: "Backwash Done",
                          isRequired: false,
                          items: roMaintDetailsController.backwashDone ?? [],
                          groupValue:
                              roMaintDetailsController.selectedbackWash?.value,
                          onChanged: (id) {
                            roMaintDetailsController.selectedbackWash = id;

                            roMaintDetailsController.update();
                          },
                        ),
                        LookupRadioGroup(
                          label: "Rinse Done",
                          isRequired: false,
                          items: roMaintDetailsController.rinseDone ?? [],
                          groupValue:
                              roMaintDetailsController.selectedRinseWash?.value,
                          onChanged: (id) {
                            roMaintDetailsController.selectedRinseWash = id;

                            roMaintDetailsController.update();
                          },
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
                                      if (widget.isEdit == false) {
                                        controller.addDailyRoLogSheetModel
                                            ?.unitId = userData['unitId'];

                                        controller.addDailyRoLogSheetModel
                                                ?.machineName =
                                            roMaintDetailsController
                                                .instituteList?.data
                                                ?.firstWhere((e) =>
                                                    e.unitId ==
                                                    userData['unitId'])
                                                .unitName;

                                        controller.addDailyRoLogSheetModel
                                                ?.machineId =
                                            roMaintDetailsController
                                                .instituteList?.data
                                                ?.firstWhere((e) =>
                                                    e.unitId ==
                                                    userData['unitId'])
                                                .unitId;

                                        controller.addDailyRoLogSheetModel
                                                ?.roPlantDate =
                                            DateTime.now()
                                                .millisecondsSinceEpoch;

                                        controller.addDailyRoLogSheetModel
                                            ?.userId = userData['ui'];

                                        controller.addDailyRoLogSheetModel
                                            ?.roLogSheetPlantDetList = [
                                          RoLogSheetPlantDetList(
                                              parameter: 'Raw Water TDS',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .rawWaterTDS.text,
                                              roLogSheetDetId: null),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Post Softener TDS',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .postSoftnerTDS.text,
                                              roLogSheetDetId: null),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Post Membrane TDS',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .postMembraneTDS.text,
                                              roLogSheetDetId: null),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Post Mixbed TDS',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .postMixbedTDS.text,
                                              roLogSheetDetId: null),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Loopline TDS',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .loopLineTDS.text,
                                              roLogSheetDetId: null),
                                          RoLogSheetPlantDetList(
                                              parameter:
                                                  'Post Softener Hardness',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .postSoftnerHardness.text,
                                              roLogSheetDetId: null),
                                          RoLogSheetPlantDetList(
                                              parameter:
                                                  'Post Carbon Filter Chlorine',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .carbonChlorine.text,
                                              roLogSheetDetId: null),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Reject Flow',
                                              units: "lph",
                                              values: roMaintDetailsController
                                                  .rejectFlow.text,
                                              roLogSheetDetId: null),
                                          RoLogSheetPlantDetList(
                                              parameter:
                                                  'Product / Permeate Flow',
                                              units: "lph",
                                              values: roMaintDetailsController
                                                  .productPermeateFlow.text,
                                              roLogSheetDetId: null),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Backwash Done',
                                              units: "-",
                                              values: roMaintDetailsController
                                                  .selectedbackWash?.value,
                                              roLogSheetDetId: null),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Rinse Done',
                                              units: "-",
                                              values: roMaintDetailsController
                                                  .selectedRinseWash?.value,
                                              roLogSheetDetId: null)
                                        ];

                                        await controller
                                            .addEditDailyRoLogSheet();
                                      } else {

                                        controller.addDailyRoLogSheetModel
                                            ?.dailyRoPlantLogId =  roMaintDetailsController.roDet
                                            ?.firstWhere((e) =>
                                        e.parameter ==
                                            "Raw Water TDS")
                                            .logId;

                                        controller.addDailyRoLogSheetModel
                                            ?.unitId = userData['unitId'];

                                        controller.addDailyRoLogSheetModel
                                                ?.machineName =
                                            widget.proLiItem?.machineName;

                                        controller.addDailyRoLogSheetModel
                                            ?.machineId =
                                            widget.proLiItem?.machineId;

                                        DateFormat format =
                                            DateFormat("dd/MM/yyyy");

                                        DateTime dateTime = format.parse(
                                            widget.proLiItem!.roPlantDate!);

                                        controller.addDailyRoLogSheetModel
                                                ?.roPlantDate =
                                            dateTime.millisecondsSinceEpoch;


                                        controller.addDailyRoLogSheetModel
                                            ?.userId = userData['ui'];

                                        controller.addDailyRoLogSheetModel
                                            ?.roLogSheetPlantDetList = [
                                          RoLogSheetPlantDetList(
                                              parameter: 'Raw Water TDS',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .rawWaterTDS.text,
                                              roLogSheetDetId:
                                                  roMaintDetailsController.roDet
                                                      ?.firstWhere((e) =>
                                                          e.parameter ==
                                                          "Raw Water TDS")
                                                      .detailId),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Post Softener TDS',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .postSoftnerTDS.text,
                                              roLogSheetDetId:
                                                  roMaintDetailsController.roDet
                                                      ?.firstWhere((e) =>
                                                          e.parameter ==
                                                          "Post Softener TDS")
                                                      .detailId),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Post Membrane TDS',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .postMembraneTDS.text,
                                              roLogSheetDetId:
                                                  roMaintDetailsController.roDet
                                                      ?.firstWhere((e) =>
                                                          e.parameter ==
                                                          "Post Membrane TDS")
                                                      .detailId),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Post Mixbed TDS',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .postMixbedTDS.text,
                                              roLogSheetDetId:
                                                  roMaintDetailsController.roDet
                                                      ?.firstWhere((e) =>
                                                          e.parameter ==
                                                          "Post Mixbed TDS")
                                                      .detailId),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Loopline TDS',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .loopLineTDS.text,
                                              roLogSheetDetId:
                                                  roMaintDetailsController.roDet
                                                      ?.firstWhere((e) =>
                                                          e.parameter ==
                                                          "Loopline TDS")
                                                      .detailId),
                                          RoLogSheetPlantDetList(
                                              parameter:
                                                  'Post Softener Hardness',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .postSoftnerHardness.text,
                                              roLogSheetDetId:
                                                  roMaintDetailsController.roDet
                                                      ?.firstWhere((e) =>
                                                          e.parameter ==
                                                          "Post Softener Hardness")
                                                      .detailId),
                                          RoLogSheetPlantDetList(
                                              parameter:
                                                  'Post Carbon Filter Chlorine',
                                              units: "ppm",
                                              values: roMaintDetailsController
                                                  .carbonChlorine.text,
                                              roLogSheetDetId:
                                                  roMaintDetailsController.roDet
                                                      ?.firstWhere((e) =>
                                                          e.parameter ==
                                                          "Post Carbon Filter Chlorine")
                                                      .detailId),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Reject Flow',
                                              units: "lph",
                                              values: roMaintDetailsController
                                                  .rejectFlow.text,
                                              roLogSheetDetId:
                                                  roMaintDetailsController.roDet
                                                      ?.firstWhere((e) =>
                                                          e.parameter ==
                                                          "Reject Flow")
                                                      .detailId),
                                          RoLogSheetPlantDetList(
                                              parameter:
                                                  'Product / Permeate Flow',
                                              units: "lph",
                                              values: roMaintDetailsController
                                                  .productPermeateFlow.text,
                                              roLogSheetDetId:
                                                  roMaintDetailsController.roDet
                                                      ?.firstWhere((e) =>
                                                          e.parameter ==
                                                          "Product / Permeate Flow")
                                                      .detailId),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Backwash Done',
                                              units: "-",
                                              values: roMaintDetailsController
                                                  .selectedbackWash?.value,
                                              roLogSheetDetId:
                                                  roMaintDetailsController.roDet
                                                      ?.firstWhere((e) =>
                                                          e.parameter ==
                                                          "Backwash Done")
                                                      .detailId),
                                          RoLogSheetPlantDetList(
                                              parameter: 'Rinse Done',
                                              units: "-",
                                              values: roMaintDetailsController
                                                  .selectedRinseWash?.value,
                                              roLogSheetDetId:
                                                  roMaintDetailsController.roDet
                                                      ?.firstWhere((e) =>
                                                          e.parameter ==
                                                          "Rinse Done")
                                                      .detailId)
                                        ];

                                        await controller
                                            .addEditDailyRoLogSheet();
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
                                controller.rawWaterTDS.text = "";
                                controller.postSoftnerTDS.text = "";
                                controller.postMembraneTDS.text = "";
                                controller.postMixbedTDS.text = "";
                                controller.loopLineTDS.text = "";
                                controller.postSoftnerHardness.text = "";
                                controller.carbonChlorine.text = "";
                                controller.rejectFlow.text = "";
                                controller.productPermeateFlow.text = "";

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
                              primColor: AppColor.red,
                              secColor: AppColor.red,
                              textColor: Colors.white,
                              iconColor: Colors.white,
                            ),
                          ],
                        ).paddingOnly(top: 20, bottom: 20)
                      ],
                    ).paddingSymmetric(horizontal: 10),
                  )
            : InternetIssue(
                onRetryPressed: () {
                  checkInternetAndLoadData();
                },
              );
      }
      ),
    );
  }
  TableRow _tableHeader() {
    return  TableRow(
      decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
      children: [
        _cellText("Sr. No.", bold: true),
        _cellText("Parameter", bold: true),
        _cellText("Units", bold: true),
        _cellText("Values", bold: true),
      ],
    );
  }
  TableRow _textRow(
      String sr,
      String param,
      String unit,
      TextEditingController controller,
      ) {
    return TableRow(
      children: [
        _cellText(sr),
        _cellText(param),
        _cellText(unit),
        Padding(
          padding: const EdgeInsets.all(6),
          child: SizedBox(
            height: 36,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '',
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                // // Normal Border
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.8)),
                ),
                // Enabled Border
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.8)),
                ),
                // Focused Border
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.8),
                    width: 0.8,
                  ),
                ),
                // Error Border
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.red, width: 0.8,),
                ),

                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.red, width: 0.8,),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  TableRow _radioRow(
      String sr,
      String param,
      List<RadioDet> items,
      RadioDet? selected,
      Function(RadioDet) onChanged,
      ) {
    return TableRow(
      children: [
        _cellText(sr),
        _cellText(param),
        _cellText("-"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: items.map((e) {
              return Row(
                children: [
                  Radio<String>(
                    value: e.value ?? '',
                    groupValue: selected?.value,
                    activeColor: AppColor.secondaryColor,
                    onChanged: (_) => onChanged(e),
                  ),
                  Text(e.text ?? ''),
                  const SizedBox(width: 10),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
  Widget _cellText(String text, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  TableRow _buildRow({
    required String sr,
    required String param,
    required String unit,
    required TextEditingController controller,
  }) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8), child: Text(sr)),
        Padding(padding: const EdgeInsets.all(8), child: Text(param)),
        Padding(padding: const EdgeInsets.all(8), child: Text(unit)),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

}

class RadioDet {
  String? text;
  String? value;

  RadioDet(this.text, this.value);
}

class LookupRadioGroup extends StatelessWidget {
  final String label;
  final bool isRequired;
  final List<RadioDet> items;
  final String? groupValue; // selected lookupDetId
  final ValueChanged<RadioDet?> onChanged;

  const LookupRadioGroup({
    super.key,
    required this.label,
    required this.isRequired,
    required this.items,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: label,
          fontSize: 14,
          fontFam: 'Lato',
          fontWeight: FontWeight.normal,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        if (isRequired)
          const Text(' *', style: TextStyle(color: Colors.red, fontSize: 16)),
        const SizedBox(width: 12),
        Wrap(
          spacing: 30,
          children: items.map((it) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  activeColor: AppColor.secondaryColor,
                  value: it.value,
                  groupValue: groupValue,
                  onChanged: (id) {
                    onChanged(it);
                  },
                ),
                Text(it.text ?? '-'),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
