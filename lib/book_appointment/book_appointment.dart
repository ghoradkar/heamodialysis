import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:heamodialysis/book_appointment/book_appointment_controller.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/patient_card_details.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_shimmer_loader.dart';

class BookAppointmentScreen extends StatefulWidget {
  final PatientData patientData;
  final bool isFromSchedular;

  const BookAppointmentScreen(
      {super.key, required this.patientData, required this.isFromSchedular});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  File? image;
  DateTime? selectedValue;
  final NewRegistrationController newRegistrationController =
      Get.find<NewRegistrationController>();
  final BookAppointmentController bookAppointmentController =
      Get.put(BookAppointmentController());
  bool hasInternet = true;

  // DateTime? pickedDate;

  var userData;

  int? slotId;
  int? selectedCardIndex;
  int _selectedCardIndex = -1;

  DateTime? selectedDate1;

  int? unitId;

  @override
  void initState() {
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
    bookAppointmentController.update();
    if (hasInternet) {
      selectedValue = DateTime.now();
      bookAppointmentController.selectedDateSendReq =
          DateFormat('dd/MM/yyyy').format(selectedValue ?? DateTime.now());
      await getUserData();
      await fetchData();
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    var userId = userData['ui'];
    debugPrint(userId.toString());
  }

  fetchData() async {
    await newRegistrationController
        .viewPatientData(widget.patientData.patientId);
    await newRegistrationController.getInstituteList();
    InstituteDataModel? initialInstModel =
        newRegistrationController.instituteList?.data?.firstWhere(
            (e) => e.unitId == int.parse(userData['unitId'].toString()));
    bookAppointmentController.selectInstitute =
        initialInstModel?.unitName ?? "";
    unitId = initialInstModel?.unitId;
    await bookAppointmentController.getSlotList(
        initialInstModel?.unitId,
        widget.patientData.patientId,
        bookAppointmentController.selectedDateSendReq);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
         // text: widget.isFromSchedular ? 'Bed Selection"' : 'Book Appointment',
         text: 'Book Appointment',
          fontSize: 18.sp,
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
      body: GetBuilder<BookAppointmentController>(
          init: BookAppointmentController(),
          builder: (controller) {
            return hasInternet
                ? (controller.isLoading)
                    ?  Center(child: buildShimmerLoader())
                    : SingleChildScrollView(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              PatientCardDetails(
                                // patientId:
                                //     widget.patientData.patientId.toString(),
                                // patientName: widget.patientData.fName != null
                                //     ? widget.patientData.fName.toString()
                                //     : widget.patientData.patientName,
                                // gender: widget.patientData.gender ?? "",
                                // refDoc:
                                //     widget.patientData.referenceDoctorName ??
                                //         "",
                                // age: widget.patientData.age.toString(),
                                refBy: widget.patientData.refByName ?? "",
                                schemaAdopted: 'MJPJAY',
                                patientDetails:
                                    newRegistrationController.viewPatientModel,
                              ),
                               SizedBox(
                                height: 20.h,
                              ),

                              Stack(
                                children: [
                                  ClipPath(
                                    clipper: ConcaveClipper(),
                                    child: Container(
                                      height: 130.h,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor.primaryBackgroundColor
                                                  .withValues(alpha: 0.5),
                                              AppColor.secondaryColor
                                                  .withValues(alpha: 0.6)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          )),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: EasyDateTimeLine(
                                      initialDate:
                                          selectedValue ?? DateTime.now(),
                                      onDateChange: (selectedDate) {
                                        // Check if the selected date is before today
                                        if (selectedDate.isBefore(DateTime.now()
                                            .subtract(
                                                const Duration(days: 1)))) {
                                          // If so, ignore the selection or show a message to the user
                                          CustomMessage.toast(
                                              "Please select a valid date.\nSelected date is before the current date");

                                          return;
                                        } else {
                                          // If the selected date is valid
                                          selectedValue = selectedDate;
                                          bookAppointmentController
                                                  .selectedDateSendReq =
                                              DateFormat('dd/MM/yyyy').format(
                                                  selectedValue ??
                                                      DateTime.now());
                                          debugPrint(bookAppointmentController
                                              .selectedDateSendReq);
                                          controller.update();
                                        }
                                      },
                                      headerProps:  EasyHeaderProps(
                                        monthPickerType:
                                            MonthPickerType.switcher,
                                        centerHeader: true,
                                        monthStyle: TextStyle(
                                            fontFamily: "Lato",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp),
                                        selectedDateStyle: TextStyle(
                                            fontFamily: "Lato",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp),
                                        dateFormatter: const DateFormatter
                                            .fullDateMonthAsStrDY(),
                                      ),
                                      dayProps: EasyDayProps(
                                          height: 86.h,
                                          width: 50.w,
                                          dayStructure:
                                              DayStructure.dayStrDayNum,
                                          activeDayStyle: DayStyle(
                                            dayNumStyle:  TextStyle(
                                                fontFamily: "Lato",
                                                color: Colors.white,
                                                fontSize: 16.sp),
                                            dayStrStyle:  TextStyle(
                                                fontFamily: "Lato",
                                                color: Colors.white,
                                                fontSize: 14.sp),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.transparent),
                                            ),
                                          ),
                                          inactiveDayStyle: DayStyle(
                                              dayNumStyle:  TextStyle(
                                                  fontFamily: "Lato",
                                                  fontSize: 16.sp),
                                              dayStrStyle:  const TextStyle(
                                                  fontFamily: "Lato"),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.transparent),
                                              )),
                                          todayStyle: DayStyle(
                                              dayNumStyle: const TextStyle(
                                                fontFamily: "Lato",
                                              ),
                                              dayStrStyle: const TextStyle(
                                                  fontFamily: "Lato"),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.transparent),
                                              ))),
                                    ),
                                  ),
                                ],
                              ),

                              Align(
                                alignment: Alignment.centerLeft,
                                child:  CustomText(
                                  text: 'Select Institute',
                                  fontSize: 15.sp,
                                  fontFam: '',
                                  fontWeight: FontWeight.normal,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start,
                                ).paddingOnly(top: 16.h, bottom: 4.h, left: 1.w),
                              ),
                              DropdownButtonFormField(
                                initialValue:
                                    bookAppointmentController.selectInstitute,
                                isExpanded: true,
                                icon: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: AppColor.primaryBackgroundColor,
                                ),
                                decoration: InputDecoration(
                                  hintText: "select",
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle:  TextStyle(
                                      fontSize: 16.sp,
                                      color: const Color(0xff999999),
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.normal),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: AppColor.borderColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: AppColor.borderColor,
                                    ),
                                  ),
                                ),
                                items: newRegistrationController
                                    .instituteList?.data
                                    ?.map((e) => e.unitName)
                                    .toList()
                                    .map((item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(item ?? ""),
                                        ))
                                    .toList(),
                                onChanged: (value) async {
                                  bookAppointmentController.selectInstitute =
                                      value;
                                  InstituteDataModel? inst =
                                      newRegistrationController
                                          .instituteList?.data
                                          ?.firstWhere((e) =>
                                              e.unitName ==
                                              bookAppointmentController
                                                  .selectInstitute);
                                  unitId = inst?.unitId;

                                  await bookAppointmentController.getSlotList(
                                      unitId,
                                      widget.patientData.patientId,
                                      bookAppointmentController
                                          .selectedDateSendReq);
                                  controller.update();
                                },
                              ).paddingOnly(bottom: 10.h),

                               SizedBox(height: 10.h),
                              // Add space instead of `paddingOnly`
                              Visibility(
                                visible:
                                    bookAppointmentController.selectInstitute !=
                                        null,
                                child: Container(
                                  padding:  EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 6.w),
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: const Offset(0,
                                            0.5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                       Padding(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: CustomText(
                                            text: 'Choose Slot',
                                            fontSize: 14.sp,
                                            fontFam: 'Lato',
                                            fontWeight: FontWeight.bold,
                                            textColor: Colors.black,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: controller
                                              .slotListModel?.data?.length,
                                          itemBuilder: (context, index) {
                                            bool isSelected =
                                                selectedCardIndex == index;

                                            return InkWell(
                                              onTap: () async {
                                                selectedCardIndex = index;
                                                bookAppointmentController
                                                    .update();
                                                String formattedDate;
                                                slotId = controller
                                                    .slotListModel
                                                    ?.data![index]
                                                    .slotId;

                                                if (selectedValue == null) {
                                                  DateTime now = DateTime.now();
                                                  formattedDate =
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(now);
                                                } else {
                                                  formattedDate = DateFormat(
                                                          'dd/MM/yyyy')
                                                      .format(selectedValue!);
                                                }

                                                await bookAppointmentController
                                                    .getBedList(
                                                        unitId,
                                                        slotId,
                                                        formattedDate,
                                                        widget.patientData
                                                            .patientId);
                                                _selectedCardIndex = -1;
                                              },
                                              child: Padding(
                                                padding:
                                                     EdgeInsets.symmetric(vertical: 8.w,horizontal: 8.w),
                                                child: Container(
                                                  width: 140.w,
                                                  height: 40.h,
                                                  decoration: BoxDecoration(
                                                    border: GradientBoxBorder(
                                                        gradient: isSelected
                                                            ? LinearGradient(
                                                                colors: [
                                                                    AppColor
                                                                        .primaryBackgroundColor,
                                                                    AppColor
                                                                        .secondaryColor
                                                                  ])
                                                            : LinearGradient(
                                                                colors: [
                                                                    AppColor
                                                                        .borderColor,
                                                                    AppColor
                                                                        .borderColor
                                                                  ])),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "assets/slot-clock.png",
                                                      ),
                                                       SizedBox(width: 4.w),
                                                      CustomText(
                                                        text: controller
                                                                .slotListModel
                                                                ?.data![index]
                                                                .slotFromTime ??
                                                            "",
                                                        fontSize: 16.sp,
                                                        fontFam: 'Lato',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textColor: Colors.black,
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                               SizedBox(height: 20.h),
                              // Add space instead of `paddingOnly`
                              Visibility(
                                visible: bookAppointmentController
                                        .bedAvailableModel?.data !=
                                    null,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          left: 4.w, right: 8.w),
                                      child: Container(
                                        width: 12.w,
                                        height: 12.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                     CustomText(
                                      text: 'Beds Allocated',
                                      fontSize: 14.sp,
                                      fontFam: 'Lato',
                                      fontWeight: FontWeight.normal,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start,
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          left: 16.w, right: 8.w),
                                      child: Container(
                                        width: 12.w,
                                        height: 12.h,
                                        decoration: BoxDecoration(
                                          color: AppColor.bedHIVPurple,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                     CustomText(
                                      text: 'HIV+',
                                      fontSize: 14.sp,
                                      fontFam: 'Lato',
                                      fontWeight: FontWeight.normal,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start,
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          left: 16.w, right: 8.w),
                                      child: Container(
                                        width: 12.w,
                                        height: 12.h,
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                     CustomText(
                                      text: 'Hepatitis C+',
                                      fontSize: 14.sp,
                                      fontFam: 'Lato',
                                      fontWeight: FontWeight.normal,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: bookAppointmentController
                                        .bedAvailableModel?.data !=
                                    null,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          left: 4.w, right: 8.w),
                                      child: Container(
                                        width: 12.w,
                                        height: 12.h,
                                        decoration: BoxDecoration(
                                          color: AppColor.red,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                     CustomText(
                                      text: 'Hepatitis C+',
                                      fontSize: 14.sp,
                                      fontFam: 'Lato',
                                      fontWeight: FontWeight.normal,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start,
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          left: 16.w, right: 8.w),
                                      child: Container(
                                        width: 12.w,
                                        height: 12.h,
                                        decoration: BoxDecoration(
                                          color: AppColor.secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                     CustomText(
                                      text: 'Negative',
                                      fontSize: 14.sp,
                                      fontFam: 'Lato',
                                      fontWeight: FontWeight.normal,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),

                               SizedBox(height: 20.h),

                              Visibility(
                                visible: bookAppointmentController
                                        .bedAvailableModel?.data !=
                                    null,
                                child: Container(
                                  // padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: const Offset(0,
                                            0.5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: 260.h,
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 5 / 7,
                                    ),
                                    itemCount: bookAppointmentController
                                        .bedAvailableModel?.data?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:  EdgeInsets.symmetric(
                                            vertical: 10.h, horizontal: 10.w),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColor.borderColor),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: getBedColor(
                                                        bookAppointmentController
                                                            .bedAvailableModel
                                                            ?.data?[index]
                                                            .bedAvailbilityFlag,
                                                        bookAppointmentController
                                                            .bedAvailableModel
                                                            ?.data?[index]
                                                            .bedTypeSpGenFlag)),
                                                height: 60.h,
                                                child: Column(
                                                  children: [
                                                    Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: SizedBox(
                                                              width: 16.w,
                                                              height: 16.h,
                                                              child: Visibility(
                                                                visible: getBedColor(
                                                                        bookAppointmentController
                                                                            .bedAvailableModel
                                                                            ?.data?[
                                                                                index]
                                                                            .bedAvailbilityFlag,
                                                                        bookAppointmentController
                                                                            .bedAvailableModel
                                                                            ?.data?[index]
                                                                            .bedTypeSpGenFlag) !=
                                                                    Colors.grey,
                                                                child:
                                                                    Radio<int>(
                                                                  activeColor:
                                                                      Colors
                                                                          .white,
                                                                  value: index,
                                                                  groupValue:
                                                                      _selectedCardIndex,
                                                                  onChanged: (int?
                                                                      value) {
                                                                    setState(
                                                                        () {
                                                                      _selectedCardIndex =
                                                                          value!;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ))
                                                        .paddingOnly(
                                                            top: 6.h, right: 8.w),
                                                    Image.asset(
                                                        "assets/bed.png"),
                                                  ],
                                                ),
                                              ),
                                               CustomText(
                                                text: 'Bed No.',
                                                fontSize: 14.sp,
                                                fontFam: 'Lato',
                                                fontWeight: FontWeight.normal,
                                                textColor: Colors.black,
                                                textAlign: TextAlign.center,
                                              ),
                                              CustomText(
                                                text: bookAppointmentController
                                                        .bedAvailableModel
                                                        ?.data?[index]
                                                        .bedNo ??
                                                    "",
                                                fontSize: 12.sp,
                                                fontFam: 'Lato',
                                                fontWeight: FontWeight.normal,
                                                textColor: Colors.black,
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              CustomButton(
                                iconColor: Colors.white,
                                buttonText: "Book Appointment",
                                path: "assets/check.png",
                                callB: () {
                                  CustomPopup.showConfirmationDialog(() {
                                    Get.back();
                                  }, () {
                                    Get.back();
                                  }, () async {
                                    var userId = userData['ui'];
                                    String formattedDate;
                                    if (selectedValue == null) {
                                      DateTime now = DateTime.now();
                                      formattedDate =
                                          DateFormat('dd/MM/yyyy').format(now);
                                    } else {
                                      formattedDate = DateFormat('dd/MM/yyyy')
                                          .format(selectedValue!);
                                    }
                                    if (bookAppointmentController
                                            .selectInstitute !=
                                        null) {
                                      if (slotId != null) {
                                        if (_selectedCardIndex != -1) {
                                          await bookAppointmentController
                                              .bookAppointment(
                                                  unitId,
                                                  slotId,
                                                  formattedDate,
                                                  bookAppointmentController
                                                      .bedAvailableModel
                                                      ?.data?[
                                                          _selectedCardIndex]
                                                      .bedMachineSlotMapDetId,
                                                  widget.patientData.patientId,
                                                  widget
                                                      .patientData.treatmentId,
                                                  userId,
                                                  widget.isFromSchedular);
                                        } else {
                                          CustomMessage.toast(
                                              "Please Select Bed");
                                        }
                                      } else {
                                        CustomMessage.toast("Choose Slot");
                                      }
                                    } else {
                                      CustomMessage.toast("Select Institute");
                                    }
                                  },
                                      "",
                                      "Are you sure?\nDo you want to book appointment",
                                      "assets/info.png");
                                },
                                buttonWidth: 190.w,
                                primColor: AppColor.primaryBackgroundColor,
                                secColor: AppColor.secondaryColor,
                                textColor: Colors.white,
                              ).paddingOnly(top: 40.h, bottom: 40.h)
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

  getBedColor(bedAvailbilityFlag, bedTypeSpGenFlag) {
    if (bedAvailbilityFlag == "Y") {
      switch (bedTypeSpGenFlag) {
        case "GEN":
          return Colors.grey;
        case "HIV":
          return AppColor.bedHIVPurple;
        case "HEC":
          return Colors.yellow;
        case "HEB":
          return AppColor.red;
        case "NEG":
          return Colors.green;
        default:
          return Colors.grey;
      }
    } else {
      return Colors.grey;
    }
  }
}

class ConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
      size.width / 2,
      size.height / 2,
      0,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
