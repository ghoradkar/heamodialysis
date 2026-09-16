import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:heamodialysis/l10n/l10n.dart';

import '../../dashboard/controller/dashboard_controller.dart';
import '../../internet/no_internet_connectivity.dart';
import '../../utils/auth_token_manager.dart';
import '../../utils/shared_preference.dart';
import '../../utils/status_update_screen.dart';
import '../controller/login_controller.dart';
import '../repository/login_repository.dart';
import 'login_screen.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final DashboardController dashboardController = Get.find();
  final LoginController loginController = Get.find();

@override
  void initState() {
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

  Future<void> _performLogout() async {
    // Reset dashboard filters if custom calendar is active
    if (dashboardController.isCustomCalender) {
      dashboardController.isCustomCalender = false;
      dashboardController.fDateController.text = "";
      dashboardController.tDateController.text = '';
      dashboardController.update();
    }

    // Reset login fields
    loginController.userName.value.text = '';
    loginController.password.value.text = '';
    loginController.captcha.value.text = '';
    loginController.unitNameList = null;
    loginController.update();

    // Bearer-token pilot: tell the backend the session ended. Best-effort -
    // local logout proceeds even if this fails (e.g. no network).
    try {
      await LoginRepository().logout();
    } catch (e) {
      debugPrint('saveLogoutHistoryMobile failed: $e');
    }
    AuthTokenManager().clear();

    // Clear saved data
    await SharedPref().clearSaveData();

    // Close logout screen and navigate to login
    Get.back(); // close LogoutScreen
    Get.offAll(() => const LoginScreen());
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable ?  Scaffold(
      body: CommonStatusScreen(
        title: context.l10n.commonLogout,
        description: context.l10n.logoutConfirm,
        img: "assets/logout.png",
        buttonText: context.l10n.commonNo, primaryTextColor: Colors.black,
        primaryGradient: const [
          Color(0xFFE1E1E1),
          Color(0XffE1E1E1),
        ],
        secondButtonText: context.l10n.commonYes, secondaryTextColor: Colors.white,
        secondOnPressed:_performLogout,
        onPressed: () {
          Get.back();
        },
      ),
    ) : InternetIssue(
      onRetryPressed: () async {
        final result = await _connectivity.checkConnectivity();
        _updateConnectionStatus(result);
      },
    );
  }
}
