import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/home_screen/models/single_boom_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SingleBoomService {
  final box = GetStorage();

  String boomId = Get.arguments[0];

  bool isLoading = true;

  Stream<SingleBoom?> getSingleBoom() async* {
    String token = box.read("token");

    while (true) {
      try {
        var res = await http.get(
          Uri.parse("${baseURL}booms/$boomId"),
          headers: {
            "Authorization": token,
          },
        );

        if (res.statusCode == 200) {
          final singleBoom = SingleBoom.fromJson(jsonDecode(res.body));
          yield singleBoom;
        } else {
          log("Single Boom Error ::: ${res.statusCode} ::: ${res.body}");
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
