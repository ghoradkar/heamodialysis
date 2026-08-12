import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/screen/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/machine_status/screen/add_machiner_counter.dart';
import 'package:heamodialysis/machine_status/controller/machine_status_controller.dart';
import 'package:heamodialysis/machine_status/model/machine_count_model.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../utils/status_update_screen.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_shimmer_loader.dart';

class MachineCounterList extends StatefulWidget {
  const MachineCounterList({super.key});

  @override
  State<MachineCounterList> createState() => _MachineCounterListState();
}

class _MachineCounterListState extends State<MachineCounterList> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final MachineStatusController machineController =
      Get.put(MachineStatusController());
  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Institute Name',
    'Date',
    'Machine Name',
    'Machine Serial No.',
    "Today's Reading (Hours)",
    "Last Reading (Hours)"
  ];

  SearchedData? dropDownValue;

  var userData;

  @override
  void initState() {
    getUserData();
    checkInternetAndLoadData();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    super.initState();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));

    machineController.update();
    if (hasInternet) {
      // final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      // final today = DateFormat('dd/MM/yyyy').format(DateTime.now());
      await machineController.getMachineList(
          '', '0', int.parse(userData['unitId'].toString()), '');
      await machineController.getInstituteList(userData['unitId']);
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  Future<void> _initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  // Update connection status handler
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final isConnected = results.any(
          (result) =>
      result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi,
    );

    setState(() {
      _isNetworkAvailable = isConnected;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable ? Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
        ),
        title: const CustomText(
          text: 'Machine Counter',
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
            child: Image.asset('assets/arrow-left.png',color: Colors.white,)),
        actions: [
          InkWell(
            onTap: () {
              Get.to(const AddMachineCounter());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.add_circle_outline_sharp,
                color:Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 2,
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
                                text: 'Machine Filter',
                                fontSize: 18.0,
                                fontFam: 'Lato',
                                fontWeight: FontWeight.w500,
                                textColor: Colors.black,
                                textAlign: TextAlign.start,
                              ),
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
                          ).paddingOnly(top: 6, bottom: 16),
                          DropdownButtonFormField(
                            initialValue: machineController.selectInstitute,
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColor.primaryBackgroundColor,
                            ),
                            decoration: InputDecoration(
                              hintText: "select",
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: const TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xff999999),
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
                            items: machineController.instituteList?.data
                                ?.map((e) => e.unitName)
                                .toList()
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item ?? ""),
                                    ))
                                .toList(),
                            onChanged: (value) async {
                              // machineController.selectInstitute = value;
                              // InstituteDataModel? inst = machineController
                              //     .instituteList?.data
                              //     ?.firstWhere((e) =>
                              //         e.unitName ==
                              //         machineController.selectInstitute);
                              //
                              // machineController.update();
                            },
                          ).paddingOnly(bottom: 10),
                          CustomDateField(
                            labelText: 'From Date',
                            hint: 'Select Date',
                            isRequired: false,
                            callB: () {
                              selectFromDate();
                            },
                            selectedDate: machineController.fromDateController,
                            filledColor: Colors.white,
                            dontDhowPrefix: false,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CustomButton(
                              buttonText: 'Save',
                              path: 'assets/next.png',
                              callB: () async {
                                Get.back();
                                String apiDate = "";
                                if (machineController.fromDateController.text.isNotEmpty) {
                                  try {
                                    DateTime parsed = DateFormat('dd-MM-yyyy').parse(machineController.fromDateController.text);
                                    apiDate = DateFormat('yyyy-MM-dd').format(parsed);
                                  } catch (e) {
                                    apiDate = machineController.fromDateController.text;
                                  }
                                }
                                await machineController.getMachineList(
                                    '',
                                    '0',
                                    int.parse(userData['unitId'].toString()),
                                    apiDate);
                              },
                              buttonWidth: 100,
                              primColor: AppColor.primaryBackgroundColor,
                              secColor: AppColor.secondaryColor,
                              textColor: Colors.white,
                              iconColor: Colors.white,
                            ),
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
              child: Image.asset(
                "assets/filter-line.png",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      // drawer: const Drawer(
      //   child: DrawerScreen(),
      // ),
      body: GetBuilder<MachineStatusController>(
          init: machineController,
          builder: (controller) {
            if (controller.isLoading) {
              return Center(child: MachineCounterShimmer());
            }
            if (controller.machineCountList == null || controller.machineCountList!.isEmpty) {
              return CommonStatusScreen(
                title: "No Data Found",
                description: "We are unable to find the data that\nyou are looking for",
                img: "assets/no_Data_Found.png",
                buttonText: "Go Back",
                onPressed: () {
                  Get.back();
                },
              );
            }
            return MachineCountCard(
                        patientList: controller.machineCountList ?? [],
                        cardItemDetailsList: cardItemDetailsList,
                        path1: "assets/edit.png",
                        callB1: (index) async {},
                      );
          }),

    )   : InternetIssue(
      onRetryPressed: () async {
        final result = await _connectivity.checkConnectivity();
        _updateConnectionStatus(result);
      },
    );
  }

  selectFromDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null) {
      DateFormat formatter = DateFormat('dd-MM-yyyy');

      var formattedFromDate = formatter.format(picked);
      machineController.fromDateController.text = formattedFromDate;
      setState(() {});
      // calculateAge(formattedDateDBO);
      // });
      // newRegistrationController.refreshUi();
    }
  }
}

