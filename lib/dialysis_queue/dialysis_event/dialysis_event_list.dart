import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/dialysis_event_controller.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/dialysis_event_details.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_list_model.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

import '../../widgets/custom_shimmer_loader.dart';

class DialysisEventList extends StatefulWidget {
  const DialysisEventList({super.key});

  @override
  State<DialysisEventList> createState() => _DialysisEventListState();
}

class _DialysisEventListState extends State<DialysisEventList> {
  final DialysisEventController dialysisEventController =
      Get.put(DialysisEventController());

  // final DashboardController dashboardController =
  // Get.put(DashboardController());

  bool hasInternet = true;
  List<SearchedData> staticIncidentList = [
    SearchedData(lookupDetValue: 'Type A', lookupDetParentName: 'Type A'),
    SearchedData(lookupDetValue: 'Type B', lookupDetParentName: 'Type B'),
    SearchedData(lookupDetValue: 'Type C', lookupDetParentName: 'Type C'),
  ];

  SearchedData? selectedValue;
  List<String> cardItemDetailsList = [
    'Patient Id',
    'Patient Name',
    'Patient Age',
    'Mobile No',
    'Scheme Adopted',
    'Viral Load Status '
  ];

  SearchedData? dropDownValue;
  SearchedData? dropDownValue2;

  TextEditingController valueController = TextEditingController();

  var userData;

  @override
  void initState() {
    getUserData();
    checkInternetAndLoadData();
    super.initState();
    valueController.addListener(() {
      if (valueController.text.isEmpty) {
        dialysisEventController.filteredDialysisEventList =
            List.from(dialysisEventController.dialysisEventList);
        dialysisEventController.update();
      }
    });
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    dialysisEventController.update();
    if (hasInternet) {
      await dialysisEventController.getDialysisEventList(
          '', '0', 'EVE', '', userData['unitId'].toString());
      await dialysisEventController.getIncidentType();
    }
  }

  void performLocalSearch() {
    String query = valueController.text.toLowerCase();

    dialysisEventController.filteredDialysisEventList =
        dialysisEventController.dialysisEventList.where((event) {
      return event.patientId.toString().toLowerCase().contains(query) ||
          event.treatmentId.toString().toLowerCase().contains(query) ||
          event.fName!.toLowerCase().contains(query) ||
          event.age.toString().contains(query) ||
          event.mobile!.contains(query);
    }).toList();

    dialysisEventController.update();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Event Queue Patient List',
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
                    padding:
                        EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
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
                        SizedBox(
                          height: 10,
                        ),
                        MyCustomDropdown(
                          labelText: 'Search By',
                          items: ['a','b','c'],
                          hint: 'Select',
                          isRequired: false,
                          senValue: (SearchedData? value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          filledColor: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                    text: "Value",
                                    fontSize: 14.sp,
                                    fontFam: "Lato",
                                    fontWeight: FontWeight.normal,
                                    textColor: const Color(0xff515151),
                                    textAlign: TextAlign.start),
                              ).paddingOnly(top: 10, bottom: 4),
                              TextField(
                                  controller: valueController,
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
                            ],
                          ),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    alignment: Alignment.center,
                                    width: 110.w,
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
                                            text: "Cancelggg",
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
                                  // dialysisEventController
                                  //     .searchPreDialysisPatient(
                                  //         dropDownValue?.lookupDetValue ?? "",
                                  //         valueController.text,
                                  //         int.parse(userData['unitId'].toString()));
                                  performLocalSearch();

