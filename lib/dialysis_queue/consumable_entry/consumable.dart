import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/screen/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/dialysis_queue/consumable_entry/consumable_used.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/controller/dialysis_event_controller.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/pre_dialysis_list/controller/pre_dialysis_controller.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/schedular/screen/patient_history_schedular.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_shimmer_loader.dart';

class ConsumableScreen extends StatefulWidget {
  const ConsumableScreen({super.key});

  @override
  State<ConsumableScreen> createState() => _ConsumableScreenState();
}

class _ConsumableScreenState extends State<ConsumableScreen> {
  final PreDialysisController preDialysisController =
      Get.put(PreDialysisController());

  // final DashboardController dashboardController =
  // Get.put(DashboardController());

  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Patient Id',
    'Patient Name',
    'Patient Age',
    'Mobile No',
    'Last Dialysis Session\nunder the Scheme',
    'Viral Load Status '
  ];

  SearchedData? dropDownValue;
  SearchedData? dropDownValue2;

  TextEditingController valueController = TextEditingController();
  final DialysisEventController dialysisEventController =
      Get.put(DialysisEventController());
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
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    preDialysisController.refreshUi();
    if (hasInternet) {
      // await dashboardController.getAllRegisteredPatient();

      await preDialysisController.searchPreDialysisPatient(
          'PRD', '', int.parse(userData['unitId'].toString()));
      await preDialysisController.searchByDropDownList();
      await dialysisEventController.getDialysisEventList(
          '', '0', 'EVE', '', userData['unitId'].toString());
      if (preDialysisController.searchByModel?.data != null ||
          preDialysisController.searchByModel!.data!.isNotEmpty) {
        dropDownValue = preDialysisController.searchByModel!.data!.first;
        preDialysisController.refreshUi();
      }
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing:0,
        title:  CustomText(
          text: context.l10n.dqPhysicalEntryConsumable,
          fontSize: 16.sp,
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
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return Container(
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
                                    text: context.l10n.commonSearch,
                                    fontSize: 16.sp,
                                    fontFam: "Lato",
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black,
                                    textAlign: TextAlign.start)
                                .paddingSymmetric(vertical: 4.h),
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
                                    text: context.l10n.commonSearchBy,
                                    fontSize: 16.sp,
                                    fontFam: "Lato",
                                    fontWeight: FontWeight.normal,
                                    textColor: const Color(0xff515151),
                                    textAlign: TextAlign.start)
                                .paddingOnly(top: 10.h, bottom: 4.h),
                            Container(
                              // width: 180,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFE1E1E1)),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              padding:
                                   EdgeInsets.symmetric(horizontal: 12.w),
                              child: DropdownButton<SearchedData>(
                                isExpanded: true,
                                value: dropDownValue,
                                hint: Text("select"),
                                onChanged: (SearchedData? newValue) {
                                  dropDownValue = newValue!;
                                  preDialysisController.update();
                                },
                                items: preDialysisController.searchByModel?.data
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
                              text: context.l10n.colType,
                              fontSize: 16.sp,
                              fontFam: "Lato",
                              fontWeight: FontWeight.normal,
                              textColor: const Color(0xff515151),
                              textAlign: TextAlign.start),
                        ).paddingOnly(top: 10.h, bottom: 4.h),
                        TextField(
                            controller: valueController,
                            decoration: InputDecoration(
                              labelText: context.l10n.regSearchPatientHint,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    padding:
                                         EdgeInsets.symmetric(vertical: 8.h),
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
                                            text: context.l10n.commonCancel,
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
                                  preDialysisController
                                      .searchPreDialysisPatient(
                                          dropDownValue?.lookupDetValue ?? "",
                                          valueController.text,
                                          int.parse(userData['unitId'].toString()));
                                  Get.back();
                                },
                                child: Container(
                                    padding:
                                         EdgeInsets.symmetric(vertical: 8.h),
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
                                            text: context.l10n.commonSearch,
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
                  );
                },
              );
            },
            child: Padding(
              padding:  EdgeInsets.only(right: 8.w),
              child: Image.asset("assets/filter-line.png"),
            ),
          ),
           SizedBox(
            width: 2.w,
          ),
        ],
      ),
      body: GetBuilder<PreDialysisController>(
          init: PreDialysisController(),
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ?  Center(child: SessionEndPatientsShimmer())
                    : ConsumableCard(
                        patientList:
                            dialysisEventController.dialysisEventList,
                        cardItemDetailsList: cardItemDetailsList,
                        isSecondColumnVisiable: false,
                        isfromPredialysis: true,
                        path1: "assets/add_entry.png",
                        path2: "",
                        path3: "assets/file-list.png",
                        path4: "",
                        path5: "assets/file-list.png",
                        callB1: (index) {
                          Get.to(() => ConsumableUsed(
                              preDialysisData: dialysisEventController
                                  .dialysisEventList[index]));
                        },
                        callB5: (index) {
                          PatientData patientData = PatientData(
                            patientId: dialysisEventController
                                .dialysisEventList[index].patientId,
                            patientName: dialysisEventController
                                .dialysisEventList[index].fName,
                            treatmentId: dialysisEventController
                                .dialysisEventList[index].treatmentId,
                            age: dialysisEventController
                                .dialysisEventList[index].age,
                          );
                          Get.to(() => PatientHistorySchedular(
                                patientData: patientData,
                              ));

                          // Get.to(() => EditPreDialysisScreen(
                          //       preDialysisData: controller
                          //           .preDialysisListModel!.data![index],
                          //       callB: () {},
                          //     ));
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
}

class ConsumableCard extends StatelessWidget {
  final List<dynamic> patientList;
  final List<String> cardItemDetailsList;
  final bool isSecondColumnVisiable;
  final bool isfromPredialysis;
  final String? path1;
  final String? path2;
  final String? path3;
  final String? path4;
  final String? path5;
  final Function callB1;

  final Function callB5;

  const ConsumableCard(
      {super.key,
      required this.patientList,
      required this.cardItemDetailsList,
      required this.isSecondColumnVisiable,
      this.path1,
      this.path2,
      this.path3,
      this.path4,
      this.path5,
      required this.isfromPredialysis,
      required this.callB1,
      required this.callB5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: patientList.length,
        itemBuilder: (context, index) {
          return Container(
           // elevation: 5,
            // height: 170.h,
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
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: patientDetailsCard(cardItemDetailsList[0],
                                  patientList[index].patientId.toString()),
                            ),
                            patientCardActions(path1!, () {
                              callB1(index);
                              // Get.to(() => BookAppointmentScreen(
                              //     patientData: patientList[index]));
                            }, null),
                           const SizedBox(width: 14),
                            Visibility(
                              visible: isSecondColumnVisiable,
                              child:  SizedBox(
                                width: 12.w,
                              ),
                            ),
                            Visibility(
                              visible: isfromPredialysis == true,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  patientCardActions(path5!, () {
                                    // Obtain a list of the available cameras on the device.
                                    callB5(index);
                                  }, null)
                                      //.paddingOnly(top: 16.h),
                                  // Visibility(
                                  //   visible: isfromPredialysis == false,
                                  //   child: const SizedBox(
                                  //     width: 12,
                                  //   ),
                                  // ),
                                  // Visibility(
                                  //   visible: isfromPredialysis == false,
                                  //   child: patientCardActions(path5!, () {
                                  //     callB5(index);
                                  //   }, true)
                                  //       .paddingOnly(top: 16),
                                  // ),
                                ],
                              ),
                            )


                          ],
                        ),
                        patientDetailsCard(
                            cardItemDetailsList[1],
                            isfromPredialysis
                                ? " ${patientList[index].fName}"
                                : " ${patientList[index].fName}"),
                        patientDetailsCard(cardItemDetailsList[2],
                            patientList[ index].age.toString()),
                        patientDetailsCard(
                            cardItemDetailsList[4],
                            isfromPredialysis
                                ? extractStringUpToParenthesis(
                                    " ${patientList[index].dialysisSupportType}")
                                : extractStringUpToParenthesis(
                                    " ${patientList[index].haemodialysisProcedureTypeEn}")),
                        patientDetailsCard(
                            cardItemDetailsList[5],
                            isfromPredialysis
                                ? " ${patientList[index].procedureType}"
                                : " ${patientList[index].patientTypeEn}")
                      ],
                    ).paddingOnly(left: 6, top: 2, bottom: 2, right: 4),
                  ),
                ),
              ],
            ),
          ).paddingSymmetric(vertical: 8.h,horizontal: 8.w);
        });
  }

  // Widget patientDetailsCard(String text, String details) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       CustomText(
  //               text: "$text : ",
  //               fontSize: 13.sp,
  //               fontFam: "Lato",
  //               fontWeight: FontWeight.normal,
  //               textColor: Colors.black,
  //               textAlign: TextAlign.start)
  //           .paddingSymmetric(vertical: 2.h),
  //       Expanded(
  //         child: CustomText(
  //                 text: details,
  //                 fontSize: 13.sp,
  //                 fontFam: "Lato",
  //                 fontWeight: FontWeight.normal,
  //                 textColor: Colors.grey,
  //                 textAlign: TextAlign.start)
  //             .paddingSymmetric(vertical: 2.h),
  //       ),
  //     ],
  //   );
  // }

  String extractStringUpToParenthesis(String input) {
    int index = input.indexOf('(');
    if (index != -1) {
      return input
          .substring(0, index)
          .trim(); // Extract up to '(' and trim whitespace
    }
    return input.trim(); // Return the original string if '(' is not found
  }

  Widget patientCardActions(String path, Function callB, bool? yes) {
    return InkWell(
        onTap: () {
          callB();
        },
        child: Image.asset(
          width: 22.w,
          height: 22.h,
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
