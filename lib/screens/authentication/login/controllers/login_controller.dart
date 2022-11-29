import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final box = GetStorage();
  UserModel? user;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await checkIfUserIsLoggedIn();
  }

  checkIfUserIsLoggedIn() async {
    if (box.read("token") != null) {
      log("Token is not null");
      Get.offAll(() => const MainScreen());
    } else {
      log("Token is null");
    }
  }

  var isPassVisible = true.obs;

  void changePassVisibility() {
    isPassVisible.value = !isPassVisible.value;
    // update();
  }

  Future<bool> loginUser() async {
    var headers = {'Content-Type': 'application/json'};

    if (loginformKey.currentState!.validate()) {
      EasyLoading.show(status: "Signing in...");
      final res = await http.post(
        Uri.parse("${baseURL}users/signin"),
        headers: headers,
        body: jsonEncode(
          {
            "email": userNameController.text.trim(),
            "password": passwordController.text.trim()
          },
        ),
      );

      if (res.statusCode == 200) {
        user = UserModel.fromJson(jsonDecode(res.body));
        EasyLoading.dismiss();
        CustomSnackBar.showCustomSnackBar(
          errorList: [jsonDecode(res.body)["message"]],
          msg: [],
          isError: false,
        );
        box.write("token", "Bearer " + jsonDecode(res.body)["token"]);
        box.write("userId", user!.user!.id);
        update();
        return true;
      } else {
        EasyLoading.dismiss();
        CustomSnackBar.showCustomSnackBar(
          errorList: [jsonDecode(res.body)["errors"][0]["message"]],
          msg: [],
          isError: true,
        );
        return false;
      }
    } else {
      return false;
    }
  }

  Future<dynamic> resetPassword() async {
    var headers = {'Content-Type': 'application/json'};

    if (userNameController.text.isNotEmpty) {
      try {
        EasyLoading.show(status: "Initiating password reset...");
        final res = await http.post(
          Uri.parse("${baseURL}users/request-password-reset"),
          headers: headers,
          body: jsonEncode(
            {
              "email": userNameController.text.trim(),
            },
          ),
        );
        log("Reset password response: ${res.body}");
        if (res.statusCode == 200) {
          EasyLoading.dismiss();
          CustomSnackBar.showCustomSnackBar(
            errorList: [jsonDecode(res.body)["message"]],
            msg: [],
            isError: false,
          );
          return true;
        } else {
          EasyLoading.dismiss();
          CustomSnackBar.showCustomSnackBar(
            errorList: [jsonDecode(res.body)["errors"][0]["message"]],
            msg: [],
            isError: true,
          );
          return false;
        }
      } catch (e) {
        EasyLoading.showError("Error: $e");
        log(e.toString());
      }
    } else {
      EasyLoading.showError("Please enter your email");
      return false;
    }
  }
}
