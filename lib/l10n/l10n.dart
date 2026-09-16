import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/l10n/gen/app_localizations.dart';

/// Single import for localization across the app:
///
/// ```dart
/// import 'package:heamodialysis/l10n/l10n.dart';
/// ...
/// Text(context.l10n.commonSave);           // in widgets
/// CustomMessage.toast(l10n.commonSomethingWentWrong); // in controllers
/// ```
export 'package:heamodialysis/l10n/gen/app_localizations.dart';
export 'package:heamodialysis/l10n/locale_controller.dart';

/// Localized strings from a widget's [BuildContext].
extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// Localized strings from places without a [BuildContext] - GetX controllers,
/// repositories, toast/snackbar helpers. Resolves against the live navigator
/// context when one exists, otherwise against the current [Get.locale].
AppLocalizations get l10n {
  final context = Get.context;
  if (context != null) {
    return AppLocalizations.of(context);
  }
  return lookupAppLocalizations(Get.locale ?? const Locale('en'));
}
