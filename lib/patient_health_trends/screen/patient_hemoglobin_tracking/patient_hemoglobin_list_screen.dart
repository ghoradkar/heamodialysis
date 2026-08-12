import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
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
//
// import '../../utils/status_update_screen.dart';
// import '../../widgets/custom_card.dart';
// import '../../widgets/custom_shimmer_loader.dart';

class PatientHemoglobinScreen extends StatefulWidget {
  const PatientHemoglobinScreen({super.key});

  @override
  State<PatientHemoglobinScreen> createState() =>
      _PatientHemoglobinScreenState();
}

class _PatientHemoglobinScreenState extends State<PatientHemoglobinScreen> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final PatientController patientController = Get.put(PatientController());
  bool hasInternet = true;
  bool isInitialLoading = true;
  var userData;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    getUserData();
    _scrollController.addListener(_onScroll);
  }

  Future<void> getUserData() async {
    try {
      userData = await SharedPref().read(const SharedPrefConstant().kUserData);
      checkInternetAndLoadData();
    } catch (e) {
      debugPrint('Error getting user data: $e');
      if (mounted) {
        setState(() {
          isInitialLoading = false;
        });
      }
    }
  }

  checkInternetAndLoadData() async {
    try {
      setState(() {
        isInitialLoading = true;
      });
      debugPrint('Checking internet connection...');
      List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi));
      setState(() {});

      if (hasInternet) {
        final unitId = int.parse(userData['unitId'].toString());
        await patientController.fetchPatientHemoglobinList(unitId: unitId);
      }

      if (mounted) {
        setState(() {
          isInitialLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isInitialLoading = false;
        });
      }
      debugPrint('Initial loading set to false');
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
    _scrollController.dispose();
    _connectivitySubscription?.cancel();
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
                    const CustomText(
                      text: 'Search Patient',
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
                  labelText: "Search",
                  hintText: "Search by patient name or id",
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
                  buttonText: "Search",
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
    return _isNetworkAvailable
        ? Scaffold(
            appBar: AppBar(
              title: const CustomText(
                text: 'Haemoglobin Tracking Report',
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
                  onTap: openFilterSheet,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.asset(
                      "assets/filter-line.png",
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            body: isInitialLoading
                ? Center(
                    child: HemoglobinTrackingReportShimmer(),
                  )
                : Obx(() {
                    // 2. No internet connection

                    // 3. Controller loading with empty list
                    if (patientController.isLoading.value &&
                        patientController.displayedPatientsVital.isEmpty) {
                      debugPrint('Showing controller loading spinner');
                      return Center(child: HemoglobinTrackingReportShimmer());
                    }

                    // 4. Search results empty
                    if (patientController.isSearchingVital.value &&
                        patientController.displayedPatientsVital.isEmpty) {
                      debugPrint('Showing no search results');
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'No Matching Patients',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Try searching with different keywords',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                patientController.clearSearchVital();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColor.primaryBackgroundColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12),
                              ),
                              child: const Text(
                                'Clear Search',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // 5. NO DATA FOUND - This is the missing case!
                    // When API returns empty array and we're not loading or searching
                    if (!patientController.isLoading.value &&
                        !patientController.isSearchingVital.value &&
                        patientController.displayedPatientsVital.isEmpty) {
                      debugPrint('Showing no data found screen');
                      return CommonStatusScreen(
                        title: "No Data Found",
                        description:
                            "We are unable to find the data that\nyou are looking for",
                        img: "assets/no_Data_Found.png",
                        buttonText: "Go Back",
                        onPressed: () {
                          Get.back();
                        },
                      );
                    }
                    debugPrint(
                        'Showing patient list with ${patientController.displayedPatientsVital.length} items');
                    return RefreshIndicator(
                      onRefresh: () async {
                        final unitId = userData != null
                            ? int.parse(userData['unitId'].toString())
                            : 0;
                        await patientController.refreshPatientsVital(
                            unitId: unitId);
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8.0),
                        itemCount: patientController
                                .displayedPatientsVital.length +
                            (patientController.isMoreDataAvailableVital.value &&
                                    !patientController.isSearchingVital.value
                                ? 1
                                : 0),
                        itemBuilder: (context, index) {
                          if (index ==
                              patientController.displayedPatientsVital.length) {
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
                            cardItemDetailsList:
                                patientController.cardItemDetailsList,
                            path1: "assets/eye.png",
                            callB1: () {
                              Get.to(PatientDialysisVitalDetailsScreen(
                                patientData: patientController
                                    .displayedPatientsVital[index],
                              ));
                            },
                          );
                        },
                      ),
                    );
                  }),
          )
        : InternetIssue(
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
          //   decoration: const BoxDecoration(
          //   //  color: AppColor.darkBlue,
          //     borderRadius: BorderRadius.only(
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
          //       const SizedBox(height: 25),
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
