import 'dart:developer';

import 'package:boom_mobile/screens/authentication/login/login_screen.dart';
import 'package:boom_mobile/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (box.read("token") != null) {
        log("Found Token ${box.read("token")}");
        Get.offAll(() => const MainScreen());
      } else {
        log("Token is null");
        Get.offAll(() => const LoginScreen());
      }
    });
  }
}
