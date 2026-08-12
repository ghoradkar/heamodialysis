import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:heamodialysis/splash/splash_screen.dart';
import 'package:heamodialysis/utils/image_ssl.dart';
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
    return const SafeArea(
      top: false,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MahaDialysis',
        home: SplashScreen(),
      ),
    );
  }
}
