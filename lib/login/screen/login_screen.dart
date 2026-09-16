import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/login/controller/login_controller.dart';
import 'package:heamodialysis/login/screen/login_navigation.dart';
import 'package:heamodialysis/login/screen/otp_screen.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/language_switcher.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:upgrader/upgrader.dart';

class LoginScreen extends StatefulWidget {
  // final Upgrader? upgrader;

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  Timer? captchaTimer;
  bool hasInternet = true;

  @override
  void initState() {
    checkInternetAndLoadData();
    super.initState();
  }

  checkInternetAndLoadData() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      hasInternet = true;
    } else {
      hasInternet = false;
    }
    setState(() {});
    if (hasInternet) {
      await loginController.getCaptcha();

      captchaTimer = Timer(const Duration(seconds: 10), () {
        if (loginController.captchaModel == null) {
          _showIndiaOnlyDialog();
        }
      });
    }
  }

  void _showIndiaOnlyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text("Note"),
          title: CustomText(
            text: context.l10n.commonNote,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            textColor: Colors.black,
            textAlign: TextAlign.center,
          ),
          content: CustomText(
            text: context.l10n.loginIndiaOnlyMessage,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            textColor: Colors.black,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                captchaTimer?.cancel();
              },
              // child: const Text("OK"),
              child: CustomText(
                text: context.l10n.commonOk,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                textColor: Colors.black,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    captchaTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
      child: Scaffold(
          body: SafeArea(
            child: hasInternet
              ? GetBuilder<LoginController>(
                  init: loginController,
                  builder: (controller) {
                    // if (controller.captchaModel != null) {
                    if (controller.captchaModel != null) {
                      captchaTimer?.cancel();
                    }
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 12.h, right: 12.w, left: 12.w),
                                    child: const Align(
                                      alignment: Alignment.centerRight,
                                      child: LanguageSwitcher(),
                                    ),
                                  ),

                                  Center(
                                    child: Image.asset(
                                      "assets/logo.png",
                                      width: 260.w,
                                      alignment: Alignment.center,
                                    ),
                                  ),

                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40)),
                                        gradient: LinearGradient(
                                            colors: [
                                              AppColor.primaryBackgroundColor,
                                              AppColor.primaryBackgroundColor
                                                  .withValues(alpha: 0.8),
                                              // Intermediate blend
                                              AppColor.secondaryColor
                                                  .withValues(alpha: 0.6),
                                              // Subtle blend for secondaryColor
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomRight,
                                            stops: const [0.0, 0.6, 1.0]),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.h),
                                            child: CustomText(
                                              text: context.l10n.loginTitle,
                                              fontSize: 25.sp,
                                              fontFam: 'Lato',
                                              fontWeight: FontWeight.w500,
                                              textColor: Colors.white,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h, horizontal: 8.w),
                                            child: TextField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              controller: loginController
                                                  .userName.value,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                labelText: context.l10n.loginUsername,
                                                suffixIcon: Image.asset(
                                                  'assets/user_textfield.png',
                                                  color: Colors.white,
                                                ),
                                                labelStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Lato",
                                                    fontSize: 14.sp),
                                                hintStyle: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h, horizontal: 8.w),
                                            child: TextField(
                                              onTap: () async {
                                                await loginController.getUnitId(
                                                    loginController
                                                        .userName.value.text
                                                        .trim());
                                              },
                                              obscureText: loginController
                                                  .obscurePassword,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              controller: loginController
                                                  .password.value,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                labelText: context.l10n.loginPassword,
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    loginController
                                                            .obscurePassword =
                                                        !loginController
                                                            .obscurePassword;
                                                    loginController.update();
                                                  },
                                                  child: Icon(
                                                    loginController
                                                            .obscurePassword
                                                        ? Icons.key_off_rounded
                                                        : Icons.key_outlined,
                                                    color: Colors.white70,
                                                    size: 22,
                                                  ),
                                                ),
                                                labelStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Lato",
                                                    fontSize: 14.sp),
                                                hintStyle: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                                onPressed: () {},
                                                child: CustomText(
                                                  text: context.l10n.loginForgotPassword,
                                                  fontSize: 14.sp,
                                                  fontFam: 'Lato',
                                                  fontWeight: FontWeight.w400,
                                                  textColor: Colors.white,
                                                  textAlign: TextAlign.end,
                                                )),
                                          ),
                                          Visibility(
                                            visible:
                                                loginController.unitNameList !=
                                                    null,
                                            child: MyCustomDropdown(
                                                isViewProfile: false,
                                                selectedItem: loginController
                                                    .unitName?.unitName,
                                                labelText: '',
                                                items: loginController
                                                        .unitNameList
                                                        ?.map((e) => e.unitName)
                                                        .toList() ??
                                                    [],
                                                hint: context.l10n.commonPleaseSelect,
                                                isRequired: false,
                                                senValue: (value) {
                                                  var unitN = loginController
                                                      .unitNameList
                                                      ?.firstWhere((e) =>
                                                          e.unitName == value);
                                                  loginController.unitName =
                                                      unitN;
                                                  loginController.update();
                                                },
                                                filledColor: Colors.white),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.w,
                                                right: 8.w,
                                                top: 18.h,
                                                bottom: 8.h),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.h,
                                                  horizontal: 8.w),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                      text: loginController
                                                              .captchaModel
                                                              ?.captcha ??
                                                          "",
                                                      fontSize: 20.sp,
                                                      fontFam: "Lato",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      textColor: Colors.black,
                                                      textAlign:
                                                          TextAlign.start),
                                                  InkWell(
                                                    onTap: () async {
                                                      await loginController
                                                          .getCaptcha();
                                                    },
                                                    child: const Icon(
                                                        Icons.refresh_rounded,
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.w,
                                                right: 8.w,
                                                top: 14.h,
                                                bottom: 8.h),
                                            child: TextField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              controller:
                                                  loginController.captcha.value,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                labelText:
                                                    context.l10n.loginCaptchaHint,
                                                labelStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Lato",
                                                    fontSize: 14.sp),
                                                hintStyle: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          InkWell(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 10.w),
                                              width: 180.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18)),
                                              child: controller.isLoading
                                                  ? Center(
                                                      child: SizedBox(
                                                          height: 40.h,
                                                          width: 40.w,
                                                          child:
                                                              const CircularProgressIndicator()))
                                                  : CustomText(
                                                      text: context.l10n.loginButton,
                                                      fontSize: 18.sp,
                                                      fontFam: 'Lato',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textColor: Colors.black,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                            ),
                                            onTap: () async {
                                              final loginCtrl = loginController;
                                              final l10n = context.l10n;

                                              // Perform login
                                              await loginCtrl.login(
                                                loginCtrl.userName.value.text
                                                    .trim(),
                                                loginCtrl.unitName?.unitId
                                                        ?.toString() ??
                                                    "1",
                                                loginCtrl.password.value.text
                                                    .trim(),
                                                loginCtrl.captchaModel
                                                        ?.captcha ??
                                                    "",
                                                loginCtrl.captcha.value.text
                                                    .trim(),
                                              );

                                              if (loginCtrl.status ==
                                                  "Success") {
                                                await navigateAfterLogin(
                                                    loginCtrl);
                                              } else if (loginCtrl.status ==
                                                  "OTP_REQUIRED") {
                                                // Credentials are valid but
                                                // the backend has texted an
                                                // OTP to the registered
                                                // mobile number - collect it
                                                // on a dedicated screen.
                                                await Get.to(() => OtpScreen(
                                                      userName: loginCtrl
                                                          .userName.value.text
                                                          .trim(),
                                                      unitId: loginCtrl
                                                              .unitName?.unitId
                                                              ?.toString() ??
                                                          "1",
                                                      password: loginCtrl
                                                          .password.value.text
                                                          .trim(),
                                                      captcha1: loginCtrl
                                                              .captchaModel
                                                              ?.captcha ??
                                                          "",
                                                      captcha2: loginCtrl
                                                          .captcha.value.text
                                                          .trim(),
                                                      mobileNo:
                                                          loginCtrl.otpMobileNo,
                                                    ));
                                              } else {
                                                CustomMessage.toast(
                                                    loginCtrl.status ??
                                                        l10n
                                                            .commonSomethingWentWrong);
                                              }
                                            },
                                          )
                                        ],
                                      ).paddingSymmetric(horizontal: 10.w),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  })
              : InternetIssue(
                  onRetryPressed: () {
                    checkInternetAndLoadData();
                  },
                ),
          )),
    );
  }
}
