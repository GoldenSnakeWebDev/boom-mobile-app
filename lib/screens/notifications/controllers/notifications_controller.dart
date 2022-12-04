import 'dart:developer';

import 'package:boom_mobile/screens/notifications/models/notification_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class NotificationsController extends GetxController {
  final box = GetStorage();
  NotificationsModel? notificationsModel;
  bool isLoading = false;

  @override
  void onInit() {
    fetchAllNotifications();
    super.onInit();
  }

  fetchAllNotifications() async {
    isLoading = true;
    final res = await http.get(
      Uri.parse("${baseURL}notifications?page=all"),
      headers: {
        "Authorization": box.read("token"),
      },
    );

    if (res.statusCode == 200) {
      isLoading = false;
      notificationsModel = notificationsModelFromJson(res.body);
      update();
    } else {
      isLoading = false;
      log("message ::: ${res.statusCode}");
      log("message ::: ${res.body}");
      update();
    }
  }
}
