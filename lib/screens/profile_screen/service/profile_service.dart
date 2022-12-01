import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/repo/get_user/get_curr_user.dart';
import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileService {
  final box = GetStorage();
  FetchCurrUserRepo repo = Get.find();

  Stream<User?> fetchMyProfile() async* {
    String token = box.read('token');
    while (true) {
      try {
        final res = await repo.fetchCurrUser(token);

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
