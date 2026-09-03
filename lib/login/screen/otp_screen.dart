import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/login/controller/login_controller.dart';
import 'package:heamodialysis/login/screen/login_navigation.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

/// Shown after `verifyLogin` responds with code:2 / "OTP_REQUIRED".
/// Carries forward everything needed to resend (re-call `verifyLogin`)
/// without asking the user to retype their credentials.
class OtpScreen extends StatefulWidget {
  final String userName;
  final String unitId;
  final String password;
  final String captcha1;
  final String captcha2;
  final String? mobileNo;

  const OtpScreen({
    super.key,
    required this.userName,
    required this.unitId,
    required this.password,
    required this.captcha1,
    required this.captcha2,
    this.mobileNo,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Reuses the same LoginController instance the login screen created
  // (Get.find, not Get.put) so unitName/captcha state stays intact for a
  // resend.
  final LoginController loginController = Get.find<LoginController>();

  static const int _otpLength = 6;
  final List<TextEditingController> _digitControllers =
      List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _digitFocusNodes =
      List.generate(_otpLength, (_) => FocusNode());

  // Countdown before "Resend OTP" becomes tappable again. This is a
  // resend-cooldown, separate from the backend's 10-minute OTP validity.
  static const int _resendCooldownSeconds = 90;
  int _secondsLeft = _resendCooldownSeconds;
  Timer? _timer;

  String? _mobileNo;
  bool _isVerifying = false;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _mobileNo = widget.mobileNo;
    _startResendTimer();
  }

  void _startResendTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = _resendCooldownSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _digitControllers) {
      c.dispose();
    }
    for (final f in _digitFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _enteredOtp => _digitControllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < _otpLength - 1) {
      _digitFocusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _digitFocusNodes[index - 1].requestFocus();
    }
    if (_enteredOtp.length == _otpLength) {
      FocusScope.of(context).unfocus();
    }
    setState(() {});
  }

  void _clearOtpBoxes() {
    for (final c in _digitControllers) {
      c.clear();
    }
    if (_digitFocusNodes.isNotEmpty) {
      _digitFocusNodes.first.requestFocus();
    }
  }

  /// "9371023232" -> "******3232"
  String _maskMobile(String number) {
    if (number.length <= 4) return number;
    final visible = number.substring(number.length - 4);
    return '*' * (number.length - 4) + visible;
  }

  Future<void> _verifyOtp() async {
    final otp = _enteredOtp;
    if (otp.length != _otpLength) {
      CustomMessage.toast("Please enter the $_otpLength-digit OTP");
      return;
    }

    setState(() => _isVerifying = true);
    await loginController.verifyOtp(widget.userName, widget.unitId, otp);
    if (!mounted) return;
    setState(() => _isVerifying = false);

    if (loginController.status == "Success") {
      await navigateAfterLogin(loginController);
    } else if (loginController.status == "Invalid User") {
      // Not something a retry on this screen can fix.
      CustomMessage.toast(loginController.status ?? "Invalid User");
      Get.back();
    } else {
      CustomMessage.toast(loginController.status ?? "Invalid or Expired OTP");
      _clearOtpBoxes();
    }
  }

  Future<void> _resendOtp() async {
    setState(() => _isResending = true);
    await loginController.login(
      widget.userName,
      widget.unitId,
      widget.password,
      widget.captcha1,
      widget.captcha2,
    );
    if (!mounted) return;
    setState(() => _isResending = false);

    if (loginController.status == "OTP_REQUIRED") {
      setState(() => _mobileNo = loginController.otpMobileNo ?? _mobileNo);
      _clearOtpBoxes();
      _startResendTimer();
      CustomMessage.toast("OTP resent");
    } else if (loginController.status == "Success") {
      // Edge case: OTP requirement got toggled off between attempts.
      await navigateAfterLogin(loginController);
    } else {
      // Credentials/captcha no longer valid for a fresh verifyLogin call -
      // can't recover from this screen.
      CustomMessage.toast(
          loginController.status ?? "Could not resend OTP. Please login again.");
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final canResend = _secondsLeft == 0 && !_isResending;
    final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back,
                      color: AppColor.textGrey, size: 22.sp),
                  padding: EdgeInsets.zero,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                height: 76.w,
                width: 76.w,
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
                child: Icon(Icons.sms_outlined, color: Colors.white, size: 36.sp),
              ),
              SizedBox(height: 24.h),
              CustomText(
                text: "Verify OTP",
                fontSize: 22.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w700,
                textColor: AppColor.textGrey,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey,
                  ),
                  children: [
                    const TextSpan(
                        text: "OTP has been sent to registered mobile number: "),
                    TextSpan(
                      text: (_mobileNo != null && _mobileNo!.isNotEmpty)
                          ? _maskMobile(_mobileNo!)
                          : "your registered number",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColor.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_otpLength, (index) {
                  return SizedBox(
                    width: 44.w,
                    height: 52.h,
                    child: TextField(
                      controller: _digitControllers[index],
                      focusNode: _digitFocusNodes[index],
                      autofocus: index == 0,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.textGrey,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: AppColor.primaryBackgroundColor, width: 2),
                        ),
                      ),
                      onChanged: (value) => _onDigitChanged(index, value),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20.h),
              CustomText(
                text: _secondsLeft > 0
                    ? "This OTP is valid for a limited time"
                    : "Didn't get it? You can resend now.",
                fontSize: 12.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: AppColor.grey,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: _isVerifying ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryBackgroundColor,
                    disabledBackgroundColor:
                        AppColor.primaryBackgroundColor.withValues(alpha: 0.6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    elevation: 0,
                  ),
                  child: _isVerifying
                      ? SizedBox(
                          height: 22.h,
                          width: 22.h,
                          child: const CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5),
                        )
                      : CustomText(
                          text: 'Verify OTP',
                          fontSize: 16.sp,
                          fontFam: 'Lato',
                          fontWeight: FontWeight.w600,
                          textColor: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Didn't receive the code? ",
                    fontSize: 13.sp,
                    fontFam: 'Lato',
                    fontWeight: FontWeight.w400,
                    textColor: AppColor.grey,
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: canResend ? _resendOtp : null,
                    child: _isResending
                        ? SizedBox(
                            height: 14.h,
                            width: 14.h,
                            child: CircularProgressIndicator(
                                color: AppColor.primaryBackgroundColor,
                                strokeWidth: 2),
                          )
                        : CustomText(
                            text: canResend
                                ? "Resend OTP"
                                : "Resend in $minutes:$seconds",
                            fontSize: 13.sp,
                            fontFam: 'Lato',
                            fontWeight: FontWeight.w700,
                            textColor: canResend
                                ? AppColor.primaryBackgroundColor
                                : AppColor.grey,
                            textAlign: TextAlign.center,
                          ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
