import 'package:boom_mobile/screens/new_post/controllers/new_post_controller.dart';
import 'package:boom_mobile/screens/tales/controllers/camera_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TalesController>(() => TalesController());
    Get.lazyPut<NewPostController>(() => NewPostController());
  }
}