                                  Get.back();
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Image.asset("assets/filter-line.png"),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
        ],
      ),
      body: GetBuilder<DialysisEventController>(
          init: dialysisEventController,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ?  Center(child: buildShimmerLoader())
                    : RegisteredPatientCardList(
                        // patientList: controller.dialysisEventList
                        patientList:
                            controller.filteredDialysisEventList != null
                                ? controller.filteredDialysisEventList ?? []
                                : controller.dialysisEventList,
                        cardItemDetailsList: cardItemDetailsList,
                        isSecondColumnVisiable: false,
                        isfromPredialysis: true,
                        path1: "assets/add_entry.png",
                        path2: "",
                        path3: "assets/file-list.png",
                        path4: "",
                        path5: "assets/file-list.png",
                        callB1: (index) {
                          Get.to(() => DialysisEventDetails(
                              dialysisEventDet:
                                  controller.filteredDialysisEventList != null
                                      ? controller
                                          .filteredDialysisEventList![index]
                                      : controller.dialysisEventList[index]));

                          // Get.to(() => DialysisEventDetails(
                          //     dialysisEventDet:
                          //         controller.dialysisEventList[index]));
                        },
                        callB2: () {},
                        callB3: () {},
                        callB4: () {},
                        callB5: (index) {
                          // Get.to(() => EditPreDialysisScreen(
                          //       preDialysisData: controller
                          //           .dialysisEventList[index],
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

class RegisteredPatientCardList extends StatelessWidget {
  final List<DialysisEventListModel> patientList;
  final List<String> cardItemDetailsList;
  final bool isSecondColumnVisiable;
  final bool isfromPredialysis;
  final String? path1;
  final String? path2;
  final String? path3;
  final String? path4;
  final String? path5;
  final Function callB1;
  final Function callB2;
  final Function callB3;
  final Function callB4;
  final Function callB5;

  const RegisteredPatientCardList(
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
      required this.callB2,
      required this.callB3,
      required this.callB4,
      required this.callB5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: patientList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 170.h,
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
                          Visibility(
                            visible: isSecondColumnVisiable,
                            child: SizedBox(
                              width: 12.w,
                            ),
                          ),
                          Visibility(
                              visible: isSecondColumnVisiable,
                              child: patientCardActions(path2!, () {
                                callB2(index);
                              }, null)),
                          Visibility(
                              visible: isfromPredialysis == false,
                              child: patientCardActions(path3!, () {
                                callB3(index);
                              }, null)),
                          Visibility(
                            visible: isSecondColumnVisiable,
                            child: SizedBox(
                              width: 12.w,
                            ),
                          ),
                          Visibility(
                              visible: isSecondColumnVisiable,
                              child: patientCardActions(path4!, () {
                                callB4(index);
                              }, null)),
                          Visibility(
                            visible: isfromPredialysis == true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                patientCardActions(path5!, () {
                                  // Obtain a list of the available cameras on the device.
                                  callB5(index);
                                }, null)
                                    .paddingOnly(left: 16.h, right: 16.w),
                              ],
                            ),
                          )
                        ],
                      ),
                      patientDetailsCard(
                          cardItemDetailsList[1],
                          isfromPredialysis
                              ? "${patientList[index].fName}"
                              : "${patientList[index].fName}"),
                      patientDetailsCard(cardItemDetailsList[2],
                          patientList[index].age.toString()),
                      patientDetailsCard(
                          cardItemDetailsList[3],
                          patientList[index].mobile != null
                              ? patientList[index].mobile!
                              : ""),
                      patientDetailsCard(cardItemDetailsList[4],
                          patientList[index].dialysisSupportType ?? ""),
                      patientDetailsCard(cardItemDetailsList[5],
                          patientList[index].procedureType ?? "")
                    ],
                  ).paddingOnly(left: 6.w, top: 2.h, bottom: 2.h, right: 4.w),
                ),
              ],
            ),
          ).paddingSymmetric(vertical: 8.h, horizontal: 8.w);
        });
  }

  Widget patientDetailsCard(String text, String details) {
    return Row(
      children: [
        CustomText(
                text: "$text :",
                fontSize: 13.sp,
                fontFam: "Lato",
                fontWeight: FontWeight.normal,
                textColor: Colors.black,
                textAlign: TextAlign.start)
            .paddingSymmetric(vertical: 2.h),
        Expanded(
          child: CustomText(
                  text: details,
                  fontSize: 13.sp,
                  fontFam: "Lato",
                  fontWeight: FontWeight.normal,
                  textColor: Colors.grey,
                  textAlign: TextAlign.start)
              .paddingSymmetric(vertical: 2.h),
        ),
      ],
    );
  }

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
          width: 24.w,
          height: 24.h,
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
