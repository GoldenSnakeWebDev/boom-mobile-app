import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/models/single_boom_post.dart';

import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/screens/home_screen/services/home_service.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  AllBooms? allBooms;
  List<Boom>? _homeBooms;
  List<Boom>? get homeBooms => _homeBooms;
  List<Boom> myBooms = [];
  HomeService homeService = HomeService();
  bool isLoading = true;
  bool isLoves = false;
  bool isSmiles = false;
  bool isRebooms = false;
  bool isLiked = false;
  bool hasLiked = false;
  bool hasLoved = false;
  bool hasSmiled = false;
  bool hasReboomed = false;
  final box = GetStorage();
  String userId = '';
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      userId = box.read("userId");
      fetchAllBooms();
    });
  }

  reactChange(String reactType) {
    switch (reactType) {
      case "like":
        hasLiked = !hasLiked;

        update();
        break;
      case "love":
        hasLoved = !hasLoved;

        update();
        break;
      case "smile":
        hasSmiled = !hasSmiled;

        update();
        break;
      case "reboom":
        hasReboomed = !hasReboomed;
        update();
        break;
      default:
        break;
    }
    update();
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

  SingleBoomPost getSingleBoomDetails(int index) {
    fetchReactionStatus(homeBooms![index]);
    return SingleBoomPost(
      index: index,
      boomType: homeBooms![index].boomType,
      location: "Location",
      chain: homeBooms![index].network.symbol,
      imgUrl: homeBooms![index].imageUrl,
      desc: homeBooms![index].description,
      title: homeBooms![index].title,
      network: homeBooms![index].network,
      isLiked: isLiked,
      isLoves: isLoves,
      isRebooms: isRebooms,
      isSmiles: isSmiles,
      likes: homeBooms![index].reactions.likes.length,
      loves: homeBooms![index].reactions.loves.length,
      smiles: homeBooms![index].reactions.smiles.length,
      rebooms: homeBooms![index].reactions.rebooms.length,
      reported: homeBooms![index].reactions.reports.length,
      comments: homeBooms![index].comments.length,
    );
  }

  fetchAllBooms() async {
    EasyLoading.show(status: "Loading");
    final res = await homeService.fetchBooms();

    if (res.statusCode == 200) {
      isLoading = false;

      // CustomSnackBar.showCustomSnackBar(
      //     errorList: ["Booms Fetched"], msg: ["Success"], isError: false);
      allBooms = AllBooms.fromJson(jsonDecode(res.body));
      _homeBooms = allBooms!.booms;
      EasyLoading.dismiss();
      // getNetworkById(allBooms);

      update();
    } else {
      isLoading = false;
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Could not fetch Booms"], msg: ["Error"], isError: true);
      EasyLoading.dismiss();
    }
  }

  reactToBoom(String reactType, String boomId, int index) async {
    log("$reactType to $boomId");
    final res = await homeService.reactToBoom(reactType, boomId);

    if (res.statusCode == 200) {
    } else {
      log(res.body);
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Could not react to Boom"],
          msg: ["Error"],
          isError: true);
    }
  }
}
