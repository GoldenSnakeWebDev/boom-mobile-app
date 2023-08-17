import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SingleBoomService {
  final box = GetStorage();

  String boomId = Get.arguments[0];

  bool isLoading = true;

  Stream<Boom?> getSingleBoom() async* {
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
          final singleBoom = Boom.fromJson(jsonDecode(res.body)["boom"]);
          yield singleBoom;
        } else {
          log("Single Boom Error ::: ${res.statusCode} ::: ${res.body}");
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<Boom?> getBoomDets(String boom) async {
    String token = box.read("token");
    try {
      var res = await http.get(
        Uri.parse("${baseURL}booms/$boom"),
        headers: {
          "Authorization": token,
        },
      );

      if (res.statusCode == 200) {
        final singleBoom = Boom.fromJson(jsonDecode(res.body)["boom"]);
        return singleBoom;
      } else {
        log("Single Boom Error ::: ${res.statusCode} ::: ${res.body}");
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  deleteBoom(String boomId) async {
    String token = box.read("token");
    EasyLoading.show(status: "Deleting Boom");
    try {
      var res = await http.delete(
        Uri.parse("${baseURL}booms/$boomId"),
        headers: {"Authorization": token},
      );
      if (res.statusCode == 204) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Boom deleted").then((value) {
          Get.back();
          Get.offAll(const MainScreen());
        });
      } else {
        EasyLoading.dismiss();
        CustomSnackBar.showCustomSnackBar(
            errorList: ["Delete Error"],
            msg: ["Could not delete boom"],
            isError: true);
      }
      log("Error ::: ${res.statusCode} ::: ${res.body}");
    } catch (e) {
      log(e.toString());
    }
  }
}
