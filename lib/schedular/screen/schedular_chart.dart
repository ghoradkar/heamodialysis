import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/schedular/controller/schedular_controller.dart';
import 'package:heamodialysis/schedular/screen/schedular_list.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';


class SchedularChart extends StatefulWidget {
  const SchedularChart({super.key});

  @override
  State<SchedularChart> createState() => _SchedularChartState();
}

class _SchedularChartState extends State<SchedularChart> {
  TextEditingController fDateController = TextEditingController();
  TextEditingController tDateController = TextEditingController();
  final SchedularController schedularController =
      Get.put(SchedularController());
  DateTime? _selectedToDate;
  String? formattedToDate;
  DateTime? _selectedFromDate;
  String? formattedFromDate;

  bool hasInternet = true;

  var userData;

  String? selectedSlot;

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

      await schedularController.getSlotListSearch(userData['unitId']);
    }
  }

  @override
  void initState() {
    checkInternetAndLoadData();
    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    schedularController.chartDataList.clear();
    super.dispose();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint(userData['user_ID'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),  // adjust as needed
          ),
        ),
        backgroundColor:AppColor.primaryBackgroundColor,
        title:  Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CustomText(
            text: context.l10n.schedDialysisScheduleChart,
            fontSize: 18.sp,
            fontFam: 'Lato',
            fontWeight: FontWeight.w400,
            textColor: Colors.white,
            textAlign: TextAlign.start,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: InkWell(
              onTap: () {
                Get.off(const SchedularListScreen());
              },
              child: Image.asset('assets/arrow-left.png',color:Colors.white,)),
        ),
      ),

      body: GetBuilder<SchedularController>(
          init: SchedularController(),
          builder: (controller) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.borderColor)),
                  child: Column(
                    children: [
                      CustomDateField(
                        labelText: context.l10n.dashFromDate,
                        hint: context.l10n.dashSelectDate,
                        isRequired: true,
                        callB: () {
                          selectFromDate();
                        },
                        selectedDate: fDateController,
                        filledColor: Colors.white,
                        dontDhowPrefix: false,
                      ),
                      CustomDateField(
                        labelText: context.l10n.dashToDate,
                        hint: context.l10n.dashSelectDate,
                        isRequired: true,
                        callB: () {
                          selectToDate();
                        },
                        selectedDate: tDateController,
                        filledColor: Colors.white,
                        dontDhowPrefix: false,
                      ),
                      MyCustomDropdown(
                        selectedItem: selectedSlot,
                        labelText: context.l10n.schedSlotTime,
                        items: schedularController.searchSlotList
                                ?.map((e) => e.slotTime)
                                .toList() ??
                            [],
                        hint: '',
                        isRequired: true,
                        senValue: (value) {
                          selectedSlot = value;
                        },
                        filledColor: Colors.white,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () async {
                            var slotId = schedularController.searchSlotList
                                ?.firstWhere((e) => e.slotTime == selectedSlot);
                            await schedularController.chartData(
                                userData['unitId'],
                                fDateController.text,
                                tDateController.text,
                                slotId?.slotId);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  CustomText(
                                      text: context.l10n.commonSearch,
                                      fontSize: 16.sp,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.normal,
                                      textColor: Colors.white,
                                      textAlign: TextAlign.start),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                    ],
                  ),
                ).paddingSymmetric(vertical: 10.h, horizontal: 10.w),
                schedularController.chartDataList.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: schedularController.chartDataList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  // color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColor.borderColor),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(
                                          text: "${context.l10n.schedAppointmentDate} :",
                                          fontSize: 14.sp,
                                          fontFam: 'Lato',
                                          fontWeight: FontWeight.w500,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start,
                                        ),
                                        CustomText(
                                          text: schedularController
                                                  .chartDataList[index].date ??
                                              "",
                                          fontSize: 14.sp,
                                          fontFam: 'Lato',
                                          fontWeight: FontWeight.w400,
                                          textColor: AppColor.textGrey,
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: "${context.l10n.colPatientId} :",
                                          fontSize: 14.sp,
                                          fontFam: 'Lato',
                                          fontWeight: FontWeight.w500,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start,
                                        ),
                                        CustomText(
                                          text: schedularController
                                                  .chartDataList[index]
                                                  .patientId ??
                                              "",
                                          fontSize: 14.sp,
                                          fontFam: 'Lato',
                                          fontWeight: FontWeight.w400,
                                          textColor: AppColor.textGrey,
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: "${context.l10n.colPatientName} :",
                                          fontSize: 14.sp,
                                          fontFam: 'Lato',
                                          fontWeight: FontWeight.w500,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start,
                                        ),
                                        CustomText(
                                          text: schedularController
                                                  .chartDataList[index]
                                                  .patientName ??
                                              "",
                                          fontSize: 14.sp,
                                          fontFam: 'Lato',
                                          fontWeight: FontWeight.w400,
                                          textColor: AppColor.textGrey,
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: "${context.l10n.schedMachineName} :",
                                          fontSize: 14.sp,
                                          fontFam: 'Lato',
                                          fontWeight: FontWeight.w500,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start,
                                        ),
                                        CustomText(
                                          text: schedularController
                                                  .chartDataList[index]
                                                  .machineName ??
                                              "",
                                          fontSize: 14.sp,
                                          fontFam: 'Lato',
                                          fontWeight: FontWeight.w400,
                                          textColor: AppColor.textGrey,
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    : Container()
              ],
            );
          }),
    );
  }

  selectFromDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != _selectedFromDate) {
      // Update the selected date
      _selectedFromDate = picked;

      // Format the date as "01-OCT-2024"
      DateFormat formatter = DateFormat('dd-MMM-yyyy');
      formattedFromDate = formatter.format(_selectedFromDate!);

      // Set the formatted date in the text field
      fDateController.text = formattedFromDate!;

      // Refresh the UI
      setState(() {});
    }
  }

  selectToDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != _selectedToDate) {
      // Update the selected date
      _selectedToDate = picked;

      // Format the date as "01-OCT-2024"
      DateFormat formatter = DateFormat('dd-MMM-yyyy');
      formattedToDate = formatter.format(_selectedToDate!);

      // Set the formatted date in the text field
      tDateController.text = formattedToDate!;

      // Refresh the UI
      setState(() {});
    }
  }
}
