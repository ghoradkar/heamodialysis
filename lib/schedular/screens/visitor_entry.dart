import 'dart:io';

import 'package:camera/camera.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/capture_photo/screen/capture_photo.dart';
import 'package:heamodialysis/capture_photo/controller/capture_photo_controller.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/model/schema_adopted/schema_data.dart';
import 'package:heamodialysis/new_registration/screens/upload_document_tab.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screens/add_edit_ro_desinfec_details.dart';
import 'package:heamodialysis/schedular/schedular_controller/schedular_controller.dart';
import 'package:heamodialysis/schedular/screens/book_bed.dart';
import 'package:heamodialysis/schedular/screens/schedular_list.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';

class VisitorEntry extends StatefulWidget {
  final PatientData? patientData;
  final int? slot;

  const VisitorEntry({super.key, this.patientData, this.slot});

  @override
  State<VisitorEntry> createState() => _VisitorEntryState();
}

class _VisitorEntryState extends State<VisitorEntry> {
  File? image;
  final CapturePhotoController capturePhotoController =
  Get.put(CapturePhotoController());

  String? pickedTime;

  String? selectedCurrentDiaSession;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool hasInternet = true;
  final SchedularController schedularController =
  Get.put(SchedularController());

  var userData;

  String? formattedFromDate;

  DateTime? selectedFromDate;

