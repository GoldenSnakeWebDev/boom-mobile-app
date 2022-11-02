import 'package:get/get.dart';

class ProfileController extends GetxController {
  bool isNewUser = true;
  int selectedTab = 0;

  changeSelectedIndex(int index) {
    selectedTab = index;
    update();
  }
}
