import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OtherProfileService {
  final box = GetStorage();

  Stream<User?> fetchotherUserProfile() async* {
    String token = box.read("token");
    User userId = Get.arguments;
    log("User Id ${userId.id}");

    while (true) {
      try {
        var res = await http.get(
          Uri.parse("${baseURL}users/${userId.id}"),
          headers: {
            "Authorization": token,
          },
        );
        if (res.statusCode == 200) {
          final user = User.fromJson(jsonDecode(res.body));
          yield user;
        } else {
          log("Error ${res.statusCode}");
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
