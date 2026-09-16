import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:heamodialysis/upload_document/controller/document_capture_photo_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class DocumentCapturePhotoScreen extends StatefulWidget {
  final ImageSource source;
  final int patientId;
  final int treatmentId;
  final String uploadApiPath;
  final String documentLabel;

  const DocumentCapturePhotoScreen({
    super.key,
    required this.patientId,
    required this.treatmentId,
    required this.uploadApiPath,
    required this.documentLabel,
    this.source = ImageSource.camera,
  });

  @override
  State<DocumentCapturePhotoScreen> createState() =>
      _DocumentCapturePhotoScreenState();
}

class _DocumentCapturePhotoScreenState
    extends State<DocumentCapturePhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  final DocumentCapturePhotoController _controller =
      Get.put(DocumentCapturePhotoController());
  File? capturedImage;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    if (widget.source == ImageSource.gallery) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _pickImage());
    }
  }

  Future<void> _pickImage() async {
    final XFile? photo = await _picker.pickImage(source: widget.source);
    if (photo != null) {
      setState(() {
        capturedImage = File(photo.path);
      });
    } else if (widget.source == ImageSource.gallery && capturedImage == null) {
      Get.back();
    }
  }

  Future<void> _cropImage() async {
    if (capturedImage == null) return;
    final CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: capturedImage!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          toolbarColor: AppColor.primaryBackgroundColor,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: context.l10n.uploadCropPhoto,
        ),
      ],
    );
    if (cropped != null) {
      setState(() {
        capturedImage = File(cropped.path);
      });
    }
  }

  Future<void> _confirm() async {
    if (capturedImage == null) return;
    setState(() => isUploading = true);
    final bool success = await _uploadDocument(capturedImage!);
    setState(() => isUploading = false);
    if (success) {
      Get.back(result: true);
    }
  }

  Future<bool> _uploadDocument(File file) async {
    final result = await _controller.uploadDocument(
      file: file,
      patientId: widget.patientId,
      treatmentId: widget.treatmentId,
      uploadApiPath: widget.uploadApiPath,
    );

    CustomMessage.toast(result.message.isNotEmpty
        ? result.message
        : 'An error occurred while uploading the ${widget.documentLabel}.');
    return result.success;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: context.l10n.photoCapturePhoto,
          fontSize: 18.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.white,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Image.asset(
            'assets/arrow-left.png',
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              children: [
                Expanded(
                  child: CustomPaint(
                    painter: _DashedRRectPainter(
                      color: Colors.grey.shade400,
                      radius: 14.r,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: capturedImage == null
                          ? Center(
                              child: ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    AppColor.primaryBackgroundColor,
                                    AppColor.secondaryColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 56.sp,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(14.r),
                              child: Image.file(
                                capturedImage!,
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                capturedImage == null
                    ? _captureButton()
                    : _postCaptureActions(),
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
                      text: context.l10n.uploadUploading,
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

  Widget _captureButton() {
    return InkWell(
      onTap: _pickImage,
      borderRadius: BorderRadius.circular(40.r),
      child: Container(
        width: 68.w,
        height: 68.w,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColor.primaryBackgroundColor,
            width: 2,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColor.primaryBackgroundColor,
                AppColor.secondaryColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
  }

  Widget _postCaptureActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _circleIconButton(
          icon: Icons.refresh,
          color: Colors.grey,
          onTap: _pickImage,
        ),
        _circleIconButton(
          icon: Icons.crop,
          color: AppColor.primaryBackgroundColor,
          onTap: _cropImage,
        ),
        _circleIconButton(
          icon: Icons.check,
          color: AppColor.secondaryColor,
          onTap: _confirm,
        ),
      ],
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

class _DashedRRectPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double dashWidth;
  final double dashSpace;

  _DashedRRectPainter({
    required this.color,
    required this.radius,
    this.dashWidth = 6,
    this.dashSpace = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final dashedPath = Path();

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        dashedPath.addPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          Offset.zero,
        );
        distance = next + dashSpace;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) => false;
}
