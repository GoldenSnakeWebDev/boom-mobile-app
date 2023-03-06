import 'package:get/get.dart';

class ViewTalesController extends GetxController {
  int storyIndex = 0;
  int taleIndex = 0;

  @override
  void onInit() {
    super.onInit();
    storyIndex = Get.arguments[0] ?? 0;
  }

  //Update details for next tale
  updateDetailsForNextTale(int index) {
    taleIndex = index;
    update();
  }

  updateDetailsForNextStory(int index) {
    storyIndex = index;
    update();
  }
}
