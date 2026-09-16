import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/screen/cluster_dashboard/cluster_district_wise_dash.dart';
import 'package:heamodialysis/dashboard/screen/cluster_dashboard/cluster_division_dash.dart';
import 'package:heamodialysis/dashboard/screen/mis/mis_dash.dart';
import 'package:heamodialysis/dashboard/screen/nephro_first_level/nephro_dashboard.dart';
import 'package:heamodialysis/dashboard/screen/super_admin/operational_head.dart';
import 'package:heamodialysis/dashboard/screen/super_admin/super_admin_dash_screen.dart';
import 'package:heamodialysis/dashboard/screen/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/login/controller/login_controller.dart';
import 'package:heamodialysis/login/screen/login_screen.dart';
import 'package:heamodialysis/utils/session_manager.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:upgrader/upgrader.dart';

class SplashScreen extends StatefulWidget {
  // final Upgrader upgrader;

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  final LoginController loginController = Get.put(LoginController());
  Map<String, dynamic>? userData;
  String? userType;
  Upgrader? upgrader;

  @override
  void initState() {
    super.initState();
    _startFadeInAnimation();
    initUpgrader();
  }

  initUpgrader() async {
    await Upgrader.clearSavedSettings();
    upgrader = Upgrader(debugLogging: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeSplash(),
        builder: (context, snapshot) {
          return AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Center(
                  child: Image.asset(
                    "assets/logo.png",
                    width: 260.w,
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: CustomText(
                    text: 'MAHADIALYSIS',
                    fontSize: 26.sp,
                    fontFam: 'Lato',
                    fontWeight: FontWeight.w600,
                    textColor: Colors.black,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: CustomText(
                    text: 'MOBILE APP',
                    fontSize: 26.sp,
                    fontFam: 'Lato',
                    fontWeight: FontWeight.w600,
                    textColor: Colors.black,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10.h),
                const Spacer(),
                Center(child: Image.asset("assets/splashscreen.png")),
              ],
            ),
          );
          // }
        },
      ),
    );
  }

  void _startFadeInAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }

  Future<void> _initializeSplash() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _opacity = 1.0;
    });
    await Future.delayed(const Duration(seconds: 2));
    await _fetchUserData();

    _navigateToNextScreen();
  }

  Future<void> _fetchUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    userType = userData?['user_Type'];
  }

  void _navigateToNextScreen() async {
    bool isLogin = await SessionManager().isLoggedIn();

    if (isLogin) {
      // AuthTokenManager only lives in memory, so it's empty whenever the
      // app is (re)launched - re-run the real login here to get a fresh
      // Bearer token before showing the dashboard, instead of skipping
      // straight to it with no token at all.
      if (await _silentReLogin()) {
        await _fetchUserData();
        _navigateBasedOnUserType();
      } else {
        _goToLoginScreen();
      }
    } else {
      _goToLoginScreen();
    }
  }

  /// Re-runs verifyLogin with the credentials saved at the last successful
  /// login. Returns false (falls back to the login screen) if nothing was
  /// saved - e.g. an OTP-only account, which this pilot doesn't cover - or
  /// if the login itself fails (bad/changed password, network, server).
  Future<bool> _silentReLogin() async {
    const prefs = SharedPrefConstant();
    final savedUsername = await SharedPref().read(prefs.kSavedUsername);
    final savedUnitId = await SharedPref().read(prefs.kSavedUnitId);
    final savedPassword = await SharedPref().read(prefs.kSavedPassword);

    if (savedUsername == null || savedUnitId == null || savedPassword == null) {
      return false;
    }

    // Captcha is only checked for equality server-side, not against a
    // real generated value, so any matching pair works for a silent call.
    await loginController.login(
        savedUsername, savedUnitId, savedPassword, "AUTO", "AUTO");
    return loginController.status == 'Success';
  }

  void _goToLoginScreen() {
    Get.off(() => UpgradeAlert(
        shouldPopScope: () => false,
        showIgnore: false,
        showLater: false,
        dialogStyle: UpgradeDialogStyle.material,
        upgrader: upgrader ??
            Upgrader(
              debugLogging: true, // Enable debug logging
            ),
        child: const LoginScreen()));
  }

  void _navigateBasedOnUserType() {
    final routes = {
      "NEPHROLOGIST": () => const NephroDashboard(),
      "DOCTOR": () => const InstituteWiseDashboardScreen(),
      "DIETICIAN": () => const InstituteWiseDashboardScreen(),
      "INVOICE SECOND APPROVAL": () => const SuperAdminDashScreen(),
      "INVOICE GENERATION": () => const SuperAdminDashScreen(),
      "nurse": () => const InstituteWiseDashboardScreen(),
      "TECHNICIAN": () => const InstituteWiseDashboardScreen(),
      "ADMIN": () => const InstituteWiseDashboardScreen(),
      "SUPER ADMIN": () => const SuperAdminDashScreen(),
      "OPERATIONAL TEAM": () => const SuperAdminDashScreen(),
      "OPERATION HEAD": () => const OperationalHeadScreen(),
      "CLUSTER HEAD DISTRICT": () => const ClusterDistrictWiseDash(),
      "CLUSTER HEAD DIVISION": () => const ClusterDivisionWiseDash(),
      "MIS": () => const MISDashboardScreen(),
    };

    final route = routes[userType];
    if (route != null) {
      Get.off(route);
    } else {
      _goToLoginScreen();
    }
  }
}
