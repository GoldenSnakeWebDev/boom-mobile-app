import 'dart:developer';

import 'package:boom_mobile/screens/notifications/models/notification_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class NotificationsController extends GetxController {
  final box = GetStorage();
  NotificationsModel? notificationsModel;
  bool isLoading = false;
  int currPage = 1;
  int pageLimit = 0;

  @override
  void onInit() {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    analytics.setCurrentScreen(screenName: "Notifications Screen");
    fetchAllNotifications();
    super.onInit();
  }

  fetchAllNotifications() async {
    isLoading = true;
    update();
    final res = await http.get(
      Uri.parse("${baseURL}notifications?page=all"),
      headers: {
        "Authorization": box.read("token"),
      },
    );

    if (res.statusCode == 200) {
      isLoading = false;
      notificationsModel = notificationsModelFromJson(res.body);
      notificationsModel!.notifications!.reversed.toList();
      update();
    } else {
      isLoading = false;
      log("message ::: ${res.statusCode}");
      log("message ::: ${res.body}");
      update();
    }
  }

  loadMoreNotifications(int page) async {}
}
