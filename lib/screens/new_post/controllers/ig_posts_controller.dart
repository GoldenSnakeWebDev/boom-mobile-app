import 'package:boom_mobile/screens/new_post/models/insta_media.dart';
import 'package:get/get.dart';

class IGPostController extends GetxController {
  final List<InstaMedia> medias = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    medias.addAll(Get.arguments as List<InstaMedia>);
  }
}
