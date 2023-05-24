import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/direct_messages/models/boom_users_model.dart'
    as user;
import 'package:boom_mobile/screens/direct_messages/service/messages_service.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/boomBox_controller.dart';
import 'package:boom_mobile/screens/profile_screen/models/boom_box_model.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  final dmService = DMService();

  List<user.User>? _users;
  List<user.User>? get users => _users;

  List<user.User> selectedUsers = [];

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

  fetchBoomBoxDetails() async {
    final token = storage.read("token");

    final ress = await http
        .get(Uri.parse("${baseURL}boom-box/${boomBoxModel.id}"), headers: {
      "Authorization": token,
    });

    if (ress.statusCode == 200) {
      boomBoxModel = BoomBox.fromJson(jsonDecode(ress.body)["boomBox"]);

      update();
    } else {
      Get.snackbar(
        "Error",
        "Error fetching messages",
        backgroundColor: kredCancelLightColor,
        snackPosition: SnackPosition.BOTTOM,
      );

      update();
    }
  }

  //Fetch User's List

  fetchUsers() async {
    EasyLoading.show(status: "Fetching users");
    var ress = await dmService.fetchUsers();
    final myUserId = storage.read("userId");
    if (ress != null) {
      _users = [...ress];
      _users!.removeWhere((element) => element.id == myUserId);
      for (var item in boomBoxModel.members) {
        _users!.removeWhere((element) => element.id == item.user.id);
      }

      update();
    }
    EasyLoading.dismiss();
  }

  selectUsers(index) {
    if (selectedUsers.contains(users![index])) {
      selectedUsers.remove(users![index]);
    } else {
      selectedUsers.add(users![index]);
    }
    update();
  }

  leaveBoomBox() async {
    // Call the service to leave the boom box
    EasyLoading.show(status: "Leaving boom box");
    final token = storage.read("token");
    final myUserId = storage.read("userId");

    final res = await http.delete(
      Uri.parse("${baseURL}boom-box/${boomBoxModel.id}/messages/$myUserId"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
    );

    if (res.statusCode == 200) {
      //Handle success
      EasyLoading.dismiss();
      Get.back();

      await BoomBoxController().fetchUserBoomBoxes();
      Get.back();
    } else {
      log("Error Leaving BoomBox statuCode:: ${res.statusCode} Body:: ${res.body}");
      EasyLoading.dismiss();
      EasyLoading.showError("Error leaving boom box");
    }
  }

  deleteBoomBox() async {
    EasyLoading.show(status: "Deleting boom box");
    final token = storage.read("token");
    final res = await http.delete(
      Uri.parse("${baseURL}boom-box/${boomBoxModel.id}"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
    );
    if (res.statusCode == 204) {
      //Handle success
      EasyLoading.dismiss();
      Get.back();

      await BoomBoxController().fetchUserBoomBoxes();
      Get.back();
    } else {
      //Handle error
      log("Error Deleting BoomBox statuCode:: ${res.statusCode} Body:: ${res.body}");
      EasyLoading.dismiss();
      EasyLoading.showError("Error deleting boom box");
    }
  }

  removeUser(String memberId) async {
    EasyLoading.show(status: "Removing user");
    final token = storage.read("token");
    final res = await http.delete(
      Uri.parse("${baseURL}boom-box/${boomBoxModel.id}/messages/$memberId"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
    );
    if (res.statusCode == 200) {
      //Handle success
      EasyLoading.dismiss();
      EasyLoading.showSuccess("User removed successfully");
      await fetchBoomBoxDetails();
      Get.back();
      update();
    } else {
      //Handle error
      log("Error ${res.statusCode} adding user::: Res.Body>> ${res.body}");
      EasyLoading.dismiss();
      EasyLoading.showError("Error removing user");
    }
  }

  addUser() async {
    EasyLoading.show(status: "Adding user(s)");
    final token = storage.read("token");

    final format = DateFormat("MM/dd/yyyy, hh:mm:ss a");
    var timeStamp = format.format(DateTime.now());

    final members = selectedUsers.map((e) => e.id).toList();

    final body = {
      "label": boomBoxModel.label,
      "members": members,
      "timestamp": timeStamp,
    };
    final res = await http.patch(
      Uri.parse("${baseURL}boom-box/${boomBoxModel.id}"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      //Handle success
      EasyLoading.dismiss();
      EasyLoading.showSuccess("User(s) added successfully");
      await fetchBoomBoxDetails();

      Get.back();
      update();
    } else {
      log("Error ${res.statusCode} adding user::: Res.Body>> ${res.body}");
      EasyLoading.dismiss();
      EasyLoading.showError("Error adding user(s) to BoomBox");
    }
  }
}
