import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/medicine_name_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/prescription_instruction_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/prescription_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/route_list_model.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/choose_package.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/choose_package.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/disinfect_type/disinfect_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

// import '../../../widgets/custom_shimmer_loader.dart';

class AddPrescription extends StatefulWidget {
  final NephroList? patientData;
  final ListOpdPrescriptionDtoSp? prescriptionDtoSp;

  final bool? isEdit;

  const AddPrescription(
      {super.key, this.patientData, this.isEdit, this.prescriptionDtoSp});

  @override
  State<AddPrescription> createState() => _AddPrescriptionState();
}

class _AddPrescriptionState extends State<AddPrescription> {
  final NephroController nephroController = Get.find<NephroController>();
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;





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
  final List<CheckBoxList> checkTitle = [
    CheckBoxList("Morning", false,
        imgPath: "assets/haze-line.png",
        firstColor: const Color(0xFF4271CB),
        secondColor: const Color(0xFFFBD1BB)),
    CheckBoxList("Afternoon", false,
        imgPath: "assets/sun.png",
        firstColor: const Color(0xFFFF8D00),
        secondColor: const Color(0xFFFBBE00)),
    CheckBoxList("Evening", false,
        imgPath: "assets/cloud.png",
        firstColor: const Color(0xFF6A1B9A),
        secondColor: const Color(0xFFD63940)),
    CheckBoxList("Nignt", false,
        imgPath: "assets/moon.png",
        firstColor: const Color(0xFF131862),
        secondColor: const Color(0xFF546BAB)),
  ];

  LstPrescriptionGenericDto? selectedMedicine;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int freqCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );

    getUserData();
    checkInternetAndLoadData();
    super.initState();
  }

  getUserData() async {
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

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    nephroController.update();
    if (hasInternet) {
      await nephroController.getMedicineNameList('');
      await nephroController.getPrescInstruction();
      await nephroController.getRouteList(userData['unitId']);
      await nephroController.getMedicationList();
      if (widget.isEdit == false) {
        nephroController.medicineNameTxtEdit.text = '';
        nephroController.selectedPrep = null;
        nephroController.dosage.text = '';
        nephroController.selectedUnit = null;
        nephroController.presFreqTxt.text = '';
        nephroController.selectedRoute = null;
        nephroController.selectedInst = null;
        nephroController.presDays.text = '';
        nephroController.presQty.text = '';
      } else if (widget.isEdit == true) {
        nephroController.medicineNameTxtEdit.text =
            widget.prescriptionDtoSp?.medicineName ?? '';
        nephroController.selectedPrep = widget.prescriptionDtoSp?.prepName;
        nephroController.dosage.text = widget.prescriptionDtoSp?.dose ?? '';
        nephroController.selectedUnit =
            widget.prescriptionDtoSp?.unitName ?? '';
        nephroController.presFreqTxt.text =
            widget.prescriptionDtoSp?.frequency.toString() ?? '';
        nephroController.selectedRoute = nephroController.routeList?.firstWhere(
            (e) => e.routeId == widget.prescriptionDtoSp?.route,
            orElse: () => Listroutemasters());
        nephroController.selectedInst = nephroController.presInstList
            ?.firstWhere(
                (e) =>
                    e.englishInstruction ==
                    widget.prescriptionDtoSp?.instructionName?.split('/')[0],
                orElse: () => ListPrescriptionInstructionDto())
            .englishInstruction;
        nephroController.presDays.text =
            widget.prescriptionDtoSp?.days.toString() ?? '';
        nephroController.presQty.text =
            widget.prescriptionDtoSp?.qty.toString() ?? '';
      }
    }
    // setState(() {});
    nephroController.update();
  }
  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
