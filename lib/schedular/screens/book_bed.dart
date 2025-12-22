import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/book_appointment/book_appointment_controller.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/schedular/schedular_controller/schedular_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';

class BookBedScreen extends StatefulWidget {
  final PatientData? patientData;
  final int? slot;
  final String? visitorDate;
  final bool? isIronSelected;
  final bool? isEpoSelected;

  const BookBedScreen(
      {super.key,
      this.patientData,
      this.slot,
      this.visitorDate,
      this.isIronSelected,
      this.isEpoSelected});

  @override
  State<BookBedScreen> createState() => _BookBedScreenState();
}

class _BookBedScreenState extends State<BookBedScreen> {
  File? image;
  DateTime? selectedValue;
  String selectedDateSendReq = '';
  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());
  final BookAppointmentController bookAppointmentController =
      Get.put(BookAppointmentController());
  final SchedularController schedularController =
      Get.find<SchedularController>();
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
    newRegistrationController.refreshUi();
    if (hasInternet) {
      selectedDateSendReq =
          DateFormat('dd/MM/yyyy').format(selectedValue ?? DateTime.now());
      getUserData();
      await fetchInstitute();
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    // var userId = userData['ui'];
    // debugPrint(userId);
  }

  fetchInstitute() async {
    await newRegistrationController.getInstituteList();
    InstituteDataModel? initialInstModel =
        newRegistrationController.instituteList?.data?.firstWhere(
            (e) => e.unitId == int.parse(userData['unitId'].toString()));
    bookAppointmentController.selectInstitute =
        initialInstModel?.unitName ?? "";
    unitId = initialInstModel?.unitId;
    // await bookAppointmentController.getSlotList(initialInstModel?.unitId,
    //     widget.patientData?.patientId, selectedDateSendReq);
    await bookAppointmentController.getBedList(unitId, widget.slot,
        selectedDateSendReq, widget.patientData?.patientId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  CustomText(
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
                    : Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
                                      height: 12.w,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(50),
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
                                        borderRadius: BorderRadius.circular(50),
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
                                        borderRadius: BorderRadius.circular(50),
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
                                        borderRadius: BorderRadius.circular(50),
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
                                        borderRadius: BorderRadius.circular(50),
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
                              child: Expanded(
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 5 / 6,
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
                                                      BorderRadius.circular(10),
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
                                                                          ?.data?[
                                                                              index]
                                                                          .bedTypeSpGenFlag) !=
                                                                  Colors.grey,
                                                              child: Radio<int>(
                                                                activeColor:
                                                                    Colors
                                                                        .white,
                                                                value: index,
                                                                groupValue:
                                                                    _selectedCardIndex,
                                                                onChanged: (int?
                                                                    value) {
                                                                  setState(() {
                                                                    _selectedCardIndex =
                                                                        value!;
                                                                  });

                                                                  CustomPopup.showConfirmationDialog(
                                                                      () {
                                                                    Get.back();
                                                                  }, () {
                                                                    Get.back();
                                                                  }, () async {
                                                                    var userId =
                                                                        userData[
                                                                            'ui'];
                                                                    String
                                                                        formattedDate;
                                                                    if (selectedValue ==
                                                                        null) {
                                                                      DateTime
                                                                          now =
                                                                          DateTime
                                                                              .now();
                                                                      formattedDate = DateFormat(
                                                                              'dd/MM/yyyy')
                                                                          .format(
                                                                              now);
                                                                    } else {
                                                                      formattedDate = DateFormat(
                                                                              'dd/MM/yyyy')
                                                                          .format(
                                                                              selectedValue!);
                                                                    }
                                                                    if (bookAppointmentController
                                                                            .selectInstitute !=
                                                                        null) {
                                                                      if (widget
                                                                              .slot !=
                                                                          null) {
                                                                        if (_selectedCardIndex !=
                                                                            -1) {
                                                                          Get.back();
                                                                          await bookAppointmentController.bookAppointment(
                                                                              unitId,
                                                                              widget.slot,
                                                                              formattedDate,
                                                                              bookAppointmentController.bedAvailableModel?.data?[_selectedCardIndex].bedMachineSlotMapDetId,
                                                                              widget.patientData?.patientId,
                                                                              widget.patientData?.treatmentId,
                                                                              userId,
                                                                              true,
                                                                              schedularController: schedularController,
                                                                              visiteDate: widget.visitorDate,
                                                                              patientData: widget.patientData,
                                                                              iron: widget.isIronSelected,
                                                                              epo: widget.isEpoSelected);
                                                                        } else {
                                                                          CustomMessage.toast(
                                                                              "Please Select Bed");
                                                                        }
                                                                      } else {
                                                                        CustomMessage.toast(
                                                                            "Choose Slot");
                                                                      }
                                                                    } else {
                                                                      CustomMessage
                                                                          .toast(
                                                                              "Select Institute");
                                                                    }
                                                                  },
                                                                      "",
                                                                      "Are you sure?\nDo you want to book appointment",
                                                                      "assets/info.png");
                                                                },
                                                              ),
                                                            ),
                                                          ))
                                                      .paddingOnly(
                                                          top: 6.h, right: 8.w),
                                                  Image.asset("assets/bed.png"),
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
