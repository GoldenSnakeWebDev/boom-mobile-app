import 'package:get/get.dart';

import '../../home_screen/models/single_boom_model.dart';

class OtherUserProfileController extends GetxController {
  User? user;
  bool isNewUser = false;
  bool isVerified = false;
  int numOfFans = 0;
  int numOfFrens = 0;
  int numOfBooms = 0;
  @override
  void onInit() {
    super.onInit();
    user = Get.arguments;
    if (user!.bio.isEmpty) {
      isNewUser = true;
    }
    if (user!.username == "Ani") {
      isVerified = true;
    }
  }
}
