class SharedPrefConstant {
  const SharedPrefConstant();

  String get kAuthToken => "kAuthToken";
  String get kDeviceId => "kDeviceId";
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