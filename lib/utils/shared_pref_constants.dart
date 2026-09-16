class SharedPrefConstant {
  const SharedPrefConstant();

  String get kAuthToken => "kAuthToken";
  String get kDeviceId => "kDeviceId";

  /// Bearer-token pilot: stored on a successful [LoginController.login]
  /// (verifyLogin only - not verifyLoginNew/OTP) so the splash screen can
  /// silently re-authenticate and get a fresh token when the app reopens
  /// via the existing "stay logged in" flow, instead of skipping straight
  /// to the dashboard with no token at all.
  String get kSavedUsername => "kSavedUsername";
  String get kSavedUnitId => "kSavedUnitId";
  String get kSavedPassword => "kSavedPassword";
  String get kUserData => "kUserData";
  String get kinTimeDisable => 'kinTimeDisable';
  String get koutTimeDisable => 'koutTimeDisable';
  String get isScrutiny => 'isScrutiny';
  //Manali
  String get modId => 'modId';
  String get isAccountant => 'isAccountant';
  String get serviceID => 'serviceID';
  String get backDatedCount => 'backDatedCount';
  String get pendingActionsCount => 'pendingActionsCount';
  String get locationPermissionGranted => 'locationPermissionGranted';

  /// Persisted UI language code ('en' | 'fr') chosen from the language switcher.
  String get kAppLocale => 'kAppLocale';
}