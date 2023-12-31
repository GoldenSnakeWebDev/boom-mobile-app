import 'dart:developer';

import 'package:boom_mobile/di/app_bindings.dart' as dl;
import 'package:boom_mobile/firebase_options.dart';
import 'package:boom_mobile/helpers/network_controller.dart';
import 'package:boom_mobile/routes/route_helper.dart';
import 'package:boom_mobile/secrets.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/widgets/custom_error_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dl.init();

  try {
    await InAppUpdate.checkForUpdate().then((info) async {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        if (info.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
        } else if (info.flexibleUpdateAllowed) {
          await InAppUpdate.startFlexibleUpdate().then((value) async {
            await InAppUpdate.completeFlexibleUpdate();
          });
        } else {
          await InAppUpdate.startFlexibleUpdate().then((value) async {
            await InAppUpdate.completeFlexibleUpdate();
          });
        }
      }
    });
  } catch (e) {
    log("Error in InAppUpdate: $e");
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var notifications = await Permission.notification.status;
  if (notifications.isDenied ||
      notifications.isPermanentlyDenied ||
      notifications.isRestricted) {
    await Permission.notification.request();
  }

  await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(oneSignalAppId);
  // await OneSignal.Notifications.requestPermission(true);

  ErrorWidget.builder = (details) => CustomErrorPage(
        flutterErrorDetails: details,
      );

  FlutterError.onError = (errorDetails) =>
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  await analytics.logAppOpen();

  // Uncomment this line to disable screenshotting due to security policy
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  await GetStorage.init();
  configureLoader();
  runApp(
    const MyApp(),
  );
  // Magic.instance = Magic(MAGIC_API_KEY);
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
    return GetBuilder<NetworkController>(
      init: NetworkController(),
      builder: (network) {
        return GetMaterialApp(
          title: 'Boom',
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fadeIn,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: GoogleFonts.montserrat().fontFamily,
          ),
          getPages: RouteHelper.routes,
          navigatorKey: Get.key,
          initialRoute: RouteHelper.splashScreen,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
