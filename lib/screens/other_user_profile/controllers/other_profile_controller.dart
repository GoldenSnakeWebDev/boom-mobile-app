import 'dart:developer';

import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/other_user_booms.dart';

class OtherUserProfileController extends GetxController {
  String? userId;
  bool isNewUser = false;
  bool isVerified = false;
  int numOfFans = 0;
  int numOfFrens = 0;
  int numOfBooms = 0;
  bool isLoves = false;
  bool isSmiles = false;
  bool isRebooms = false;
  bool isLiked = false;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    userId = Get.arguments;
    log(userId.toString());
  }

  fetchReactionStatus(Boom boom) {
    userId = box.read("userId");
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
      // network: boom.network,
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
}
