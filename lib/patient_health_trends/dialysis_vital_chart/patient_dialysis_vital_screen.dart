import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/patient_health_trends/model/dialysis_vital_patient_list_model.dart';
import 'package:heamodialysis/patient_health_trends/dialysis_vital_chart/patient_dialysis_vital_details_screen.dart';
import 'package:heamodialysis/patient_health_trends/controller/patient_heath_trends_controller.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../widgets/custom_shimmer_loader.dart';

class PatientDialysisVitalScreen extends StatefulWidget {
  const PatientDialysisVitalScreen({super.key});

  @override
  State<PatientDialysisVitalScreen> createState() =>
      _PatientDialysisVitalScreenState();
}

class _PatientDialysisVitalScreenState extends State<PatientDialysisVitalScreen> {
  final PatientController patientController = Get.put(PatientController());
  bool hasInternet = true;
  var userData;
  final ScrollController _scrollController = ScrollController();
  bool isInitialLoading = false;

  @override
  void initState() {
    super.initState();
    getUserData();
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

  @override
  void dispose() {
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
    print('Building PatientDialysisVitalScreen');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
        ),
        title: const CustomText(
          text: 'Patient Dialysis Vital Chart',
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
        if (!hasInternet) {
          return InternetIssue(onRetryPressed: () {
            checkInternetAndLoadData();
          });
        }

        // Controller loading with empty list
        if (patientController.isLoading.value &&
            patientController.displayedPatientsVital.isEmpty) {
          print('Showing controller loading with empty list');
          return  Center(child: buildShimmerLoader());
        }


        if (patientController.isLoading.value &&
            patientController.displayedPatientsVital.isEmpty) {
          return  Center(child: buildShimmerLoader());
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
                    backgroundColor: AppColor.primaryBackgroundColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
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

        // No data found (empty list and not loading)
        if (!patientController.isLoading.value &&
            !patientController.isSearchingVital.value &&
            patientController.displayedPatientsVital.isEmpty) {
          print('Showing no data found screen');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people_outline,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 20),
                const Text(
                  'No Patients Found',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'There are no patients available for this unit',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (userData != null) {
                      setState(() {
                        isInitialLoading = true;
                      });
                      checkInternetAndLoadData();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryBackgroundColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: const Text(
                    'Try Again',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
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
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(child: CircularProgressIndicator()),
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
                patientDetailsCard(cardItemDetailsList[0],
                    patient.patientId?.toString() ?? ''),
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
          Container(
            width: 70,
            decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    patientCardActions(path1, callB1, null),
                  ],
                ),
                const SizedBox(height: 25),
              ],
            ),
          )
        ],
      ),
    ).paddingAll(8.0);
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
          width: 22,
          height: 22,
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
