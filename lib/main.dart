import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/login/screen/login_screen.dart';
import 'package:heamodialysis/splash/splash_screen.dart';
import 'package:heamodialysis/utils/app_lifecycle_watcher.dart';
import 'package:heamodialysis/utils/auth_token_manager.dart';
import 'package:heamodialysis/utils/image_ssl.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
// import 'package:media_kit/media_kit.dart';
// import 'package:media_store_plus/media_store_plus.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  // const env = String.fromEnvironment('ENV', defaultValue: 'prod');
  // ApiConstants.configure(Environment.values.firstWhere((e) => e.name == env));

  WidgetsFlutterBinding.ensureInitialized();
  // MediaKit.ensureInitialized();
  FlutterError.onError = (details) {
    debugPrint('Flutter Error: ${details.exception}');
    debugPrint('Stack trace: ${details.stack}');
  };

  // if (Platform.isAndroid) {
  //   MediaKit.ensureInitialized();
  //   await MediaStore.ensureInitialized();
  // }
  HttpOverrides.global = MyHttpOverrides();

  // Bearer-token pilot: forced logout when the silent 59-minute refresh
  // fails or any API returns 401 (see ApiClient/AuthTokenManager).
  AuthTokenManager().onSessionExpired = () {
    SharedPref().clearSaveData();
    Get.offAll(() => const LoginScreen());
  };
  WidgetsBinding.instance.addObserver(AppLifecycleWatcher());

  // Register the locale controller before the first frame and apply any
  // previously persisted language choice.
  final localeController = Get.put(LocaleController(), permanent: true);
  await localeController.loadSavedLocale();

  runApp(
    DevicePreview(
      enabled: false,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder:(context, child) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();
    return SafeArea(
      top: false,
      child: Obx(
        () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MahaDialysis',
          locale: localeController.locale.value,
          fallbackLocale: LocaleController.english,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
