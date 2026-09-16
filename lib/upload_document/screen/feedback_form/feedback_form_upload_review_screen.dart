import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:heamodialysis/upload_document/controller/feedback_form_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

/// Review/confirm screen for the picked feedback-form PDF, styled like
/// DocumentCapturePhotoScreen (dashed preview box, circular action
/// buttons) but built as its own class rather than extending that one -
/// a PDF needs SfPdfViewer instead of Image.file, and cropping doesn't
/// apply to a document, so the two screens would otherwise diverge on
/// almost every line of the body.
class FeedbackFormUploadReviewScreen extends StatefulWidget {
  final FeedbackFormController controller;
  final String filePath;

  const FeedbackFormUploadReviewScreen({
    super.key,
    required this.controller,
    required this.filePath,
  });

  @override
  State<FeedbackFormUploadReviewScreen> createState() =>
      _FeedbackFormUploadReviewScreenState();
}

class _FeedbackFormUploadReviewScreenState
    extends State<FeedbackFormUploadReviewScreen> {
  late File _pickedFile;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    _pickedFile = File(widget.filePath);
  }

  Future<void> _rePick() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() => _pickedFile = File(result.files.single.path!));
    }
  }

  Future<void> _confirm() async {
    setState(() => isUploading = true);
    final success = await widget.controller.uploadFeedbackForm(_pickedFile);
    setState(() => isUploading = false);

    if (success) {
      CustomPopup.showSuccessDialog(
        () {
          Get.back(); // close dialog
          Get.back(result: true); // close review screen
        },
        '',
        'Feedback form uploaded as PDF Successfully.',
      );
    } else {
      CustomMessage.toast('Failed to upload the feedback form');
    }
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
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: SfPdfViewer.file(_pickedFile),
                  ),
                ),
                SizedBox(height: 28.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _circleIconButton(
                      icon: Icons.refresh,
                      color: Colors.grey,
                      onTap: _rePick,
                    ),
                    _circleIconButton(
                      icon: Icons.check,
                      color: AppColor.secondaryColor,
                      onTap: _confirm,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isUploading)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 12.h),
                    CustomText(
                      text: 'Uploading...',
                      fontSize: 14.sp,
                      fontFam: 'Lato',
                      fontWeight: FontWeight.normal,
                      textColor: Colors.white,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _circleIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32.r),
      child: Container(
        width: 56.w,
        height: 56.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2),
        ),
        child: Icon(icon, color: color, size: 26.sp),
      ),
    );
  }
}
