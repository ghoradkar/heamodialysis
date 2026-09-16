import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/investigation/screen/all_test_package.dart';
import 'package:heamodialysis/dialysis_queue/investigation/controller/investigation_controller.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/invest_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/investigation_que_model.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/save_barcode_model.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../../utils/status_update_screen.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_shimmer_loader.dart';

class InvestigationQueue extends StatefulWidget {
  const InvestigationQueue({super.key});

  @override
  State<InvestigationQueue> createState() => _InvestigationQueueState();
}

class _InvestigationQueueState extends State<InvestigationQueue> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  final InvestigationController investController =
      Get.put(InvestigationController());
  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Patient ID',
    'Patient Name',
    'Age',
    'Mobile No',
    'Gender',
    'Package Name',
    'Barcode',
    'Date',
    'Time'
  ];

  var userData;

  String? formattedTime;

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
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    investController.update();
    if (hasInternet) {
      await investController.getInvestList(
          userData['unitId'].toString(), "PRD");
      // investController.filteredList = investController.investList;
    }
  }

  // void filterList() {
  //   String query = investController.searchController.text.trim().toLowerCase();
  //   if (query.isEmpty) {
  //     setState(() {
  //       investController.filteredList = investController.investList;
  //     });
  //   } else {
  //     investController.filteredList =
  //         investController.investList?.where((patient) {
  //       final lowerQuery = query.toLowerCase();
  //
  //       // Ensure `patName` is also converted to lowercase for case-insensitive matching
  //       return patient.patientId?.toString().contains(lowerQuery) == true ||
  //           patient.patName?.toLowerCase().contains(lowerQuery) == true ||
  //           patient.gender?.toLowerCase().contains(lowerQuery) == true ||
  //           patient.age?.toString().contains(lowerQuery) == true ||
  //           patient.packageName?.toLowerCase().contains(lowerQuery) == true;
  //     }).toList();
  //     investController.filteredList;
  //     setState(() {});
  //   }
  // }

  void filterList() {
    investController.applySearchFilter(); // or expose a public method
    investController.update();
  }

  String formatDate(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return dateString; // If parsing fails, return the original string
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    // debugPrint(userData);
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
        title: CustomText(
          text: context.l10n.dqInvestigationQueue,
          fontSize: 18.0,
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
        actions: [
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
                            offset: const Offset(0, 0.5),
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
                                      fontSize: 16,
                                      fontFam: "Lato",
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start)
                                  .paddingSymmetric(vertical: 4),
                              InkWell(
                                  onTap: () {
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                text: context.l10n.commonSearchBy,
                                fontSize: 16,
                                fontFam: "Lato",
                                fontWeight: FontWeight.normal,
                                textColor: Color(0xff515151),
                                textAlign: TextAlign.start),
                          ).paddingOnly(top: 10, bottom: 4),
                          TextField(
                              controller: investController.searchController,
                              decoration: const InputDecoration(
                                labelText:
                                    'Application no, date, patient id, name',
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
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
                                          CustomText(
                                              text: context.l10n.commonCancel,
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
                                    filterList();
                                    Get.back();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          CustomText(
                                              text: context.l10n.commonSearch,
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
        ],
      ),
      body: GetBuilder<InvestigationController>(
          // init: investController,
          builder: (controller) {
            if (controller.isLoading) {
              return Center(child: SessionEndPatientsShimmer());
            }

            if (controller.filteredList == null ||
                controller.filteredList!.isEmpty) {
              return CommonStatusScreen(
                title: context.l10n.commonNoDataFound,
                description: "We are unable to find the data that\nyou are looking for ",
                img: "assets/no_Data_Found.png",
                buttonText: context.l10n.commonGoBack,
                onPressed: () {
                  Get.back();
                },
                // secondButtonText: "Refresh",
                // secondOnPressed: () {
                //   checkInternetAndLoadData();
                // },
              );
            }
            return InvestigationCard(
                    patientList: controller.filteredList ?? [],
                    cardItemDetailsList: cardItemDetailsList,
                    path1: "assets/sample_collection.png",
                    path2: "assets/package.png",
                    path3: "assets/barcode.png",
                    callB1: (index) async {
                      await controller.getAllTest(
                          userData['unitId'], controller.filteredList?[index]);

                      if (controller.filteredList?[index]
                                  .sampleCollectedBytechTime ==
                              null ||
                          controller.filteredList?[index]
                                  .sampleCollectedBytechTime ==
                              '') {
                        firstNav(controller.filteredList?[index]);
                      }
                    },
                    callB2: (index) async {
                      await controller.getAllTest(
                          userData['unitId'], controller.filteredList?[index]);
                      Get.to(AllTestPackage(
                        testList: controller.testList,
                      ));
                    },
                    callB3: (index) async {
                      await controller.getAllTest(
                          userData['unitId'], controller.filteredList?[index]);

                      // if (controller.filteredList?[index].barcodeNo ==
                      //         null &&
                      //     controller.filteredList?[index].barcodeNo == '') {
                      thirdNav(controller.filteredList?[index]);
                      // }
                    },
                  );
      }),
    ) : InternetIssue(
    onRetryPressed: () async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
    },
    );
  }

  void firstNav(InvestigationQueModel? patientData) {
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
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                            text:
                                "Sample collected by Technician Date and Time",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start)
                        .paddingSymmetric(vertical: 8),
                    InkWell(
                        onTap: () {
                          investController.date.text = "";
                          investController.time.text = "";
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
                  labelText: context.l10n.commonDate,
                  hint: context.l10n.dashSelectDate,
                  isRequired: false,
                  callB: () {
                    pickInspectionDate();
                  },
                  selectedDate: investController.date,
                  // selectedDate: issueDateController,
                  filledColor: Colors.white,
                  dontDhowPrefix: false,
                ),
                CustomDateField(
                  key: UniqueKey(),
                  labelText: context.l10n.commonTime,
                  hint: context.l10n.regHintSelect,
                  isRequired: false,
                  callB: () {
                    selectTime();
                  },
                  selectedDate: investController.time,
                  filledColor: Colors.white,
                  dontDhowPrefix: false,
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
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            alignment: Alignment.center,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.red,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/cancel.png"),
                                CustomText(
                                    text: context.l10n.commonCancel,
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
                        onTap: () async {
                          Get.back();
                          DateTime parsedTime = DateFormat("HH:mm")
                              .parse(investController.time.text);

                          // Format it to "h:mm a" (e.g., "4:14 PM")
                          String formattedTime =
                              DateFormat("h:mm a").format(parsedTime);
                          DateTime parsed = DateFormat("dd-MM-yyyy")
                              .parse(investController.date.text);
                          String date = DateFormat("dd/MM/yyyy").format(parsed);

                          List<InvestModel> investList = [];
                          for (int i = 0;
                              i < investController.testList!.length;
                              i++) {
                            investList.add(InvestModel(
                              treatmentId: patientData!.treatmentId,
                              patientId: patientData.patientId,
                              testId: investController.testList![i].testId,
                              packageId: patientData.packageId,
                              expectedSampleDispatchDate: date,
                              expectedSampleDispatchTime:
                                  formattedTime.split(' ').first,
                              barcodeNo:
                                  investController.testList![i].barcodeNo,
                              createdBy:
                                  investController.testList![i].createdBy,
                            ));
                          }

                          await investController.saveDateTime(
                              investList, userData['unitId'].toString());

                          // await investController.saveSampleCollected(
                          //   patientData,
                          //   null,
                          //   investController.date.text,
                          //   formattedTime,
                          //   userData['user_ID'],
                          // );
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/save-next.png"),
                                SizedBox(
                                  width: 6,
                                ),
                                CustomText(
                                    text: context.l10n.commonSave,
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
                )
              ],
            ),
          );
        });
      },
    );
  }

  void thirdNav(InvestigationQueModel? patientData) {
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
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                            text: context.l10n.dqAddBarcodeNo,
                            fontSize: 16,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start)
                        .paddingSymmetric(vertical: 4),
                    InkWell(
                        onTap: () {
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
                TextField(
                    controller: investController.barCodeController,
                    decoration: InputDecoration(
                      labelText: context.l10n.dqBarcodeNo,
                      labelStyle: TextStyle(color: Color(0xFFE1E1E1)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE1E1E1)),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE1E1E1)),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            alignment: Alignment.center,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.red,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/cancel.png"),
                                CustomText(
                                    text: context.l10n.commonCancel,
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
                        onTap: () async {
                          await investController.checkDuplicateBarcode(
                              userData['unitId'].toString(),
                              investController.barCodeController.text);

                          if (investController.message !=
                              "Barcode Already In Use, Please Add Another Barcode") {
                            List<SaveBarcodeModel> investList = [];
                            for (int i = 0;
                                i < investController.testList!.length;
                                i++) {
                              investList.add(SaveBarcodeModel(
                                treatmentId: patientData!.treatmentId,
                                patientId: patientData.patientId,
                                testId: investController.testList![i].testId,
                                packageId: patientData.packageId,
                                sampleCollectedBytechDate:
                                    patientData.sampleCollectedBytechDate,
                                sampleCollectedBytechTime:
                                    patientData.sampleCollectedBytechTime,
                                barcodeNo:
                                    investController.barCodeController.text,
                                createdBy: userData['unitId'],
                              ));
                            }

                            await investController.saveBarcode(
                                investList,
                                userData['unitId'].toString(),
                                userData['user_ID'].toString(),
                                patientData);

                            // await investController.saveSampleCollected(
                            //     patientData,
                            //     investController.barCodeController.text,
                            //     investController.date.text,
                            //     formattedTime,
                            //     userData['user_ID']);
                            Get.back();
                          } else {
                            CustomMessage.toast(investController.message);
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.save,
                                  color: Colors.white,
                                ),
                                CustomText(
                                    text: context.l10n.commonSave,
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
                )
              ],
            ),
          );
        });
      },
    );
  }

  Future<void> pickInspectionDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null) {
      // setState(() {

      // DateFormat formatter = DateFormat('yyyy-MM-dd');
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      var formattedDate1 = formatter.format(picked);
      investController.date.text = formattedDate1;

      // });
      setState(() {});
    }
  }

  selectTime() async {
    String? pickedTime = await DatePickerHelper.selectTime(context);
    investController.time.text = pickedTime!;

    setState(() {});
  }
}

