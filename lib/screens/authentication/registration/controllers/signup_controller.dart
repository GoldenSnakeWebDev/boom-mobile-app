import 'dart:convert';

import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  GlobalKey<FormState> regFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

  var isPassVisible = true.obs;
  var isConfirmPassVisibe = true.obs;

  void changePassVisibility() {
    isPassVisible.value = !isPassVisible.value;
    // update();
  }

  void changeConfirmPassVisibility() {
    isConfirmPassVisibe.value = !isConfirmPassVisibe.value;
    // update();
  }

  bool validatePassword() {
    if (passwordController.text.trim().length ==
            confirmPasswordController.text.trim().length &&
        passwordController.text.trim() ==
            confirmPasswordController.text.trim() &&
        regex.hasMatch(passwordController.text.trim()) &&
        regex.hasMatch(confirmPasswordController.text.trim()) &&
        passwordController.text.trim().length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerUser() async {
    var headers = {'Content-Type': 'application/json'};
    if (regFormKey.currentState!.validate() && validatePassword()) {
      Map<String, dynamic> userData = {
        "email": emailController.text.trim(),
        "username": usernameController.text.trim(),
        "password": passwordController.text.trim(),
      };

      EasyLoading.show(status: "Signing up...");

      final res = await http.post(
        Uri.parse("${baseURL}users/signup"),
        headers: headers,
        body: jsonEncode(userData),
      );

      if (res.statusCode == 201) {
        EasyLoading.dismiss();

        CustomSnackBar.showCustomSnackBar(
          errorList: [jsonDecode(res.body)["message"]],
          msg: ["Success"],
          isError: false,
        );

        return true;
      } else {
        EasyLoading.dismiss();

        CustomSnackBar.showCustomSnackBar(
          errorList: [
            "Sign up Error: ${jsonDecode(res.body)["errors"][0]["message"]}"
          ],
          msg: ["Sign up Error"],
          isError: true,
        );

        return false;
      }
    } else {
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Please make sure you password meets the requirements"],
          msg: ["Input Error"],
          isError: true);
    }
    return false;
  }
}
