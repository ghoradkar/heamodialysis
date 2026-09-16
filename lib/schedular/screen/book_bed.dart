import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/book_appointment/controller/book_appointment_controller.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/schedular/controller/schedular_controller.dart';
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
    // var userId = userData['user_ID'];
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
        title: CustomText(
          text: context.l10n.schedBookAppointment,
          fontSize: 14.sp,
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
                    ? const BookBedShimmer()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            // Add space instead of `paddingOnly`
                            Visibility(
                              visible: bookAppointmentController
                                      .bedAvailableModel?.data !=
                                  null,
                              child: Wrap(
                                spacing: 14.w,
                                runSpacing: 6.h,
                                children: [
                                  _legend(Colors.grey,
                                      context.l10n.schedBedsAllocated),
                                  _legend(AppColor.bedHIVPurple,
                                      context.l10n.schedHivPositive),
                                  _legend(Colors.yellow,
                                      context.l10n.schedHcvPositive),
                                  _legend(AppColor.red,
                                      context.l10n.schedHbsagPositive),
                                  _legend(AppColor.secondaryColor,
                                      context.l10n.schedHhhNegative),
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
                                  padding: EdgeInsets.symmetric(vertical: 6.h),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12.w,
                                    mainAxisSpacing: 12.h,
                                    childAspectRatio: 0.72,
                                  ),
                                  itemCount: bookAppointmentController
                                      .bedAvailableModel?.data?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                                        alignment:
                                                            Alignment.topRight,
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
                                                                  Colors.white,
                                                              value: index,
                                                              groupValue:
                                                                  _selectedCardIndex,
                                                              onChanged:
                                                                  (int? value) {
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
                                                                          'user_ID'];
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
                                                                        CustomMessage.toast(context
                                                                            .l10n
                                                                            .bookSelectBed);
                                                                      }
                                                                    } else {
                                                                      CustomMessage.toast(context
                                                                          .l10n
                                                                          .bookChooseSlot);
                                                                    }
                                                                  } else {
                                                                    CustomMessage
                                                                        .toast(context
                                                                            .l10n
                                                                            .bookSelectInstitute);
                                                                  }
                                                                },
                                                                    "",
                                                                    context.l10n
                                                                        .bookConfirmBookAppointment,
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
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w,
                                                  vertical: 4.h),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                    text:
                                                        context.l10n.schedBedNo,
                                                    fontSize: 11.sp,
                                                    fontFam: 'Lato',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    textColor: Colors.black,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  CustomText(
                                                    text: bookAppointmentController
                                                            .bedAvailableModel
                                                            ?.data?[index]
                                                            .bedNo ??
                                                        "",
                                                    fontSize: 13.sp,
                                                    fontFam: 'Lato',
                                                    fontWeight: FontWeight.w600,
                                                    textColor: Colors.black,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
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

  Widget _legend(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(width: 6.w),
        CustomText(
          text: label,
          fontSize: 12.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.normal,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
      ],
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
