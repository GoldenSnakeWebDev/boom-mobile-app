import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/direct_messages/models/boom_box_response.dart';
import 'package:boom_mobile/screens/direct_messages/models/boom_users_model.dart';
import 'package:boom_mobile/screens/direct_messages/service/messages_service.dart';
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
  late BoomUsers boomUsers;
  final dmService = DMService();

  bool isLoading = false;

  List<User>? _users;
  List<User>? get users => _users;

  List<BoomBox>? _boomBoxes;
  List<BoomBox>? get boomBoxes => _boomBoxes;

  List<User> selectedUsers = [];

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
    var ress = await dmService.fetchBoomBoxMessages();

    if (ress != null) {
      _boomBoxes = ress;
      _boomBoxes!.sort((a, b) =>
          b.messages!.last.timestamp!.compareTo(a.messages!.last.timestamp!));
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
