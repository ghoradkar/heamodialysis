import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/schedular/model/dialysis_queue.dart';
import 'package:heamodialysis/schedular/model/new_stages_model.dart';
import 'package:heamodialysis/schedular/schedular_controller/schedular_controller.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_card.dart';
import 'package:heamodialysis/widgets/custom_patient_document_card.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';

import '../../internet/no_internet_connectivity.dart';
import '../../widgets/custom_shimmer_loader.dart';
import '../../widgets/patient_card_details.dart';

class PatientHistorySchedular extends StatefulWidget {
  final PatientData? patientData;

  const PatientHistorySchedular({super.key, this.patientData});

  @override
  PatientHistorySchedularState createState() => PatientHistorySchedularState();
}

class PatientHistorySchedularState extends State<PatientHistorySchedular> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  final SchedularController schedularController =
      Get.put(SchedularController());
  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());

  bool hasInternet = true;
  bool isExpanded = false;

  @override
  void initState() {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      schedularController.refreshUi();
    });
    if (hasInternet) {
      await newRegistrationController
          .viewPatientData(widget.patientData?.patientId);
      await schedularController.getPatientStages(widget.patientData?.patientId);

      await newRegistrationController
          .getDocumentList(widget.patientData?.patientId);
    }
  }

  bool _hasDisplayableContent(NewStagesModel? stage) {
    String? stageDescription = stage?.stageDescription;
    // Filter out NPL stage
    if (stageDescription == 'NPL') {
      return false;
    }
    return true;
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
    return _isNetworkAvailable
        ? Scaffold(
            appBar: AppBar(
              title: CustomText(
                text: 'Patient History',
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
                  child: Image.asset('assets/arrow-left.png')),
            ),
            body:

            GetBuilder<SchedularController>(
                init: schedularController,
                builder: (controller) {
                  return schedularController.isLoading
                      ? const PatientHistoryShimmer()
                      : Column(
                          children: [
                            GetBuilder<NewRegistrationController>(
                                builder: (controller) {
                              return PatientCardDetails(
                                isExpand: (value) {
                                  isExpanded = value;
                                  setState(() {});
                                },
                                isExpanded: isExpanded,
                                isFromAddPredialysis: true,
                                refBy: widget.patientData?.refByName ?? "",
                                schemaAdopted: newRegistrationController
                                        .viewPatientModel
                                        ?.data
                                        ?.lookupDetIdPatientType
                                        .toString() ??
                                    '',
                                // patientDetailsModel: widget.preDialysisData,
                                patientDetails:
                                    newRegistrationController.viewPatientModel,
                              ).paddingSymmetric(vertical: 12.h);
                            }),
                            schedularController.patientStagesModel != [] &&
                                    schedularController.patientStagesModel !=
                                        null
                                ? Expanded(
                                    child: Builder(
                                      builder: (context) {
                                        // Filter stages with displayable content
                                        List<NewStagesModel> displayableStages =
                                            schedularController
                                                    .patientStagesModel
                                                    ?.where((stage) =>
                                                        _hasDisplayableContent(
                                                            stage))
                                                    .toList() ??
                                                [];

                                        return ListView.builder(
                                          itemCount: displayableStages.length,
                                          itemBuilder: (context, index) {
                                            NewStagesModel? stage =
                                                displayableStages[index];

                                            String? lookupDetValue =
                                                stage.lookupDetValue;
                                            String? createdDateTime =
                                                stage.createdDateTime;
                                            String? stageDescription =
                                                stage.stageDescription;

                                            List<PatientTrackHistoryBean>?
                                                patientTrackHistory =
                                                stage.patientTrackHistoryBean ??
                                                    [];

                                            return IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        color: AppColor
                                                            .secondaryColor,
                                                        width: 1.w,
                                                        height: 20.h,
                                                        padding:
                                                            EdgeInsets.zero,
                                                      ),
                                                      Transform.scale(
                                                        scale: 1.2,
                                                        // Adjust scale to crop the icon as needed
                                                        child: Icon(
                                                          Icons
                                                              .radio_button_checked,
                                                          size: 22,
                                                          color: AppColor
                                                              .secondaryColor,
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                            color: AppColor
                                                                .secondaryColor,
                                                            width: 1),
                                                      )
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8.h,
                                                              horizontal: 10.w),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withValues(
                                                                    alpha: 0.1),
                                                            spreadRadius: 2,
                                                            blurRadius: 4,
                                                            offset: const Offset(
                                                                0,
                                                                0.5), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: IntrinsicHeight(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            if (stageDescription == 'PTR' ||
                                                                stageDescription ==
                                                                    'RPT' ||
                                                                stageDescription ==
                                                                    'STT')
                                                              _buildStageButton(
                                                                  lookupDetValue,
                                                                  stageDescription,
                                                                  AppColor
                                                                      .primaryBackgroundColor,
                                                                  AppColor
                                                                      .secondaryColor),
                                                            if (stageDescription ==
                                                                'CNE')
                                                              _buildNephrologistButton(),
                                                            if (stageDescription ==
                                                                'OTH')
                                                              _buildExitButton(),
                                                            if (stageDescription == 'AIRR' ||
                                                                stageDescription ==
                                                                    'INVE' ||
                                                                stageDescription ==
                                                                    'PTT')
                                                              buildButton(),
                                                            SizedBox(
                                                                height: 8.h),
                                                            Column(
                                                              children: patientTrackHistory
                                                                  .map<Widget>(
                                                                      (history) {
                                                                return _buildHistoryButton(
                                                                    createdDateTime,
                                                                    history,
                                                                    stage);
                                                              }).toList(),
                                                            ),
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                  createdDateTime ??
                                                                      '',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ).paddingSymmetric(
                                                        vertical: 10.h,
                                                        horizontal: 10.w),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
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

  Widget _buildStageButton(String? lookupDetValue, String? stageDescription,
      Color firstColor, Color secondColor) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  firstColor,
                  secondColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
            ),
            child: CustomText(
              text: lookupDetValue ?? '',
              fontSize: 12,
              fontFam: "Lato",
              fontWeight: FontWeight.w400,
              textColor: Colors.white,
              textAlign: TextAlign.center,
            ),
          ),
        ).paddingSymmetric(vertical: 4),
        InkWell(
          onTap: () {
            Get.to(CaseHistoryTable(
                l1: List.generate(
                    newRegistrationController.viewDocument?.obj?.length ?? 0,
                    (index) => (index + 1).toString()), // Sr. No.
                l2: newRegistrationController.viewDocument?.obj
                        ?.map((doc) => doc[3])
                        .toList() ??
                    [], // Document Name
                tableHeader: const ["Sr. No", "Document Name", "Actions"],
                lastColumnWidgets: List.generate(
                  newRegistrationController.viewDocument?.obj?.length ?? 0,
                  (index) => TextButton(
                      onPressed: () {
                        ApiConstants.imageBaseUrl +
                            newRegistrationController.viewDocument?.obj?[index]
                                [0];
                        Get.to(CustomViewer(
                          fileUrl: ApiConstants.imageBaseUrl +
                              newRegistrationController
                                  .viewDocument?.obj?[index][0],
                        ));
                      },
                      child: const Text("View")),
                )));
          },
          child: Container(
            alignment: Alignment.center,
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  firstColor,
                  secondColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const CustomText(
              text: 'Case History',
              fontSize: 12,
              fontFam: "Lato",
              fontWeight: FontWeight.w400,
              textColor: Colors.white,
              textAlign: TextAlign.center,
            ),
          ),
        ).paddingSymmetric(vertical: 4),
      ],
    );
  }

  Widget _buildNephrologistButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      onPressed: () {
        // Action for Nephrologist's Comment
      },
      child: const Text("Nephrologist's Comment"),
    );
  }

  Widget _buildExitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColor.red,
      ),
      onPressed: () {
        // Action for Patient Exits
      },
      child: const Text("Patient Exits"),
    );
  }

  Widget buildButton() {
    return Container(
      alignment: Alignment.center,
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            AppColor.primaryBackgroundColor,
            AppColor.secondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const CustomText(
        text: "Dialysis Details",
        fontSize: 12,
        fontFam: "Lato",
        fontWeight: FontWeight.w400,
        textColor: Colors.white,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildHistoryButton(String? createdDateTime,
      PatientTrackHistoryBean? patientDet, NewStagesModel? stage) {
    String? text;
    Color? firstColor;
    Color? secondColor;

    switch (patientDet?.lookupDetValue) {
      case 'APC':
        text = "Appointment Cancelled";
        firstColor = AppColor.red;
        secondColor = AppColor.red;
        break;
      case 'EVE':
        text = "Event";
        firstColor = AppColor.red;
        secondColor = AppColor.red;
        break;
      case 'DCD':
        text = "Dietician Consultation Done";
        firstColor = Colors.green;
        secondColor = Colors.green;
        break;
      case 'CNE':
        text = "Nephrologist's Comment";
        firstColor = Colors.green;
        secondColor = Colors.green;
        break;
      case 'PTA':
        text = "Patient Absent";
        firstColor = AppColor.red;
        secondColor = AppColor.red;
        break;
      case 'BED':
        text = "Dialysis Details";
        firstColor = AppColor.primaryBackgroundColor;
        secondColor = AppColor.secondaryColor;
        break;
    }

    if (text != null && firstColor != null && secondColor != null) {
      return InkWell(
        onTap: () {
          if (text == "Dialysis Details") {
            Get.to(DialysisQueue(
                treatmentId: stage?.treatmentId, patientId: stage?.patientId));
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: 150,
          height: 40,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                firstColor,
                secondColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: CustomText(
            text: text,
            fontSize: 12,
            fontFam: "Lato",
            fontWeight: FontWeight.w400,
            textColor: Colors.white,
            textAlign: TextAlign.center,
          ),
        ),
      ).paddingSymmetric(vertical: 4);
    } else {
      return const SizedBox.shrink();
    }
  }
}

class CaseHistoryTable extends StatefulWidget {
  final PatientData? patientData;
  final List<String> l1;
  final List<dynamic> l2;
  final List<Widget>? lastColumnWidgets;
  final List<String> tableHeader;
  final Function(int index)? onButtonPressed;

  const CaseHistoryTable({
    super.key,
    required this.l1,
    required this.l2,
    required this.tableHeader,
    this.lastColumnWidgets,
    this.onButtonPressed,
    this.patientData,
  });

  @override
  State<CaseHistoryTable> createState() => _CaseHistoryTableState();
}

class _CaseHistoryTableState extends State<CaseHistoryTable> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool isExpanded = false;
  bool isLoading = true;

  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());

  @override
  void initState() {
    shwProgressIndicator();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    super.initState();
  }

  Future<void> _initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

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
    return _isNetworkAvailable
        ? Scaffold(
            appBar: AppBar(
              title: CustomText(
                text: 'Case History',
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
                  child: Image.asset('assets/arrow-left.png')),
            ),
            body: isLoading
                ? const PatientHistoryShimmer()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        // Patient Card Details here
                        GetBuilder<NewRegistrationController>(
                          builder: (controller) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: PatientCardDetails(
                                isExpand: (value) {
                                  setState(() {
                                    isExpanded = value;
                                  });
                                },
                                isExpanded: isExpanded,
                                isFromAddPredialysis: true,
                                refBy: widget.patientData?.refByName ?? "",
                                schemaAdopted: newRegistrationController
                                        .viewPatientModel
                                        ?.data
                                        ?.lookupDetIdPatientType
                                        .toString() ??
                                    '',
                                patientDetails:
                                    newRegistrationController.viewPatientModel,
                              ).paddingSymmetric(vertical: 12.h),
                            );
                          },
                        ),

                        SizedBox(height: 10.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: "Patient Documents",
                            fontSize: 14.sp,
                            textColor: Colors.black,
                            textAlign: TextAlign.center,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w400,
                          ).paddingOnly(left: 8.w, bottom: 4.h),
                        ),
                        SizedBox(height: 10.h),

                        // Patient Documents List
                        if (widget.l1.isNotEmpty)
                          Column(
                            children: List.generate(
                              widget.l1.length,
                              (index) {
                                // Extract document name from l2 list
                                String documentName =
                                    widget.l2[index]?.toString() ?? 'N/A';

                                return patientDocumentCard(
                                  title: 'Document Name:',
                                  value: documentName,
                                  icon: Icons.remove_red_eye_outlined,
                                  onEyePressed: () {
                                    // Handle view action
                                    if (newRegistrationController
                                                .viewDocument?.obj !=
                                            null &&
                                        newRegistrationController
                                                .viewDocument!.obj!.length >
                                            index) {
                                      String fileUrl =
                                          ApiConstants.imageBaseUrl +
                                              (newRegistrationController
                                                      .viewDocument
                                                      ?.obj?[index][0]
                                                      ?.toString() ??
                                                  '');

                                      if (fileUrl.isNotEmpty) {
                                        Get.to(CustomViewer(fileUrl: fileUrl));
                                      }
                                    }
                                  },
                                ).paddingSymmetric(
                                  vertical: 8.h,
                                  horizontal: 8.w,
                                );
                              },
                            ),
                          )
                        else
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CustomText(
                                text: "No documents available",
                                fontSize: 16.sp,
                                textColor: Colors.grey,
                                textAlign: TextAlign.center,
                                fontFam: "Lato",
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),

                        // Table section
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: SizedBox(
                        //     width: MediaQuery.of(context).size.width,
                        //     child: Table(
                        //       defaultColumnWidth: const IntrinsicColumnWidth(),
                        //       children: [
                        //         widget.l1.isNotEmpty
                        //             ? _buildRoundedTableRow(widget.tableHeader)
                        //             : TableRow(children: [
                        //           CustomText(
                        //             text: "Data Not available",
                        //             fontSize: 16.sp,
                        //             textColor: Colors.black,
                        //             textAlign: TextAlign.center,
                        //             fontFam: "Lato",
                        //             fontWeight: FontWeight.normal,
                        //           ).paddingOnly(left: 8.w, bottom: 4.h)
                        //         ]),
                        //         for (int i = 0; i < widget.l1.length; i++)
                        //           widget.l1.isNotEmpty
                        //               ? _buildTableRow(i)
                        //               : TableRow(children: [
                        //             CustomText(
                        //               text: "",
                        //               fontSize: 2.sp,
                        //               textColor: Colors.black,
                        //               textAlign: TextAlign.start,
                        //               fontWeight: FontWeight.normal,
                        //               fontFam: 'Lato',
                        //             ).paddingOnly(left: 8.w, bottom: 4.h)
                        //           ]),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
          )
        : InternetIssue(
            onRetryPressed: () async {
              final result = await _connectivity.checkConnectivity();
              _updateConnectionStatus(result);
            },
          );
  }

  shwProgressIndicator() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  TableRow _buildRoundedTableRow(List<String> data) {
    return TableRow(
      children: List.generate(
        data.length,
        (index) => TableCell(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: index == 0 ? Radius.circular(10.r) : Radius.zero,
                topRight: index == data.length - 1
                    ? Radius.circular(10.r)
                    : Radius.zero,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Text(
                data[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(int index) {
    return TableRow(
      children: List.generate(
        widget.tableHeader.length,
        (i) => TableCell(
          verticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
          child: Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 8.h),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: i == (widget.tableHeader.length - 1)
                  ? GestureDetector(
                      onTap: () {
                        if (widget.onButtonPressed != null) {
                          widget.onButtonPressed!(index);
                        }
                      },
                      child: widget.lastColumnWidgets?[index] ?? Container(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            [
                              widget.l1[index],
                              widget.l2[index],
                            ][i]
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
// import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
// import 'package:heamodialysis/schedular/model/dialysis_queue.dart';
// import 'package:heamodialysis/schedular/model/new_stages_model.dart';
// import 'package:heamodialysis/schedular/schedular_controller/schedular_controller.dart';
// import 'package:heamodialysis/utils/api_urls.dart';
// import 'package:heamodialysis/utils/color_constants.dart';
// import 'package:heamodialysis/widgets/custom_text.dart';
// import 'package:heamodialysis/widgets/image_viewer.dart';
//
// import '../../widgets/patient_card_details.dart';
//
// class PatientHistorySchedular extends StatefulWidget {
//   final PatientData? patientData;
//
//   const PatientHistorySchedular({super.key, this.patientData});
//
//   @override
//   PatientHistorySchedularState createState() => PatientHistorySchedularState();
// }
//
// class PatientHistorySchedularState extends State<PatientHistorySchedular> {
//   final SchedularController schedularController =
//       Get.put(SchedularController());
//   final NewRegistrationController newRegistrationController =
//       Get.put(NewRegistrationController());
//
//   bool hasInternet = true;
//   bool isExpanded = false;
//
//   @override
//   void initState() {
//     checkInternetAndLoadData();
//
//     super.initState();
//   }
//
//   checkInternetAndLoadData() async {
//     List<ConnectivityResult> connectivityResult =
//         await Connectivity().checkConnectivity();
//     // setState(() {
//     hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
//         connectivityResult.contains(ConnectivityResult.wifi));
//     // });
//     schedularController.refreshUi();
//     if (hasInternet) {
//       await newRegistrationController
//           .viewPatientData(widget.patientData?.patientId);
//       await schedularController.getPatientStages(widget.patientData?.patientId);
//       await newRegistrationController
//           .getDocumentList(widget.patientData?.patientId);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const CustomText(
//           text: 'Patient History',
//           fontSize: 18.0,
//           fontFam: 'Lato',
//           fontWeight: FontWeight.w400,
//           textColor: Colors.black,
//           textAlign: TextAlign.start,
//         ),
//         leading: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: Image.asset('assets/arrow-left.png')),
//       ),
//       body: GetBuilder<SchedularController>(
//           init: schedularController,
//           builder: (controller) {
//             return schedularController.isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : Column(
//                     children: [
//                       PatientCardDetails(
//                         isExpand: (value) {
//                           isExpanded = value;
//                           setState(() {});
//                         },
//                         isExpanded: isExpanded,
//                         isFromAddPredialysis: true,
//                         refBy: widget.patientData?.refByName ?? "",
//                         schemaAdopted: newRegistrationController
//                                 .viewPatientModel?.data?.lookupDetIdPatientType
//                                 .toString() ??
//                             '',
//                         // patientDetailsModel: widget.preDialysisData,
//                         patientDetails:
//                             newRegistrationController.viewPatientModel,
//                       ).paddingSymmetric(vertical: 12),
//                       schedularController.patientStagesModel != [] &&
//                               schedularController.patientStagesModel != null
//                           ? Expanded(
//                               child: ListView.builder(
//                                 // shrinkWrap: true,
//                                 itemCount: schedularController
//                                     .patientStagesModel?.length,
//                                 itemBuilder: (context, index) {
//                                   NewStagesModel? stage = schedularController
//                                       .patientStagesModel?[index];
//
//                                   String? lookupDetValue =
//                                       stage?.lookupDetValue;
//                                   String? createdDateTime =
//                                       stage?.createdDateTime;
//                                   String? stageDescription =
//                                       stage?.stageDescription;
//
//                                   List<PatientTrackHistoryBean>?
//                                       patientTrackHistory = schedularController
//                                               .patientStagesModel?[index]
//                                               .patientTrackHistoryBean ??
//                                           [];
//
//                                   return IntrinsicHeight(
//                                     child: Row(
//                                       children: [
//                                         Column(
//                                           children: [
//                                             Container(
//                                               color: AppColor.secondaryColor,
//                                               width: 1,
//                                               height: 20,
//                                               padding: EdgeInsets.zero,
//                                             ),
//                                             Transform.scale(
//                                               scale: 1.2,
//                                               // Adjust scale to crop the icon as needed
//                                               child: Icon(
//                                                 Icons.radio_button_checked,
//                                                 size: 22,
//                                                 color: AppColor.secondaryColor,
//                                               ),
//                                             ),
//                                             Flexible(
//                                               child: Container(
//                                                   color:
//                                                       AppColor.secondaryColor,
//                                                   width: 1),
//                                             )
//                                           ],
//                                         ),
//                                         Expanded(
//                                           child: Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 8, horizontal: 10),
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.black
//                                                       .withValues(alpha: 0.1),
//                                                   spreadRadius: 2,
//                                                   blurRadius: 4,
//                                                   offset: const Offset(0,
//                                                       0.5), // changes position of shadow
//                                                 ),
//                                               ],
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 if (stageDescription == 'PTR' ||
//                                                     stageDescription == 'RPT' ||
//                                                     stageDescription == 'STT')
//                                                   _buildStageButton(
//                                                       lookupDetValue,
//                                                       stageDescription,
//                                                       AppColor
//                                                           .primaryBackgroundColor,
//                                                       AppColor.secondaryColor),
//                                                 if (stageDescription == 'CNE')
//                                                   _buildNephrologistButton(),
//                                                 if (stageDescription == 'OTH')
//                                                   _buildExitButton(),
//                                                 if (stageDescription == 'AIRR' ||
//                                                     stageDescription ==
//                                                         'INVE' ||
//                                                     stageDescription == 'PTT')
//                                                   buildButton(),
//                                                 const SizedBox(height: 8),
//                                                 Column(
//                                                   children: patientTrackHistory
//                                                       .map<Widget>((history) {
//                                                     return _buildHistoryButton(
//                                                         createdDateTime,
//                                                         history,
//                                                         stage);
//                                                   }).toList(),
//                                                 ),
//                                                 Align(
//                                                     alignment:
//                                                         Alignment.centerRight,
//                                                     child: Text(
//                                                       createdDateTime ?? '',
//                                                       style: const TextStyle(
//                                                           color: Colors.grey),
//                                                       textAlign:
//                                                           TextAlign.right,
//                                                     )),
//                                               ],
//                                             ),
//                                           ).paddingSymmetric(
//                                               vertical: 10, horizontal: 10),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                             )
//                           : Container(),
//                     ],
//                   );
//           }),
//     );
//   }
//
//   Widget _buildStageButton(String? lookupDetValue, String? stageDescription,
//       Color firstColor, Color secondColor) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: () {},
//           child: Container(
//             alignment: Alignment.center,
//             width: 140,
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               gradient: LinearGradient(
//                 colors: [
//                   firstColor,
//                   secondColor,
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: CustomText(
//               text: lookupDetValue ?? '',
//               fontSize: 14,
//               fontFam: "Lato",
//               fontWeight: FontWeight.normal,
//               textColor: Colors.white,
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ).paddingSymmetric(vertical: 4),
//         InkWell(
//           onTap: () {
//             Get.to(CaseHistoryTable(
//                 l1: List.generate(
//                     newRegistrationController.viewDocument?.obj?.length ?? 0,
//                     (index) => (index + 1).toString()), // Sr. No.
//                 l2: newRegistrationController.viewDocument?.obj
//                         ?.map((doc) => doc[3])
//                         .toList() ??
//                     [], // Document Name
//                 tableHeader: const ["Sr. No", "Document Name", "Actions"],
//                 lastColumnWidgets: List.generate(
//                   newRegistrationController.viewDocument?.obj?.length ?? 0,
//                   (index) => TextButton(
//                       onPressed: () {
//                         ApiConstants.imageBaseUrl +
//                             newRegistrationController.viewDocument?.obj?[index]
//                                 [0];
//                         Get.to(CustomViewer(
//                           fileUrl: ApiConstants.imageBaseUrl +
//                               newRegistrationController
//                                   .viewDocument?.obj?[index][0],
//                         ));
//                       },
//                       child: const Text("View")),
//                 )));
//           },
//           child: Container(
//             alignment: Alignment.center,
//             width: 140,
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               gradient: LinearGradient(
//                 colors: [
//                   firstColor,
//                   secondColor,
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: const CustomText(
//               text: 'Case History',
//               fontSize: 14,
//               fontFam: "Lato",
//               fontWeight: FontWeight.normal,
//               textColor: Colors.white,
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ).paddingSymmetric(vertical: 4),
//       ],
//     );
//   }
//
//   Widget _buildNephrologistButton() {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.green,
//       ),
//       onPressed: () {
//         // Action for Nephrologist's Comment
//       },
//       child: const Text("Nephrologist's Comment"),
//     );
//   }
//
//   Widget _buildExitButton() {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.white,
//         backgroundColor: AppColor.red,
//       ),
//       onPressed: () {
//         // Action for Patient Exits
//       },
//       child: const Text("Patient Exits"),
//     );
//   }
//
//   Widget buildButton() {
//     return Container(
//       alignment: Alignment.center,
//       width: 140,
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         gradient: LinearGradient(
//           colors: [
//             AppColor.primaryBackgroundColor,
//             AppColor.secondaryColor,
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: const CustomText(
//         text: "Dialysis Details",
//         fontSize: 14,
//         fontFam: "Lato",
//         fontWeight: FontWeight.normal,
//         textColor: Colors.white,
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
//
//   Widget _buildHistoryButton(String? createdDateTime,
//       PatientTrackHistoryBean? patientDet, NewStagesModel? stage) {
//     String? text;
//     Color? firstColor;
//     Color? secondColor;
//
//     switch (patientDet?.lookupDetValue) {
//       case 'APC':
//         text = "Appointment Cancelled";
//         firstColor = AppColor.red;
//         secondColor = AppColor.red;
//         break;
//       case 'EVE':
//         text = "Event";
//         firstColor = AppColor.red;
//         secondColor = AppColor.red;
//         break;
//       case 'DCD':
//         text = "Dietician Consultation Done";
//         firstColor = Colors.green;
//         secondColor = Colors.green;
//         break;
//       case 'CNE':
//         text = "Nephrologist's Comment";
//         firstColor = Colors.green;
//         secondColor = Colors.green;
//         break;
//       case 'PTA':
//         text = "Patient Absent";
//         firstColor = AppColor.red;
//         secondColor = AppColor.red;
//         break;
//       case 'BED':
//         text = "Dialysis Details";
//         firstColor = AppColor.primaryBackgroundColor;
//         secondColor = AppColor.secondaryColor;
//         break;
//     }
//
//     if (text != null && firstColor != null && secondColor != null) {
//       return InkWell(
//         onTap: () {
//           if (text == "Dialysis Details") {
//             Get.to(DialysisQueue(
//                 treatmentId: stage?.treatmentId, patientId: stage?.patientId));
//           }
//         },
//         child: Container(
//           alignment: Alignment.center,
//           width: 140,
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             gradient: LinearGradient(
//               colors: [
//                 firstColor,
//                 secondColor,
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: CustomText(
//             text: text,
//             fontSize: 14,
//             fontFam: "Lato",
//             fontWeight: FontWeight.normal,
//             textColor: Colors.white,
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ).paddingSymmetric(vertical: 4);
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
// }
//
// class CaseHistoryTable extends StatefulWidget {
//   final List<String> l1;
//   final List<dynamic> l2;
//   final List<Widget>? lastColumnWidgets;
//   final List<String> tableHeader;
//   final Function(int index)? onButtonPressed;
//
//   const CaseHistoryTable(
//       {super.key,
//       required this.l1,
//       required this.l2,
//       required this.tableHeader,
//       this.lastColumnWidgets,
//       this.onButtonPressed});
//
//   @override
//   State<CaseHistoryTable> createState() => _CaseHistoryTableState();
// }
//
// class _CaseHistoryTableState extends State<CaseHistoryTable> {
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     shwProgressIndicator();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const CustomText(
//           text: 'Case History',
//           fontSize: 18.0,
//           fontFam: 'Lato',
//           fontWeight: FontWeight.w400,
//           textColor: Colors.black,
//           textAlign: TextAlign.start,
//         ),
//         leading: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: Image.asset('assets/arrow-left.png')),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: Table(
//                   defaultColumnWidth: const IntrinsicColumnWidth(),
//                   children: [
//                     widget.l1.isNotEmpty
//                         ? _buildRoundedTableRow(widget.tableHeader)
//                         : TableRow(children: [
//                             const CustomText(
//                               text: "Data Not available",
//                               fontSize: 16,
//                               textColor: Colors.black,
//                               textAlign: TextAlign.center,
//                               fontFam: "Lato",
//                               fontWeight: FontWeight.normal,
//                             ).paddingOnly(left: 8, bottom: 4)
//                           ]),
//                     for (int i = 0; i < widget.l1.length; i++)
//                       widget.l1.isNotEmpty
//                           // ? _buildTableRow([widget.l1[i], widget.l2[i], widget.l3[i],widget.lastColumnWidgets[i]])
//                           ? _buildTableRow(i)
//                           : TableRow(children: [
//                               const CustomText(
//                                 text: "",
//                                 fontSize: 2.0,
//                                 textColor: Colors.black,
//                                 textAlign: TextAlign.start,
//                                 fontWeight: FontWeight.normal,
//                                 fontFam: 'Lato',
//                               ).paddingOnly(left: 8, bottom: 4)
//                             ]),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
//
//   shwProgressIndicator() async {
//     await Future.delayed(const Duration(seconds: 0));
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   TableRow _buildRoundedTableRow(List<String> data) {
//     return TableRow(
//       children: List.generate(
//         data.length,
//         (index) => TableCell(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               // Background color of the first row
//               borderRadius: BorderRadius.only(
//                 topLeft: index == 0 ? const Radius.circular(10.0) : Radius.zero,
//                 topRight: index == data.length - 1
//                     ? const Radius.circular(10.0)
//                     : Radius.zero,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 data[index],
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   color: Colors.black,
//                 ), // Text color
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   TableRow _buildTableRow(int index) {
//     return TableRow(
//       children: List.generate(
//         widget.tableHeader.length,
//         (i) => TableCell(
//           verticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 2),
//             child: Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
//               decoration: BoxDecoration(
//                 border: Border.all(color: const Color(0xFFE0E0E0)),
//               ),
//               child: i == (widget.tableHeader.length - 1)
//                   ? GestureDetector(
//                       onTap: () {
//                         // Trigger the callback with the index
//                         if (widget.onButtonPressed != null) {
//                           widget.onButtonPressed!(index);
//                         }
//                       },
//                       child: widget.lastColumnWidgets?[index] ??
//                           Container(), // Use widget directly
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Flexible(
//                           child: Text(
//                             [
//                               widget.l1[index],
//                               widget.l2[index],
//                             ][i]
//                                 .toString(),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           ),
//         ),
//       ),
//       // decoration: BoxDecoration(color: getColor(isPastDate)
//       // ),
//     );
//   }
// }
