import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/direct_messages/service/messages_service.dart';
import 'package:boom_mobile/screens/profile_screen/models/boom_box_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SingleBoxController extends GetxController {
  final service = DMService();
  final storage = GetStorage();
  var isLoading = false.obs;
  TextEditingController messageController = TextEditingController();
  late BoomBox boomBoxModel;

  List<Message> messages = [];
  String userId = "";

  final ScrollController listViewController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    boomBoxModel = Get.arguments[0];
    userId = storage.read("userId");
    fetchMessages();
  }

  chatWithUser() async {
    final token = storage.read("token");
    final format = DateFormat("MM/dd/yyyy, hh:mm:ss a");
    var timeStamp = format.format(DateTime.now());
    final body = {
      "content": messageController.text,
      "timestamp": timeStamp,
    };

    final res = await http.post(
      Uri.parse("${baseURL}boom-box/${boomBoxModel.id}/messages"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      messageController.clear();
      fetchMessages();
      update();
    } else {
      log("message not sent ${res.body} ${res.statusCode}");
      Get.snackbar(
        "Error",
        "Check your connection and try again",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  fetchMessages() async* {
    final token = storage.read("token");
    final res = await http.get(
      Uri.parse("${baseURL}boom-box/${boomBoxModel.id}"),
      headers: {
        "Authorization": token,
      },
    );
    if (res.statusCode == 200) {
      messages.clear();
      for (var item in jsonDecode(res.body)["boomBox"]["messages"]) {
        messages.add(Message.fromJson(item));
      }
      yield messages;
    } else {
      Get.snackbar(
        "Error",
        "Error fetching messages",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  leaveBoomBox() async {
    // Call the service to leave the boom box

    final token = storage.read("token");

    final res = await http.post(
      Uri.parse(baseURL),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: {},
    );

    if (res.statusCode == 200) {
    } else {}
  }

  deleteBoomBox() async {}

  addUser() async {}
}
