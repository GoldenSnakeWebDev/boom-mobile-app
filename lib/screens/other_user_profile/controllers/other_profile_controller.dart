import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/models/single_boom_post.dart';

import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/network_model.dart';
import '../../authentication/login/models/user_model.dart';
import '../../home_screen/models/all_booms.dart';
import '../../main_screen/controllers/main_screen_controller.dart';
import 'package:http/http.dart' as http;

class OtherUserProfileController extends GetxController {
  String? userId;
  bool isNewUser = false;
  bool isVerified = false;
  int numOfFans = 0;
  int numOfFrens = 0;
  int numOfBooms = 0;
  int selectedTab = 0;
  bool isLoves = false;
  bool isSmiles = false;
  bool isRebooms = false;
  bool isLiked = false;
  bool isReported = false;
  NetworkModel? networkModel = Get.find<MainScreenController>().networkModel;
  String? selectedNetwork;
  Network? selectedNetworkModel;
  List<Network> networks = [];
  bool isBlockedUser = true;
  var bioExpanded = false.obs;
  bool isLoading = false;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.setCurrentScreen(screenName: "OtherUser Profile  Screen");
    userId = Get.arguments;
    fetchMyDetails();
    selectedNetwork = networkModel!.networks![0].symbol;
    log("Selected network Controller: $selectedNetwork");
    selectedNetworkModel = networkModel!.networks![0];
    networks.clear();
    for (var element in networkModel!.networks!) {
      networks.add(element);
    }
  }

  fetchMyDetails() async {
    String token = box.read("token");
    isLoading = true;
    var res = await http.get(Uri.parse("${baseURL}users/currentuser"),
        headers: {"Authorization": token});
    if (res.statusCode == 200) {
      isLoading = false;
      final user = User.fromJson(jsonDecode(res.body)["user"]);
      if (user.blockedUsers!.contains(userId)) {
        isBlockedUser = true;
        update();
      } else {
        isBlockedUser = false;
        isLoading = false;
        update();
      }
    } else {
      log("Error in fetching my details");
    }
  }

  expandBio() {
    bioExpanded.value = !bioExpanded.value;
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

  changeChain(String value) {
    selectedNetwork = value;
    for (var element in networkModel!.networks!) {
      if (element.symbol == value) {
        selectedNetworkModel = element;
      }
    }
    update();
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
}