  // SchemaData? scheme;

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    checkInternetAndLoadData();
    super.initState();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint(userData['ui'].toString());
    schedularController.oxygenSupply?.isSelected = false;
    schedularController.fuelAvailable?.isSelected = false;
    schedularController.uploadImage.isSelected = false;
    schedularController.uploadImage.file = null;
    schedularController.uploadImage.docName = null;
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    schedularController.refreshUi();
    if (hasInternet) {
      //date
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yyyy').format(now);
      schedularController.visitDateController.text = formattedDate;

      // time
      String formattedTime1 = DateFormat('HH:mm:ss').format(now);
      String formattedTime = DateFormat('hh:mm a').format(now);

      schedularController.visitTimeController.text = formattedTime;
      schedularController.visitorTime = formattedTime1;

      await schedularController.visitPatientDetails(widget.patientData);
      await schedularController.getSchemaAdoptedList();
      await schedularController.getVisitorEntryData(
          widget.patientData!.patientId!, widget.patientData!.treatmentId!);
      //old code
      // schedularController.selectedSchemeObj =
      //     schedularController.schemaAdoptedModel?.data!.firstWhere(
      //         (e) =>
      //             e.lookupDetId ==
      //             schedularController
      //                 .visitPatientDetalis?.data?.lookupDetIdPatientType,
      //         orElse: () => SchemaData());
      // selectedCurrentDiaSession =
      //     schedularController.selectedSchemeObj?.lookupDetDescEn;
      // schedularController.lastDiaSession.text =
      //     schedularController.selectedSchemeObj?.lookupDetDescEn ?? '';
      //
      // schedularController.abhaId.text = widget.patientData?.abhaNo ?? "";
      //
      // schedularController.enrollNo.text =
      //     schedularController.visitPatientDetalis?.data?.mjpjayenrollmentNo ??
      //         "";
      // schedularController.preAuthApprovalDateController.text =
      //     schedularController.visitPatientDetalis?.data?.preAuthapdate ?? "";
      // schedularController.caseNumber.text =
      //     schedularController.visitPatientDetalis?.data?.mjpjaycaseNumber ?? "";
      // schedularController.claimNumber.text =
      //     schedularController.visitPatientDetalis?.data?.mjpjayclaimNumber ??
      //         "";
      // schedularController.ipNumber.text =
      //     schedularController.visitPatientDetalis?.data?.mjpjayIPNumber ?? "";

      if (schedularController.visitorEntryData?.packageMasterData != null) {
        schedularController.selectedSchemeObj =
            schedularController.schemaAdoptedModel?.data!.firstWhere(
                    (e) =>
                e.lookupDetDescEn ==
                    "MJPJAY(Mahatma Jyotirao Phule Jan Arogya Yojana )",
                orElse: () => SchemaData());
      } else {
        schedularController.selectedSchemeObj = schedularController
            .schemaAdoptedModel?.data!
            .firstWhere((e) => e.lookupDetDescEn == "Non MJPJAY",
            orElse: () => SchemaData());

        schedularController.selectedSchemeObj;
      }

      selectedCurrentDiaSession =
          schedularController.selectedSchemeObj?.lookupDetDescEn;

      schedularController.lastDiaSession.text =
          schedularController.visitorEntryData?.previousScheme?[0] ?? '';

      schedularController.abhaId.text =
          schedularController.visitorEntryData?.abhaNo ?? "";

      if (schedularController.visitorEntryData?.packageMasterData != null) {
        schedularController.mjpjayPackageMasterId =
        schedularController.visitorEntryData?.packageMasterData?[0];
        schedularController.enrollNo.text =
            schedularController.visitorEntryData?.packageMasterData?[1] ?? "";
        schedularController.preAuthApprovalDateController.text =
            schedularController.visitorEntryData?.packageMasterData?[2] ?? "";
        schedularController.preAuthNumber.text =
            schedularController.visitorEntryData?.packageMasterData?[3] ?? "";

        schedularController.caseNumber.text =
            "${schedularController.visitorEntryData?.packageMasterData?[3]} - ${schedularController.visitorEntryData?.packageMasterData?[4]}" ??
                "";
        schedularController.claimNumber.text =
            schedularController.visitPatientDetalis?.data?.mjpjayclaimNumber ??
                "";
        schedularController.ipNumber.text =
            schedularController.visitPatientDetalis?.data?.mjpjayIPNumber ?? "";

        schedularController.sessionCount.text =
            schedularController.visitorEntryData?.sessionCount.toString() ?? "";
      }

      await schedularController.getDocumentId();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Visitor Entry',
          fontSize: 18.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.off(const SchedularListScreen());
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body: GetBuilder<SchedularController>(
          init: SchedularController(),
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                ? const VisitorEntryShimmer()
                : SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: image == null
                            ? const AssetImage(
                            "assets/profile-placeholder.png")
                            : FileImage(image!),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColor.primaryBackgroundColor,
                                AppColor.secondaryColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 15,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _pickImageFromDevice();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColor.primaryBackgroundColor,
                                AppColor.secondaryColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 15,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              // final cameras = await availableCameras();
                              //
                              // final frontCamera = cameras.firstWhere(
                              //   (camera) =>
                              //       camera.lensDirection ==
                              //       CameraLensDirection.front,
                              // );
                              // Get.to(() => CapturePhoto(
                              //       camera: frontCamera,
                              //       callBack: () {
                              //         pickImageFromCamera();
                              //       },
                              //     ));

                              // Get the list of available cameras
                              final cameras =
                              await availableCameras();

                              // Optionally select a default camera (e.g., front camera)
                              final defaultCamera =
                              cameras.firstWhere(
                                    (camera) =>
                                camera.lensDirection ==
                                    CameraLensDirection.front,
                              );

                              // Navigate to the CapturePhoto screen, passing the list of cameras
                              Get.to(() => CapturePhoto(
                                cameras: cameras,
                                // Pass all available cameras
                                camera: defaultCamera,
                                // Initial camera (front)
                                callBack: () {
                                  pickImageFromCamera();
                                },
                              ));
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: AppColor.borderColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8.h,
                          ),
                          CustomDateField(
                            labelText: 'Visit Date',
                            hint: 'Select',
                            isRequired: true,
                            callB: () {},
                            selectedDate:
                            controller.visitDateController,
                            filledColor: Colors.white,
                            dontDhowPrefix: false,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          CustomDateField(
                            labelText: 'Visit Time',
                            hint: 'Select',
                            isRequired: true,
                            callB: () {
                              selectTime(context);
                            },
                            selectedDate:
                            controller.visitTimeController,
                            filledColor: Colors.white,
                            dontDhowPrefix: false,
                          ),
                          SizedBox(height: 8.h),
                          CustomTextField(
                              fontSize: 16.sp,
                              maxLines: 1,
                              isReadOnly: true,
                              keyBoardType: TextInputType.name,
                              labelText:
                              'Last Dialysis Session Under The Scheme',
                              hintText: 'Select',
                              isRequired: false,
                              txtController:
                              controller.lastDiaSession,
                              fillColor: Colors.white),
                          SizedBox(height: 8.h),
                          MyCustomDropdown(
                              selectedItem: selectedCurrentDiaSession,
                              labelText:
                              'Current Dialysis Session Under The Scheme',
                              items: controller
                                  .schemaAdoptedModel?.data
                                  ?.map((e) => e.lookupDetDescEn)
                                  .toList() ??
                                  [],
                              hint: 'Select',
                              isRequired: false,
                              senValue: (value) {
                                selectedCurrentDiaSession = value;
                                schedularController
                                    .selectedSchemeObj =
                                    controller
                                        .schemaAdoptedModel?.data
                                        ?.firstWhere((e) =>
                                    e.lookupDetDescEn ==
                                        value);
                                controller.refreshUi();
                              },
                              filledColor: Colors.white),
                          if (schedularController.visitorEntryData
                              ?.pendingData?[1] !=
                              null &&
                              schedularController.visitorEntryData
                                  ?.pendingData?[0] ==
                                  null)
                            CustomText(
                                text:
                                "Pending Session ${schedularController.visitorEntryData?.pendingData?[1] ?? "NA"}",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                textColor: AppColor.red,
                                textAlign: TextAlign.start)
                                .paddingSymmetric(horizontal: 8),
                          SizedBox(height: 8.h),
                          if (schedularController.visitorEntryData
                              ?.pendingData?[0] !=
                              null &&
                              schedularController.visitorEntryData
                                  ?.pendingData?[1] !=
                                  null)
                            CustomText(
                                text:
                                "Effective Date ${schedularController.visitorEntryData?.pendingData?[0]} and Pending Session ${schedularController.visitorEntryData?.pendingData?[1]}",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                textColor: AppColor.red,
                                textAlign: TextAlign.start)
                                .paddingSymmetric(horizontal: 8.w),
                          SizedBox(height: 8.h),
                          Visibility(
                            visible: selectedCurrentDiaSession ==
                                'Non MJPJAY',
                            child: CustomTextField(
                                mazLenght: 500,
                                maxLines: 1,
                                fontSize: 16.sp,
                                isReadOnly: false,
                                keyBoardType: TextInputType.text,
                                labelText:
                                'Reason for not registered on MJPJAY',
                                hintText: 'Enter',
                                isRequired: true,
                                txtController: controller.reason,
                                fillColor: Colors.white),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextField(
                              maxLines: 1,
                              fontSize: 16.sp,
                              isReadOnly: true,
                              keyBoardType: TextInputType.name,
                              labelText: 'ABHA No',
                              hintText: 'Select',
                              isRequired: false,
                              txtController: controller.abhaId,
                              fillColor: Colors.white),
                          // Visibility(
                          //   // visible: selectedCurrentDiaSession ==
                          //   //     "MJPJAY(Mahatma Jyotirao Phule Jan Arogya Yojana)",
                          //   visible: schedularController
                          //           .visitorEntryData
                          //           ?.packageMasterData !=
                          //       null,
                          //   child: Column(
                          //     children: [
                          //       SizedBox(height: 8.h),
                          //       CustomTextField(
                          //           fontSize: 16.sp,
                          //           maxLines: 1,
                          //           isReadOnly: true,
                          //           keyBoardType: TextInputType.name,
                          //           labelText: 'MJPJAY Enrollment Id',
                          //           hintText: 'Enter',
                          //           isRequired: false,
                          //           txtController:
                          //               controller.enrollNo,
                          //           fillColor: Colors.white),
                          //       SizedBox(height: 8.h),
                          //       CustomDateField(
                          //         labelText: 'Pre Auth Approval Date',
                          //         hint: 'Select',
                          //         isRequired: true,
                          //         callB: () {
                          //           // selectFromDate();
                          //         },
                          //         selectedDate: controller
                          //             .preAuthApprovalDateController,
                          //         filledColor: Colors.white,
                          //         dontDhowPrefix: false,
                          //       ),
                          //       SizedBox(height: 8.h),
                          //       CustomTextField(
                          //           fontSize: 16.sp,
                          //           maxLines: 1,
                          //           isReadOnly: true,
                          //           keyBoardType: TextInputType.text,
                          //           labelText: 'Pre Auth Number',
                          //           hintText: 'Enter',
                          //           isRequired: false,
                          //           txtController:
                          //               controller.preAuthNumber,
                          //           fillColor: Colors.white),
                          //       SizedBox(height: 8.h),
                          //       CustomTextField(
                          //           fontSize: 16.sp,
                          //           maxLines: 1,
                          //           // mazLenght: 4,
                          //           isReadOnly: true,
                          //           keyBoardType: TextInputType.text,
                          //           labelText: 'MJPJAY Case Number',
                          //           hintText: 'Enter',
                          //           isRequired: false,
                          //           txtController:
                          //               controller.caseNumber,
                          //           fillColor: Colors.white),
                          //       SizedBox(height: 8.h),
                          //       CustomTextField(
                          //           fontSize: 16.sp,
                          //           maxLines: 1,
                          //           // mazLenght: 4,
                          //           isReadOnly: false,
                          //           keyBoardType: TextInputType.text,
                          //           labelText: 'MJPJAY Claim Number',
                          //           hintText: 'Enter',
                          //           isRequired: false,
                          //           txtController:
                          //               controller.claimNumber,
                          //           fillColor: Colors.white),
                          //       SizedBox(height: 8.h),
                          //       CustomTextField(
                          //           fontSize: 16.sp,
                          //           maxLines: 1,
                          //           isReadOnly: false,
                          //           // mazLenght: 4,
                          //           keyBoardType:
                          //               TextInputType.number,
                          //           labelText: 'IP Number',
                          //           hintText: 'Enter',
                          //           isRequired: false,
                          //           txtController:
                          //               controller.ipNumber,
                          //           fillColor: Colors.white),
                          //       SizedBox(height: 8.h),
                          //       CustomTextField(
                          //           fontSize: 16.sp,
                          //           maxLines: 1,
                          //           isReadOnly: true,
                          //           // mazLenght: 4,
                          //           keyBoardType:
                          //               TextInputType.number,
                          //           labelText:
                          //               'Session CountPackage Wise',
                          //           hintText: '',
                          //           isRequired: false,
                          //           txtController:
                          //               controller.sessionCount,
                          //           fillColor: Colors.white),
                          //       SizedBox(height: 8.h),
                          //     ],
                          //   ),
                          // ),
                          Row(
                            children: [
                              Checkbox(
                                activeColor:
                                AppColor.primaryBackgroundColor,
                                value: controller
                                    .oxygenSupply?.isSelected,
                                // Boolean value for checkbox state
                                onChanged: (bool? newValue) {
                                  controller.oxygenSupply
                                      ?.isSelected = newValue;
                                  setState(() {});
                                },
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: controller.oxygenSupply
                                            ?.checkTitle ??
                                            "", // Main text
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                        " *", // Asterisk with red color
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: AppColor.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                activeColor:
                                AppColor.primaryBackgroundColor,
                                value: controller
                                    .fuelAvailable?.isSelected,
                                // Boolean value for checkbox state
                                onChanged: (bool? newValue) {
                                  controller.fuelAvailable
                                      ?.isSelected = newValue;
                                  setState(() {});
                                },
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: controller.fuelAvailable
                                            ?.checkTitle ??
                                            "", // Main text
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                        " *", // Asterisk with red color
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: AppColor.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: selectedCurrentDiaSession !=
                                "MJPJAY(Mahatma Jyotirao Phule Jan Arogya Yojana )",
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor:
                                  AppColor.primaryBackgroundColor,
                                  value: controller
                                      .ironSucrose?.isSelected,
                                  // Boolean value for checkbox state
                                  onChanged: (bool? newValue) {
                                    controller.ironSucrose
                                        ?.isSelected = newValue;
                                    setState(() {});
                                  },
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: controller.ironSucrose
                                              ?.checkTitle ??
                                              "", // Main text
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: selectedCurrentDiaSession !=
                                "MJPJAY(Mahatma Jyotirao Phule Jan Arogya Yojana )",
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor:
                                  AppColor.primaryBackgroundColor,
                                  value: controller.eop?.isSelected,
                                  // Boolean value for checkbox state
                                  onChanged: (bool? newValue) {
                                    controller.eop?.isSelected =
                                        newValue;
                                    setState(() {});
                                  },
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: controller
                                              .eop?.checkTitle ??
                                              "", // Main text
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: selectedCurrentDiaSession !=
                                "MJPJAY(Mahatma Jyotirao Phule Jan Arogya Yojana )",
                            child: UploadDocumentVisitorEntry(
                              fileData: controller.uploadImage,
                              onFilePick: () {
                                pickFile(
                                    controller.uploadImage, false);
                              },
                              onFileDelete: () {
                                controller.uploadImage.isSelected =
                                false;
                                controller.uploadImage.file = null;
                                setState(() {});
                              },
                              imgNameCallBack: (value) {
                                controller.uploadImage.docName =
                                    value;
                              },
                              isViewPatient: false,
                            ).paddingOnly(top: 4.h, bottom: 12.h),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                primColor:
                                AppColor.primaryBackgroundColor,
                                secColor: AppColor.secondaryColor,
                                textColor: Colors.white,
                                iconColor: Colors.white,
                                buttonText: 'Save & Next',
                                path: 'assets/save-next.png',
                                callB: () async {
                                  DateTime parsedDate =
                                  DateFormat("dd-MM-yyyy").parse(
                                      controller
                                          .visitDateController
                                          .text);

                                  String visitorDate =
                                  DateFormat("yyyy-MM-dd")
                                      .format(parsedDate);

                                  if (formKey.currentState
                                      ?.validate() ??
                                      false) {
                                    if (controller.oxygenSupply
                                        ?.isSelected ==
                                        true &&
                                        controller.fuelAvailable
                                            ?.isSelected ==
                                            true) {
                                      Get.to(BookBedScreen(
                                        patientData:
                                        widget.patientData,
                                        slot: widget.slot,
                                        visitorDate: visitorDate,
                                        isIronSelected: controller
                                            .ironSucrose?.isSelected,
                                        isEpoSelected: controller
                                            .eop?.isSelected,
                                      ));
                                    } else {
                                      CustomMessage.toast(
                                          "Please select checkbox");
                                    }
                                  }
                                },
                                buttonWidth: 140.w,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              CustomButton(
                                buttonText: 'Cancel',
                                path: 'assets/cancel.png',
                                callB: () {
                                  Get.back();
                                },
                                buttonWidth: 100.w,
                                primColor: AppColor.red,
                                secColor: AppColor.red,
                                textColor: Colors.white,
                                iconColor: Colors.white,
                              )
                            ],
                          ).paddingOnly(bottom: 8.h)
                        ],
                      ),
                    ).paddingSymmetric(
                        vertical: 10.h, horizontal: 10.w)
                  ],
                ),
              ),
            )
                : InternetIssue(
              onRetryPressed: () {
                checkInternetAndLoadData();
              },
            );
          }),
    );
  }

  Future<void> pickFile(ROFileDetails uploadedFile, isEdit) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String extension = file.path.split('.').last.toLowerCase();
      int fileSizeInBytes = await file.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (['jpg', 'jpeg', 'png'].contains(extension) && fileSizeInMB > 10) {
        debugPrint('Image should not exceed 10 MB.');
        return;
      }

      setState(() {
        // FileDetails uploadedFile =
        //     newRegistrationController.items.firstWhere((e) => e.key == key);
        uploadedFile.file = file;
        uploadedFile.isSelected = true;
        if (isEdit == false) {
          uploadedFile.ids = "0";
        }
      });

      debugPrint(schedularController.uploadImage.docName);
    } else {
      debugPrint('No file selected.');
    }
  }

  Future<void> _pickImageFromDevice() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      image = File(result.files.single.path!);

      setState(() {});
    } else {
      debugPrint('No image selected.');
    }
  }

  pickImageFromCamera() {
    if (capturePhotoController.userProfilePhoto.file != null) {
      image = File(capturePhotoController.userProfilePhoto.file!.path);
      setState(() {});
    }
  }

  selectFromDate() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != selectedFromDate) {
      // setState(() {
      selectedFromDate = picked;
      // DateFormat formatter = DateFormat('yyyy-MM-dd');
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      formattedFromDate = formatter.format(selectedFromDate!);
      schedularController.preAuthApprovalDateController.text =
      formattedFromDate!;
      setState(() {});
      // calculateAge(formattedDateDBO);
      // });
      // newRegistrationController.refreshUi();
    }
  }

  selectTime(context) async {
    pickedTime = await DatePickerHelper.selectTime(context);

    if (pickedTime != null) {
      DateTime time = DateFormat('HH:mm').parse(pickedTime!);

      String formattedTime1 = DateFormat('HH:mm:ss').format(time);
      String formattedTime = DateFormat('hh:mm a').format(time);
      schedularController.visitTimeController.text = formattedTime;
      schedularController.visitorTime = formattedTime1;
      setState(() {});
    }
  }
}

