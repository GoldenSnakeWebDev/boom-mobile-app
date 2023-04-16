import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/direct_messages/models/boom_users_model.dart'
    as user;
import 'package:boom_mobile/screens/direct_messages/service/messages_service.dart';
import 'package:boom_mobile/screens/profile_screen/models/boom_box_model.dart';
import 'package:boom_mobile/screens/profile_screen/service/boom_box_service.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class BoomBoxController extends GetxController {
  final TextEditingController boomBoxNameController = TextEditingController();
  final box = GetStorage();
  final formKey = GlobalKey<FormState>();
  late user.BoomUsers boomUsers;
  final dmService = DMService();
  final boomBoxService = BoomBoxService();

  bool isLoading = false;

  List<user.User>? _users;
  List<user.User>? get users => _users;

  List<BoomBox> boomBoxes = [];
  // List<BoomBoxModel>? get boomBoxes => _boomBoxes;

  List<user.User> selectedUsers = [];

  @override
  void onInit() {
    fetchUserBoomBoxes();
    fetchUsers();
    super.onInit();
  }

  @override
  void onClose() {
    boomBoxNameController.dispose();
    super.onClose();
  }

  //fetch BoomUsers

  fetchUsers() async {
    var ress = await dmService.fetchUsers();
    final myUserId = box.read("useId");
    if (ress != null) {
      _users = [...ress];
      _users!.removeWhere((element) => element.id == myUserId);
      update();
    }
  }

  fetchUserBoomBoxes() async {
    isLoading = true;
    update();
    final ress = await boomBoxService.fetchUserBoomBox();
    boomBoxes.clear();
    if (ress.statusCode == 200) {
      for (var item in BoomBoxModel.fromJson(jsonDecode(ress.body)).boomBoxes) {
        boomBoxes.add(item);
      }

      isLoading = false;
      update();
    } else {
      Get.snackbar(
        "Error",
        "Error fetching boomboxes",
        backgroundColor: kredCancelLightColor,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading = false;
      update();
    }
  }

  selectUsers(index) {
    if (selectedUsers.contains(users![index])) {
      selectedUsers.remove(users![index]);
    } else {
      selectedUsers.add(users![index]);
    }
    update();
  }

  createBox() async {
    //Create BoomBox and add to user's boombox list
    EasyLoading.show(status: "Creating BoomBox");
    final token = box.read("token");
    final userId = box.read("userId");
    final receiverId = selectedUsers[0].id;
    // final receiverId = selectedUsers.map((e) => e.id).toList().join(",");
    final body = {
      "command": "join_room",
      "content": "Created BoomBox",
      "author": userId,
      "receiver": receiverId,
      "box": "",
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };

    final res = await http.post(
      Uri.parse("${baseURL}boom-box"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      //Enter the created boombox
      Get.back();
      EasyLoading.dismiss();
      EasyLoading.showSuccess("BoomBox created");
      Get.snackbar("Error", "Error entering boombox",
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    } else {
      log(res.body);
      EasyLoading.dismiss();
      Get.snackbar(
        "Error",
        "Could not create boombox",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
}
