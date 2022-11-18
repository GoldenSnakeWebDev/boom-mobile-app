import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/other_user_profile/models/other_user_booms.dart';
import 'package:boom_mobile/screens/other_user_profile/models/other_user_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OtherProfileService {
  final box = GetStorage();

  Stream<OtherUserModel?> fetchotherUserProfile(String userId) async* {
    String token = box.read("token");

    log("User Id $userId");

    while (true) {
      try {
        var res = await http.get(
          Uri.parse("${baseURL}users/$userId"),
          headers: {
            "Authorization": token,
          },
        );
        if (res.statusCode == 200) {
          final user = OtherUserModel.fromJson(jsonDecode(res.body));

          yield user;
        } else {
          log("Error ${res.statusCode}");
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  followUser(String userId) async {
    String token = box.read("token");
    final res = await http.patch(
      Uri.parse("${baseURL}friends/$userId"),
      headers: {"Authorization": token},
    );

    if (res.statusCode == 200) {
      log("Followed");
    } else {
      log(res.body);
      log(res.statusCode.toString());
      Get.snackbar("Error", "Could not follow user");
    }
  }

  Stream<OtherUserBooms?> fetchUserBooms(String userId) async* {
    String token = box.read("token");

    log("User Id $userId");

    while (true) {
      try {
        var res = await http.get(
          Uri.parse("${baseURL}fetch-user-booms/$userId?page=all"),
          headers: {
            "Authorization": token,
          },
        );

        if (res.statusCode == 200) {
          final booms = OtherUserBooms.fromJson(jsonDecode(res.body));

          yield booms;
        } else {
          log("Error ${res.statusCode}");
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