class InvestigationCard extends StatelessWidget {
  final List<InvestigationQueModel> patientList;
  final List<String> cardItemDetailsList;
  final String? path1;
  final String? path2;
  final String? path3;
  final Function callB1;
  final Function callB2;
  final Function callB3;

  const InvestigationCard(
      {super.key,
      required this.patientList,
      required this.cardItemDetailsList,
      this.path1,
      required this.callB1,
      this.path2,
      this.path3,
      required this.callB2,
      required this.callB3});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                  offset: const Offset(0, 0.5), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(  left: 6, top: 2, bottom: 2, right: 4),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ✅ Main content section
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 6, top: 2, bottom: 2, right: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First row with Patient ID and icons
                          Row(
                            children: [
                              Expanded(
                                child: patientDetailsCard(
                                    cardItemDetailsList[0],
                                    patientList[index].patientId.toString(),
                                  showStatus:false,
                                  status:null),
                              ),
                              patientCardActions(path1!, () {
                                if (patientList[index].testStatus != "Y") {
                                  callB1(index);
                                }
                              }, null),
                              patientCardActions(path2!, () {
                                callB2(index);
                              }, null),
                              patientCardActions(path3!, () {
                                if (patientList[index].testStatus != "Y") {
                                  callB3(index);
                                }
                              }, null),
                            ],
                          ),
                          // Other patient details
                          patientDetailsCard(
                              cardItemDetailsList[1],
                              patientList[index].patName != null
                                  ? formatDate(patientList[index].patName!)
                                  : "",
                            showStatus: false,
                             status:null),
                          patientDetailsCard(cardItemDetailsList[2],
                              patientList[index].age.toString(),showStatus: false,status: null),
                          patientDetailsCard(cardItemDetailsList[3],
                              patientList[index].mobile ?? '',showStatus:false,status:null),
                          patientDetailsCard(
                              cardItemDetailsList[4],
                              extractStringUpToParenthesis(
                                  "${patientList[index].gender}"),
                             showStatus:false,
                             status:null),
                          patientDetailsCard(cardItemDetailsList[5],
                              "${patientList[index].packageName}",showStatus:false,status:null),
                          patientDetailsCard(cardItemDetailsList[6],
                              "${patientList[index].barcodeNo}",showStatus:false,status:null),
                          patientDetailsCard(
                              cardItemDetailsList[7],
                              patientList[index]
                                      .sampleCollectedBytechDate
                                      ?.split(" ")
                                      .first ??
                                  '',
                             showStatus: false,
                             status: null),
                          patientDetailsCard(
                              cardItemDetailsList[8],
                              patientList[index].sampleCollectedBytechTime ?? '',
                             showStatus: true,statusColor: patientList[index].testStatus == "Y"
                              ? AppColor.secondaryColor
                              : AppColor.inProcess,
                             status:  patientList[index].testStatus == "Y"
                                 ? "Test Confirmation Done"
                                 : "Test Confirmation Pending",),
                        ],
                      ),
                    ),
                    // ✅ Status section at bottom RIGHT side (as per image)
                    // Container(
                    //   padding:
                    //       const EdgeInsets.only(bottom: 18, left: 12, right: 12),
                    //   child: Row(
                    //     mainAxisAlignment:
                    //         MainAxisAlignment.end, // ✅ Align to right
                    //     children: [
                    //       // Status badge at bottom right
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 12, vertical: 4),
                    //         decoration: BoxDecoration(
                    //           color: patientList[index].testStatus == "Y"
                    //               ? AppColor.secondaryColor
                    //               : AppColor.inProcess,
                    //           borderRadius: BorderRadius.circular(20),
                    //         ),
                    //         child: Text(
                    //           patientList[index].testStatus == "Y"
                    //               ? "Test Confirmation Done"
                    //               : "Test Confirmation Pending",
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 12,
                    //             fontWeight: FontWeight.normal,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ).paddingAll(8.0);
        });
  }

  String formatDate(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return dateString; // If parsing fails, return the original string
    }
  }

  // Widget patientDetailsCard(
  //     String text, String details, bool showStatus, String? status) {
  //   return Row(
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
  //       // ❌ Status removed from individual rows - will be shown at bottom
  //       if (showStatus && status != null)
  //         Container(
  //           padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
  //           decoration: BoxDecoration(
  //               color: status == "Test Confirmation Done"
  //                   ? AppColor.secondaryColor
  //                   : AppColor.inProcess,
  //               borderRadius: BorderRadius.circular(20)),
  //           child: CustomText(
  //               text: status,
  //               fontSize: 12,
  //               fontWeight: FontWeight.normal,
  //               textColor: Colors.white,
  //               textAlign: TextAlign.center),
  //         ).paddingOnly(top: 4, right: 4),
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
          width: 24,
          height: 24,
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ).paddingOnly(left: 4, right: 4));
  }
}
