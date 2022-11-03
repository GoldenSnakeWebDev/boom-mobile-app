import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  bool isNewUser = true;
  int selectedTab = 0;
  int numberOfBooms = 0;
  int numberOfFans = 0;
  int numberOfFrens = 0;
  bool isVerified = false;

  List<SingleBoomPost> booms = [];

  changeSelectedIndex(int index) {
    selectedTab = index;
    update();
  }
}
