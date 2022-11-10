import 'dart:developer';

import 'package:boom_mobile/screens/home_screen/services/home_service.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SingleBoomController extends GetxController {
  final box = GetStorage();
  HomeService homeService = HomeService();

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

  obtainBoom() async {}

  viewBoomContract() async {}

  reportBoom() async {}
}
