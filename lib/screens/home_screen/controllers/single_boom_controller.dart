import 'dart:developer';

import 'package:boom_mobile/screens/home_screen/models/single_boom_model.dart';
import 'package:boom_mobile/screens/home_screen/services/home_service.dart';
import 'package:boom_mobile/screens/home_screen/services/single_boom_service.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SingleBoomController extends GetxController {
  final box = GetStorage();
  HomeService homeService = HomeService();
  SingleBoomService singleBoomService = SingleBoomService();
  bool isLiked = false;
  bool isLoves = false;
  bool isSmiles = false;
  bool isRebooms = false;

  Future<bool> reactToBoom(String reactType, String boomId) async {
    log("$reactType to $boomId");
    final res = await homeService.reactToBoom(reactType, boomId);

    if (res.statusCode == 200) {
      log("Boom Reacted To : $reactType");
      log("message: ${res.body}");
      return true;
    } else {
      log(res.body);
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Could not react to Boom"],
          msg: ["Error"],
          isError: true);
      return false;
    }
  }

  fetchReactionStatus(SingleBoom boom) {
    String userId = box.read("userId");
    for (var item in boom.boom.reactions.likes) {
      if (item.id == userId) {
        isLiked = true;
      }
    }
    for (var item in boom.boom.reactions.loves) {
      if (item.id == userId) {
        isLoves = true;
      }
    }
    for (var item in boom.boom.reactions.smiles) {
      if (item.id == userId) {
        isSmiles = true;
      }
    }
    for (var item in boom.boom.reactions.rebooms) {
      if (item.id == userId) {
        isRebooms = true;
      }
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
