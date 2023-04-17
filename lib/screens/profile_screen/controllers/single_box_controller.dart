import 'package:boom_mobile/screens/direct_messages/service/messages_service.dart';
import 'package:boom_mobile/screens/profile_screen/models/boom_box_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SingleBoxController extends GetxController {
  final service = DMService();
  final _storage = GetStorage();
  var isLoading = false.obs;
  TextEditingController messageController = TextEditingController();
  late BoomBox boomBoxModel;

  @override
  void onInit() {
    super.onInit();
    boomBoxModel = Get.arguments[0];
  }

  chatWithUser(String action, String message, String receiverId,
      String boomBoxUd) async {}
}
