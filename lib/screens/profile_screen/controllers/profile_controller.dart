import 'dart:convert';

import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/repo/get_user/get_curr_user.dart';
import 'package:boom_mobile/screens/authentication/login/login_screen.dart';
import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  bool isNewUser = true;
  int selectedTab = 0;
  int numberOfBooms = 0;
  int numberOfFans = 0;
  int numberOfFrens = 0;
  bool isVerified = false;
  User? user;
  FetchCurrUserRepo repo = Get.find();

  final box = GetStorage();
  List<SingleBoomPost> booms = [];

  @override
  void onInit() {
    user = Get.find<MainScreenController>().user;
    if (user != null && user!.bio.isNotEmpty) {
      isNewUser = false;
    }
    super.onInit();
  }

  changeSelectedIndex(int index) {
    index != 0
        ? Get.snackbar(
            "Hang in there.",
            "Shipping soon..",
            backgroundColor: kPrimaryColor,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.black,
            overlayBlur: 5.0,
            margin: EdgeInsets.only(
              top: SizeConfig.screenHeight * 0.05,
              left: SizeConfig.screenWidth * 0.05,
              right: SizeConfig.screenWidth * 0.05,
            ),
          )
        : selectedTab = index;
    update();
  }

  fetchProfile() async {
    String token = box.read("token");
    final res = await repo.fetchCurrUser(token);
    if (res.statusCode == 200) {
      user = User.fromJson(jsonDecode(res.body)["user"]);
      update();
    } else {
      CustomSnackBar.showCustomSnackBar(
        errorList: ["User Details Fetched"],
        msg: ["Error"],
        isError: true,
      );
    }
  }

  signOut() async {
    await box.erase();
    Get.offAll(() => const LoginScreen());
    CustomSnackBar.showCustomSnackBar(
        errorList: ["Signed out"], msg: ["Sign out"], isError: false);
  }
}
