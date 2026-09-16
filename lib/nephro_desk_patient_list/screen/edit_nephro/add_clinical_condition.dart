import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/clinical_condition_provisiona_list.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/get_diagnosis_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';


class AddClinicalCondition extends StatefulWidget {
  final ClinicalConditionProvisionaList? proLiItem;
  final bool? isEdit;
  final NephroList? patientData;

  const AddClinicalCondition(
      {super.key, this.proLiItem, this.isEdit, this.patientData});

  @override
  State<AddClinicalCondition> createState() => _AddClinicalConditionState();
}

class _AddClinicalConditionState extends State<AddClinicalCondition> {
  final NephroController nephroController = Get.find<NephroController>();

  DateTime? selectedInspection;
  DateTime? selectedNextInspection;

  String formattedDate1 = '';

  bool hasInternet = true;

  var userData;

  CustomRadioButtons groupVal = CustomRadioButtons.yes;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GetDiagonisisList? selectedDiagno;

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
    nephroController.update();
    if (hasInternet) {
      if (widget.isEdit == true) {
        setFieldValue();
      }
    }
    // setState(() {});
    nephroController.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.isEdit == true
              ? context.l10n.nephroEditClinicalCondition
              : context.l10n.nephroAddClinicalCondition,
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body: GetBuilder<NephroController>(
          init: nephroController,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                ?  Center(child: buildShimmerLoader())
                    : SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomRadioField(
                                isRequired: false,
                                radioCallB1: (value) {
                                  groupVal = value;
                                  setState(() {});
                                },
                                radioCallB2: (value) {
                                  groupVal = value;
                                  setState(() {});
                                },
                                groupVal: groupVal,
                                text: '',
                                firstRadioText: 'ICD10',
                                secondRadioText: 'ICDO',
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                    text: context.l10n.nephroDiagnosis,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    textColor: Colors.black,
                                    textAlign: TextAlign.start),
                              ).paddingOnly(left: 8, bottom: 4),
                              TypeAheadField<GetDiagonisisList>(
                                controller: controller.diagnosisController,
                                // Ensure this is the main controller
                                suggestionsCallback: (search) {
                                  if (search.isEmpty) {
                                    return []; // Return an empty list if no input
                                  }
                                  return controller.diagnosisList
                                          ?.where((area) =>
                                              area.nameL
                                                  ?.toLowerCase()
                                                  .contains(
                                                      search.toLowerCase()) ??
                                              false)
                                          .toList() ??
                                      [];
                                },
                                builder: (context, textEditingController,
                                    focusNode) {
                                  return TextField(
                                    controller: textEditingController,
                                    // Use the same main controller
                                    focusNode: focusNode,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 14),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: context.l10n.nephroDiagnosis,
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
                                            color: AppColor.borderColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: AppColor.borderColor),
                                      ),
                                    ),
                                  );
                                },
                                itemBuilder: (context, city) {
                                  return ListTile(
                                    title: Text(city.nameL ?? ""),
                                  );
                                },
                                onSelected: (city) async {
                                  selectedDiagno = city;
                                  controller.diagnosisController.text =
                                      city.nameL ?? "";
                                  controller.diagnoDes.text = city.nameL ?? "";
                                  await controller
                                      .getICDCode(city.idicd10L.toString());
                                  controller.update();
                                },
                              ).paddingOnly(left: 8, right: 8),
                              CustomTextField(
                                  labelText: context.l10n.nephroDiagnosisDescription,
                                  hintText: context.l10n.regHintEnter,
                                  isRequired: false,
                                  keyBoardType: TextInputType.text,
                                  txtController: controller.diagnoDes,
                                  fillColor: Colors.white,
                                  isReadOnly: true,
                                  fontSize: 16,
                                  maxLines: 1),
                              CustomTextField(
                                labelText: context.l10n.nephroIcd10Code,
                                hintText: context.l10n.regHintEnter,
                                isRequired: false,
                                keyBoardType: TextInputType.text,
                                txtController: controller.icdCodeTxtField,
                                fillColor: Colors.white,
                                isReadOnly: true,
                                maxLines: 1,
                                fontSize: 16,
                              ),
                              CustomDateField(
                                labelText: context.l10n.commonDate,
                                hint: context.l10n.dashSelectDate,
                                isRequired: true,
                                callB: () {
                                  pickInspectionDate(context);
                                },
                                selectedDate: nephroController.diagDate,
                                filledColor: Colors.white,
                                dontDhowPrefix: false,
                              ),
                              MyCustomDropdown(
                                selectedItem: nephroController.diagType,
                                labelText: context.l10n.nephroDiagnosisType,
                                items: const ['Provisional', 'Confirmed'],
                                hint: context.l10n.regHintSelect,
                                isRequired: true,
                                senValue: (value) {
                                  nephroController.diagType = value;
                                  controller.update();
                                },
                                filledColor: Colors.white,
                              ),
                              CustomTextField(
                                labelText: context.l10n.commonComments,
                                hintText: context.l10n.nephroEnterComments,
                                isRequired: true,
                                keyBoardType: TextInputType.text,
                                txtController: nephroController.diagComment,
                                fillColor: Colors.white,
                                isReadOnly: false,
                                maxLines: 3,
                                fontSize: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomButton(
                                    isLoading: controller.isLoading,
                                    buttonText: context.l10n.commonSave,
                                    path: 'assets/save-ro-disinfec.png',
                                    callB: controller.isLoading
                                        ? null
                                        : () async {
                                            if (formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              await controller
                                                  .addClinicalCondition(
                                                      widget.isEdit == true
                                                          ? widget
                                                              .proLiItem!.id!
                                                          : 0,
                                                      nephroController
                                                          .diagDate.text,
                                                      controller
                                                          .diagnosisController
                                                          .text,
                                                      controller.diagnoDes.text,
                                                      controller
                                                          .icdCodeTxtField.text,
                                                      nephroController.diagType,
                                                      controller
                                                          .diagComment.text,
                                                      userData['unitId'],
                                                      widget.patientData
                                                          ?.patientId,
                                                      widget.patientData
                                                          ?.treatmentId,
                                                      userData['user_ID'],
                                                      userData['un']);
                                            } else {
                                              CustomMessage.toast(
                                                  context.l10n.nephroFillMandatory);
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
                          ),
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
    if (picked != null && picked != selectedInspection) {
      // setState(() {
      selectedInspection = picked;
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      formattedDate1 = formatter.format(selectedInspection!);
      nephroController.diagDate.text = formattedDate1;

      // });
      nephroController.update();
    }
  }

  sendConvertedDateToAPI(date) {
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(date);

    // Format the parsed date to the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
    return formattedDate;
  }

  dateConversion(inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  void setFieldValue() {
    nephroController.diagnosisController.text =
        widget.proLiItem?.diagoName ?? '';
    nephroController.diagnoDes.text = widget.proLiItem?.diagndesc ?? '';
    nephroController.icdCodeTxtField.text = widget.proLiItem?.icd10Code ?? '';
    nephroController.diagComment.text = widget.proLiItem?.comment ?? '';
    nephroController.diagType = widget.proLiItem?.diagnoType;
    nephroController.diagDate.text = widget.proLiItem?.date ?? '';
  }
}
