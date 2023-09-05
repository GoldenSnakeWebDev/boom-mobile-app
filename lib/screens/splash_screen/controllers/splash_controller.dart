import 'dart:developer';

import 'package:boom_mobile/routes/route_helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    loadToken();
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    analytics.setCurrentScreen(screenName: "Splash Screen");
  }

  loadToken() async {
    // EasyLoading.show(status: 'loading...');
    isLoading = true;
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (box.read("token") != null) {
        // EasyLoading.dismiss();
        isLoading = false;
        update();

        Get.offAllNamed(RouteHelper.homeScreen);
        // Get.offAll(() => const MainScreen());
      } else {
        log("Token is null");
        isLoading = false;
        update();
        // EasyLoading.dismiss();
        Get.offNamed(RouteHelper.loginScreen);
      }
    });
  }
}
