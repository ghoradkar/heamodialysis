import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/disinfect_type/disinfect_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/status_dialog.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';


class AddEditInst extends StatefulWidget {
  final NephroList? patientData;
  final bool? isEdit;

  const AddEditInst({super.key, this.isEdit, this.patientData});

  @override
  State<AddEditInst> createState() => _AddEditInstState();
}

class _AddEditInstState extends State<AddEditInst> {
  final NephroController nephroInstructions = Get.find();

  DateTime? selectedInspection;
  DateTime? selectedNextInspection;

  String formattedDate1 = '';
  String formattedDate2 = '';

  bool hasInternet = true;

  var userData;

  InstituteDataModel? ins;

  MachineData? mac;

  DisinfectData? desIn;
  CustomRadioButtons groupVal = CustomRadioButtons.yes;

  DoneByData? don;

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
    nephroInstructions.update();
    if (hasInternet) {
      // await nephroInstructions.getInstituteList();
      // await nephroInstructions
      //     .getMachineList(userData['unitId']);
      // await nephroInstructions.getDisinfecUsed();
      // await nephroInstructions
      //     .getDoneByList(userData['unitId']);
    }
    // setState(() {});
    nephroInstructions.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.isEdit == true ? "Edit Instruction" : 'Add Instruction',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              // nephroInstructions.initialInsti = null;
              // nephroInstructions.initialMachine = null;
              // nephroInstructions.initialDisinfect = null;
              // nephroInstructions.initialDoneBy = null;
              // nephroInstructions.nextInspecDateController.text = "";
              // nephroInstructions.inspectionDateController.text = "";
              // nephroInstructions.commentController.text = "";

              Get.back();
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body: GetBuilder<NephroController>(
          init: nephroInstructions,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ? Center(child: buildShimmerLoader())
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomTextField(
                              labelText: "Instruction in English",
                              hintText: "Enter",
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController: controller.instEnglish,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 1,
                              fontSize: 16,
                            ),
                            CustomTextField(
                              labelText: "Instruction in हिंदी",
                              hintText: "Enter",
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController: controller.instHindi,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 1,
                              fontSize: 16,
                            ),
                            CustomTextField(
                              labelText: "Instruction in मराठी",
                              hintText: "Enter",
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController: controller.instMarathi,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 1,
                              fontSize: 16,
                            ),
                            CustomTextField(
                              labelText: "Other Language 1",
                              hintText: "Enter",
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController: controller.instLang1,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 1,
                              fontSize: 16,
                            ),
                            CustomTextField(
                              labelText: "Other Language 2",
                              hintText: "Enter",
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController: controller.instLang2,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 1,
                              fontSize: 16,
                            ),
                            CustomTextField(
                              labelText: "Other Language 3",
                              hintText: "Enter",
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController: controller.instLang3,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 1,
                              fontSize: 16,
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
                                          var body = {
                                            "reportInstructionID": 0,
                                            "reportInstruction":
                                                controller.instEnglish.text,
                                            "reportInstructionHindi":
                                                controller.instHindi.text,
                                            "reportInstructionMarathi":
                                                controller.instMarathi.text,
                                            "reportInstructionOther1":
                                                controller.instLang1.text,
                                            "reportInstructionOther2":
                                                controller.instLang2.text,
                                            "reportInstructionOther3":
                                                controller.instLang3.text,
                                            "mandatoryInstFlag": "Y",
                                            "deleted": "N",
                                            "createdBy": userData['createdBy'],
                                            "unitId": userData['unitId'],
                                            "userId": userData['user_ID']
                                          };

                                          final isSave = await controller
                                              .saveIndivisualInstructions(
                                                  body,
                                                  widget
                                                      .patientData?.treatmentId
                                                      .toString(),
                                                  widget.patientData?.patientId
                                                      .toString(),
                                                  context);

                                          if (isSave) {
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 300), () {
                                              Get.back();
                                              // Navigator.of(context).pop();
                                              Get.back();
                                            });
                                          }
                                        },
                                  buttonWidth: 100,
                                  primColor: AppColor.primaryBackgroundColor,
                                  secColor: AppColor.secondaryColor,
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
                                  secColor: Colors.red,
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

  sendConvertedDateToAPI(date) {
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(date);

    // Format the parsed date to the desired format
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    return formattedDate;
  }

  dateConversion(inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }
}
