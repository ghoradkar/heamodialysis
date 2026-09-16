import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Holds the app's current UI display mode and switches it live via
/// [Get.updateLocale] - every widget that reads `context.l10n` (or
/// `AppLocalizations.of(context)`) rebuilds immediately, no restart needed.
/// The choice is persisted to SharedPreferences so it survives a relaunch.
///
/// Three modes are exposed:
///   [english]   - English only        ("Patient Name")
///   [french]    - French only          ("Nom du patient")
///   [bilingual] - both, side by side   ("Patient Name / Nom du patient")
///
/// [bilingual] is carried by the synthetic locale `Locale('en', 'FR')` - see
/// `l10n_source/` and `tool/build_bilingual_arb.dart`. It is not a real locale.
class LocaleController extends GetxController {
  static const Locale english = Locale('en');
  static const Locale french = Locale('fr');
  static const Locale bilingual = Locale('en', 'FR');
  static const List<Locale> supported = [english, french, bilingual];

  /// Default for a fresh install.
  static const Locale defaultLocale = bilingual;

  final Rx<Locale> locale = defaultLocale.obs;

  bool get isEnglish => locale.value == english;
  bool get isFrench => locale.value == french;
  bool get isBilingual => locale.value == bilingual;

  /// Reads any previously persisted choice. Call once during `main()` before
  /// `runApp` so the first frame is already in the right mode.
  Future<void> loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = _fromTag(prefs.getString(const SharedPrefConstant().kAppLocale));
      if (saved != null) {
        locale.value = saved;
        Get.updateLocale(saved);
      }
    } catch (_) {
      // Fall back to the default mode if preferences can't be read.
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    if (locale.value == newLocale || !supported.contains(newLocale)) return;
    locale.value = newLocale;
    Get.updateLocale(newLocale);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          const SharedPrefConstant().kAppLocale, _toTag(newLocale));
    } catch (_) {
      // Non-fatal: the switch still applies for this session.
    }
  }

  // "en" / "fr" / "en_FR"
  static String _toTag(Locale l) => l.countryCode == null
      ? l.languageCode
      : '${l.languageCode}_${l.countryCode}';

  static Locale? _fromTag(String? tag) {
    if (tag == null || tag.isEmpty) return null;
    final parts = tag.split('_');
    final l = parts.length == 2 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
    return supported.contains(l) ? l : null;
  }
}
