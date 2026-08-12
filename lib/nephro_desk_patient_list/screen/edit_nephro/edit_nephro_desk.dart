import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/coversheet.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/expandable_card.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/clinical_condition.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/clinical_history.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/diagnostic_inv.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/diet.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/instructions.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/prescription.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/upload_document.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/expandable_card.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/clinical_condition.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/clinical_history.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/diagnostic_inv.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/diet.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/instructions.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/prescription.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/upload_document.dart';

import 'package:heamodialysis/schedular/schedular_controller/schedular_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

// import '../../internet/no_internet_connectivity.dart';
// import '../../widgets/custom_shimmer_loader.dart';

class EditNephroDesk extends StatefulWidget {
  final NephroList? patientData;
  final String appBarTitle;

  const EditNephroDesk(
      {super.key, required this.patientData, required this.appBarTitle});

  @override
  State<EditNephroDesk> createState() => _EditNephroDeskState();
}

class _EditNephroDeskState extends State<EditNephroDesk> {
  final NephroController nephroController = Get.find<NephroController>();
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  bool isExpanded = false;
  final PageController pageController = PageController();
  int currentPage = 0;

  var userData;
  final SchedularController schedularController =
      Get.put(SchedularController());
  bool _isInitialDataLoaded = false;

  @override
  void initState() {
    super.initState();
    debugPrint('EditNephroDesk initState called');

    // Initialize connectivity first
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );

    // Load data after connectivity check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetAndLoadData();
    });
  }

  Future<void> _checkInternetAndLoadData() async {
    try {
      await getUserData();

      if (_isNetworkAvailable && mounted) {
        debugPrint('Loading initial data for EditNephroDesk');

        // Load essential data first
        await _loadEssentialData();

        // Load additional data in background
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _loadAdditionalData();
        });
      }
    } catch (e) {
      debugPrint('Error in _checkInternetAndLoadData: $e');
    }
  }

  Future<void> _loadEssentialData() async {
    try {
      // Get treatment ID first
      await nephroController.getTreatmentId(
        widget.patientData?.patientId.toString(),
      );

      // Load patient details
      await nephroController.getPatientDet(
        widget.patientData!.treatmentId.toString(),
        widget.patientData!.patientId.toString(),
      );

      // Load clinical history status
      await nephroController.getClinicalHistoryStat(
        widget.patientData!.patientId.toString(),
      );

      if (mounted) {
        setState(() {
          _isInitialDataLoaded = true;
        });
      }
    } catch (e) {
      debugPrint('Error loading essential data: $e');
    }
  }

  Future<void> _loadAdditionalData() async {
    try {
      debugPrint('Loading additional data in background...');

      // Load data in batches to avoid overwhelming the API
      await Future.wait([
        nephroController.getClinicaConditionProvisionalList(
          widget.patientData?.treatmentId.toString(),
        ),
        nephroController.getClinicalHistoryList(
          widget.patientData?.patientId.toString(),
          nephroController.treatmentIdModel?[0][0].toString(),
        ),
      ]);

      await Future.wait(<Future>[
        nephroController.getDefaultInstruction(
          userData['unitId'].toString(),
          widget.patientData?.treatmentId.toString(),
        ),
        nephroController.getInstructions(
          widget.patientData?.treatmentId.toString(),
          widget.patientData?.patientId.toString(),
        ),
      ]);

      await Future.wait(<Future>[
        nephroController.getPackageList(userData['unitId'].toString()),
        nephroController.getRelationAndDietList(),
        nephroController.getDiseaseList(),
      ]);

      // Load schedular controller data
      await Future.wait([
        schedularController.getPrePostCoversheet(
          widget.patientData!.patientId.toString(),
          userData['unitId'].toString(),
          widget.patientData!.treatmentId!,
          userData['ui'],
        ),
        schedularController.getPrescriptionDet(
          widget.patientData!.treatmentId.toString(),
          userData['unitId'].toString(),
          widget.patientData!.patientId.toString(),
          userData['ui'].toString(),
        ),
      ]);

      await schedularController.getLabInvest(
        widget.patientData!.patientId.toString(),
      );

      await Future.wait(<Future>[
        schedularController.getUploadedDocList(
          widget.patientData?.patientId,
          widget.patientData?.treatmentId.toString(),
          userData['unitId'].toString(),
        ),
        schedularController.getInstructions(
          widget.patientData?.treatmentId,
          widget.patientData?.patientId,
        ),
      ]);

      await schedularController.getDietDetails(
        widget.patientData!.treatmentId.toString(),
      );

      debugPrint('All additional data loaded successfully');
    } catch (e) {
      debugPrint('Error loading additional data: $e');
    }
  }

  Future<void> getUserData() async {
    try {
      userData = await SharedPref().read(const SharedPrefConstant().kUserData);
      debugPrint('User data retrieved: ${userData != null}');
    } catch (e) {
      debugPrint('Error getting user data: $e');
    }
  }

  void goToPage(int pageIndex) {
    if (!pageController.hasClients) return;

    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    if (mounted) {
      setState(() {
        currentPage = pageIndex;
      });
    }
  }

  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final isConnected = results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi,
    );

    if (mounted) {
      setState(() {
        _isNetworkAvailable = isConnected;
      });
    }

    // If connection is restored, load data
    if (isConnected && !_isInitialDataLoaded) {
      _checkInternetAndLoadData();
    }
  }

  @override
  void dispose() {
    debugPrint('EditNephroDesk dispose called');
    _connectivitySubscription?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_isNetworkAvailable
        ? InternetIssue(
            onRetryPressed: () async {
              await _initConnectivity();
            },
          )
        : Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: CustomText(
                text: widget.appBarTitle,
                fontSize: 18.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.black,
                textAlign: TextAlign.start,
              ),
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset('assets/arrow-left.png'),
              ),
              actions: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Image.asset("assets/filter-line.png"),
                  ),
                ),
                SizedBox(width: 2.w),
              ],
            ),
            body: GetBuilder<NephroController>(
              init: nephroController,
              builder: (controller) {
                if (!_isInitialDataLoaded) {
                  return const Center(
                    child: NephroDeskShimmer(),
                  );
                }

                return Column(
                  children: [
                    // Patient Info Card
                    ExpandableCardDetails(
                      patientData: nephroController.patientDet?.first,
                      isExpand: (value) {
                        if (mounted) {
                          setState(() {
                            isExpanded = value;
                          });
                        }
                      },
                      isExpanded: isExpanded,
                      currentStat: nephroController.currentStat,
                    ).paddingSymmetric(vertical: 10.h),

                    // Tab Buttons - Row 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton(0, 'Cover Sheet'),
                        _buildButton(1, 'Clinical History'),
                        _buildButton(2, 'Clinical Condition'),
                        _buildButton(3, 'Diagnostic Inv'),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // Tab Buttons - Row 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton(4, 'Prescription'),
                        _buildButton(5, 'Instruction'),
                        _buildButton(6, 'Diet'),
                        _buildButton(7, 'Upload Document'),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // PageView with proper constraints
                    Expanded(
                      child: _buildPageView(),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 10.w);
              },
            ),
          );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: pageController,
      onPageChanged: (int pageIndex) {
        if (mounted) {
          setState(() {
            currentPage = pageIndex;
          });
        }
      },
      itemCount: 8,
      itemBuilder: (context, index) {
        // Only build the current page and adjacent ones for performance
        if ((index - currentPage).abs() > 1) {
          return Container(); // Return empty container for non-visible pages
        }

        return _buildPageContent(index);
      },
    );
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return Coversheet(
          patientId: widget.patientData?.patientId,
          treatmentId: widget.patientData?.treatmentId,
        );
      case 1:
        return ClinicalHistory(patientData: widget.patientData);
      case 2:
        return ClinicalCondition(patientData: widget.patientData);
      case 3:
        return DiagnosticInv(
          packageList: nephroController.packageList,
          onAdd: () {},
          patientData: widget.patientData,
          choosePackageListModel: nephroController.choosePackageListModel,
        );
      case 4:
        return Prescription(patientData: widget.patientData);
      case 5:
        return Instructions(patientData: widget.patientData);
      case 6:
        return DietScreen(patientData: widget.patientData);
      case 7:
        return UploadDocument(patientData: widget.patientData);
      default:
        return Container();
    }
  }

  Widget _buildButton(int index, String text) {
    return InkWell(
      onTap: () {
        goToPage(index);
      },
      child: SizedBox(
        width: 80.w,
        height: 70.h,
        child: Stack(
          children: [
            /// Main Card
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 2.w),
              decoration: BoxDecoration(
                gradient: currentPage == index
                    ? LinearGradient(
                        colors: [
                          AppColor.primaryBackgroundColor,
                          AppColor.secondaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      )
                    : const LinearGradient(
                        colors: [Colors.white, Colors.white],
                      ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: currentPage == index
                      ? AppColor.secondaryColor
                      : AppColor.borderColor,
                ),
              ),
              child: CustomText(
                text: text,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                textColor:
                    currentPage == index ? Colors.white : Color(0xFF777777),
                textAlign: TextAlign.center,
              ),
            ),

            /// Check Icon – Top Right
            Positioned(
              top: 4,
              right: 4,
              child: Icon(
                Icons.check_circle,
                size: 16,
                color: currentPage == index ? Colors.white : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