//
  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable ?  Scaffold(
      appBar: AppBar(
        title: CustomText(
          text:
              widget.isEdit == true ? "Edit Prescription" : 'Add Prescription',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              nephroController.medicineNameTxtEdit.text = '';
              nephroController.selectedPrep = null;
              nephroController.dosage.text = '';
              nephroController.selectedUnit = null;
              nephroController.presFreqTxt.text = '';
              nephroController.selectedRoute = null;
              nephroController.selectedInst = null;
              nephroController.presDays.text = '';
              nephroController.presQty.text = '';
              Get.back();
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body: GetBuilder<NephroController>(
          init: nephroController,
          builder: (controller) {
            if (controller.isLoading) {
              return Center(child: buildShimmerLoader());
            }
            return SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              MyCustomDropdown(
                                selectedItem: nephroController.selectedPrep,
                                labelText: 'Prep',
                                items: nephroController.prepListDropDown
                                    ?.map((e) => e.preparationName)
                                    .toList() ??
                                    [],
                                hint: 'Select',
                                isRequired: true,
                                senValue: (value) {
                                  nephroController.selectedPrep = value;
                                  controller.update();
                                },
                                filledColor: Colors.white,
                              ),

                              Row(
                                children: [
                                  const CustomText(
                                      text: "Medicine Name",
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start),
                                  CustomText(
                                      text: "*",
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      textColor: AppColor.red,
                                      textAlign: TextAlign.start),
                                ],
                              ).paddingOnly(left: 8, bottom: 4),
                              FormField<String>(
                                validator: (value) {
                                  if (controller.medicineNameTxtEdit.text
                                      .trim()
                                      .isEmpty) {
                                    return "Medicine name is required";
                                  }
                                  return null;
                                },
                                builder: (formFieldState) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TypeAheadField<LstPrescriptionGenericDto>(
                                        controller:
                                            controller.medicineNameTxtEdit,
                                        suggestionsCallback: (search) {
                                          if (search.isEmpty) return [];
                                          return controller
                                                  .medicineNameModelList
                                                  ?.where((area) =>
                                                      area.drugName
                                                          ?.toLowerCase()
                                                          .contains(search
                                                              .toLowerCase()) ??
                                                      false)
                                                  .toList() ??
                                              [];
                                        },
                                        builder: (context,
                                            textEditingController, focusNode) {
                                          return TextField(
                                            controller: textEditingController,
                                            focusNode: focusNode,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: "Medicine Name",
                                              hintStyle: TextStyle(
                                                fontSize: 16.0,
                                                color: AppColor.textGrey,
                                                fontFamily: "Nunito Sans",
                                                fontWeight: FontWeight.normal,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColor.borderColor),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColor.borderColor),
                                              ),
                                            ),
                                            onChanged: (_) =>
                                                formFieldState.didChange(_),
                                          );
                                        },
                                        itemBuilder: (context, city) {
                                          return ListTile(
                                            title: Text(
                                                city.drugName?.trim() ?? ""),
                                          );
                                        },
                                        onSelected: (city) async {
                                          selectedMedicine = city;
                                          controller.medicineNameTxtEdit.text =
                                              city.drugName?.trim() ?? "";
                                          await controller.getMedicineDataById(
                                              selectedMedicine!.productId
                                                  .toString());
                                          nephroController.selectedPrep =
                                              controller
                                                  .medicineDataById
                                                  ?.preparationMaster
                                                  ?.preparationName;
                                          nephroController.selectedUnit =
                                              controller.medicineDataById
                                                      ?.uomMaster?.uomName ??
                                                  "";
                                          controller.dosage.text = controller
                                                  .medicineDataById
                                                  ?.strengthMaster
                                                  ?.strengthName ??
                                              "";
                                          controller.update();
                                          formFieldState
                                              .didChange(city.drugName);
                                        },
                                      ).paddingOnly(left: 8, right: 8),
                                      if (formFieldState.hasError)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, top: 4),
                                          child: Text(
                                            formFieldState.errorText ?? '',
                                            style: TextStyle(
                                                color: AppColor.red,
                                                fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      labelText: "Dosage",
                                      hintText: "Enter",
                                      isRequired: false,
                                      keyBoardType: TextInputType.text,
                                      txtController: controller.dosage,
                                      fillColor: Colors.white,
                                      isReadOnly: false,
                                      maxLines: 1,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: MyCustomDropdown(
                                      selectedItem:
                                          nephroController.selectedUnit,
                                      labelText: 'Unit',
                                      items: controller.prepUnitList
                                              ?.map((e) => e.uomName)
                                              .toList() ??
                                          [],
                                      hint: 'Select',
                                      isRequired: false,
                                      senValue: (value) {
                                        nephroController.selectedUnit = value;
                                        controller.update();
                                      },
                                      filledColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: checkTitle.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: 50,
                                        width: 95,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: CustomText(
                                                  text: checkTitle[index]
                                                          .checkTitle ??
                                                      "",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  textColor: Colors.black,
                                                  textAlign: TextAlign.start),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffF8F8F8),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: AppColor
                                                          .borderColor)),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            checkTitle[index]
                                                                .firstColor!,
                                                            checkTitle[index]
                                                                .secondColor!,
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        6),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        6))),
                                                    child: Image.asset(checkTitle[
                                                                index]
                                                            .imgPath ??
                                                        "assets/haze-line.png"),
                                                  ),
                                                  Expanded(
                                                    child: Checkbox(
                                                      activeColor: AppColor
                                                          .primaryBackgroundColor,
                                                      value: checkTitle[index]
                                                          .isSelected,
                                                      // Boolean value for checkbox state
                                                      onChanged:
                                                          (bool? newValue) {
                                                        checkTitle[index]
                                                                .isSelected =
                                                            newValue;
                                                        setState(() {
                                                          checkTitle[index]
                                                                  .isSelected =
                                                              newValue;
                                                          freqCount = checkTitle
                                                              .where((isChecked) =>
                                                                  isChecked
                                                                      .isSelected!)
                                                              .length;
                                                          controller.presFreqTxt
                                                                  .text =
                                                              freqCount
                                                                  .toString();
                                                        });

                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).paddingAll(4.0);
                                    }),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      labelText: "Frequency",
                                      hintText: "Enter",
                                      isRequired: false,
                                      keyBoardType: TextInputType.text,
                                      txtController: controller.presFreqTxt,
                                      fillColor: Colors.white,
                                      isReadOnly: true,
                                      maxLines: 1,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: MyCustomDropdownObject(
                                      selectedItem:
                                          nephroController.selectedRoute,
                                      labelText: 'Route',
                                      items: nephroController.routeList
                                              ?.map((e) => e)
                                              .toList() ??
                                          [],
                                      hint: 'Select',
                                      isRequired: false,
                                      senValue: (value) {
                                        nephroController.selectedRoute = value;
                                        controller.update();
                                      },
                                      filledColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              MyCustomDropdown(
                                selectedItem: nephroController.selectedInst,
                                labelText: 'Instructions',
                                items: controller.presInstList
                                        ?.map((e) => e.englishInstruction)
                                        .toSet()
                                        .toList() ??
                                    [],
                                hint: 'Select',
                                isRequired: false,
                                senValue: (value) {
                                  nephroController.selectedInst = value;
                                  controller.update();
                                },
                                filledColor: Colors.white,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      labelText: "Days",
                                      hintText: "Enter",
                                      isRequired: true,
                                      keyBoardType: TextInputType.number,
                                      txtController: controller.presDays,
                                      fillColor: Colors.white,
                                      isReadOnly: false,
                                      maxLines: 1,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      labelText: "Quantity",
                                      hintText: "Enter",
                                      isRequired: true,
                                      keyBoardType: TextInputType.number,
                                      txtController: controller.presQty,
                                      fillColor: Colors.white,
                                      isReadOnly: false,
                                      maxLines: 1,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              MyCustomDropdown(
                                selectedItem:
                                    nephroController.selectedMedication,
                                labelText: 'Medication Method',
                                items: nephroController.medicationList
                                        ?.map((e) => e.lookupDetDescEn)
                                        .toList() ??
                                    [],
                                hint: 'Select',
                                isRequired: true,
                                senValue: (value) {
                                  nephroController.selectedMedication = value;
                                  controller.update();
                                },
                                filledColor: Colors.white,
                              ),
                              CustomTextField(
                                labelText: "Reason",
                                hintText: "Enter",
                                isRequired: true,
                                keyBoardType: TextInputType.text,
                                txtController: controller.reason,
                                fillColor: Colors.white,
                                isReadOnly: false,
                                maxLines: 1,
                                fontSize: 16,
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 20,
                                  bottom: MediaQuery.of(context).viewPadding.bottom + // safe area (gesture bar)
                                      MediaQuery.of(context).viewInsets.bottom + // keyboard inset (if keyboard open)
                                      12, // extra spacing
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomButton(
                                      isLoading: controller.isLoading,
                                      buttonText: 'Save',
                                      path: 'assets/save-ro-disinfec.png',
                                      callB: () async {
                                        if (formKey.currentState?.validate() ??
                                            false) {
                                          ListPrescriptionInstructionDto?
                                              selectedInstruc;
                                          String? selectedFreq;
                                          if (nephroController.selectedInst !=
                                              null) {
                                            selectedInstruc = controller
                                                .presInstList
                                                ?.firstWhere((e) =>
                                                    e.englishInstruction ==
                                                    nephroController
                                                        .selectedInst);
                                          }

                                          if (checkTitle.isNotEmpty) {
                                            selectedFreq = checkTitle
                                                .map((value) =>
                                                    value.isSelected! ? "1" : "0")
                                                .join(",");
                                          }

                                          String formattedDate =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(DateTime.now());

                                          var body = {
                                            "prescriptionId":
                                                widget.isEdit == true
                                                    ? widget.prescriptionDtoSp
                                                        ?.prescriptionId
                                                    : 0,
                                            "patientId":
                                                widget.patientData?.patientId,
                                            "treatmentId":
                                                widget.patientData?.treatmentId,
                                            "prep": widget.isEdit == true
                                                ? widget.prescriptionDtoSp?.prep
                                                : controller
                                                    .medicineDataById
                                                    ?.preparationMaster
                                                    ?.preparationId,
                                            "medicineName": controller
                                                .medicineNameTxtEdit.text,
                                            "strength": controller.dosage.text,
                                            "unit": selectedInstruc?.unitId,
                                            "frequency": freqCount,
                                            "instruction": selectedInstruc?.id,
                                            "route": nephroController
                                                .selectedRoute?.routeId,
                                            "days": convertToNumber(
                                                controller.presDays.text),
                                            "qty": convertToNumber(
                                                controller.presQty.text),
                                            "paediatricsMedicineFlag": "N",
                                            "paediatricsMedicineCapacity": 0,
                                            "dayPrescription": selectedFreq,
                                            "deleted": "N",
                                            "administeredStatus": "N",
                                            "nutracalProductFlag": 1,
                                            "drugName": controller
                                                .medicineDataById
                                                ?.drugMaster
                                                ?.drugName
                                                ?.trim(),
                                            "drugId": 0,
                                            "prescriptionOrderDate":
                                                formattedDate,
                                            "unitId": userData['unitId'],
                                            "userId": userData['user_ID'],
                                            "medId": widget.isEdit == true
                                                ? widget
                                                    .prescriptionDtoSp?.medicineId
                                                : controller
                                                    .medicineDataById?.productId,
                                            "reason": "test",

                                            ///need to pass values
                                            "medicationMethod": 871

                                            ///need to pass values
                                          };
                                          await controller.addPrescription(
                                              body,
                                              widget.patientData,
                                              userData['unitId']);
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
                                      secColor: AppColor.red,
                                      textColor: Colors.white,
                                      iconColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 6),
                        ),
                      );
          }),
    ) : InternetIssue(
      onRetryPressed: () async {
        final result = await _connectivity.checkConnectivity();
        _updateConnectionStatus(result);
      },
    );
  }

  dynamic convertToNumber(String input) {
    if (input.contains('.')) {
      return double.parse(input);
    } else {
      return int.parse(input);
    }
  }
}
