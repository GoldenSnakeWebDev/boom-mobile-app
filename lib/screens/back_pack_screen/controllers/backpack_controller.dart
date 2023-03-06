import 'dart:convert';

import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class BackPackController extends GetxController {
  AllBooms? myBooms;
  final box = GetStorage();
  String userId = '';
  String token = '';
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    userId = box.read("userId");
    token = box.read("token");
    fetchMyBooms();
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    analytics.setCurrentScreen(screenName: "BackPack Screen");
  }

  fetchMyBooms() async {
    EasyLoading.show(status: 'loading...');
    final res = await http.get(
        Uri.parse("${baseURL}fetch-user-booms/$userId?page=all"),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
          "Accept": "application/json"
        });

    if (res.statusCode == 200) {
      EasyLoading.dismiss();
      myBooms = AllBooms.fromJson(jsonDecode(res.body));
      isLoading = false;
      update();
    } else {
      isLoading = false;
      EasyLoading.dismiss();
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Something went wrong"], msg: ["Error"], isError: true);
      update();
    }
  }
}
