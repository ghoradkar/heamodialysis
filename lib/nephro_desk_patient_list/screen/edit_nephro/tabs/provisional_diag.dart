import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/clinical_condition_list.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/clinical_condition_provisiona_list.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/add_clinical_condition.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';


class ProvisionalDiag extends StatefulWidget {

  final NephroList? patientData;
  final List<DatDiagonosisMasterDtoa>? clinicalConditionList;
  final List<ClinicalConditionProvisionaList>? clinicalConditionProvisionList;
  final Function check;

  const ProvisionalDiag(
      {super.key,
      this.clinicalConditionList,
      this.clinicalConditionProvisionList,
      this.patientData, required this.check});

  @override
  State<ProvisionalDiag> createState() => _ProvisionalDiagState();
}

class _ProvisionalDiagState extends State<ProvisionalDiag> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;




  final NephroController nephroController = Get.find<NephroController>();

  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Diagnosis',
    'Diagnosis Description',
    'ICD 10 Code',
    'Date',
    'Diagnosis Type',
    'Diagnosed By',
    'Comments',
  ];

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
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    nephroController.update();
    if (hasInternet) {
      // await dashboardController.getAllRegisteredPatient();
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint("Logged-in user data: $userData");
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
    debugPrint("Logged-in user data: $userData");
    return _isNetworkAvailable ?  GetBuilder<NephroController>(
        init: nephroController,
        builder: (controller) {
          if (controller.isLoading) {
            return Center(child: buildShimmerLoader());
          }

          final provisionList =
              widget.clinicalConditionProvisionList ?? [];

          if (provisionList.isEmpty) {
            return  Center(child: Text('No Data Found'));
            //   CommonStatusScreen(
            //   title: "No Data Found",
            //   description:
            //   "We are unable to find the data that\nyou are looking for ",
            //   img: "assets/no_Data_Found.png",
            //   buttonText: "Go Back",
            //   onPressed: () {
            //     Get.back();
            //   },
            // );
          }
          return  ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              widget.clinicalConditionProvisionList?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ProvisionalDiagCard(
                              index: index,
                              roList:
                                  widget.clinicalConditionProvisionList?[index],
                              cardItemDetailsList: cardItemDetailsList,
                              path1: "assets/edit.png",
                              path2: "assets/delete-bin.png",
                              callB1: (index) {
                                Get.to(() => AddClinicalCondition(
                                      patientData: widget.patientData,
                                      proLiItem: widget
                                              .clinicalConditionProvisionList?[
                                          index],
                                      isEdit: true,
                                    ));
                              },
                              callB2: (index) async {
                                await nephroController.deleteClinicalCondi(
                                    widget
                                        .clinicalConditionProvisionList?[index]
                                        .id,
                                    widget.patientData?.treatmentId);
                              },
                              check: (value) {
                                widget.clinicalConditionProvisionList?[index]
                                    .isSelected = value;
                                setState(() {});
                                widget.check(widget.clinicalConditionProvisionList?[index]);
                              }, userData:userData,
                            );
                          },
                        );
        }) : InternetIssue(
      onRetryPressed: () async {
        final result = await _connectivity.checkConnectivity();
        _updateConnectionStatus(result);
      },
    );
  }
}

class ProvisionalDiagCard extends StatelessWidget {
  final ClinicalConditionProvisionaList? roList;
  final Map<String, dynamic>? userData;
  final List<String> cardItemDetailsList;
  final String? path1;
  final String? path2;
  final Function callB1;
  final Function callB2;
  final Function check;

  final int index;

  const ProvisionalDiagCard({
    super.key,
    this.roList,
    required this.cardItemDetailsList,
    this.path1,
    this.path2,
    required this.callB1,
    required this.callB2,
    required this.index,
    required this.check,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // height: 220,
      // padding: const EdgeInsets.only(left: 4),
      // width: double.infinity,
      // decoration: BoxDecoration(
      //   color: const Color(0xffF8F8F8),
      //   borderRadius: BorderRadius.circular(6),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withValues(alpha: 0.1),
      //       spreadRadius: 2,
      //       blurRadius: 4,
      //       offset: const Offset(0, 0.5), // changes position of shadow
      //     ),
      //   ],
      // ),
      child: Stack(
        children: [
          Checkbox(
            activeColor: AppColor.primaryBackgroundColor,
            value: roList?.isSelected, // Boolean value for checkbox state
            onChanged: (bool? newValue) {
              check(newValue);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: patientDetailsCard(
                                cardItemDetailsList[0], roList?.diagoName ?? "-"),
                          ),
                          SizedBox(
                            width: 60,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                patientCardActions(path1!, () {
                                  callB1(index);
                                  // Get.to(() => BookAppointmentScreen(
                                  //     patientData: patientList[index]));
                                }, null),
                                patientCardActions(path2!, () {
                                  callB2(index);
                                }, null),
                              ],
                            ),
                          )

                        ],
                      ),
                      patientDetailsCard(
                          cardItemDetailsList[1], "${roList?.diagndesc}"),
                      patientDetailsCard(
                          cardItemDetailsList[2], "${roList?.icd10Code}"),
                      patientDetailsCard(
                          cardItemDetailsList[3], roList?.date ?? ''),
                      patientDetailsCard(
                          cardItemDetailsList[4], roList?.diagnoType ?? ''),
                      patientDetailsCard(
                          cardItemDetailsList[5], roList?.comment ?? '')
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: patientDetailsCard(
                      //           cardItemDetailsList[3], roList?.date ?? ''),
                      //     ),
                      //     const SizedBox(
                      //       width: 8,
                      //     ),
                      //     Expanded(
                      //       child: patientDetailsCard(
                      //           cardItemDetailsList[4], roList?.diagnoType ?? ''),
                      //     ),
                      //   ],
                      // ),

                      ,
                      patientDetailsCard(
                        cardItemDetailsList[5],
                        (userData?['fuNm'] ?? '').toString().trim(),
                      ),


                      // patientDetailsCard(cardItemDetailsList[6],
                      //     roList?.fName ?? ''),
                    ],
                  ),
                ),

              ],
            ).paddingOnly(left: 44),
          ),
        ],
      ),
    ).paddingSymmetric(vertical: 4, horizontal: 0);
  }

  Widget patientDetailsCard(String text, String? details) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$text : ",
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: details ?? "",
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.normal,
                    color: Colors.grey, // 👈 details ka color
                  ),
                ),
              ],
            ),
          ).paddingSymmetric(vertical: 2),
        ),
      ],
    );
  }


  dateConversion(inputDate) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(inputDate);
    String convertedDate = DateFormat('yyyy-MM-dd').format(date);
    return convertedDate;
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
