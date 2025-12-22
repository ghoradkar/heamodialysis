import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/tabs/coversheet.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/expandable_card.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/clinical_condition.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/clinical_history.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/coversheet_nephro.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/diagnostic_inv.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/diet.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/instructions.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/prescription.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/upload_document.dart';
import 'package:heamodialysis/nephro_desk_patient_list/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/nephro_desk_patient_list.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/schedular/schedular_controller/schedular_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

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

  bool isExpanded = false;
  final PageController pageController = PageController();
  int currentPage = 0;

  // final NewRegistrationController newRegistrationController =
  //     Get.put(NewRegistrationController());
  var userData;

  bool hasInternet = true;
  final SchedularController schedularController =
      Get.put(SchedularController());

  @override
  void initState() {
    // TODO: implement initState
    checkInternetAndLoadData();
    super.initState();
  }

  checkInternetAndLoadData() async {
    await getUserData();
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));

    debugPrint('Internet status: $hasInternet');
    nephroController.update();

    if (hasInternet) {
      try {
        debugPrint('Calling ...');
        nephroController.parsedPrescriptionData.clear();
        nephroController.parsedLabInvestData.clear();

        await nephroController
            .getTreatmentId(widget.patientData?.patientId.toString());

        await nephroController.getClinicaConditionProvisionalList(
            widget.patientData?.treatmentId.toString());
        await nephroController.getClinicalHistoryList(
            widget.patientData?.patientId.toString(),
            nephroController.treatmentIdModel?[0][0].toString());
        await nephroController.getDefaultInstruction(
            userData['unitId'].toString(),
            widget.patientData?.treatmentId.toString());
        await nephroController.getInstructions(
            widget.patientData?.treatmentId.toString(),
            widget.patientData?.patientId.toString());

        await nephroController.getPackageList(userData['unitId'].toString());
        await nephroController.getRelationAndDietList();
        await nephroController.getDiseaseList();
        await schedularController.getPrePostCoversheet(
            widget.patientData!.patientId.toString(),
            userData['unitId'].toString(),
            widget.patientData!.treatmentId!,
            userData['ui']);
        await schedularController.getPrescriptionDet(
            widget.patientData!.treatmentId.toString(),
            userData['unitId'].toString(),
            widget.patientData!.patientId.toString(),
            userData['ui'].toString());
        await schedularController
            .getLabInvest(widget.patientData!.patientId.toString());//here

        await nephroController.getClinicalHistoryList(
            widget.patientData?.patientId.toString(),
            widget.patientData?.treatmentId.toString());
        await schedularController.getUploadedDocList(
            widget.patientData?.patientId,
            widget.patientData?.treatmentId.toString(),
            userData['unitId'].toString());
        await schedularController.getInstructions(
          widget.patientData?.treatmentId,
          widget.patientData?.patientId,
        );
        await schedularController
            .getDietDetails(widget.patientData!.treatmentId.toString());

        await nephroController.getPatientDet(
            widget.patientData!.treatmentId.toString(),
            widget.patientData!.patientId.toString());

        await nephroController
            .getClinicalHistoryStat(widget.patientData!.patientId.toString());
      } catch (e) {
        debugPrint('Error while calling getNephroList: $e');
      }
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint('User data retrieved: $userData');
  }

  // Function to handle button taps
  void goToPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      currentPage = pageIndex; // Set the active page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              if (widget.appBarTitle != "Patient Clinical History") {
                Get.off(NephroDeskPatientList(
                  appBarTitle: widget.appBarTitle,
                ));
              }
            },
            child: Image.asset('assets/arrow-left.png')),
        actions: [
          InkWell(
            onTap: () {},
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
      body: GetBuilder<NephroController>(
          init: nephroController,
          builder: (controller) {
            return Column(
              children: [
                ExpandableCardDetails(
                  patientData: nephroController.patientDet?.first,
                  isExpand: (value) {
                    isExpanded = value;
                    setState(() {});
                  },
                  isExpanded: isExpanded,
                  currentStat: nephroController.currentStat,
                ).paddingSymmetric(vertical: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(0, 'Cover Sheet'),
                    _buildButton(1, 'Clinical History'),
                    _buildButton(2, 'Clinical Condition'),
                    _buildButton(3, 'Diagnostic Inv'),
                  ],
                ),
                SizedBox(height: 20.h),
                // Second row of buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(4, 'Prescription'),
                    _buildButton(5, 'Instruction'),
                    _buildButton(6, 'Diet'),
                    _buildButton(7, 'Upload Document'),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (int pageIndex) {
                      setState(() {
                        currentPage =
                            pageIndex; // Update the current page on swipe
                      });
                    },
                    children: [
                      // CoverSheetNephro(
                      //   coverSheetNephro: nephroController.coverSheetNephro,
                      //   patientData: widget.patientData,
                      //   appbarTitle: widget.appBarTitle,
                      // ),
                      Coversheet(
                        patientId: widget.patientData?.patientId,
                        treatmentId: widget.patientData?.treatmentId,
                      ),
                      ClinicalHistory(
                        patientData: widget.patientData,
                      ),
                      ClinicalCondition(
                        patientData: widget.patientData,
                      ),
                      DiagnosticInv(
                        packageList: nephroController.packageList,
                        onAdd: () {},
                        patientData: widget.patientData,
                        choosePackageListModel:
                            nephroController.choosePackageListModel,
                      ),
                      // LabInvestigation(choosePackageListModel: nephroController.choosePackageListModel,),
                      Prescription(
                        patientData: widget.patientData,
                      ),
                      Instructions(
                        patientData: widget.patientData,
                      ),
                      DietScreen(
                        patientData: widget.patientData,
                      ),
                      UploadDocument(patientData: widget.patientData),
                    ],
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 10.w);
          }),
    );
  }

  handleButtonPress(int index) {
    // Perform action based on the index
    if (index == 0) {
      debugPrint('Button pressed at index: $index');
    } else if (index == 1) {
      debugPrint('Button pressed at index: $index');
    }
  }

  Widget _buildButton(int index, String text) {
    return InkWell(
      onTap: () {
        goToPage(index);
      },
      child: Container(
        alignment: Alignment.center,
        width: 80.w,
        height: 70.h,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 2.w),
        decoration: BoxDecoration(
            gradient: currentPage == index
                ? LinearGradient(
                    colors: [
                      AppColor.primaryBackgroundColor,
                      AppColor.secondaryColor
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  )
                : const LinearGradient(
                    colors: [Colors.white, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: currentPage == index
                    ? AppColor.secondaryColor
                    : AppColor.borderColor)),
        child: CustomText(
          text: text,
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          textColor: currentPage == index ? Colors.white : Colors.black,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
