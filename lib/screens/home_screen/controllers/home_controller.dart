import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/models/network_model.dart' as net;
import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/screens/home_screen/services/home_service.dart';
import 'package:boom_mobile/screens/profile_screen/models/boom_box_model.dart';
import 'package:boom_mobile/screens/splash_screen/controllers/splash_controller.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

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
  bool isReported = false;
  bool hasLiked = false;
  bool hasLoved = false;
  bool hasSmiled = false;
  bool hasReboomed = false;
  final box = GetStorage();
  String userId = '';
  List<CachedVideoPlayerController> videoPlayerControllers = [];
  late int totalPages;
  int currentPage = 0;
  late ScrollController scrollController;
  // BoomBoxModel? boomBoxModel;
  List<BoomBox> boomBoxes = [];

  net.NetworkModel? networkModel;

  @override
  void onInit() async {
    Get.put(SplashController(), permanent: true);
    super.onInit();
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    await analytics.logLogin();
    await analytics.setCurrentScreen(screenName: "Home Screen");

    scrollController = ScrollController()
      ..addListener(() {
        loadMore();
      });
    Future.delayed(const Duration(seconds: 1), () {
      userId = box.read("userId");

      fetchAllBooms();
      getNetworks();
    });
  }

  getNetworks() async {
    if (box.read("networkModel") != null) {
      networkModel = net.NetworkModel.fromJson(
          jsonDecode(box.read("networkModel").toString()));
      update();
    } else {
      final res = await http.get(
        Uri.parse("${baseURL}networks?page=all"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      if (res.statusCode == 200) {
        networkModel = net.NetworkModel.fromJson(jsonDecode(res.body));
        await box.write("networkModel", res.body);
        log("networkModel is $networkModel");
        update();
      } else {
        CustomSnackBar.showCustomSnackBar(
            errorList: ["Networks not fetched"], msg: ["Error"], isError: true);
      }
    }
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
    for (var item in boom.reactions!.likes!) {
      if (item.id == userId) {
        isLiked = true;
      } else {
        isLiked = false;
      }
    }
    // for (var item in boom.reactions!.loves!) {
    //   if (item.id == userId) {
    //     isLoves = true;
    //   } else {
    //     isLoves = false;
    //   }
    // }
    // for (var item in boom.reactions!.smiles!) {
    //   if (item.id == userId) {
    //     isSmiles = true;
    //   } else {
    //     isSmiles = false;
    //   }
    // }
    // for (var item in boom.reactions!.rebooms!) {
    //   if (item.id == userId) {
    //     isRebooms = true;
    //   } else {
    //     isRebooms = false;
    //   }
    // }
    // for (var item in boom.reactions!.reports!) {
    //   if (item.id == userId) {
    //     isReported = true;
    //   } else {
    //     isReported = false;
    //   }
    // }
  }

  List<SingleBoomPost> getSingleBoomDetails(List<Boom> boom) {
    List<SingleBoomPost> singleBoomPost = [];
    for (int i = 0; i < boom.length; i++) {
      fetchReactionStatus(boom[i]);
      var singleBoom = SingleBoomPost(
        index: i,
        boomType: "${homeBooms![i].boomType}",
        location: "${homeBooms![i].location}",
        chain: "${homeBooms![i].network!.symbol}",
        imgUrl: "${homeBooms![i].imageUrl}",
        desc: "${homeBooms![i].description}",
        title: "${homeBooms![i].title}",
        network: homeBooms![i].network!,
        user: homeBooms![i].user!,
        isLiked: isLiked,
        isLoves: isLoves,
        isRebooms: isRebooms,
        isSmiles: isSmiles,
        isReported: isReported,
        likes: homeBooms![i].reactions!.likes!.length,
        loves: homeBooms![i].reactions!.loves!.length,
        smiles: homeBooms![i].reactions!.smiles!.length,
        rebooms: homeBooms![i].reactions!.rebooms!.length,
        reported: homeBooms![i].reactions!.reports!.length,
        comments: homeBooms![i].comments!.length,
      );
      singleBoomPost.add(singleBoom);
    }

    return singleBoomPost;
  }

  fetchAllBooms() async {
    log("We have been invoked");
    try {
      EasyLoading.show(status: "Loading");
      final res = await homeService.fetchBooms(0);

      if (res.statusCode == 200) {
        videoPlayerControllers.clear();
        isLoading = false;

        // CustomSnackBar.showCustomSnackBar(
        //     errorList: ["Booms Fetched"], msg: ["Success"], isError: false);
        box.write("savedBooms", res.body);
        allBooms = AllBooms.fromJson(jsonDecode(res.body));
        totalPages = allBooms!.page?.limit ?? 0;
        _homeBooms = allBooms!.booms;

        // for (var item in videoPlayerControllers) {
        //   await item.initialize().then((value) {
        //     item.play();
        //     item.setLooping(true);
        //   });
        // }
        // for (var item in videoPlayerControllers) {
        //   log("Data Source ${item.dataSource}");
        // }

        EasyLoading.dismiss();
        // getNetworkById(allBooms);

        // await initializeVideos();
        // await fetchTrendingBoxes();
        update();
      } else {
        log("back end error on fetchbooms");
        isLoading = false;
        CustomSnackBar.showCustomSnackBar(
            errorList: ["Could not fetch Booms"],
            msg: ["Error"],
            isError: true);
        EasyLoading.dismiss();
      }
    } on SocketException catch (_) {
      CustomSnackBar().networkErrorSnack(onInit);
      EasyLoading.dismiss();
      final savedBooms = box.read("savedBooms");
      if (savedBooms != null) {
        allBooms = AllBooms.fromJson(jsonDecode(savedBooms));
        totalPages = allBooms!.page?.limit ?? 0;
        _homeBooms = allBooms!.booms;
        isLoading = false;
        update();
      }
      update();
    }
  }

  //Function to fetch BoomBoxes from Three accounts
  fetchTrendingBoxes() async {
    try {
      // TODO: Remove Renny's UserId
      // TODO: Destructure the BoomBoxModel to only have one List of BoomBoxes

      List<String> trendingIds = [
        "63863cd5ae4f58f9eee7fb22",
        "6386b0beae4f58f9eee8376b",
        "642e8a69c3feef8b61b7b78b",
        "64337275c3feef8b61c3c301",
      ];
      for (String item in trendingIds) {
        final res = await homeService.fetchBoomBoxes(item);

        if (res.statusCode == 200) {
          for (var item
              in BoomBoxModel.fromJson(jsonDecode(res.body)).boomBoxes) {
            boomBoxes.add(item);
          }

          update();
          //Handle success
        } else {
          Get.snackbar("Error", "Could not fetch Trending BoomBoxes");
          //Handle errors
        }
      }
    } on SocketException catch (_) {
      CustomSnackBar().networkErrorSnack(fetchTrendingBoxes());
    }
  }

  loadMore() async {
    if (currentPage <= totalPages &&
        scrollController.position.extentAfter < 300) {
      currentPage++;
      update();
      EasyLoading.show(status: "Loading More Booms");
      final res = await homeService.fetchBooms(currentPage);

      if (res.statusCode == 200) {
        EasyLoading.dismiss();
        allBooms = AllBooms.fromJson(jsonDecode(res.body));
        _homeBooms!.addAll(allBooms!.booms!);
        update();
      } else {
        log("error occured on fetch boom (load more))");
        EasyLoading.dismiss();
        CustomSnackBar.showCustomSnackBar(
            errorList: ["Could not fetch Booms"],
            msg: ["Error"],
            isError: true);
      }
    } else {}
  }

  initializeVideos() async {
    videoPlayerControllers.add(
      CachedVideoPlayerController.network(
          "https://topitbackend.s3.us-east-2.amazonaws.com/1631832288865-1631832230476.mp4"),
    );

    await videoPlayerControllers[0].initialize();
  }

  reactToBoom(String reactType, String boomId, int index) async {
    log("$reactType to $boomId");
    final res = await homeService.reactToBoom(reactType, boomId);

    if (res.statusCode == 200) {
    } else {
      log("error occured on react to boom");
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Could not react to Boom"],
          msg: ["Error"],
          isError: true);
    }
  }
}
