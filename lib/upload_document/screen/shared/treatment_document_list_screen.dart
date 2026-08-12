import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:heamodialysis/dashboard/screen/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/dialysis_queue/hd_chart/hd_chart_controller.dart';
import 'package:heamodialysis/upload_document/controller/document_list_controller.dart';
import 'package:heamodialysis/upload_document/model/document_search_request_model.dart';
import 'package:heamodialysis/upload_document/model/patient_document_model.dart';
import 'package:heamodialysis/upload_document/screen/shared/document_capture_photo_screen.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/status_update_screen.dart';
import '../../../widgets/custom_shimmer_loader.dart';

class TreatmentDocumentListScreen<T extends DocumentListController>
    extends StatefulWidget {
  final String title;
  final T controller;
  final String uploadApiPath;
  final String documentLabel;

  const TreatmentDocumentListScreen({
    super.key,
    required this.title,
    required this.controller,
    required this.uploadApiPath,
    required this.documentLabel,
  });

  @override
  State<TreatmentDocumentListScreen<T>> createState() =>
      _TreatmentDocumentListScreenState<T>();
}

class _TreatmentDocumentListScreenState<T extends DocumentListController>
    extends State<TreatmentDocumentListScreen<T>> {
  final HdChartController hdChartController = Get.put(HdChartController());
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool hasInternet = true;

  static const List<String> _searchTypeOptions = ['Patient ID', 'Treatment ID'];

  String? dropDownValue;
  String fromDate = '';
  String toDate = '';
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  DocumentSearchRequestModel? _lastSearchRequest;

  String _searchTypeApiValue(String? label) {
    switch (label) {
      case 'Treatment ID':
        return 'TreatmentID';
      case 'Patient ID':
      default:
        return 'PatientID';
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    checkInternetAndLoadData();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();
    setState(() {
      hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi));
    });
    widget.controller.update();
    if (hasInternet) {}
  }

  Future<void> getUserData() async {
    hdChartController.userData =
    await SharedPref().read(const SharedPrefConstant().kUserData);
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
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable
        ? Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackgroundColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
          ),
        ),
        title: CustomText(
          text: widget.title,
          fontSize: 18.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.white,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.off(const InstituteWiseDashboardScreen());
            },
            child: Image.asset(
              'assets/arrow-left.png',
              color: Colors.white,
            )),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (context, setModalState) {
                      return Container(
                        margin: EdgeInsets.only(
                            bottom:
                            MediaQuery
                                .of(context)
                                .viewInsets
                                .bottom),
                        padding: EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 10.w),
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Search",
                                  fontSize: 16.sp,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start,
                                ).paddingSymmetric(vertical: 4.h),
                                InkWell(
                                  onTap: () {
                                    setModalState(() {
                                      dropDownValue = null;
                                    });
                                    hdChartController.valueController
                                        .clear();
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    "assets/cancel.png",
                                    width: 24.w,
                                    height: 24.h,
                                    color:
                                    AppColor.primaryBackgroundColor,
                                  ),
                                ),
                              ],
                            ),

                            // Search By
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Type",
                                  fontSize: 16.sp,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.normal,
                                  textColor: const Color(0xff515151),
                                  textAlign: TextAlign.start,
                                ).paddingOnly(top: 10.h, bottom: 4.h),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFE1E1E1)),
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: dropDownValue,
                                    hint: const Text("select"),
                                    onChanged: (String? newValue) {
                                      setModalState(() {
                                        dropDownValue = newValue;
                                      });
                                    },
                                    items: _searchTypeOptions
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                    underline: const SizedBox(),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color:
                                      AppColor.primaryBackgroundColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Value field
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                text: "Value",
                                fontSize: 16.sp,
                                fontFam: "Lato",
                                fontWeight: FontWeight.normal,
                                textColor: const Color(0xff515151),
                                textAlign: TextAlign.start,
                              ),
                            ).paddingOnly(top: 10.h, bottom: 4.h),

                            TextField(
                              controller:
                              hdChartController.valueController,
                              decoration: const InputDecoration(
                                labelText:
                                'Patient Id, name, mobile no etc.',
                                labelStyle:
                                TextStyle(color: Color(0xFFE1E1E1)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFE1E1E1)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFE1E1E1)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDateField(
                                    selectedDate: fromDateController,
                                    labelText: "From Date",
                                    hint: "From Date",
                                    isRequired: false,
                                    callB: () async {
                                      await selectFrom();
                                      setModalState(() {});
                                    },
                                    filledColor: Colors.white54,
                                    dontDhowPrefix: false,
                                    isViewProfile: false,
                                  ),
                                ),
                                Expanded(
                                  child: CustomDateField(
                                      selectedDate: toDateController,
                                      labelText: "To Date",
                                      hint: "To Date",
                                      isRequired: false,
                                      callB: () async {
                                        await selectTo();
                                        setModalState(() {});
                                      },
                                      filledColor: Colors.white54,
                                      dontDhowPrefix: false,
                                      isViewProfile: false),
                                ),
                              ],
                            ),

                            // Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Cancel
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      setModalState(() {
                                        dropDownValue = null;
                                      });
                                      hdChartController.valueController
                                          .clear();
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.h),
                                      alignment: Alignment.center,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: AppColor.red,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              "assets/cancel.png"),
                                          CustomText(
                                            text: "Cancel",
                                            fontSize: 16.sp,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.normal,
                                            textColor: Colors.white,
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ).paddingOnly(top: 20.h),

                                SizedBox(width: 14.w),

                                // Search
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () async {
                                      final bool hasDateRange =
                                          fromDate.isNotEmpty ||
                                              toDate.isNotEmpty;
                                      final bool hasTypeAndValue =
                                          dropDownValue != null &&
                                              hdChartController
                                                  .valueController
                                                  .text
                                                  .isNotEmpty;
                                      if (hasDateRange && !hasTypeAndValue) {
                                        CustomMessage.toast(
                                            'Please select Type and enter value');
                                        return;
                                      }
                                      final request =
                                      DocumentSearchRequestModel(
                                        searchType: _searchTypeApiValue(
                                            dropDownValue),
                                        searchValue: hdChartController
                                            .valueController.text,
                                        fromDate: fromDate,
                                        toDate: toDate,
                                      );
                                      _lastSearchRequest = request;
                                      await widget.controller
                                          .fetchDocumentList(request);
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.h),
                                      alignment: Alignment.center,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColor
                                                .primaryBackgroundColor,
                                            AppColor.secondaryColor,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.search,
                                              color: Colors.white),
                                          CustomText(
                                            text: "Search",
                                            fontSize: 16.sp,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.normal,
                                            textColor: Colors.white,
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ).paddingOnly(top: 20.h),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Image.asset(
                "assets/filter-line.png",
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
        ],
      ),
      body: GetBuilder<T>(builder: (controller) {
        if (controller.isLoading) {
          return _buildScreenShimmer();
        }
        if (controller.documentList.isEmpty) {
          return CommonStatusScreen(
            title: "No Data Found",
            description:
            "We are unable to find the data that\nyou are looking for ",
            img: "assets/no_Data_Found.png",
            buttonText: "Go Back",
            onPressed: () {
              Get.back();
            },
          );
        }
        return Column(
          children: [
            _buildPatientCard(controller.documentList.first),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 12.h),
                itemCount: controller.documentList.length,
                itemBuilder: (context, index) {
                  return _buildDocumentCard(
                      controller.documentList[index]);
                },
              ),
            ),
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

  Widget _buildScreenShimmer() {
    return Column(
      children: [
        headerCard(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 12.h),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildDocumentCardShimmer();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentCardShimmer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 12.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 12.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 12.h,
                        width: 180.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 40.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientCard(PatientDocumentModel firstDocument) {
    return Container(
      margin: EdgeInsets.all(12.w),
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            AppColor.primaryBackgroundColor.withValues(alpha: 0.2),
            AppColor.secondaryColor.withValues(alpha: 0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.account_circle,
              color: Colors.grey,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _patientInfoRow(
                    'Patient ID', firstDocument.patientId.toString()),
                SizedBox(height: 6.h),
                _patientInfoRow('Patient Name', firstDocument.patientName),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _patientInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label : ',
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              color: AppColor.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(PatientDocumentModel doc) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Treatment Date : ',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '${doc.formattedTreatmentDate}   |   ',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.normal,
                              color: AppColor.grey,
                            ),
                          ),
                          TextSpan(
                            text: 'Treatment ID : ',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: doc.treatmentId.toString(),
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.normal,
                              color: AppColor.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    CustomText(
                      text: doc.isUploaded
                          ? 'File name : ${doc.fileName}'
                          : 'Not uploaded yet',
                      fontSize: 13.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.normal,
                      textColor: AppColor.grey,
                      textAlign: TextAlign.start,
                    ),
                    if (doc.isUploaded) ...[
                      SizedBox(height: 4.h),
                      CustomText(
                        text: 'Uploaded on : ${doc.formattedUploadDateTime}',
                        fontSize: 12.sp,
                        fontFam: 'Lato',
                        fontWeight: FontWeight.normal,
                        textColor: AppColor.grey,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            _buildDocumentActions(doc),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentActions(PatientDocumentModel doc) {
    return Container(
      width: 40.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: doc.isUploaded ? AppColor.darkBlue : null,
        gradient: doc.isUploaded
            ? null
            : LinearGradient(
          colors: [
            AppColor.primaryBackgroundColor,
            AppColor.secondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () async {
              if (doc.isUploaded) {
                Get.to(() => CustomViewer(fileUrl: doc.fullFileUrl));
              } else {
                await _captureAndUpload(doc, source: ImageSource.gallery);
              }
            },
            child: Icon(
              doc.isUploaded
                  ? Icons.remove_red_eye_outlined
                  : Icons.folder_open,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
          Container(
            height: 8.h,
          ),
          InkWell(
            onTap: () async {
              await _captureAndUpload(doc);
            },
            child: Icon(
              doc.isUploaded ? Icons.refresh : Icons.camera_alt_outlined,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _captureAndUpload(PatientDocumentModel doc, {
    ImageSource source = ImageSource.camera,
  }) async {
    final result = await Get.to(() =>
        DocumentCapturePhotoScreen(
          patientId: doc.patientId,
          treatmentId: doc.treatmentId,
          uploadApiPath: widget.uploadApiPath,
          documentLabel: widget.documentLabel,
          source: source,
        ));
    if (result == true && _lastSearchRequest != null) {
      await widget.controller.fetchDocumentList(_lastSearchRequest!);
    }
  }

  selectFrom() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);

    if (picked != null) {
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      fromDate = formatter.format(picked);
      fromDateController.text = fromDate;
    }
  }

  selectTo() async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);

    if (picked != null) {
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      toDate = formatter.format(picked);
      toDateController.text = toDate;
    }
  }
}
