import 'dart:developer';

import 'package:boom_mobile/screens/direct_messages/models/new_message_response.dart';
import 'package:boom_mobile/screens/direct_messages/service/messages_service.dart';
import 'package:boom_mobile/screens/direct_messages/single_message.dart';
import 'package:boom_mobile/screens/profile_screen/models/boom_box_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/boom_users_model.dart' as user;

class DMCrontroller extends GetxController {
  final service = DMService();
  final _storage = GetStorage();

  // IOWebSocketChannel? channel;

  BoomBoxModel? _boomBoxes;
  BoomBoxModel? get boomBoxes => _boomBoxes;

  List<user.User>? _boxUsers;
  List<user.User>? get boxUsers => _boxUsers;

  List<BoomBox> dmMessages = [];
  List<BoomBox> groupMessages = [];
  // List<BoomBox>? get dmMessages => _dmMessages;

  var isLoading = false.obs;

  String boomBox = '';
  String userId = '';

  final box = GetStorage();

  setLoading(bool value) {
    isLoading.value = value;
  }

  @override
  void onInit() {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    analytics.setCurrentScreen(screenName: "Direct Message Screen");
    userId = box.read("userId");
    fetchBoomBoxMessages();
    fetchUsers();
    // channel = IOWebSocketChannel.connect(
    //   'ws://170.16.2.44:4000',
    // );
    super.onInit();
  }

  // Fetch boom box messages
  Future<dynamic> fetchBoomBoxMessages() async {
    setLoading(true);
    var ress = await service.fetchBoomBoxMessages();
    setLoading(false);
    if (ress != null) {
      _boomBoxes = ress;
      _boomBoxes!.boomBoxes.sort((a, b) =>
          b.messages.last.createdAt.compareTo(a.messages.last.createdAt));

      dmMessages.clear();
      groupMessages.clear();

      for (var item in _boomBoxes!.boomBoxes) {
        if (item.isGroup == false) {
          dmMessages.add(item);
        } else {
          groupMessages.add(item);
        }
      }
      update();
    }
  }

  Future<dynamic> fetchUsers() async {
    var ress = await service.fetchUsers();
    final myUserId = box.read("useId");
    if (ress != null) {
      _boxUsers = [...ress];
      _boxUsers!.removeWhere((element) => element.id == myUserId);

      update();
    }
  }

  // Future<dynamic> fetchDMs(String boomId) async {
  //   var ress = await service.fetchDMs(boomId);
  //   if (ress != null) {
  //     _dmMessages = ress.messages;
  //     update();
  //     return true;
  //   }
  // }

  chatWithUser(String message, String boomBoxId) async {
    // setLoading(true);
    var ress = await service.chatWithUser(message, boomBoxId);
    fetchBoomBoxMessages();
    // setLoading(false);
    update();

    if (ress != null) {
      fetchBoomBoxMessages();
      boomBox = ress;
    }
    return ress;
  }

  goToSingleUserMessage(int index) async {
    if (dmMessages.isEmpty) {
      NewBoomBoxResponse? res = await service.createNewMessage(
        boxUsers![index].id!,
        boxUsers![index].photo!,
        boxUsers![index].username!,
      );

      if (res != null) {
        EasyLoading.dismiss();
        Get.back();

        final boomBox = res;
        Get.to(
          () => SingleMessage(
            boomBoxModel: boomBox.boomBox,
            isBoomBox: false,
          ),
        );
        return;
      }
    } else {
      for (var item in dmMessages) {
        log("Dm Messages ${item.id}");
        log("Box User ${boxUsers![index].id}");
        log("List Id ${item.members.first.user.id}");

        if (boxUsers![index].id == item.members.first.user.id) {
          Get.back();

          update();
          Get.to(
            () => SingleMessage(
              boomBoxModel: item,
              isBoomBox: false,
            ),
          );
          return;
        }
      }

      NewBoomBoxResponse? res = await service.createNewMessage(
        boxUsers![index].id!,
        boxUsers![index].photo!,
        boxUsers![index].username!,
      );

      if (res != null) {
        EasyLoading.dismiss();
        Get.back();

        final boomBox = res;
        log("Boom Box ${boomBox.boomBox.id} ${boomBox.boomBox.members.first.user.id}");
        Get.to(
          () => SingleMessage(
            boomBoxModel: boomBox.boomBox,
            isBoomBox: false,
          ),
        );
        return;
      } else {
        Get.snackbar(
          "Error",
          "Could not message User",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        return;
      }
    }
  }
}
