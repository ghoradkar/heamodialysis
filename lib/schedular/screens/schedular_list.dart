import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/book_appointment/book_appointment.dart';
import 'package:heamodialysis/dashboard/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/schedular/model/slot_for_search.dart';
import 'package:heamodialysis/schedular/screens/patient_history_schedular.dart';
import 'package:heamodialysis/schedular/schedular_controller/schedular_controller.dart';
import 'package:heamodialysis/schedular/screens/add_schedular.dart';
import 'package:heamodialysis/schedular/screens/schedular_card.dart';
import 'package:heamodialysis/schedular/screens/schedular_chart.dart';
import 'package:heamodialysis/schedular/screens/visitor_entry.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';

class SchedularListScreen extends StatefulWidget {
  const SchedularListScreen({super.key});

  @override
  State<SchedularListScreen> createState() => _SchedularListScreenState();
}

class _SchedularListScreenState extends State<SchedularListScreen> {
  final SchedularController schedularController =
      Get.put(SchedularController());

  // final DashboardController dashboardController =
  // Get.put(DashboardController());

  final NewRegistrationController newRegistrationController =
      Get.find<NewRegistrationController>();

  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Patient Id',
    'Patient Name',
    'Age',
    'Mobile No',
    'ABHA Number',
    'Gender',
    'Appointment Date',
    'Slot',
    'Viral Load Status'
  ];

  SlotForSearch? dropDownValue;
  SearchedData? dropDownValue1;
  SearchedData? dropDownValue2;

  var userData;

  DateTime? _selectedFromDate;

  String? formattedFromDate;

  DateTime? _selectedToDate;

  String? formattedToDate;

  @override
  void initState() {
    getUserData();
    checkInternetAndLoadData();
    super.initState();
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
      // await dashboardController.getAllRegisteredPatient();

      final now = DateTime.now();

      // Format the date
      final formatter = DateFormat('dd/MM/yyyy');
      final formattedDate = formatter.format(now);
      schedularController.fromDateController.text = formattedDate;
      schedularController.toDateController.text = formattedDate;
      // await fetchData();
      await schedularController.searchSchedularList(
          '',
          '',
          int.parse(userData['unitId'].toString()),
          schedularController.fromDateController.text,
          schedularController.toDateController.text,
          0,
          1);
      await schedularController
          .getSlotListSearch(userData['unitId'].toString());
      await schedularController.searchByDropDownList();
      if (schedularController.searchByModel?.data != null ||
          schedularController.searchByModel!.data!.isNotEmpty) {
        dropDownValue1 = schedularController.searchByModel!.data!.first;
        schedularController.refreshUi();
      }
    }
  }



  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint(userData['ui'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:  CustomText(
          text: 'Dialysis Patient List',
          fontSize: 18.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.off(const InstituteWiseDashboardScreen());
            },
            child: Image.asset('assets/arrow-left.png')),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const SchedularChart());
            },
            child: Padding(
              padding:  EdgeInsets.only(right: 8.w),
              child: Image.asset("assets/chart.png"),
            ),
          ),
           SizedBox(
            width: 4.w,
          ),
          InkWell(
            onTap: () {
              newRegistrationController.viewPatientModel = null;
              Get.to(() => const AddSchedular());
            },
            child: Padding(
              padding:  EdgeInsets.only(right: 8.w),
              child: Image.asset("assets/add-pre-dialysis.png"),
            ),
          ),
           SizedBox(
            width: 4.w,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isDismissible: false,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        FocusScope.of(context).unfocus();   // <-- Closes keyboard
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            padding:  EdgeInsets.symmetric(
                                vertical: 14.h, horizontal: 10.w),
                            decoration: BoxDecoration(
                              color: const Color(0xffF8F8F8),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 0.5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     CustomText(
                                            text: "Search",
                                            fontSize: 16.sp,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.bold,
                                            textColor: Colors.black,
                                            textAlign: TextAlign.start)
                                        .paddingSymmetric(vertical: 4),
                                    InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Image.asset(
                                          "assets/cancel.png",
                                          width: 24.w,
                                          height: 24.h,
                                          color: AppColor.primaryBackgroundColor,
                                        )),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     CustomText(
                                            text: "Type",
                                            fontSize: 16.sp,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.normal,
                                            textColor: const Color(0xff515151),
                                            textAlign: TextAlign.start)
                                        .paddingOnly(top: 10.h, bottom: 4.h),
                                    Container(
                                      // width: 180,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFFE1E1E1)),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      padding:  EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      child: DropdownButton<SearchedData>(
                                        isExpanded: true,
                                        value: dropDownValue1,
                                        hint: const Text("select"),
                                        onChanged: (SearchedData? newValue) {
                                          dropDownValue1 = newValue!;
                      
                                          setState(() {});
                                        },
                                        items: schedularController.searchByModel?.data
                                            ?.map<DropdownMenuItem<SearchedData>>(
                                                (SearchedData value) {
                                          return DropdownMenuItem<SearchedData>(
                                            value: value,
                                            child: Text(value.lookupDetDescEn ?? ""),
                                          );
                                        }).toList(),
                                        underline: const SizedBox(),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: AppColor.primaryBackgroundColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                 Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(
                                      text: "Value",
                                      fontSize: 16.sp,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.normal,
                                      textColor: const Color(0xff515151),
                                      textAlign: TextAlign.start),
                                ).paddingOnly(top: 10.h, bottom: 4.h),
                                TextField(
                                    controller: schedularController.valueController,
                                    decoration: const InputDecoration(
                                      labelText: 'Patient Id, name, mobile no etc.',
                                      labelStyle: TextStyle(color: Color(0xFFE1E1E1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Color(0xFFE1E1E1)),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Color(0xFFE1E1E1)),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                    )),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomDateField(
                                        labelText: 'From Date',
                                        hint: 'Select Date',
                                        isRequired: false,
                                        callB: () {
                                          selectFromDate();
                                        },
                                        selectedDate:
                                            schedularController.fromDateController,
                                        filledColor: Colors.white,
                                        dontDhowPrefix: false,
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomDateField(
                                        labelText: 'To Date',
                                        hint: 'Select Date',
                                        isRequired: false,
                                        callB: () {
                                          selectToDate();
                                        },
                                        selectedDate:
                                            schedularController.toDateController,
                                        filledColor: Colors.white,
                                        dontDhowPrefix: false,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     CustomText(
                                            text: "Slot",
                                            fontSize: 16.sp,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.normal,
                                            textColor: Color(0xff515151),
                                            textAlign: TextAlign.start)
                                        .paddingOnly(top: 10.h, bottom: 4.h),
                                    Container(
                                      // width: 180,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFFE1E1E1)),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      padding:  EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      child: DropdownButton<SlotForSearch>(
                                        isExpanded: true,
                                        value: dropDownValue,
                                        hint: const Text("select"),
                                        onChanged: (SlotForSearch? newValue) {
                                          dropDownValue = newValue!;
                                          schedularController.update();
                                        },
                                        items: schedularController.searchSlotList
                                            ?.map<DropdownMenuItem<SlotForSearch>>(
                                                (SlotForSearch value) {
                                          return DropdownMenuItem<SlotForSearch>(
                                            value: value,
                                            child: Text(value.slotTime ?? ""),
                                          );
                                        }).toList(),
                                        underline: const SizedBox(),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: AppColor.primaryBackgroundColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                            padding:  EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            alignment: Alignment.center,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
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
                                    ).paddingOnly(top: 20.h),
                                     SizedBox(
                                      width: 14.w,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          SlotForSearch? selectedSlot;
                                          if (dropDownValue != null) {
                                            selectedSlot = schedularController
                                                .searchSlotList
                                                ?.firstWhere((e) =>
                                                    e.slotTime ==
                                                    dropDownValue?.slotTime);
                                          }
                      
                                          schedularController.searchSchedularList(
                                              dropDownValue1?.lookupDetValue ?? '',
                                              schedularController
                                                  .valueController.text,
                                              int.parse(
                                                  userData['unitId'].toString()),
                                              schedularController
                                                  .fromDateController.text,
                                              schedularController
                                                  .toDateController.text,
                                              int.parse(selectedSlot?.slotId ?? "0"),
                                              1);
                                          Get.back();
                                        },
                                        child: Container(
                                            padding:  EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            alignment: Alignment.center,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppColor.primaryBackgroundColor,
                                                  AppColor.secondaryColor
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                            child:  Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.search,
                                                  color: Colors.white,
                                                ),
                                                CustomText(
                                                    text: "Search",
                                                    fontSize: 16.sp,
                                                    fontFam: "Lato",
                                                    fontWeight: FontWeight.normal,
                                                    textColor: Colors.white,
                                                    textAlign: TextAlign.start),
                                              ],
                                            )),
                                      ),
                                    ).paddingOnly(top: 20.h),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset("assets/filter-line.png"),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
        ],
      ),
      body: GetBuilder<SchedularController>(
          init: schedularController,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                ?  Center(child: buildShimmerLoader())
                    : ListView.builder(
                      // shrinkWrap: true,
                      itemCount:
                      controller.schedularPatientList?.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        PatientData patientData = PatientData();
                        patientData.patientId = controller
                            .schedularPatientList?.data?[index].patientId;
                        patientData.createdDateTime = controller
                            .schedularPatientList
                            ?.data?[index]
                            .createdDateTime;
                        patientData.lName = controller
                            .schedularPatientList?.data?[index].lName;
                        patientData.mName = controller
                            .schedularPatientList?.data?[index].mName;
                        patientData.patientTypeEn = controller
                            .schedularPatientList?.data?[index].patientTypeEn;
                        patientData.mobile = controller
                            .schedularPatientList?.data?[index].mobile;
                        patientData.height = controller
                            .schedularPatientList?.data?[index].pheight;
                        patientData.age =
                            controller.schedularPatientList?.data?[index].age;
                        patientData.dob =
                            controller.schedularPatientList?.data?[index].dob;
                        patientData.gender = controller
                            .schedularPatientList?.data?[index].gender;
                        patientData.bloodGroupId = controller
                            .schedularPatientList?.data?[index].bloodGroupId;
                        patientData.patientName = controller
                            .schedularPatientList?.data?[index].fName ??
                            controller.schedularPatientList?.data?[index]
                                .searchParam;
                        patientData.abhaNo = controller
                            .schedularPatientList?.data?[index].abhaNo;
                        patientData.maritalStatusId = controller
                            .schedularPatientList
                            ?.data?[index]
                            .maritalStatusId;
                        patientData.emailId = controller
                            .schedularPatientList?.data?[index].emailId;

                        patientData.treatmentId = controller
                            .schedularPatientList?.data?[index].treatmentId;

                        return SchedularCard(
                          patientList:
                          controller.schedularPatientList?.data?[index],
                          cardItemDetailsList: cardItemDetailsList,
                          isSecondColumnVisiable: true,
                          path1: "assets/file-list.png",
                          path2: "assets/visitor_entry.png",
                          path3: "assets/reschedule.png",
                          path4: "assets/cancel_appointment.png",
                          path5: "assets/camera.png",
                          // isfromPredialysis: false,
                          callB1: () {
                            Get.to(() => PatientHistorySchedular(
                              patientData: patientData,
                            ));
                          },
                          callB2: () {
                            debugPrint('jj');
                            Get.to(() => VisitorEntry(
                              patientData: patientData,
                              slot: controller.schedularPatientList
                                  ?.data?[index].slotId,
                            ));
                          },
                          callB3: () {
                            ///reschedular
                            debugPrint('kk');

                            Get.to(() => BookAppointmentScreen(
                              patientData: patientData,
                              isFromSchedular: true,
                            ));
                          },
                          callB4: () async {
                            CustomPopup.showConfirmationDialog(() {
                              Get.back();
                            }, () {
                              Get.back();
                            }, () async {
                              Get.back();

                              bool isCancelled =
                              await controller.cancelAppointment(
                                  userData['ui'],
                                  patientData.patientId,
                                  int.parse(
                                      userData['unitId'].toString()),
                                  patientData.treatmentId);
                              if (isCancelled) {
                                CustomPopup.showSuccessDialog(
                                      () {
                                    Get.back();
                                  },
                                  "Appointment Cancelled",
                                  "Appointment Cancelled Successfully",
                                );
                              }
                            },
                                '',
                                'Are you sure? Do you want to cancel the appointment?',
                                'assets/info.png');
                          },
                          callB5: () {},
                        );
                      },
                    )
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }

  selectFromDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != _selectedFromDate) {
      // setState(() {
      _selectedFromDate = picked;
      // DateFormat formatter = DateFormat('yyyy-MM-dd');
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      formattedFromDate = formatter.format(_selectedFromDate!);
      schedularController.fromDateController.text = formattedFromDate!;
      setState(() {});
      // calculateAge(formattedDateDBO);
      // });
      // newRegistrationController.refreshUi();
    }
  }

  selectToDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != _selectedToDate) {
      // setState(() {
      _selectedToDate = picked;
      // DateFormat formatter = DateFormat('yyyy-MM-dd');
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      formattedToDate = formatter.format(_selectedToDate!);
      schedularController.toDateController.text = formattedToDate!;
      setState(() {});
      // calculateAge(formattedDateDBO);
      // });
      // newRegistrationController.refreshUi();
    }
  }
}
