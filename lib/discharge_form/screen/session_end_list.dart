import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/screen/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/discharge_form/controller/session_end_controller.dart';
import 'package:heamodialysis/discharge_form/screen/session_end_form_details.dart';
import 'package:heamodialysis/discharge_form/model/discharge_list.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/schedular/screen/patient_history_schedular.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../utils/status_update_screen.dart';
import '../../widgets/custom_shimmer_loader.dart';
import '../../widgets/custom_textfield.dart';

class SessionEndList extends StatefulWidget {
  final dynamic userData;

  const SessionEndList({super.key, this.userData});

  @override
  State<SessionEndList> createState() => _SessionEndListState();
}

class _SessionEndListState extends State<SessionEndList> {
  final SessionEndController dischargeController =
      Get.put(SessionEndController());

  // final DashboardController dashboardController =
  // Get.put(DashboardController());

  List<String> cardItemDetailsList = [
    'Patient Id',
    'Patient Name',
    'Patient Age',
    'Mobile No',
    'Dialysis Date',
    'Scheme Adopt',
    'Treatment Id',
  ];

  // 🔹 Selected Type
  String? selectedType;

  // 🔹 Approval Status list
  List<String> approvalStatusList = ['Approved', 'Pending', 'Rejected'];

  // 🔹 Selected Approval Status
  String? selectedApprovalStatus;

  bool isListenerAdded = false;
  SearchedData? dropDownValue;
  SearchedData? dropDownValue2;

  TextEditingController valueController = TextEditingController();

  @override
  void initState() {
    debugPrint("initState called");

    checkInternetAndLoadData();
    super.initState();

    valueController.addListener(() {
      if (valueController.text.isEmpty) {
        dischargeController.filteredDialysisEventList =
            List.from(dischargeController.dischargeList);
        dischargeController.update();
      }
    });
  }

  checkInternetAndLoadData() async {
    // Load user data (if needed)
    debugPrint("Checking internet and loading data...");

    // Check the internet connection
    var connectivityResult = await Connectivity().checkConnectivity();
    debugPrint("Connectivity status: $connectivityResult");
    if (connectivityResult == ConnectivityResult.none) {
      debugPrint("No internet connection");
    } else {
      debugPrint("Internet is available");
      dischargeController.hasInternet = true;
    }

    if (dischargeController.hasInternet) {
      await dischargeController.fetchDialysisEventListFromAPI(
        '',
        0,
        'DIS',
        '',
        int.parse(widget.userData['unitId'].toString()),
      );
      dischargeController.update();
    } else {
      debugPrint("No internet connection."); // Debug print if no internet
    }
  }