class MachineCountCard extends StatelessWidget {
  final List<MachineCountModel> patientList;
  final List<String> cardItemDetailsList;
  final String? path1;
  final Function callB1;

  const MachineCountCard({
    super.key,
    required this.patientList,
    required this.cardItemDetailsList,
    this.path1,
    required this.callB1,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: patientList.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xffF8F8F8),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 0.5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            patientDetailsCard(cardItemDetailsList[0],
                                patientList[index].unitName ?? ''),
                            patientCardActions(path1!, () {callB1(index);}, null),
                          ],
                        ),
                        patientDetailsCard(cardItemDetailsList[1],
                            formatDisplayDate(patientList[index].createdDate)),
                        patientDetailsCard(cardItemDetailsList[2],
                            patientList[index].machineName ?? ''),
                        patientDetailsCard(
                            cardItemDetailsList[3],
                            patientList[index].machineSerialNo != null
                                ? patientList[index].machineSerialNo.toString()
                                : ""),
                        patientDetailsCard(
                            cardItemDetailsList[4],
                            extractStringUpToParenthesis(
                                patientList[index].todayReading.toString())),
                        patientDetailsCard(
                            cardItemDetailsList[5],
                            patientList[index].lastReading != null
                                ? patientList[index].lastReading.toString()
                                : "")
                      ],
                    ).paddingOnly(left: 6, top: 2, bottom: 2, right: 4),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     height: 20,width: 25,
                  //    // color:Colors.black,
                  //     child: Row(
                  //       children: [
                  //         patientCardActions(path1!, () {
                  //           callB1(index);
                  //         }, null),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ).paddingAll(8.0);
        });
  }
  //
  // Widget patientDetailsCard(String text, String details) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       CustomText(
  //               text: "$text :",
  //               fontSize: 13,
  //               fontFam: "Lato",
  //               fontWeight: FontWeight.normal,
  //               textColor: Colors.black,
  //               textAlign: TextAlign.start)
  //           .paddingSymmetric(vertical: 2),
  //       Expanded(
  //         child: CustomText(
  //                 text: details,
  //                 fontSize: 13,
  //                 fontFam: "Lato",
  //                 fontWeight: FontWeight.normal,
  //                 textColor: Colors.grey,
  //                 textAlign: TextAlign.start)
  //             .paddingSymmetric(vertical: 2),
  //       ),
  //     ],
  //   );
  // }

  String extractStringUpToParenthesis(String input) {
    int index = input.indexOf('(');
    if (index != -1) {
      return input.substring(0, index).trim();
    }
    return input.trim();
  }

  Widget patientCardActions(String path, Function callB, bool? yes) {
    return InkWell(
        onTap: () {
          callB();
        },
        child: Image.asset(
          width: 22,
          height: 22,
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }

  String formatDisplayDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    try {
      DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(dateStr);
      return DateFormat("dd-MM-yyyy").format(parsedDate);
    } catch (e) {
      try {
        DateTime parsedDate = DateTime.parse(dateStr);
        return DateFormat("dd-MM-yyyy").format(parsedDate);
      } catch (e2) {
        return dateStr;
      }
    }
  }
}
