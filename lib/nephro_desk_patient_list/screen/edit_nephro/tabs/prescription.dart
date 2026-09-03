import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/prescription_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/add_prescription.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/registered_patient_list/screen/registered_patient_list.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_card.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/status_dialog.dart';
import 'package:intl/intl.dart';


class Prescription extends StatefulWidget {
  final NephroList? patientData;

  const Prescription({super.key, this.patientData});

  @override
  State<Prescription> createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  final NephroController nephroController = Get.find<NephroController>();
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Medicine Name',
    'Prep',
    'Strength',
    'Dose',
    'Unit',
    'Frequency',
    'Instructions',
    'Quantity',
    'Prescribed by',
  ];

  List<SearchByPatient> searchByList = [
    SearchByPatient('1', 'Dialysis Center'),
    SearchByPatient('2', 'State')
  ];

  SearchedData? dropDownValue;
  SearchByPatient? dropDownValue2;

  var userData;

  RadioButtons? radioButtons = RadioButtons.existingAbhaId;

  @override
  void initState() {
    getUserData();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    checkInternetAndLoadData();
    super.initState();
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


  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    nephroController.update();
    if (hasInternet) {
      await nephroController.getPrescriptionList(
          widget.patientData?.treatmentId.toString(),
          userData['unitId'].toString());

      await nephroController.getPrepList();
      await nephroController.getUnitList();
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }
  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable
        ? GetBuilder<NephroController>(
            init: nephroController,
            builder: (controller) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(AddPrescription(

                            patientData: widget.patientData,
                            isEdit: false,
                          ));
                        },
                        child: Image.asset("assets/add-pre-dialysis.png"),
                      ),
                      const SizedBox(width: 8),
                      // Image.asset("assets/download.png"),
                    ],
                  ).paddingOnly(right: 8),
                  // FIXED: Added Expanded to give ListView a bounded height
                  Expanded(
                    child: controller.prescrriptionList?.isEmpty ?? true
                        ? const Center(
                            child: CustomText(
                              text: "No prescriptions found",
                              fontSize: 16,
                              fontFam: "Lato",
                              fontWeight: FontWeight.normal,
                              textColor: Colors.grey,
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                      itemCount: controller.prescrriptionList?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 11),
                                child:  PrescriptionDiagCard(
                                  index: index,
                                  prescriptionItem:
                                  controller.prescrriptionList?[index],
                                  cardItemDetailsList: cardItemDetailsList,
                                  path1: "assets/edit.png",
                                  path2: "assets/delete-bin.png",
                                  callB1: (index) {
                                    Get.to(() =>
                                        AddPrescription(
                                          patientData: widget.patientData,
                                          prescriptionDtoSp: controller
                                              .prescrriptionList?[index],
                                          isEdit: true,
                                        ));
                                  },
                                  callB2: (index) async{
                                    await controller.deletePrescriptin(userData['unitId']
                                        .toString(), controller
                                        .prescrriptionList?[index].prescriptionId
                                        .toString(), userData['user_ID'].toString(), widget
                                        .patientData?.treatmentId.toString());
                                  },
                                )
                              );
                            },
                          ),
                  ),
                ],
              );
            })
        : InternetIssue(
            onRetryPressed: () async {
              final result = await _connectivity.checkConnectivity();
              _updateConnectionStatus(result);
            },
          );
  }
}

class PrescriptionDiagCard extends StatelessWidget {
  final ListOpdPrescriptionDtoSp? prescriptionItem;
  final List<String> cardItemDetailsList;
  final String? path1;
  final String? path2;
  final Function callB1;
  final Function callB2;

  final int index;

  const PrescriptionDiagCard({
    super.key,
    this.prescriptionItem,
    required this.cardItemDetailsList,
    this.path1,
    this.path2,
    required this.callB1,
    required this.callB2,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 7,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: patientDetailsCard(cardItemDetailsList[0],
                                prescriptionItem?.medicineName ?? "-"),
                          ),
                          SizedBox(
                            width: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                patientCardActions(path1!, () {
                                  callB1(index);
                                }, null),
                                patientCardActions(path2!, () {
                                  callB2(index);
                                }, null),
                              ],
                            ),
                          )
                        ],
                      ),
                      patientDetailsCard(cardItemDetailsList[6],
                          prescriptionItem?.instructionName ?? ''),
                      patientDetailsCard(cardItemDetailsList[8],
                          prescriptionItem?.userName ?? ''),
                      Row(
                        children: [
                          Expanded(
                            child: patientDetailsCard(cardItemDetailsList[1],
                                prescriptionItem?.prepName ?? "-"),
                          ),
                          Expanded(
                            child: patientDetailsCard(cardItemDetailsList[2],
                                prescriptionItem?.strength ?? "-"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: patientDetailsCard(cardItemDetailsList[3],
                                prescriptionItem?.dose ?? ''),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: patientDetailsCard(cardItemDetailsList[4],
                                prescriptionItem?.unitName.toString() ?? ''),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: patientDetailsCard(cardItemDetailsList[7],
                                prescriptionItem?.qty.toString() ?? ''),
                          ),
                          Expanded(
                            child: patientDetailsCard(cardItemDetailsList[5],
                                prescriptionItem?.frequency.toString() ?? ''),
                          ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(vertical: 4, horizontal: 2),
                ),
              ],
            ),
          ),
        ).paddingOnly(top: 8, bottom: 8, left: 8, right: 8),
        Positioned(
          top: -11,
          left: 25,
          child: Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF27A9E3),
                  Color(0xFF07B259),
                ],
              ),
            ),
            child: Text(
              '${index + 1}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget patientDetailsCard(String text, String? details) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 2),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           width: 100,
  //           child: CustomText(
  //             text: "$text:",
  //             fontSize: 13,
  //             fontFam: "Lato",
  //             fontWeight: FontWeight.w600,
  //             textColor: Colors.black,
  //             textAlign: TextAlign.start,
  //           ),
  //         ),
  //         Expanded(
  //           child: CustomText(
  //             text: details ?? "",
  //             fontSize: 13,
  //             fontFam: "Lato",
  //             fontWeight: FontWeight.normal,
  //             textColor: Colors.grey,
  //             textAlign: TextAlign.start,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget patientCardActions(String path, Function callB, bool? yes) {
    return InkWell(
      onTap: () {
        callB();
      },
      child: Image.asset(
        path,
        width: 24,
        height: 24,
        color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
      ),
    );
  }
}
