import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/new_registration/model/blood_group/blood_data.dart';
import 'package:heamodialysis/new_registration/model/viral_status/viral_data.dart';
import 'package:heamodialysis/registered_patient_list/controller/registration_controller.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/registered_patient_list/screen/registered_patient_list.dart';
import 'package:heamodialysis/schedular/model/add_schedular_request.dart';
import 'package:heamodialysis/schedular/model/slot_time_model.dart';
import 'package:heamodialysis/schedular/controller/schedular_controller.dart';
import 'package:heamodialysis/schedular/model/auto_suggestion_search.dart';
import 'package:heamodialysis/schedular/screen/date_slot_card.dart';
import 'package:heamodialysis/schedular/screen/patient_details_schedular.dart';
import 'package:heamodialysis/schedular/screen/schedular_list.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';

class AddSchedular extends StatefulWidget {
  const AddSchedular({super.key});

  @override
  State<AddSchedular> createState() => _AddSchedularState();
}

class _AddSchedularState extends State<AddSchedular> {
  final SchedularController schedularController =
      Get.put(SchedularController());

  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());

  final RegistrationController registrationController =
      Get.put(RegistrationController());

  String? selectedDiaFreq;
  List<AddSchedularRequest> cardList = [];

  DateTime? _selectedFromDate;

  String? formattedFromDate;

  String? formattedToDate;

  SearchByPatient? dropDownValue2;

  List<SearchByPatient> searchByList = [
    SearchByPatient('1', 'Dialysis Center'),
    SearchByPatient('2', 'State')
  ];

  bool hasInternet = true;

  var userData;
  List<String> diaFrequency = ["1", "2", "3", "4", "5", "6"];

  // String? showSearchByFlag;

  // String? selectedSlotTime;

  @override
  void initState() {
    // TODO: implement initState

    getUserData();
    checkInternetAndLoadData();
    super.initState();
  }

  void addCard() {
    setState(() {
      cardList.add(AddSchedularRequest(
          unitId: schedularController.inst?.unitId != null
              ? schedularController.inst!.unitId
              : 0,
          bedAllocationDate: "",
          patientId: schedularController
              .alreadyRegisteredPatient?.data?.first.patientId,
          slotId: null,
          userId: userData['unitId']));
    });
  }

  void removeCard(int index) {
    if (cardList.length > 1) {
      cardList.removeAt(index);
      setState(() {});
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint(userData['unitId']?.toString());
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    schedularController.refreshUi();
    if (hasInternet) {
      await schedularController.searchByDropDownList();
      await schedularController.getInstituteList(userData['unitId']);
      await newRegistrationController.getViralStatueList();

      // showSearchByFlag =  await schedularController
      //      .showSearchBy(int.parse(userData['user_ID'].toString()));

      if (schedularController.searchByModel?.data != null ||
          schedularController.searchByModel!.data!.isNotEmpty) {
        schedularController.dropDownValue1 =
            schedularController.searchByModel!.data!.first;
        schedularController.refreshUi();
      }

      dropDownValue2 = searchByList[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Add Dialysis Schedular',
          fontSize: 18.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              newRegistrationController.viewPatientModel = null;
              schedularController.selectedSearchedData = null;
              schedularController.alreadyRegisteredPatient = null;
              schedularController.addSchedularValueController.text = '';
              Get.off(const SchedularListScreen());
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<SchedularController>(
            init: SchedularController(),
            builder: (controller) {
              return hasInternet
                  ? controller.isLoading
                      ?  const AddSchedularShimmer()
                      : Column(
                          children: [
                            Theme(
                                data: ThemeData()
                                    .copyWith(dividerColor: Colors.transparent),
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
                                        SizedBox(width: 12.w),
                                        CustomText(
                                            text: "Search Patient",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                            textColor: Colors.white,
                                            textAlign: TextAlign.start)
                                      ]),
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.h, horizontal: 8.w),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[50],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColor.borderColor)),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                          text: "Search By",
                                                          fontSize: 16.sp,
                                                          fontFam: "Lato",
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          textColor:
                                                              const Color(
                                                                  0xff515151),
                                                          textAlign:
                                                              TextAlign.start)
                                                      .paddingOnly(
                                                          top: 10.h,
                                                          bottom: 4.h),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xFFE1E1E1)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w),
                                                    child: DropdownButton<
                                                        SearchByPatient>(
                                                      isExpanded: true,
                                                      value: dropDownValue2,
                                                      hint: CustomText(
                                                          text: "select",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          textColor:
                                                              Colors.black,
                                                          textAlign:
                                                              TextAlign.start),
                                                      onChanged:
                                                          (SearchByPatient?
                                                              newValue) {
                                                        dropDownValue2 =
                                                            newValue!;
                                                        setState(() {});
                                                      },
                                                      items: searchByList.map<
                                                              DropdownMenuItem<
                                                                  SearchByPatient>>(
                                                          (SearchByPatient
                                                              value) {
                                                        return DropdownMenuItem<
                                                                SearchByPatient>(
                                                            value: value,
                                                            child: CustomText(
                                                                text: value
                                                                    .searchBy,
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start));
                                                      }).toList(),
                                                      underline:
                                                          const SizedBox(),
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down_outlined,
                                                        color: AppColor
                                                            .primaryBackgroundColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // ),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                          text: "Type",
                                                          fontSize: 16.sp,
                                                          fontFam: "Lato",
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          textColor:
                                                              const Color(
                                                                  0xff515151),
                                                          textAlign:
                                                              TextAlign.start)
                                                      .paddingOnly(
                                                          top: 10.h,
                                                          bottom: 4.h),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xFFE1E1E1)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.0.h),
                                                    child: DropdownButton<
                                                        SearchedData>(
                                                      isExpanded: true,
                                                      value: controller
                                                          .dropDownValue1,
                                                      hint: CustomText(
                                                          text: "select",
                                                          fontSize: 16.sp,
                                                          fontFam: "Lato",
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          textColor:
                                                              Colors.black,
                                                          textAlign:
                                                              TextAlign.start),
                                                      onChanged: (SearchedData?
                                                          newValue) {
                                                        controller
                                                                .dropDownValue1 =
                                                            newValue!;
                                                        schedularController
                                                                .selectedSearchedData =
                                                            null;
                                                        schedularController
                                                            .addSchedularValueController
                                                            .text = "";
                                                        setState(() {});
                                                      },
                                                      items: controller
                                                          .searchByModel?.data
                                                          ?.map<
                                                                  DropdownMenuItem<
                                                                      SearchedData>>(
                                                              (SearchedData
                                                                  value) {
                                                        return DropdownMenuItem<
                                                                SearchedData>(
                                                            value: value,
                                                            child: CustomText(
                                                                text:
                                                                    value.lookupDetDescEn ??
                                                                        "",
                                                                fontSize: 16.sp,
                                                                fontFam: "Lato",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start));
                                                      }).toList(),
                                                      underline:
                                                          const SizedBox(),
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down_outlined,
                                                        color: AppColor
                                                            .primaryBackgroundColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 14.h,
                                              ),
                                              Visibility(
                                                visible: controller
                                                        .dropDownValue1
                                                        ?.lookupDetValue ==
                                                    "PNA",
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: CustomText(
                                                      text: "Value",
                                                      fontSize: 16.sp,
                                                      fontFam: "Lato",
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      textColor: const Color(
                                                          0xff515151),
                                                      textAlign:
                                                          TextAlign.start),
                                                ).paddingOnly(
                                                    top: 12.h, bottom: 4.h),
                                              ),
                                              Visibility(
                                                visible: controller
                                                        .dropDownValue1
                                                        ?.lookupDetValue !=
                                                    "PID",
                                                child: TypeAheadField<
                                                    AutoSuggestionSearch>(
                                                  controller: schedularController
                                                      .addSchedularValueController,
                                                  suggestionsCallback:
                                                      (search) async {
                                                    return await schedularController
                                                        .autoSuggestion(
                                                            controller
                                                                    .dropDownValue1
                                                                    ?.lookupDetValue ??
                                                                "PNA",
                                                            search,
                                                            userData['unitId'],
                                                            int.parse(
                                                                dropDownValue2
                                                                        ?.id ??
                                                                    "1"));
                                                  },
                                                  builder: (context, controller,
                                                      focusNode) {
                                                    return TextField(
                                                        controller: controller,
                                                        focusNode: focusNode,
                                                        autofocus: true,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Patient Id, name, mobile no etc',
                                                        ));
                                                  },
                                                  itemBuilder:
                                                      (context, suggestion) {
                                                    return ListTile(
                                                        title: CustomText(
                                                            text: getSuggestionType(
                                                                    controller
                                                                        .dropDownValue1
                                                                        ?.lookupDetValue,
                                                                    suggestion) ??
                                                                "",
                                                            fontSize: 16.sp,
                                                            fontFam: "Lato",
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            textColor:
                                                               Colors.black,
                                                            textAlign: TextAlign
                                                                .start));
                                                  },
                                                  onSelected:
                                                      (selectedParam) async {
                                                    await registrationController
                                                        .checkScrutinyApproval(
                                                            selectedParam
                                                                .patientId);
                                                    if (registrationController
                                                                .scrutinyType ==
                                                            "NEPHROLOGIST" &&
                                                        registrationController
                                                                .approvalStat ==
                                                            "Approved") {
                                                      schedularController
                                                          .addSchedularValueController
                                                          .text = selectedParam
                                                              .searchParam ??
                                                          "";
                                                      schedularController
                                                              .selectedSearchedData =
                                                          selectedParam;
                                                      await newRegistrationController
                                                          .viewPatientData(
                                                              schedularController
                                                                  .selectedSearchedData
                                                                  ?.patientId);
                                                    } else {
                                                      registrationController
                                                              .scrutinyType ??=
                                                          "Undefined ";

                                                      CustomPopup
                                                          .showSuccessDialog(
                                                              () {
                                                        Get.back();
                                                      }, "", "Approval From ${registrationController.scrutinyType} Is In Process");
                                                    }
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: controller
                                                        .dropDownValue1
                                                        ?.lookupDetValue ==
                                                    "PID",
                                                child:  Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: CustomText(
                                                      text: "Value",
                                                      fontSize: 16.sp,
                                                      fontFam: "Lato",
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      textColor:
                                                          const Color(0xff515151),
                                                      textAlign:
                                                          TextAlign.start),
                                                ).paddingOnly(
                                                    top: 12.h, bottom: 4.h),
                                              ),
                                              Visibility(
                                                visible: controller
                                                        .dropDownValue1
                                                        ?.lookupDetValue ==
                                                    "PID",
                                                child: TextField(
                                                    inputFormatters: [
                                                      UpperCaseTextFormatter()
                                                    ],
                                                    controller: schedularController
                                                        .addSchedularValueController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          'Patient Id, name, mobile no etc.',
                                                      labelStyle: TextStyle(
                                                          color: Color(
                                                              0xFFE1E1E1)),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFFE1E1E1)),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFFE1E1E1)),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                      ),
                                                    )),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: InkWell(
                                                      onTap: () {
                                                        newRegistrationController
                                                                .viewPatientModel =
                                                            null;
                                                        schedularController
                                                                .selectedSearchedData =
                                                            null;
                                                        schedularController
                                                            .addSchedularValueController
                                                            .text = '';
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                          padding:
                                                               EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8.h),
                                                          alignment:
                                                              Alignment.center,
                                                          width: 100.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: AppColor.red,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                  "assets/cancel.png"),
                                                               CustomText(
                                                                  text:
                                                                      "Cancel",
                                                                  fontSize: 16.sp,
                                                                  fontFam:
                                                                      "Lato",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start),
                                                            ],
                                                          )),
                                                    ),
                                                  ).paddingOnly(top: 20.h),
                                                   SizedBox(
                                                    width: 14.w,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (controller
                                                                .dropDownValue1
                                                                ?.lookupDetValue ==
                                                            "PID") {
                                                          controller.searchAddSchedularPage(
                                                              controller
                                                                      .dropDownValue1
                                                                      ?.lookupDetValue ??
                                                                  "",
                                                              schedularController
                                                                  .addSchedularValueController
                                                                  .text,
                                                              userData[
                                                                  'unitId'],
                                                              dropDownValue2
                                                                      ?.id ??
                                                                  "",
                                                              newRegistrationController,
                                                              registrationController);
                                                        } else {
                                                          setState(() {});
                                                        }
                                                      },
                                                      child: Container(
                                                          padding:
                                                               EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8.h),
                                                          alignment:
                                                              Alignment.center,
                                                          width: 100.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                AppColor
                                                                    .primaryBackgroundColor,
                                                                AppColor
                                                                    .secondaryColor
                                                              ],
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                            ),
                                                          ),
                                                          child:  Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Icon(
                                                                Icons.search,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              CustomText(
                                                                  text:
                                                                      "Search",
                                                                  fontSize: 16.sp,
                                                                  fontFam:
                                                                      "Lato",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start),
                                                            ],
                                                          )),
                                                    ),
                                                  ).paddingOnly(top: 20.h),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))).paddingSymmetric(
                                vertical: 10.h, horizontal: 10.w),
                            Visibility(
                              visible:
                                  newRegistrationController.viewPatientModel !=
                                      null,
                              child: PatientDetailsSchedular(
                                patientId:
                                newRegistrationController
                                            .viewPatientModel
                                            ?.data
                                            ?.patientId !=
                                        null
                                    ? newRegistrationController
                                        .viewPatientModel!.data!.patientId
                                        .toString()
                                    : "",
                                patientName: newRegistrationController
                                            .viewPatientModel?.data?.fName !=
                                        null
                                    ? "${newRegistrationController.viewPatientModel!.data!.fName!} ${newRegistrationController.viewPatientModel?.data?.lName}"
                                    : "",
                                bloodGroup: newRegistrationController
                                    .bloodGroupModel?.data
                                    ?.firstWhere(
                                        (e) =>
                                            e.bloodGroupId ==
                                            newRegistrationController
                                                .viewPatientModel
                                                ?.data
                                                ?.bloodGroupId,
                                        orElse: () => BloodData())
                                    .bloodGrouptName,
                                gender: newRegistrationController
                                            .viewPatientModel?.data?.gender !=
                                        null
                                    ? newRegistrationController
                                        .viewPatientModel!.data!.gender!
                                    : "",
                                dbo: newRegistrationController
                                            .viewPatientModel?.data?.dob !=
                                        null
                                    ? newRegistrationController
                                        .viewPatientModel!.data!.dob
                                        .toString()
                                    : "",
                                age: newRegistrationController
                                            .viewPatientModel?.data?.age !=
                                        null
                                    ? newRegistrationController
                                        .viewPatientModel!.data!.age
                                        .toString()
                                    : "",
                                height: newRegistrationController
                                            .viewPatientModel?.data?.pheight !=
                                        null
                                    ? newRegistrationController
                                        .viewPatientModel!.data!.pheight
                                        .toString()
                                    : "",
                                schemaAdopted: newRegistrationController
                                    .viralStatusModel?.data
                                    ?.firstWhere(
                                        (e) =>
                                            e.lookupDetId ==
                                            newRegistrationController
                                                .viewPatientModel
                                                ?.data
                                                ?.lookupDetIdHaemodialysisProcedureType,
                                        orElse: () => ViralData())
                                    .lookupDetDescEn,
                                weight: newRegistrationController
                                            .viewPatientModel?.data?.pweight !=
                                        null
                                    ? newRegistrationController
                                        .viewPatientModel!.data!.pweight
                                        .toString()
                                    : "",
                                mobile: newRegistrationController
                                            .viewPatientModel?.data?.mobile !=
                                        null
                                    ? newRegistrationController
                                        .viewPatientModel!.data!.mobile!
                                    : "",
                              ),
                            ),
                            Visibility(
                              visible:
                                  (schedularController.selectedSearchedData !=
                                          null ||
                                      schedularController
                                              .alreadyRegisteredPatient !=
                                          null),
                              child: Container(
                                padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                                decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColor.borderColor)),
                                child: Column(
                                  children: [
                                    CustomTextField(
                                        fontSize: 16.sp,
                                        maxLines: 1,
                                        isReadOnly: true,
                                        keyBoardType:
                                            TextInputType.streetAddress,
                                        labelText: 'Institute Name',
                                        hintText: 'Enter',
                                        isRequired: false,
                                        txtController: schedularController
                                            .instituteController,
                                        fillColor: Colors.white),
                                     SizedBox(height: 8.h),
                                    MyCustomDropdown(
                                        isViewProfile: false,
                                        selectedItem: selectedDiaFreq,
                                        labelText:
                                            'Dialysis Frequency Status/ Week',
                                        items: diaFrequency,
                                        hint: 'Select',
                                        isRequired: false,
                                        senValue: (value) {
                                          cardList.clear();
                                          selectedDiaFreq = value;
                                          for (int i = 0;
                                              i < int.parse(selectedDiaFreq!);
                                              i++) {
                                            cardList.add(AddSchedularRequest(
                                                unitId: schedularController
                                                            .inst?.unitId !=
                                                        null
                                                    ? schedularController
                                                        .inst!.unitId
                                                    : 0,
                                                bedAllocationDate: "",
                                                patientId: newRegistrationController
                                                            .viewPatientModel
                                                            ?.data
                                                            ?.patientId !=
                                                        null
                                                    ? newRegistrationController
                                                        .viewPatientModel!
                                                        .data!
                                                        .patientId
                                                    : null,
                                                slotId: null,
                                                userId: userData['unitId']));
                                          }
                                          controller.update();
                                        },
                                        filledColor: Colors.white),
                                     SizedBox(height: 8.h),
                                  ],
                                ),
                              ).paddingOnly(
                                  top: 10.h, left: 10.w, right: 10.w, bottom: 0),
                            ),
                            Visibility(
                              visible:
                                  schedularController.selectedSearchedData !=
                                          null ||
                                      schedularController
                                              .alreadyRegisteredPatient !=
                                          null,
                              child: Column(
                                children: [
                                   SizedBox(
                                    height: 10.h,
                                  ),
                                  ...cardList.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    AddSchedularRequest? cardData = entry.value;
                                    return DateSlotCard(
                                      cardData: cardData,
                                      dropDownList: controller.slotTimeList
                                          .map((e) => e.slotTimes ?? '')
                                          .toList(),
                                      // dropDownList: [],
                                      index: index,
                                      selectedSlot: cardData.slot,
                                      // fromDateController:
                                      //     controller.fDateController,
                                      isSlotSelected: (value) {
                                        if (int.parse(selectedDiaFreq!) !=
                                            cardList.length) {
                                          CustomMessage.toast(
                                              'schedule according to selected frequency');
                                          cardData = null;
                                          controller.update();
                                        } else {
                                          SlotTimeModel? selectedSlot =
                                              controller.slotTimeList
                                                  .firstWhere((e) =>
                                                      e.slotTimes == value);
                                          cardData?.slot = value;
                                          controller.update();
                                          cardData?.slotId =
                                              selectedSlot.slotId;
                                          cardData?.userId = userData['unitId'];
                                          cardData?.userId = userData['user_ID'];
                                        }
                                      },
                                      selectFromDate: () {
                                        if (cardData != null) {
                                          schedularController.slotTimeList
                                              .clear();
                                          cardData?.slot = null;
                                          cardData?.slotId = null;
                                          schedularController.update();

                                          selectFromDate(cardData!);
                                        }
                                      },
                                      addCard: () {
                                        if (selectedDiaFreq != null) {
                                          int.parse(selectedDiaFreq!) >
                                                  (cardList.length)
                                              ? addCard()
                                              : null;
                                        }
                                      },
                                      removeCard: () {
                                        removeCard(index);
                                      },
                                    );
                                  }),
                                   SizedBox(
                                    height: 10.h,
                                  )
                                ],
                              ).paddingSymmetric(vertical: 10.h, horizontal: 10.w),
                            ),
                            Visibility(
                              visible:
                                  schedularController.selectedSearchedData !=
                                          null ||
                                      schedularController
                                              .alreadyRegisteredPatient !=
                                          null,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {
                                        newRegistrationController
                                            .viewPatientModel = null;
                                        schedularController
                                            .selectedSearchedData = null;
                                        schedularController
                                            .addSchedularValueController
                                            .text = '';
                                        Get.back();
                                      },
                                      child: Container(
                                          padding:  EdgeInsets.symmetric(
                                              vertical: 8.h),
                                          alignment: Alignment.center,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColor.red,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset("assets/cancel.png"),
                                               CustomText(
                                                  text: "Cancel",
                                                  fontSize: 16.sp,
                                                  fontFam: "Lato",
                                                  fontWeight: FontWeight.normal,
                                                  textColor: Colors.white,
                                                  textAlign: TextAlign.start),
                                            ],
                                          )),
                                    ),
                                  ).paddingOnly(top: 20.h,bottom: 20.h),
                                   SizedBox(
                                    width: 14.w,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () async {
                                        for (final card in cardList) {
                                          final slot = (card.slot ?? '')
                                              .toString()
                                              .trim();
                                          final hasSlot = slot.isNotEmpty;
                                          final hasDate =
                                              card.bedAllocationDate != null;

                                          if (!hasSlot || !hasDate) {
                                            CustomMessage.toast(
                                                'Please select date and slot');
                                            return;
                                          }
                                        }

                                        // If we reach here, all cards are valid
                                        for (final card in cardList) {
                                          await controller.addSchedular(card);
                                        }

                                      },
                                      child: Container(
                                          padding:  EdgeInsets.symmetric(
                                              vertical: 8.h),
                                          alignment: Alignment.center,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColor.primaryBackgroundColor,
                                                AppColor.secondaryColor
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/save-next.png'),
                                               CustomText(
                                                  text: "Save",
                                                  fontSize: 16.sp,
                                                  fontFam: "Lato",
                                                  fontWeight: FontWeight.normal,
                                                  textColor: Colors.white,
                                                  textAlign: TextAlign.start),
                                            ],
                                          )),
                                    ),
                                  ).paddingOnly(top: 20.h,bottom: 20.h),
                                   SizedBox(
                                    height: 14.h,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                  : InternetIssue(
                      onRetryPressed: () {
                        checkInternetAndLoadData();
                      },
                    );
            }),
      ),
    );
  }

  selectFromDate(AddSchedularRequest cardData) async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    // if (picked != null && picked != _selectedFromDate) {
    if (picked != null) {
      // setState(() {
      _selectedFromDate = picked;
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      formattedFromDate = formatter.format(_selectedFromDate!);
      cardData.bedAllocationDate = formattedFromDate!;
      // setState(() {});
      String formattedDate =
          DateFormat('dd/MM/yyyy').format(_selectedFromDate!);
      // if (dropDownValue?.lookupDetValue == "PID" &&
      //     schedularController.alreadyRegisteredPatient?.data != null) {
      String isAval =
          (schedularController.dropDownValue1?.lookupDetValue == "PID" &&
                  schedularController.alreadyRegisteredPatient?.data != null)
              ? await schedularController.getAppointmentAvail(
                  formattedDate,
                  schedularController
                      .alreadyRegisteredPatient?.data?.first.patientId,
                  cardData)
              : await schedularController.getAppointmentAvail(
                  formattedDate,
                  schedularController.selectedSearchedData?.patientId,
                  cardData);

      if (isAval == "false") {
        DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(formattedDate);

        // Format the parsed date to "13-SEP-2024" format
        String formattedD =
            DateFormat("dd-MMM-yyyy").format(parsedDate).toUpperCase();

        schedularController.getSlotList(
            schedularController.inst?.unitId != null
                ? schedularController.inst!.unitId.toString()
                : "",
            formattedD,
            cardData,
            schedularController.selectedSearchedData?.patientId);
      }
      schedularController.update();
      // }
    }
  }

  getSuggestionType(String? type, AutoSuggestionSearch suggestion) {
    if (type == "PNA") {
      return suggestion.searchParam;
    } else if (type == "PMO") {
      return suggestion.mobile;
    }
    return suggestion.searchParam;
  }
}

class TimeSlot {
  String? time;
  String? slot;

  TimeSlot(this.time, this.slot);
}
