import 'package:flutter/widgets.dart';
import 'package:heamodialysis/utils/auth_token_manager.dart';

/// Registered once in main() so a resumed app catches up on the silent
/// 59-minute token refresh if it was missed while backgrounded (Dart's
/// [Timer.periodic] in [AuthTokenManager] can pause while suspended).
class AppLifecycleWatcher extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AuthTokenManager().refreshIfDue();
    }
  }
}
