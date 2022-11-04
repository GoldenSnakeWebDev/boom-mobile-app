import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../authentication/login/models/user_model.dart';

class EditProfileController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  final box = GetStorage();
  final User? user = Get.find<MainScreenController>().user;

  @override
  void onInit() {
    usernameController.text = user!.username;

    super.onInit();
  }
}
