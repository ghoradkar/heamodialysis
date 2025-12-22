import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/patient_history/pre_dialysis_patient_history.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/patient_card_details.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class PatientHistoryScreen extends StatefulWidget {
  final dynamic preDialysisData;

  const PatientHistoryScreen({super.key, required this.preDialysisData});

  @override
  State<PatientHistoryScreen> createState() => _PatientHistoryScreenState();
}

class _PatientHistoryScreenState extends State<PatientHistoryScreen> {
  bool isExpanded = false;
  bool hasInternet = true;
  final NewRegistrationController newRegistrationController =
  Get.put(NewRegistrationController());


  @override
  void initState() {
    // TODO: implement initState
    checkInternetAndLoadData();
    super.initState();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    newRegistrationController.refreshUi();
    if (hasInternet) {
      await newRegistrationController
          .viewPatientData(widget.preDialysisData?.patientId);
      await newRegistrationController
          .getPatientHistory(widget.preDialysisData?.patientId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Patient History',
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
      ),
      body: GetBuilder<NewRegistrationController>(
          init: NewRegistrationController(),
          builder: (controller) {
          return hasInternet
              ? controller.isLoading
              ?  Center(child: buildShimmerLoader())
              :Column(
            children: [
              PatientCardDetails(
                isExpand: (value) {
                  isExpanded = value;
                  setState(() {});
                },
                isExpanded: isExpanded,
                isFromAddPredialysis: true,

                refBy: widget.preDialysisData.refByName ?? "",
                schemaAdopted: '',
                // patientDetailsModel: widget.preDialysisData,
                patientDetails:
                newRegistrationController.viewPatientModel,

              ).paddingSymmetric(vertical: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.regisPatientHistory?.data?.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.radio_button_checked,
                              color: AppColor.secondaryColor,
                            ),
                            Container(
                              height: 90,
                              color: AppColor.secondaryColor,
                              width: 1,
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.borderColor, width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() =>const PreDialysisPatientHistory());
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 4),
                                        alignment: Alignment.centerLeft,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor.primaryBackgroundColor,
                                              AppColor.secondaryColor
                                              // AppColor.primaryBackgroundColor,
                                              // AppColor.secondaryColor
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child: CustomText(
                                            text: controller
                                                .regisPatientHistory
                                                ?.data?[index]
                                                .stageDescription ??
                                                "",
                                            fontSize: 14,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.normal,
                                            textColor: Colors.white,
                                            textAlign: TextAlign.end)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomText(
                                    text: convertDate(controller
                                        .regisPatientHistory
                                        ?.data?[index]
                                        .createdDateTime ??
                                        ""),
                                    fontSize: 14,
                                    fontFam: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black,
                                    textAlign: TextAlign.start,
                                  ),
                                )
                              ],
                            ),
                          ).paddingOnly(right: 4, left: 4),
                        )
                      ],
                    );
                  },
                ),
                // ),
              ),
            ],
          ).paddingSymmetric(horizontal: 8) : InternetIssue(
            onRetryPressed: () {
              checkInternetAndLoadData();
            },
          );
        }
      ),
    );
  }
  String convertDate(String isoDateString) {
    // Parse the ISO 8601 date string
    DateTime parsedDate = DateTime.parse(isoDateString);

    // Format the parsed date to "Sep 13, 2024 5:51:50 PM" format
    String formattedDate =
    DateFormat("MMM dd, yyyy h:mm:ss a").format(parsedDate);

    return formattedDate;
  }
}

class PatientDetailsCard extends StatelessWidget {
  final String patientId,
      patientName,
      viralLoadStatus,
      treatmentId,
      age,
      gender;

  const PatientDetailsCard({
    super.key,
    required this.patientId,
    required this.patientName,
    required this.viralLoadStatus,
    required this.treatmentId,
    required this.age,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.account_circle, size: 50),
        title: Text(patientName),
        subtitle: Text("Viral Load Status: $viralLoadStatus"),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {},
        ),
      ),
    );
  }
}