class UploadDocumentVisitorEntry extends StatelessWidget {
  final ROFileDetails fileData;
  final Function(String)? imgNameCallBack;
  final Function onFilePick;
  final Function onFileDelete;
  final bool isViewPatient;

  const UploadDocumentVisitorEntry(
      {super.key,
        required this.fileData,
        this.imgNameCallBack,
        required this.onFilePick,
        required this.onFileDelete,
        required this.isViewPatient});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
                text: "Upload Document",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                textColor: Colors.black,
                textAlign: TextAlign.start),
          ).paddingOnly(bottom: 2.h),
          CustomUploadButton(
            isSelected: fileData.isSelected,
            index: 0,
            title: fileData.name,
            callB: () {
              // pickFile(newRegistrationController
              //     .relativeDoc.key);
              onFilePick();
            },
            callDelete: () {
              onFileDelete();

              // fileData.isSelected = false;
              // fileData.file =
              //  null;
              //  setState(() {});
            },
            viewCallBack: () {
              Get.to(() => CustomViewer(
                fileUrl: fileData.file!.path,
              ));
              // }
            },
            isReq: fileData.isReq,
            isViewProfile: isViewPatient,
            showIndex: false,
          ).paddingOnly(bottom: 8.h, left: 5.w, right: 5.w),
        ],
      ),
    ).paddingSymmetric(vertical: 2.h, horizontal: 10.w);
  }
}
