import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/routes/route_helper.dart';
import 'package:boom_mobile/screens/authentication/login/login_screen.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../authentication/login/models/user_model.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  bool isLoading = false;
  User? user;

  @override
  void onInit() {
    super.onInit();
    loadToken();
    getCurrenUser();
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
      } else {
        log("Token is null");
        isLoading = false;
        update();
        // EasyLoading.dismiss();
        Get.offNamed(RouteHelper.loginScreen);
      }
    });
  }

  getCurrenUser() async {
    try {
      String token = box.read("token") ?? "";

      final res = await http.get(
        Uri.parse("${baseURL}users/currentUser"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": token,
        },
      );
      if (res.statusCode == 200) {
        user = User.fromJson(jsonDecode(res.body)["user"]);
        box.write("userId", user!.id);
        // CustomSnackBar.showCustomSnackBar(
        //     errorList: ["User Details Fetched"],
        //     msg: ["Success"],
        //     isError: false);
        update();
      } else {
        CustomSnackBar.showCustomSnackBar(
          errorList: ["User Details Not Fetched"],
          msg: ["Error"],
          isError: true,
        );
        box.erase();
        Get.offAll(
          () => const LoginScreen(),
        );
      }
    } on SocketException catch (e) {
      log("Socket Exception $e");
      CustomSnackBar.showCustomSnackBar(
        errorList: ["No Internet Connection"],
        msg: ["Error"],
        isError: true,
      );
    } catch (e) {
      log("Error in Splash Controller $e");
      CustomSnackBar.showCustomSnackBar(
        errorList: ["Error in Splash Controller"],
        msg: ["Error"],
        isError: true,
      );
    }
  }
}
