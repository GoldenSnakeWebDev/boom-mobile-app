import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/repo/get_user/get_curr_user.dart';
import 'package:boom_mobile/screens/authentication/login/login_screen.dart';
import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  bool isNewUser = true;
  int selectedTab = 0;
  int numberOfBooms = 0;
  int numberOfFans = 0;
  int numberOfFrens = 0;
  bool isVerified = false;
  bool isLoves = false;
  bool isSmiles = false;
  bool isRebooms = false;
  bool isLiked = false;
  User? user;
  AllBooms? myBooms;
  bool isLoadingBooms = false;
  FetchCurrUserRepo repo = Get.find();

  final box = GetStorage();
  List<SingleBoomPost> booms = [];

  @override
  void onInit() {
    user = Get.find<MainScreenController>().user;
    fetchMyBooms();
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

  fetchMyBooms() async {
    String token = box.read("token");
    String userId = box.read("userId");
    isLoadingBooms = true;
    final res = await http.get(
      Uri.parse("${baseURL}fetch-user-booms/$userId?page=all"),
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
    }
  }

  fetchReactionStatus(Boom boom) {
    String userId = box.read("userId");
    for (var item in boom.reactions.likes) {
      if (item.id == userId) {
        isLiked = true;
      } else {
        isLiked = false;
      }
    }
    for (var item in boom.reactions.loves) {
      if (item.id == userId) {
        isLoves = true;
      }
    }
    for (var item in boom.reactions.smiles) {
      if (item.id == userId) {
        isSmiles = true;
      }
    }
    for (var item in boom.reactions.rebooms) {
      if (item.id == userId) {
        isRebooms = true;
      }
    }
  }

  SingleBoomPost getSingleBoomDetails(Boom boom, int index) {
    fetchReactionStatus(boom);
    return SingleBoomPost(
      index: index,
      boomType: boom.boomType,
      location: "Location",
      chain: boom.network.symbol,
      imgUrl: boom.imageUrl,
      desc: boom.description,
      title: boom.title,
      network: boom.network,
      isLiked: isLiked,
      isLoves: isLoves,
      isRebooms: isRebooms,
      isSmiles: isSmiles,
      likes: boom.reactions.likes.length,
      loves: boom.reactions.loves.length,
      smiles: boom.reactions.smiles.length,
      rebooms: boom.reactions.rebooms.length,
      reported: boom.reactions.reports.length,
      comments: boom.comments.length,
    );
  }

  signOut() async {
    await box.erase();
    Get.offAll(() => const LoginScreen());
    CustomSnackBar.showCustomSnackBar(
        errorList: ["Signed out"], msg: ["Sign out"], isError: false);
  }
}
