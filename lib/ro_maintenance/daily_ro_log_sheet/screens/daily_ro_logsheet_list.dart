import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/controller/daily_ro_logsheet_controller.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/model/daily_ro_logsheet_model.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/screens/add_edit_daily_ro_logsheet.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class DailyRoLogSheetScreen extends StatefulWidget {
  const DailyRoLogSheetScreen({super.key});

  @override
  State<DailyRoLogSheetScreen> createState() => _DailyRoLogSheetScreenState();
}

class _DailyRoLogSheetScreenState extends State<DailyRoLogSheetScreen> {
  final DailyRoLogSheetController dailyRoLogSheetController =
      Get.put(DailyRoLogSheetController());

  List<String> cardItemDetailsList = ["RO Machine", "Date"];
  bool hasInternet = true;
  var userData;

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

    dailyRoLogSheetController.update();
    if (hasInternet) {
      await dailyRoLogSheetController.getDailyRoLogSheetAndSearchList(
          '', userData['unitId'].toString());
      await dailyRoLogSheetController.getInstituteList();
    }
    // var ins = roMaintDetailsController.instituteList?.data?.firstWhere(
    //     (e) => e.unitId == int.parse(userData['unitId'].toString()));
    // roMaintDetailsController.dropDownValue = ins;

    dailyRoLogSheetController.update();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Daily RO Log Sheet',
          fontSize: 18.0,
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
              Get.to(() => const AddEditDailyRoLogSheet(
                    isEdit: false,
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset("assets/add-pre-dialysis.png"),
            ),
          ),
          const SizedBox(
            width: 4,
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
                    return Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 10),
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
                              const CustomText(
                                      text: "Search",
                                      fontSize: 16,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start)
                                  .paddingSymmetric(vertical: 4),
                              InkWell(
                                  onTap: () {
                                    // roMaintDetailsController.dropDownValue =
                                    //     null;
                                    dailyRoLogSheetController
                                        .valueController.text = "";
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    "assets/cancel.png",
                                    width: 30,
                                    height: 30,
                                    color: AppColor.primaryBackgroundColor,
                                  )),
                            ],
                          ),
                          CustomDateField(
                            labelText: 'Date',
                            hint: 'yyyy-MM-dd',
                            isRequired: false,
                            callB: () {
                              selectDate();
                            },
                            selectedDate:
                                dailyRoLogSheetController.valueController,
                            filledColor: Colors.white,
                            dontDhowPrefix: true,
                          ),
                          InkWell(
                            onTap: () {
                              dailyRoLogSheetController
                                  .getDailyRoLogSheetAndSearchList(
                                      dailyRoLogSheetController
                                          .valueController.text,
                                      userData['unitId'].toString());
                              Get.back();
                            },
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                alignment: Alignment.center,
                                width: 100,
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
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    CustomText(
                                        text: "Search",
                                        fontSize: 16,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.white,
                                        textAlign: TextAlign.start),
                                  ],
                                )),
                          )
                        ],
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
      body: GetBuilder<DailyRoLogSheetController>(builder: (controller) {
        return hasInternet
            ? controller.isLoading
            ?  Center(child: buildShimmerLoader())
                : DailyRoLogSheetCardList(
                    roList: controller.roMaintenanceDetailsModel ?? [],
                    cardItemDetailsList: cardItemDetailsList,
                    path1: "assets/edit.png",
                    callB1: (index) {
                      Get.to(() => AddEditDailyRoLogSheet(
                            proLiItem:
                                controller.roMaintenanceDetailsModel?[index],
                            isEdit: true,
                          ));
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

  selectDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);

    if (picked != null) {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formattedFromDate = formatter.format(picked);
      dailyRoLogSheetController.valueController.text = formattedFromDate;
    }
  }
}

class DailyRoLogSheetCardList extends StatelessWidget {
  final List<DailyRoLogSheetModel> roList;
  final List<String> cardItemDetailsList;
  final String? path1;
  final Function callB1;

  const DailyRoLogSheetCardList({
    super.key,
    required this.roList,
    required this.cardItemDetailsList,
    this.path1,
    required this.callB1,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: roList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xffF8F8F8),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: (0.1)),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 0.5), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 11,top: 15),
              child: Row(

               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          patientDetailsCard(
                              cardItemDetailsList[0], roList[index].machineName ?? ''),
                          patientDetailsCard(
                              cardItemDetailsList[1], roList[index].roPlantDate ?? ''),
                        ],
                      ).paddingSymmetric(vertical: 4, horizontal: 4),
                    ),
                  ),
                  Container(
                    width: 50,
                    decoration: const BoxDecoration(
                      //color: AppColor.darkBlue,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomRight: Radius.circular(6)),
                    ),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        patientCardActions(path1!, () {
                          callB1(index);
                          // Get.to(() => BookAppointmentScreen(
                          //     patientData: patientList[index]));
                        }, null),
                        // patientCardActions(path2!, () {
                        //   callB2(index);
                        // }, null)
                        //     .paddingOnly(top: 16),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ).paddingSymmetric(vertical: 8, horizontal: 12);
        });
  }

  Widget patientDetailsCard(String text, String details) {
    return Row(
      children: [
        CustomText(
                text: "$text :",
                fontSize: 13,
                fontFam: "Lato",
                fontWeight: FontWeight.normal,
                textColor: Colors.black,
                textAlign: TextAlign.start)
            .paddingSymmetric(vertical: 2),
        Expanded(
          child: CustomText(
                  text: details,
                  fontSize: 13,
                  fontFam: "Lato",
                  fontWeight: FontWeight.normal,
                  textColor: Colors.grey,
                  textAlign: TextAlign.start)
              .paddingSymmetric(vertical: 2),
        ),
      ],
    );
  }

  Widget patientCardActions(String path, Function callB, bool? yes) {
    return InkWell(
        onTap: () {
          callB();
        },
        child: Image.asset(
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
