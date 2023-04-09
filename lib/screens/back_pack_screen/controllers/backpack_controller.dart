import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/direct_messages/models/boom_users_model.dart';
import '../../authentication/login/models/user_model.dart' as usr;
import 'package:boom_mobile/screens/direct_messages/service/messages_service.dart';
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
  final dmService = DMService();

  List<User>? _boxUsers;
  List<User>? get boxUsers => _boxUsers;
  late usr.User user;

  @override
  void onInit() {
    super.onInit();
    userId = box.read("userId");
    token = box.read("token");
    fetchMyDetails();
    fetchUsers();
    fetchMyBooms();
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    analytics.setCurrentScreen(screenName: "BackPack Screen");
  }

  fetchMyDetails() async {
    String token = box.read("token");
    var res = await http.get(Uri.parse("${baseURL}users/currentuser"),
        headers: {"Authorization": token});
    if (res.statusCode == 200) {
      user = usr.User.fromJson(jsonDecode(res.body)["user"]);
      update();
    } else {
      log("Error in fetching my details");
    }
  }

  fetchMyBooms() async {
    EasyLoading.show(status: 'loading...');
    final res =
        await http.get(Uri.parse("${baseURL}booms/mine?page=all"), headers: {
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

  onTapYesSendBoom(int index, int receiverId) async {
    EasyLoading.show(status: 'loading...');
    final res = await http.post(
      Uri.parse("${baseURL}transfer-my-boom/${myBooms!.booms![index].id}"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(
        {
          "receiver": _boxUsers![receiverId].id,
        },
      ),
    );

    if (res.statusCode == 200) {
      EasyLoading.dismiss();
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Boom sent successfully"],
          msg: ["Success"],
          isError: false);
      fetchMyBooms();

      update();
      return true;
    } else {
      EasyLoading.dismiss();
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Something went wrong"], msg: ["Error"], isError: true);

      update();
      return false;
    }
  }

  Future<dynamic> fetchUsers() async {
    var ress = await dmService.fetchUsers();
    final myUserId = box.read("useId");
    if (ress != null) {
      _boxUsers = [...ress];
      _boxUsers!.removeWhere((element) => element.id == myUserId);

      update();
    }
  }
}
