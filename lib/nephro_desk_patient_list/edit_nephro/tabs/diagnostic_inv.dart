import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/test_details_model.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/add_test_package_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/choose_package_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/diagnostic_inv_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/package_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/test_lis_details.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/choose_package.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/choose_test.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/test_name_card.dart';
import 'package:heamodialysis/nephro_desk_patient_list/nephro_controller.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class DiagnosticInv extends StatefulWidget {
  final Function onAdd;
  final NephroList? patientData;
  final ChoosePackageListModel? choosePackageListModel;
  final List<PackageListModel>? packageList;

  const DiagnosticInv(
      {super.key,
      required this.onAdd,
      this.choosePackageListModel,
      this.patientData,
      this.packageList});

  @override
  State<DiagnosticInv> createState() => _DiagnosticInvState();
}

class _DiagnosticInvState extends State<DiagnosticInv> {
  final NephroController nephroController = Get.find<NephroController>();

  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Test Name',
    'Consultant Name',
    'Type',
    'Event',
    'Instructions',
    'Clinical Notes'
  ];

  List<SearchByPatient> searchByList = [
    SearchByPatient('1', 'Dialysis Center'),
    SearchByPatient('2', 'State')
  ];

  SearchedData? dropDownValue;
  SearchByPatient? dropDownValue2;

  var userData;

  RadioButtons? radioButtons = RadioButtons.existingAbhaId;
  CustomRadioButtons groupVal = CustomRadioButtons.yes;

  String? selectedTests;

  LstService? selectedTestNAmeObj;

  // ListSubServiceIpdDto? selectedTestName;

  @override
  void initState() {
    getUserData();
    checkInternetAndLoadData();
    super.initState();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    nephroController.update();
    if (hasInternet) {
      await nephroController
          .getDiagnosticInvList(widget.patientData?.treatmentId);

      nephroController.getTestNameList(
          userData['unitId'].toString(), '2', "", userData['ui'].toString());
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NephroController>(
        init: nephroController,
        builder: (controller) {
          return hasInternet
              ? controller.isLoading
              ?  Center(child: buildShimmerLoader())
                  : Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: CustomButton(
                            buttonText: 'Add to Test',
                            path: 'assets/save-ro-disinfec.png',
                            callB: () {
                              groupVal = CustomRadioButtons.yes;
                              controller.update();

                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return customBottomSheet(false, null);
                                },
                              );
                            },
                            buttonWidth: 140,
                            primColor: AppColor.primaryBackgroundColor,
                            secColor: AppColor.secondaryColor,
                            textColor: Colors.white,
                            iconColor: Colors.white,
                          ),
                        ).paddingOnly(top: 8, bottom: 2),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.diagnosticInvestList?.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return TestNameCard(
                                patientList:
                                    controller.diagnosticInvestList?[index],
                                cardItemDetailsList: cardItemDetailsList,
                                isSecondColumnVisiable: true,
                                path1: "assets/send_to_tech.png",
                                path2: "assets/ct_report.png",
                                path3: "assets/edit.png",
                                path4: "assets/delete-bin.png",
                                callB1: (index) async {
                                  await controller.sendToTechnician(
                                      controller.diagnosticInvestList?[index]
                                          .billDetailsId,
                                      userData['ui'].toString(),
                                      widget.patientData?.treatmentId
                                          .toString(),
                                      widget.patientData?.patientId.toString(),
                                      userData['unitId'].toString());
                                },
                                callB2: (index) async {
                                  await controller.viewCtReoprt(
                                      userData['unitId'].toString(),
                                      widget.patientData!.patientId.toString(),
                                      controller.treatmentIdModel![0][0]
                                          .toString(),
                                      userData['ui'].toString());
                                },
                                callB3: (index) {
                                  groupVal = CustomRadioButtons.no;
                                  controller.update();
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return customBottomSheet(
                                          true,
                                          controller
                                              .diagnosticInvestList?[index]);
                                    },
                                  );
                                },
                                callB4: (index) {
                                  controller.deleteDiagnosticIns(
                                      controller.diagnosticInvestList?[index]
                                          .billDetailsId,
                                      userData['ui'],
                                      widget.patientData?.treatmentId
                                          .toString());
                                },
                                index: index,
                              );
                            },
                          ),
                        ),
                      ],
                    )
              : InternetIssue(
                  onRetryPressed: () {
                    checkInternetAndLoadData();
                  },
                );
        });
  }

  String formatSelectedTests(
      String selectedTests, List<LabInvestigationPackage> itemList) {
    List<String> selectedList = selectedTests.split(','); // Step 2
    List<String> idList = [];

    for (String test in selectedList) {
      var matchedItem = itemList.firstWhere(
        (item) => item.packageName == test, // Step 3
        orElse: () => LabInvestigationPackage(
            packageName: '',
            labInvestigationPackageId: 0), // Default case if not found
      );

      if (matchedItem.labInvestigationPackageId != null) {
        idList.add(matchedItem.labInvestigationPackageId.toString());
      }
    }

    return idList.isNotEmpty ? '${idList.join('#')}#' : ''; // Step 4
  }

  customBottomSheet(bool isEdit, ListSubServiceIpdDto? data) {
    return StatefulBuilder(builder: (context, updateState) {
      if (isEdit) {
        nephroController.testNameField.text = data?.categoryName ?? '';
        selectedTestNAmeObj = nephroController.testNameList
            ?.firstWhere((e) => e.categoryName == data?.categoryName);

        nephroController.instructions.text = data?.instructions ?? '';
        nephroController.clinicalNote.text = data?.clinicalNotes ?? '';
        selectedTests = data?.investigationEventDesc;

        widget.choosePackageListModel?.parsedData?.forEach((e) {
          if (e.packageName == selectedTests) {
            e.isSelected = true;
          }
        });
      }

      return Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 0.5), // changes position of shadow
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                          text: "Add Tests/Packages",
                          fontSize: 16,
                          fontFam: "Lato",
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black,
                          textAlign: TextAlign.start)
                      .paddingSymmetric(vertical: 4),
                  InkWell(
                      onTap: () {
                        nephroController.selectedPackage = null;
                        nephroController.instructions.clear();
                        nephroController.selectedTestsController.text = '';
                        nephroController.testNameField.clear();
                        nephroController.clinicalNote.clear();
                        selectedTests = null;
                        nephroController.urgentEvent.isSelected = false;
                        widget.packageList?.forEach((e) {
                          e.isSelected = false;
                        });
                        widget.choosePackageListModel?.parsedData?.forEach((e) {
                          e.isSelected = false;
                        });
                        Get.back();
                        updateState(() {});

                        setState(() {});
                      },
                      child: Image.asset(
                        "assets/cancel.png",
                        width: 24,
                        height: 24,
                        color: AppColor.primaryBackgroundColor,
                      )),
                ],
              ),
              CustomRadioField(
                isRequired: false,
                radioCallB1: (value) {
                  updateState(() {});
                  groupVal = value;
                  setState(() {});
                },
                radioCallB2: (value) {
                  updateState(() {});
                  groupVal = value;
                  setState(() {});
                },
                groupVal: groupVal,
                text: '',
                firstRadioText: 'Choose Packages',
                secondRadioText: 'Choose Test',
              ).paddingSymmetric(vertical: 8),
              Visibility(
                visible: CustomRadioButtons.yes == groupVal,
                child: ChoosePackage(
                  getBack: () {
                    nephroController.selectedPackage = null;
                    nephroController.selectedTestsController.text = '';
                    widget.packageList?.forEach((e) {
                      e.isSelected = false;
                    });

                    Get.back();
                    updateState(() {});

                    setState(() {});
                  },
                  selectedVal: nephroController.selectedPackage,
                  label: "Investigation Test Scheduling Details",
                  choosePackageListModel: nephroController.packageList,
                  onAdd: (value) {
                    nephroController.selectedPackage = value;
                    updateState(() {});

                    // widget.onAdd(value);
                  },
                ),
              ),
              Visibility(
                visible: CustomRadioButtons.no == groupVal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const CustomText(
                        text: 'Test Name',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start,
                      ).paddingOnly(left: 8, right: 8, bottom: 4),
                    ),
                    TypeAheadField<LstService>(
                      controller: nephroController.testNameField,
                      // Ensure this is the main controller
                      suggestionsCallback: (search) async {
                        return await nephroController.getTestNameList(
                            userData['unitId'].toString(),
                            '2',
                            search,
                            userData['ui'].toString());
                      },
                      builder: (context, textEditingController, focusNode) {
                        return TextField(
                          controller: nephroController.testNameField,
                          // Use the same main controller
                          focusNode: focusNode,
                          autofocus: false,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 14),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "  Enter",
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: AppColor.textGrey,
                              fontFamily: "Nunito Sans",
                              fontWeight: FontWeight.normal,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(color: AppColor.borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(color: AppColor.borderColor),
                            ),
                          ),
                        );
                      },
                      itemBuilder: (context, city) {
                        return ListTile(
                          title: Text(city.categoryName ?? ''),
                        );
                      },
                      onSelected: (city) async {
                        // selectedTestName = city;

                        nephroController.testNameField.text =
                            city.categoryName ?? "";
                        // nephroController.diagnoDes.text =
                        //     city.categoryName ?? "";
                        selectedTestNAmeObj = city;

                        nephroController.update();
                      },
                    ).paddingOnly(left: 8, right: 8),
                  ],
                ),
              ),
              Visibility(
                visible: CustomRadioButtons.no == groupVal,
                child: CustomTextField(
                  labelText: "Instructions",
                  hintText: "Enter",
                  isRequired: false,
                  keyBoardType: TextInputType.text,
                  txtController: nephroController.instructions,
                  fillColor: Colors.white,
                  isReadOnly: false,
                  maxLines: 1,
                  fontSize: 16,
                ),
              ),
              Visibility(
                visible: CustomRadioButtons.no == groupVal,
                child: CustomTextField(
                  labelText: "Clinical Notes",
                  hintText: "Enter",
                  isRequired: false,
                  keyBoardType: TextInputType.text,
                  txtController: nephroController.clinicalNote,
                  fillColor: Colors.white,
                  isReadOnly: false,
                  maxLines: 1,
                  fontSize: 16,
                ),
              ),
              Visibility(
                  visible: CustomRadioButtons.no == groupVal,
                  child: ChooseTests(
                    initialVal: selectedTests,
                    onAdd: (value) {
                      selectedTests = value;
                      setState(() {});
                    },
                    label: 'Event',
                    choosePackageListModel: widget.choosePackageListModel,
                  )),
              Visibility(
                visible: CustomRadioButtons.no == groupVal,
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: AppColor.primaryBackgroundColor,
                      value: nephroController.urgentEvent.isSelected,
                      // Boolean value for checkbox state
                      onChanged: (bool? newValue) {
                        nephroController.urgentEvent.isSelected = newValue!;
                        updateState(() {});
                      },
                    ),
                    const CustomText(
                        text: "Urgent",
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                  ],
                ),
              ),
              CustomButton(
                buttonText: 'Save',
                path: 'assets/save-ro-disinfec.png',
                callB: () async {
                  if (CustomRadioButtons.no == groupVal) {
                    //selected test

                    String? testIdToBeEdit;
                    String? finalSelectedTestIds;
                    if (isEdit) {
                      testIdToBeEdit = widget.choosePackageListModel?.parsedData
                          ?.firstWhere((e) =>
                              e.packageName == data?.investigationEventDesc)
                          .labInvestigationPackageId
                          .toString();
                    } else {
                      if (selectedTests != null) {
                        finalSelectedTestIds = formatSelectedTests(
                            selectedTests!,
                            widget.choosePackageListModel!.parsedData!);
                      } else {
                        CustomMessage.toast("Enter Test");
                      }
                    }

                    bool isDuplicate =
                        await nephroController.checkDuplicateTest(
                            widget.patientData!.patientId.toString(),
                            widget.patientData!.treatmentId.toString(),
                            selectedTestNAmeObj!.categoryid.toString(),
                            userData['unitId'].toString(),
                            userData['ui'].toString());
                    if (isDuplicate == false) {
                      nephroController.testPackageList.add(AddTestPackageModel(
                          patienttId: widget.patientData?.patientId.toString(),
                          perticularSName: selectedTestNAmeObj?.categoryName,
                          billDetailsId: "0",
                          serviceId: selectedTestNAmeObj?.serviceid.toString(),
                          doctorId: userData['ui'].toString(),
                          treatmentId:
                              widget.patientData?.treatmentId.toString(),
                          departmentId: selectedTestNAmeObj?.deptId.toString(),
                          billId: null,
                          rate: "0",
                          concession: "0",
                          concessionPer: "0",
                          quantity: 1,
                          amount: "0",
                          pay: "0",
                          coPay: "0",
                          instructions: nephroController.instructions.text,
                          clinicalnotes: nephroController.clinicalNote.text,
                          subServiceId: selectedTestNAmeObj?.categoryid,
                          unitId: userData['unitId'].toString(),
                          createdDateTime: null,
                          urgentFlag: "N",
                          callfrom: "N",
                          masterReceiptId: isEdit
                              ? selectedTestNAmeObj?.masterconfigid.toString()
                              : "0",
                          subservicesname: selectedTestNAmeObj?.categoryName,
                          sponsorId: 0,
                          chargesSlaveId: 0,
                          otherAmount: 0,
                          otherCoPay: 0,
                          otherPay: 0,
                          otherConcession: '',
                          narration: "-",
                          hallId: 0,
                          narrationidBill: "-",
                          accountStatusIpd: "N",
                          emrPer: 0,
                          sendToRisIpdBill: "N",
                          otFlag: '',
                          sndToLabFlag: "N",
                          drdeskflag: "-",
                          sampleTypeId: selectedTestNAmeObj?.categoryid,
                          barCode: 0,
                          inOutHouse: "0",
                          businessType: selectedTestNAmeObj?.categoryid,
                          customerId: 0,
                          customerType: 0,
                          regRefDocId: 0,
                          event: isEdit ? testIdToBeEdit : finalSelectedTestIds,
                          ivfTreatFlag: "N"));

                      await nephroController.saveTestPackage(
                          nephroController.testPackageList,
                          userData['unitId'].toString(),
                          userData['ui'].toString(),
                          widget.patientData?.treatmentId?.toString());
                    } else {
                      CustomMessage.toast(
                          'This Test Already Assigned to Patient');
                    }
                  } else if (CustomRadioButtons.yes == groupVal) {
                    //selected package

                    if (nephroController.selectedPackage != null) {
                      Get.back();

                      List<PackageListModel>? selectedPackageList =
                          nephroController.packageList
                              ?.where((e) => e.isSelected == true)
                              .toList();

                      List<String>? ids = selectedPackageList
                          ?.map((e) => e.labInvestigationPackageId.toString())
                          .toList();

                      String idsString = ids?.join(',') ?? '';

                      bool isDuplicate =
                          await nephroController.checkDuplicatePackage(
                        widget.patientData!.patientId.toString(),
                        widget.patientData!.treatmentId.toString(),
                        idsString,
                      );

                      if (isDuplicate == false) {
                        List<TestDetailsModel> allTest =
                            await nephroController.getAllTest(ids);
                        // }

                        for (int i = 0; i < allTest.length; i++) {
                          nephroController.testPackageList.add(
                              AddTestPackageModel(
                                  patienttId:
                                      widget.patientData?.patientId.toString(),
                                  perticularSName: allTest[i].testName,
                                  billDetailsId: "0",
                                  serviceId: "11",
                                  doctorId: userData['ui'].toString(),
                                  treatmentId: widget.patientData?.treatmentId
                                      .toString(),
                                  departmentId: '2',
                                  billId: null,
                                  rate: '',
                                  concession: "0",
                                  concessionPer: "0",
                                  quantity: 1,
                                  amount: "0",
                                  pay: "0",
                                  coPay: "0",
                                  instructions: '',
                                  clinicalnotes: '',
                                  subServiceId: allTest[i].subServId,
                                  // subServiceId:
                                  //     null,
                                  unitId: userData['unitId'].toString(),
                                  createdDateTime: null,
                                  urgentFlag: "N",
                                  callfrom: "N",
                                  masterReceiptId: "0",
                                  subservicesname: allTest[i].testName,
                                  sponsorId: 0,
                                  chargesSlaveId: 0,
                                  otherAmount: null,
                                  otherCoPay: 0,
                                  otherPay: null,
                                  otherConcession: "NaN",
                                  narration: "-",
                                  hallId: 0,
                                  narrationidBill: "-",
                                  accountStatusIpd: "N",
                                  emrPer: 0,
                                  sendToRisIpdBill: "N",
                                  otFlag: "N",
                                  sndToLabFlag: "N",
                                  drdeskflag: "-",
                                  sampleTypeId: 0,
                                  barCode: 0,
                                  inOutHouse: "0",
                                  businessType: 2,
                                  customerId: 0,
                                  customerType: 0,
                                  regRefDocId: 0,
                                  event:
                                      "${allTest[i].labInvestigationPackageId.toString()}#",
                                  // event:
                                  //     '${widget.choosePackageListModel!.parsedData?.firstWhere((e) => e.packageName == controller.allTest[i].packageName).labInvestigationPackageId.toString()}#',
                                  ivfTreatFlag: "N"));
                        }

                        for (int i = 0;
                            i < nephroController.testPackageList.length;
                            i++) {
                          await nephroController.savePackage(
                              nephroController.testPackageList[i],
                              userData['unitId'].toString(),
                              userData['ui'].toString(),
                              widget.patientData?.treatmentId?.toString());
                        }
                        CustomMessage.toast("Test Added");
                      } else {
                        CustomMessage.toast(
                            'This Test Already Assigned to Patient');
                      }
                    } else {
                      CustomMessage.toast("Select Package");
                    }
                  }
                },
                buttonWidth: 140,
                primColor: AppColor.primaryBackgroundColor,
                secColor: AppColor.secondaryColor,
                textColor: Colors.white,
                iconColor: Colors.white,
              ),
            ],
          ),
        ),
      );
    });
  }
}

enum RadioButtons {
  existingAbhaId,
  newAbhaId,
  demoInfoBasedAuth,
  // newRegistration
}

class SearchByPatient {
  String id;
  String searchBy;

  SearchByPatient(this.id, this.searchBy);
}
