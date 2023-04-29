import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/direct_messages/models/boom_users_model.dart';
import 'package:boom_mobile/screens/direct_messages/models/messages_model.dart';
import 'package:boom_mobile/screens/direct_messages/models/new_message_response.dart'
    as newRes;
import 'package:boom_mobile/screens/profile_screen/models/boom_box_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DMService {
  final _storage = GetStorage();
  List<Message> messages = [];

  Future<dynamic> fetchBoomBoxMessages() async {
    var token = _storage.read('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };
    try {
      final response = await http.get(
        Uri.parse('${baseURL}boom-box'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final boomResponse = boomBoxModelFromJson(response.body);
        return boomResponse;
      } else {
        EasyLoading.showError('Error boom-boxes');
        return null;
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
      return null;
    }
  }

  fetchMessages(String boomBoxId) async* {
    final token = _storage.read("token");
    final res = await http.get(
      Uri.parse("${baseURL}boom-box/$boomBoxId"),
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

  Stream<DMBoomBox?> fetchDMs(String boomId) async* {
    var token = _storage.read('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };

    try {
      final response = await http.get(
        Uri.parse('${baseURL}boom-box/$boomId/messages'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final dMsResponse = dMsResponseFromJson(response.body);
        yield dMsResponse.boomBox;
      } else {
        // EasyLoading.showError('Error gettting dms');
        yield null;
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
      yield null;
    }
  }

  Future<dynamic> fetchUsers() async {
    var token = _storage.read('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };
    try {
      final response = await http.get(
        Uri.parse('${baseURL}users-only-funs-or-frens'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final boomUsers = boomUsersFromJson(response.body);
        return boomUsers.users;
      } else {
        EasyLoading.showError('Error boom-boxes');
        return null;
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
      return null;
    }
  }

  chatWithUser(String message, String boomBoxId) async {
    final token = _storage.read("token");
    final format = DateFormat("MM/dd/yyyy, hh:mm:ss a");
    var timeStamp = format.format(DateTime.now());
    final body = {
      "content": message,
      "timestamp": timeStamp,
    };

    final res = await http.post(
      Uri.parse("${baseURL}boom-box/$boomBoxId/messages"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
    } else {
      log("Response ${res.body} ${res.statusCode}");
      Get.snackbar(
        "Error",
        "Check your connection and try again",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // chatWithUser(Map<String, dynamic> boomBoxData) async {

  //   String boomBox = "";
  //   var token = _storage.read('token');
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': '$token',
  //   };

  //   try {
  //     final response = await http.post(
  //       Uri.parse('${baseURL}boom-box'),
  //       headers: headers,
  //       body: jsonEncode(boomBoxData),
  //     );

  //     if (response.statusCode == 200) {
  //       EasyLoading.dismiss();
  //       boomBox = jsonDecode(response.body)["boom_box"]["box"];
  //       return boomBox;
  //     } else {
  //       CustomSnackBar.showCustomSnackBar(
  //         errorList: [jsonDecode(response.body)["errors"][0]["message"]],
  //         msg: [jsonDecode(response.body)["errors"][0]["message"]],
  //         isError: true,
  //       );
  //       return null;
  //     }
  //   } catch (e) {
  //     // EasyLoading.showError('Error: $e');
  //     return null;
  //   }
  // }

  Future<newRes.NewBoomBoxResponse?> createNewMessage(
      String userId, String imageUrl, String username) async {
    EasyLoading.show(status: "DMing...");
    final token = _storage.read("token");
    final format = DateFormat("MM/dd/yyyy, hh:mm:ss a");
    var timeStamp = format.format(DateTime.now());
    final members = [userId];
    final body = {
      "members": members,
      "image_url": imageUrl,
      "label": username,
      "timestamp": timeStamp,
      "is_group_chat": false
    };

    final res = await http.post(
      Uri.parse("${baseURL}boom-box"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      EasyLoading.dismiss();
      final boomBox = newRes.NewBoomBoxResponse.fromJson(jsonDecode(res.body));

      return boomBox;
    } else {
      log("Create New Message: ${res.body}");
      EasyLoading.dismiss();

      return null;
    }
  }
}
