import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  final box = GetStorage();
  // FetchCurrUserRepo repo = Get.find();

  Stream<User?> fetchMyProfile() async* {
    String token = box.read('token');
    while (true) {
      try {
        final res = await http.get(
          Uri.parse("${baseURL}users/currentUser"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": token,
          },
        );

        if (res.statusCode == 200) {
          final user = User.fromJson(jsonDecode(res.body)["user"]);
          yield user;
        } else {
          log("Profile Error ::: ${res.statusCode} ::: ${res.body}");
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
