import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/patient_health_trends/model/dialysis_vital_patient_list_model.dart';
import 'package:heamodialysis/patient_health_trends/screen/dialysis_vital_chart/patient_dialysis_vital_details_screen.dart';
import 'package:heamodialysis/patient_health_trends/controller/patient_heath_trends_controller.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../../utils/status_update_screen.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_shimmer_loader.dart';

// import '../../utils/status_update_screen.dart';
// import '../../widgets/custom_card.dart';
// import '../../widgets/custom_shimmer_loader.dart';

class PatientDialysisVitalScreen extends StatefulWidget {
  const PatientDialysisVitalScreen({super.key});

  @override
  State<PatientDialysisVitalScreen> createState() =>
      _PatientDialysisVitalScreenState();
}

class _PatientDialysisVitalScreenState extends State<PatientDialysisVitalScreen> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final PatientController patientController = Get.put(PatientController());
  bool hasInternet = true;
  var userData;
  final ScrollController _scrollController = ScrollController();
  bool isInitialLoading = false;

  @override
  void initState() {
    super.initState();
    getUserData();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    _scrollController.addListener(_onScroll);
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    checkInternetAndLoadData();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    setState(() {});

    if (hasInternet) {
      final unitId = int.parse(userData['unitId'].toString());
      await patientController.refreshPatientsVital(unitId: unitId);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // near bottom
      if (!patientController.isLoading.value &&
          patientController.isMoreDataAvailableVital.value) {
        patientController.loadMoreVital();
      }
    }
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
    _scrollController.dispose();
    super.dispose();
  }

  void openFilterSheet() {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: context.l10n.phtSearchPatient,
                      fontSize: 18.0,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    InkWell(
                        onTap: () {
                          patientController.clearSearchVital();
                          Get.back();
                        },
                        child: Image.asset(
                          "assets/cancel.png",
                          width: 30,
                          height: 30,
                          color: AppColor.primaryBackgroundColor,
                        )),
                  ],
                ).paddingOnly(top: 6, bottom: 16),
                CustomTextField(
                  txtController: patientController.searchControllerVital,
                  labelText: context.l10n.commonSearch,
                  hintText: context.l10n.phtSearchHint,
                  isRequired: false,
                  keyBoardType: TextInputType.text,
                  fillColor: Colors.white,
                  isReadOnly: false,
                  maxLines: 1,
                  fontSize: 14,
                  // onChanged: (val) {
                  //   patientController.localSearch(val);
                  // },
                ),
                CustomButton(
                  buttonText: context.l10n.commonSearch,
                  path: "assets/save-next.png",
                  callB: () {
                    final query =
                        patientController.searchControllerVital.text.trim();
                    if (query.isNotEmpty) {
                      patientController.localSearchVital(query);
                      Get.back();
                    }
                  },
                  buttonWidth: 100,
                  primColor: AppColor.primaryBackgroundColor,
                  secColor: AppColor.primaryBackgroundColor,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                )
              ]),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Building PatientDialysisVitalScreen');
    return _isNetworkAvailable ? Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
        ),
        title: CustomText(
          text: context.l10n.phtVitalChart,
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.white,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset('assets/arrow-left.png',color: Colors.white,)),
        actions: [
          InkWell(
            onTap: openFilterSheet,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                "assets/filter-line.png",
                color:Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        // if (!hasInternet) {
        //   return InternetIssue(onRetryPressed: () {
        //     checkInternetAndLoadData();
        //   });
        // }

        // Controller loading with empty list
        if (patientController.isLoading.value &&
            patientController.displayedPatientsVital.isEmpty) {
          print('Showing controller loading with empty list');
          return  Center(child: HemoglobinTrackingReportShimmer());
        }


        if (patientController.isLoading.value &&
            patientController.displayedPatientsVital.isEmpty) {
          return  Center(child: HemoglobinTrackingReportShimmer());
        }
        // Search results empty
        if (patientController.isSearchingVital.value &&
            patientController.displayedPatientsVital.isEmpty) {
          print('Showing no search results');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 80,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 20),
                Text(
                  'No Matching Patients',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Try searching with different keywords',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    patientController.clearSearchVital();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryBackgroundColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: Text(
                    'Clear Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        // No data found (empty list and not loading)
        if (!patientController.isLoading.value &&
            !patientController.isSearchingVital.value &&
            patientController.displayedPatientsVital.isEmpty) {
          print('Showing no data found screen');
          return CommonStatusScreen(
            title: context.l10n.commonNoDataFound,
            description: "We are unable to find the data that\nyou are looking for",
            img: "assets/no_Data_Found.png",
            buttonText: context.l10n.commonGoBack,
            onPressed: () {
              Get.back();
            },
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            final unitId =
                userData != null ? int.parse(userData['unitId'].toString()) : 0;
            await patientController.refreshPatientsVital(unitId: unitId);
          },
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            itemCount: patientController.displayedPatientsVital.length +
                (patientController.isMoreDataAvailableVital.value &&
                        !patientController.isSearchingVital.value
                    ? 1
                    : 0),
            itemBuilder: (context, index) {
              if (index == patientController.displayedPatientsVital.length) {
                // loader for pagination
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: buildShimmerLoader(),
                );
              }
              final DialysisVitalPatientListModel p =
                  patientController.displayedPatientsVital[index];
              return PatientCard(
                patient: p,
                cardItemDetailsList: patientController.cardItemDetailsList,
                path1: "assets/eye.png",
                callB1: () {
                  Get.to(PatientDialysisVitalDetailsScreen(
                    patientData: patientController.displayedPatientsVital[index],
                  ));
                },
              );
            },
          ),
        );
      }),
    )  : InternetIssue(
      onRetryPressed: () async {
        final result = await _connectivity.checkConnectivity();
        _updateConnectionStatus(result);
      },
    );
  }
}

class PatientCard extends StatelessWidget {
  final DialysisVitalPatientListModel patient;
  final List<String> cardItemDetailsList;
  final String path1;
  final VoidCallback callB1;

  const PatientCard({
    super.key,
    required this.patient,
    required this.cardItemDetailsList,
    required this.path1,
    required this.callB1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    patientDetailsCard(cardItemDetailsList[0],
                        patient.patientId?.toString() ?? ''),
                    patientCardActions(path1, callB1, null),
                  ],
                ),
                patientDetailsCard(
                    cardItemDetailsList[1], patient.patientName ?? ''),
                patientDetailsCard(
                    cardItemDetailsList[2], patient.divisionName ?? ''),
                patientDetailsCard(
                    cardItemDetailsList[3], patient.districtName ?? ''),
                patientDetailsCard(
                    cardItemDetailsList[4], patient.unitName ?? ''),
                patientDetailsCard(
                    cardItemDetailsList[5], patient.gender ?? ''),
              ],
            ).paddingOnly(left: 6, top: 2, bottom: 2, right: 4),
          ),
          // Container(
          //   width: 70,
          //   decoration:const BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: const BorderRadius.only(
          //         topRight: Radius.circular(6),
          //         bottomRight: Radius.circular(6)),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           patientCardActions(path1, callB1, null),
          //         ],
          //       ),
          //       SizedBox(height: 25),
          //     ],
          //   ),
          // )
        ],
      ),
    ).paddingAll(8.0);
  }

  // Widget patientDetailsCard(String text, String details) {
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
  //     ],
  //   );
  // }

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
}
