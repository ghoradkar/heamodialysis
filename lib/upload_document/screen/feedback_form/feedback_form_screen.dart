import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/upload_document/controller/feedback_form_controller.dart';
import 'package:heamodialysis/upload_document/model/pending_feedback_treatment_model.dart';
import 'package:heamodialysis/upload_document/screen/feedback_form/feedback_form_upload_review_screen.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/status_update_screen.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class FeedbackFormScreen extends StatefulWidget {
  const FeedbackFormScreen({super.key});

  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  final FeedbackFormController controller = Get.put(FeedbackFormController());
  final TextEditingController _patientIdController = TextEditingController();
  int? _year;
  int? _month;

  static final List<int> _years =
      List.generate(6, (i) => DateTime.now().year - i);
  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  void initState() {
    super.initState();
    _year = DateTime.now().year;
    _month = DateTime.now().month;
    WidgetsBinding.instance.addPostFrameCallback((_) => _openSearchSheet());
  }

  @override
  void dispose() {
    _patientIdController.dispose();
    super.dispose();
  }

  Future<void> _openSearchSheet() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: const Color(0xffF8F8F8),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Search",
                        fontSize: 16.sp,
                        fontFam: "Lato",
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black,
                        textAlign: TextAlign.start,
                      ),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Icon(Icons.close,
                            color: AppColor.primaryBackgroundColor, size: 24.sp),
                      ),
                    ],
                  ),
                  _fieldLabel('Patient ID', required: true),
                  TextField(
                    controller: _patientIdController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter patient ID',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE1E1E1)),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE1E1E1)),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _fieldLabel('Year'),
                            _dropdown<int>(
                              value: _year,
                              items: _years,
                              labelBuilder: (y) => y.toString(),
                              onChanged: (v) =>
                                  setModalState(() => _year = v),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _fieldLabel('Month'),
                            _dropdown<int>(
                              value: _month,
                              items: List.generate(12, (i) => i + 1),
                              labelBuilder: (m) => _monthNames[m - 1],
                              onChanged: (v) =>
                                  setModalState(() => _month = v),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          alignment: Alignment.center,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.red,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.close, color: Colors.white, size: 18),
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
                      ).paddingOnly(top: 20.h),
                      SizedBox(width: 14.w),
                      InkWell(
                        onTap: () async {
                          final patientId =
                              int.tryParse(_patientIdController.text.trim());
                          if (patientId == null || _year == null || _month == null) {
                            CustomMessage.toast('Please enter Patient ID');
                            return;
                          }
                          Get.back();
                          await controller.search(
                            patientId: patientId,
                            year: _year!,
                            month: _month!,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          alignment: Alignment.center,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                AppColor.primaryBackgroundColor,
                                AppColor.secondaryColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.search, color: Colors.white, size: 18),
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
  }

  Widget _fieldLabel(String text, {bool required = false}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Lato',
              color: const Color(0xff515151),
            ),
          ),
          if (required)
            const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
        ],
      ),
    ).paddingOnly(top: 10.h, bottom: 4.h);
  }

  Widget _dropdown<T>({
    required T? value,
    required List<T> items,
    required String Function(T) labelBuilder,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE1E1E1)),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: DropdownButton<T>(
        isExpanded: true,
        value: value,
        onChanged: onChanged,
        items: items
            .map((e) => DropdownMenuItem<T>(value: e, child: Text(labelBuilder(e))))
            .toList(),
        underline: const SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down_outlined,
            color: AppColor.primaryBackgroundColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackgroundColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
        ),
        title: CustomText(
          text: 'Feedback Form',
          fontSize: 18.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.white,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Image.asset('assets/arrow-left.png', color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: _openSearchSheet,
            child: Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Image.asset('assets/filter-line.png', color: Colors.white),
            ),
          ),
        ],
      ),
      body: GetBuilder<FeedbackFormController>(builder: (controller) {
        if (controller.isSearching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!controller.isSearched) {
          return const SizedBox.shrink();
        }
        if (controller.treatments.isEmpty) {
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
            _patientCard(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 12.h),
                itemCount: controller.treatments.length,
                itemBuilder: (context, index) =>
                    _treatmentRow(controller.treatments[index]),
              ),
            ),
            _bottomButton(),
          ],
        );
      }),
    );
  }

  Widget _patientCard() {
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
            child: Icon(Icons.account_circle, color: Colors.grey, size: 28.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow('Patient ID', controller.patientId?.toString() ?? ''),
                SizedBox(height: 6.h),
                _infoRow('Patient Name', controller.patientName),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Expanded(child: _infoRow('Age', '${controller.patientAge} Yr')),
                    Expanded(
                        child: _infoRow('Blood Group', controller.patientBloodGroup)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
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

  Widget _treatmentRow(PendingFeedbackTreatment treatment) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
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
      child: Row(
        children: [
          // Every pending treatment is mandatory, so the checkbox is
          // always checked and locked - there's nothing to opt out of.
          Container(
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              color: AppColor.secondaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(Icons.check, color: Colors.white, size: 16.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
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
                        text: treatment.treatmentId.toString(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Lato',
                          color: AppColor.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
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
                        text: treatment.formattedTreatmentDate,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Lato',
                          color: AppColor.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton() {
    final bool showUpload = controller.downloadedPath != null;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: InkWell(
        onTap: controller.isDownloading || controller.isUploading
            ? null
            : (showUpload ? _pickAndReviewFile : _downloadPdf),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [AppColor.primaryBackgroundColor, AppColor.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: controller.isDownloading
              ? const CircularProgressIndicator(color: Colors.white)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(showUpload ? Icons.upload : Icons.download,
                        color: Colors.white),
                    SizedBox(width: 8.w),
                    CustomText(
                      text: showUpload
                          ? 'Upload Feedback Form'
                          : 'Download Feedback Form',
                      fontSize: 16.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.normal,
                      textColor: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _downloadPdf() async {
    final success = await controller.downloadPdf();
    if (success) {
      CustomMessage.toast('Feedback form saved');
      setState(() {});
    } else {
      CustomMessage.toast('Feedback form was not saved');
    }
  }

  Future<void> _pickAndReviewFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null || result.files.single.path == null) return;

    final uploaded = await Get.to(() => FeedbackFormUploadReviewScreen(
          controller: controller,
          filePath: result.files.single.path!,
        ));
    if (uploaded == true) {
      Get.back();
    }
  }
}
