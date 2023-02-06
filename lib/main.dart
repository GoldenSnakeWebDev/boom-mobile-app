import 'dart:developer';

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/screens/splash_screen/splash_screen.dart';
import 'package:boom_mobile/secret.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId(oneSignalAppId);
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    log("User has accpeted notifications: $accepted");
  });

  // Uncomment this line to disable screenshotting due to security policy
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  GetStorage.init();
  configureLoader();
  runApp(const MyApp());
}

configureLoader() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.custom
    ..textColor = Colors.white
    ..indicatorColor = kPrimaryColor
    ..progressColor = kSecondaryColor
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.black
    ..maskColor = Colors.black.withOpacity(0.5)
    ..dismissOnTap = false
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Boom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      initialBinding: AppBindings(),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
