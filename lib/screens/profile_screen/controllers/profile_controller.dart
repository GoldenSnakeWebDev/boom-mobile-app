import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/authentication/login/login_screen.dart';
import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/screens/splash_screen/controllers/splash_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

class ProfileController extends GetxController {
  bool isNewUser = true;
  int selectedTab = 0;
  int numberOfBooms = 0;
  int numberOfFans = 0;
  int numberOfFrens = 0;
  var bioFontSize = 14.0.obs;
  bool isVerified = false;
  bool isLoves = false;
  bool isSmiles = false;
  bool isRebooms = false;
  bool isReported = false;
  bool isLiked = false;
  User? user;
  AllBooms? myBooms;
  bool isLoadingBooms = false;
  // FetchCurrUserRepo repo = Get.find();

  final box = GetStorage();
  List<SingleBoomPost> booms = [];
  List<String> boxCreators = [
    "6386b0beae4f58f9eee8376b",
    "642e8a69c3feef8b61b7b78b",
    "64337275c3feef8b61c3c301",
    "63863cd5ae4f58f9eee7fb22",
  ];

  String myUserId = '';

  @override
  void onInit() {
    Get.put(SplashController(), permanent: true);
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    myUserId = box.read("userId");
    analytics.setCurrentScreen(screenName: "Profile Screen");
    user = Get.find<SplashController>().user;
    fetchMyBooms();
    if (user != null && user!.bio!.isNotEmpty) {
      isNewUser = false;
    }
    super.onInit();
  }

  changeSelectedIndex(int index) {
    switch (index) {
      case 0:
        selectedTab = index;
        break;
      case 1:
        Get.snackbar(
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
        );
        break;
      case 2:
        selectedTab = index;
        break;
      case 3:
        Get.snackbar(
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
        );
        break;
      case 4:
        Get.snackbar(
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
        );
        break;
      case 5:
        Get.snackbar(
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
        );
        break;
      default:
    }

    update();
  }

  fetchMyBooms() async {
    String token = box.read("token");
    isLoadingBooms = true;
    update();
    final res = await http.get(
      Uri.parse("${baseURL}booms/mine?page=all"),
      headers: {"Authorization": token},
    );
    if (res.statusCode == 200) {
      myBooms = AllBooms.fromJson(jsonDecode(res.body));
      isLoadingBooms = false;
      update();
    } else {
      isLoadingBooms = false;
      log("My Booms res${res.body}");
      CustomSnackBar.showCustomSnackBar(
        errorList: ["Could not fetch your booms"],
        msg: ["Error"],
        isError: true,
      );
      update();
    }
  }

  fetchReactionStatus(Boom boom) {
    String userId = box.read("userId");
    for (var item in boom.reactions!.likes!) {
      if (item.id == userId) {
        isLiked = true;
      } else {
        isLiked = false;
      }
    }
    for (var item in boom.reactions!.loves!) {
      if (item.id == userId) {
        isLoves = true;
      } else {
        isLoves = false;
      }
    }
    for (var item in boom.reactions!.smiles!) {
      if (item.id == userId) {
        isSmiles = true;
      } else {
        isSmiles = false;
      }
    }
    for (var item in boom.reactions!.rebooms!) {
      if (item.id == userId) {
        isRebooms = true;
      } else {
        isRebooms = false;
      }
    }
    for (var item in boom.reactions!.reports!) {
      if (item.id == userId) {
        isReported = true;
      } else {
        isReported = false;
      }
    }
  }

  changeFontSize() {
    if (bioFontSize == 14.0) {
      bioFontSize.value = 11.0;
    } else {
      bioFontSize.value = 14.0;
    }
  }

  SingleBoomPost getSingleBoomDetails(Boom boom, int index) {
    fetchReactionStatus(boom);
    return SingleBoomPost(
      index: index,
      boomType: "${boom.boomType}",
      location: "${boom.location}",
      chain: "${boom.network!.symbol}",
      imgUrl: "${boom.imageUrl}",
      desc: "${boom.description}",
      title: "${boom.title}",
      network: boom.network!,
      user: boom.user!,
      isLiked: isLiked,
      isLoves: isLoves,
      isRebooms: isRebooms,
      isSmiles: isSmiles,
      isReported: isReported,
      likes: boom.reactions!.likes!.length,
      loves: boom.reactions!.loves!.length,
      smiles: boom.reactions!.smiles!.length,
      rebooms: boom.reactions!.rebooms!.length,
      reported: boom.reactions!.reports!.length,
      comments: boom.comments!.length,
    );
  }

  signOut() async {
    await box.erase();
    Get.offAll(() => const LoginScreen());
    await OneSignal.shared.removeExternalUserId();
    CustomSnackBar.showCustomSnackBar(
        errorList: ["Signed out"], msg: ["Sign out"], isError: false);
  }
}
