import 'dart:developer';

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/screens/authentication/login/login_screen.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    EasyLoading.show(status: 'loading...');

    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (box.read("token") != null) {
        EasyLoading.dismiss();
        Get.offAll(
          () => const MainScreen(),
          binding: AppBindings(),
        );
      } else {
        log("Token is null");
        EasyLoading.dismiss();
        Get.offAll(() => const LoginScreen());
      }
    });
  }
}