  void performLocalSearch() {
    String query = valueController.text.toLowerCase();

    dischargeController.filteredDialysisEventList =
        dischargeController.dischargeList.where((event) {
      return event.patientId.toString().toLowerCase().contains(query) ||
          event.treatmentId.toString().toLowerCase().contains(query) ||
          event.fName.toLowerCase().contains(query) ||
          event.age.toString().contains(query) ||
          event.dialysisDate.toString().contains(query) ||
          event.dialysisSupportType.toString().contains(query) ||
          event.mobile.contains(query);
    }).toList();

    dischargeController.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30), // adjust as needed
          ),
        ),
        title: const CustomText(
          text: 'Session End Patient List',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.white,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.off(const InstituteWiseDashboardScreen());
            },
            child: Image.asset(
              'assets/arrow-left.png',
              color: Colors.white,
            )),
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
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black,
                                    textAlign: TextAlign.start)
                                .paddingSymmetric(vertical: 4),
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Image.asset(
                                  "assets/cancel.png",
                                  width: 24,
                                  height: 24,
                                  color: AppColor.primaryBackgroundColor,
                                )),
                          ],
                        ),
                        //Type Dropdown
                        MyCustomDropdown(
                          selectedItem: dischargeController.selectedType,
                          labelText: 'Type',
                          items: dischargeController.typeList,
                          hint: 'Select',
                          isRequired: true,
                          senValue: (value) {
                            dischargeController.selectedType = value;
                            dischargeController.update();
                          },
                          filledColor: Colors.white,
                        ),
                        //value Entry filed
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                              text: "Value",
                              fontSize: 16,
                              fontFam: "Lato",
                              fontWeight: FontWeight.normal,
                              textColor: Color(0xff515151),
                              textAlign: TextAlign.start),
                        ).paddingOnly(
                          top: 10,
                          bottom: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
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
                        ),
                        //Approval Status Dropdown
                        MyCustomDropdown(
                          selectedItem:
                              dischargeController.selectedApprovalStatus,
                          labelText: 'Approval Status',
                          items: ['Approved', 'Pending', 'Rejected'],
                          hint: 'Select',
                          isRequired: true,
                          senValue: (value) {
                            setState(() {
                              dischargeController.selectedApprovalStatus =
                                  value;
                            });
                          },
                          filledColor: Colors.white,
                        ),
                        // .paddingOnly(top: 10,left: 5,right: 10),
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
                                        const EdgeInsets.symmetric(vertical: 8),
                                    alignment: Alignment.center,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.red,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/cancel.png"),
                                        const CustomText(
                                            text: "Cancel",
                                            fontSize: 16,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.normal,
                                            textColor: Colors.white,
                                            textAlign: TextAlign.start),
                                      ],
                                    )),
                              ),
                            ).paddingOnly(top: 20),
                            const SizedBox(
                              width: 14,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  performLocalSearch();

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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              ),
                            ).paddingOnly(top: 20),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                "assets/filter-line.png",
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
        ],
      ),
      body: GetBuilder<SessionEndController>(
          init: dischargeController,
          builder: (controller) {
            return controller.hasInternet
                ? controller.isLoading
                    ? const Center(child: SessionEndPatientsShimmer())
                    : (controller.filteredDialysisEventList != null
                            ? controller.filteredDialysisEventList!.isEmpty
                            : controller.dischargeList.isEmpty)
                        ? CommonStatusScreen(
                            title: "No Data Found",
                            description:
                                "We are unable to find the data that\nyou are looking for ",
                            img: "assets/no_Data_Found.png",
                            buttonText: "Go Back",
                            onPressed: () {
                              Get.back();
                            },
                          )
                        : ListView.builder(
                            itemCount: controller.filteredDialysisEventList !=
                                    null
                                ? controller.filteredDialysisEventList!.length
                                : controller.dischargeList.length,
                            // itemCount: controller.dischargeList?.length,
                            itemBuilder: (context, index) {
                              PatientData patientData = PatientData();
                              if (controller.filteredDialysisEventList !=
                                  null) {
                                patientData.patientId = controller
                                    .filteredDialysisEventList![index]
                                    .patientId;
                                patientData.centerPatientId = controller
                                    .filteredDialysisEventList![index]
                                    .centerPatientId;
                                patientData.fName = controller
                                    .filteredDialysisEventList![index].fName;
                                patientData.mobile = controller
                                    .filteredDialysisEventList![index].mobile;
                                patientData.age = controller
                                    .filteredDialysisEventList![index].age;
                                patientData.gender = controller
                                    .filteredDialysisEventList![index].gender;
                                patientData.patientName = controller
                                    .filteredDialysisEventList![index].fName;
                                patientData.treatmentId = controller
                                    .filteredDialysisEventList![index]
                                    .treatmentId;
                              } else {
                                patientData.patientId =
                                    controller.dischargeList[index].patientId;
                                patientData.centerPatientId = controller
                                    .dischargeList[index].centerPatientId;
                                patientData.fName =
                                    controller.dischargeList[index].fName;

                                patientData.mobile =
                                    controller.dischargeList[index].mobile;
                                patientData.age =
                                    controller.dischargeList[index].age;
                                patientData.gender =
                                    controller.dischargeList[index].gender;
                                patientData.patientName =
                                    controller.dischargeList[index].fName;
                                patientData.treatmentId =
                                    controller.dischargeList[index].treatmentId;
                              }

                              return DischargePatientCardList(
                                patientList:
                                    controller.filteredDialysisEventList != null
                                        ? controller
                                            .filteredDialysisEventList![index]
                                        : controller.dischargeList[index],
                                // patientList: controller.dischargeList[index],
                                cardItemDetailsList: cardItemDetailsList,
                                path1: "assets/discharge.png",
                                path2: "assets/file-list.png",
                                callB1: () {
                                  Get.to(() => SessionEndFormDetails(
                                        dialysisEventDet: controller
                                                    .filteredDialysisEventList !=
                                                null
                                            ? controller
                                                    .filteredDialysisEventList![
                                                index]
                                            : controller.dischargeList[index],
                                        userData: widget.userData,
                                      ));
                                  // Get.to(() => DialysisEventDetails(
                                  //     dialysisEventDet:
                                  //         controller.dialysisEventList[index]));
                                },
                                callB2: () {
                                  Get.to(() => PatientHistorySchedular(
                                        patientData: patientData,
                                      ));
                                },
                              );
                            })
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }
}

class DischargePatientCardList extends StatelessWidget {
  final DischargeListModel patientList;
  final List<String> cardItemDetailsList;
  final String? path1;
  final String? path2;
  final Function callB1;
  final Function callB2;

  const DischargePatientCardList({
    super.key,
    required this.patientList,
    required this.cardItemDetailsList,
    this.path1,
    this.path2,
    required this.callB1,
    required this.callB2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: patientDetailsCard(cardItemDetailsList[0],
                              patientList.patientId.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SizedBox(
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                patientCardActions(path1!, () {
                                  callB1();
                                  // Get.to(() => BookAppointmentScreen(
                                  //     patientData: patientList[index]));
                                }, null),
                                patientCardActions(path2!, () {
                                  callB2();
                                  // Get.to(() => BookAppointmentScreen(
                                  //     patientData: patientList[index]));
                                }, null),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  patientDetailsCard(cardItemDetailsList[1], patientList.fName),
                  patientDetailsCard(
                      cardItemDetailsList[2], patientList.age.toString()),
                  patientDetailsCard(
                      cardItemDetailsList[3], patientList.mobile),
                  patientDetailsCard(
                      cardItemDetailsList[4], patientList.dialysisDate ?? ''),
                  patientDetailsCard(cardItemDetailsList[5],
                      patientList.dialysisSupportType ?? ""),
                  patientDetailsCard(cardItemDetailsList[6],
                      patientList.treatmentId.toString())
                ],
              ).paddingOnly(left: 6, top: 2, bottom: 2, right: 4),
            ),
          ],
        ).paddingAll(8.0),
      ),
    );
  }

  Widget patientDetailsCard(String text, String details) {
    return Row(
      children: [
        CustomText(
                text: "$text : ",
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
          width: 24,
          height: 24,
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
