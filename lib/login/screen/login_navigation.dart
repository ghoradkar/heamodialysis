import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/screen/cluster_dashboard/cluster_district_wise_dash.dart';
import 'package:heamodialysis/dashboard/screen/cluster_dashboard/cluster_division_dash.dart';
import 'package:heamodialysis/dashboard/screen/mis/mis_dash.dart';
import 'package:heamodialysis/dashboard/screen/nephro_first_level/nephro_dashboard.dart';
import 'package:heamodialysis/dashboard/screen/super_admin/operational_head.dart';
import 'package:heamodialysis/dashboard/screen/super_admin/super_admin_dash_screen.dart';
import 'package:heamodialysis/dashboard/screen/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/login/controller/login_controller.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';

/// Role-based navigation run after a successful login - whether that
/// success came directly from `verifyLogin` or from `verifyLoginOtp`,
/// since both return the same `dataDet` shape. Kept in one place so the
/// login screen and the OTP screen don't duplicate this switch.
Future<void> navigateAfterLogin(LoginController loginCtrl) async {
  CustomMessage.toast(l10n.loginSuccessful);

  final userRole = loginCtrl.loginRespModel?.dataDet.userType ?? "";

  Future<void> handleSuccessfulLogin(Widget nextScreen) async {
    // offAll (not off): when this runs after the OTP screen, the login
    // screen is still underneath it in the stack, and we don't want either
    // of them reachable via back-navigation once the dashboard is shown.
    await Get.offAll(() => nextScreen);
    loginCtrl.userName.value.clear();
    loginCtrl.password.value.clear();
    loginCtrl.captcha.value.clear();
    loginCtrl.update();

    // Warn testers when a non-prod build lands on the dashboard, so a
    // dev/test/replica session isn't mistaken for prod.
    if (!ApiConstants.isProd) {
      CustomMessage.toast(l10n.loginRunningEnv(ApiConstants.environmentName));
    }
  }

  switch (userRole) {
    case "nurse":
    case "ADMIN":
    case "TECHNICIAN":
    case "Technician":
      await handleSuccessfulLogin(const InstituteWiseDashboardScreen());
      break;

    case "NEPHROLOGIST":
      // Second-level approval (can be changed to relevant screen)
      await handleSuccessfulLogin(const NephroDashboard());
      break;

    case "DOCTOR":
      // First-level approval
      await handleSuccessfulLogin(const InstituteWiseDashboardScreen());
      break;

    case "SUPER ADMIN":
      await handleSuccessfulLogin(const SuperAdminDashScreen());
      break;
    case "INVOICE SECOND APPROVAL":
      await handleSuccessfulLogin(const SuperAdminDashScreen());
      break;
    case "INVOICE GENERATION":
      await handleSuccessfulLogin(const SuperAdminDashScreen());
      break;

    case "OPERATIONAL TEAM":
      await handleSuccessfulLogin(const SuperAdminDashScreen());
      break;

    case "HOD ONE":
      await handleSuccessfulLogin(const SuperAdminDashScreen());
      break;

    case "OPERATION HEAD":
      await handleSuccessfulLogin(const OperationalHeadScreen());
      break;

    case "CLUSTER HEAD DISTRICT":
      await handleSuccessfulLogin(const ClusterDistrictWiseDash());
      break;

    case "CLUSTER HEAD DIVISION":
      await handleSuccessfulLogin(const ClusterDivisionWiseDash());
      break;

    case "MIS":
      await handleSuccessfulLogin(const MISDashboardScreen());
      break;
    case "DIETICIAN":
      await handleSuccessfulLogin(const InstituteWiseDashboardScreen());
      break;

    default:
      CustomMessage.toast(l10n.loginUnknownRole(userRole));
  }
}
