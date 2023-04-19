import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/screens/home_screen/models/single_boom_model.dart';
import 'package:boom_mobile/screens/home_screen/services/home_service.dart';
import 'package:boom_mobile/screens/home_screen/services/single_boom_service.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SingleBoomController extends GetxController {
  final box = GetStorage();
  HomeService homeService = HomeService();
  SingleBoomService singleBoomService = SingleBoomService();
  bool isLikes = false;
  bool isLoves = false;
  bool isSmiles = false;
  bool isRebooms = false;
  bool isReports = false;
  bool commentLoading = false;
  int likesCount = 0;
  int lovesCount = 0;
  int smilesCount = 0;
  int reboomsCount = 0;
  int reportsCount = 0;

  TextEditingController commentController = TextEditingController();
  FocusNode commentFocusNode = FocusNode();

  syntheticallyMintBoom(String boomId) async {
    EasyLoading.show(status: "Minting...");

    final res = await http.post(
      Uri.parse("${baseURL}by-booms-with-sync-coins"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": box.read("token"),
      },
      body: jsonEncode({
        "boom": boomId,
      }),
    );
    if (res.statusCode == 200) {
      EasyLoading.dismiss();
      Get.snackbar("Minting", "Boom successfully minted",
          backgroundColor: kPrimaryColor);
      Get.off(() => const MainScreen(), binding: AppBindings());
    } else {
      log(res.body);
      log(boomId);
      log(res.statusCode.toString());

      EasyLoading.dismiss();
      Get.snackbar("Minting", "Boom minting failed",
          backgroundColor: kwarningColor1);
    }
  }

  Future<bool> reactToBoom(String reactType, String boomId) async {
    final res = await homeService.reactToBoom(reactType, boomId);

    if (res.statusCode == 200) {
      log("Boom Reacted To : $reactType");
      log("message: ${res.body}");
      update();
      return true;
    } else {
      log("Reaction Body ${res.body}");
      log("Reaction Code ${res.statusCode}");
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Could not react to Boom"],
          msg: ["Error"],
          isError: true);
      return false;
    }
  }

  fetchReactionStatus(SingleBoom boom) {
    likesCount = boom.boom.reactions!.likes.length;
    lovesCount = boom.boom.reactions!.loves.length;
    smilesCount = boom.boom.reactions!.smiles.length;
    reboomsCount = boom.boom.reactions!.rebooms.length;
    reportsCount = boom.boom.reactions!.reports.length;

    String userId = box.read("userId");
    for (var item in boom.boom.reactions!.likes) {
      if (item.id == userId) {
        isLikes = true;
      } else {
        isLikes = false;
      }
    }
    for (var item in boom.boom.reactions!.loves) {
      if (item.id == userId) {
        isLoves = true;
      } else {
        isLoves = false;
      }
    }
    for (var item in boom.boom.reactions!.smiles) {
      if (item.id == userId) {
        isSmiles = true;
      } else {
        isSmiles = false;
      }
    }
    for (var item in boom.boom.reactions!.reports) {
      if (item.id == userId) {
        isReports = true;
      } else {
        isReports = false;
      }
    }
    for (var item in boom.boom.reactions!.rebooms) {
      if (item.id == userId) {
        isRebooms = true;
      } else {
        isRebooms = false;
      }
    }
    update();
  }

  commentOnPost(String text, String boomId) async {
    commentLoading = true;

    String token = box.read("token");

    var d12 = DateFormat('MM-dd-yyyy, hh:mm a').format(DateTime.now());
    Map<String, dynamic> body = {
      "message": text,
      "timestamp": d12,
    };
    var res = await http.post(Uri.parse("${baseURL}booms/$boomId/comments"),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(body));
    if (res.statusCode == 201) {
      commentLoading = false;

      commentController.clear();
    } else {
      commentLoading = false;
      log(res.body);
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Could not comment on Boom"],
          msg: ["Error"],
          isError: true);
    }
  }

  refreshPage() {
    singleBoomService.getSingleBoom();
    update();
  }

  obtainBoom() async {}

  viewBoomContract() async {}

  reportBoom() async {}
}
