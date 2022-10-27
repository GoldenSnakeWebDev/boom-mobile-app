import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var isPassVisible = true.obs;
  var isConfirmPassVisibe = true.obs;

  void changePassVisibility() {
    isPassVisible.value = !isConfirmPassVisibe.value;
  }

  void changeConfirmPassVisibility() {
    isConfirmPassVisibe.value = !isConfirmPassVisibe.value;
    update();
  }

  bool validatePassword() {
    if (passwordController.text.trim().length ==
            confirmPasswordController.text.trim().length &&
        passwordController.text.trim() ==
            confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerUser() async {
    if (formKey.currentState!.validate() && validatePassword()) {
      Map<String, dynamic> userData = {
        "email": emailController.text.trim(),
        "username": usernameController.text.trim(),
        "password": passwordController.text.trim(),
      };

      log("Body ${jsonEncode(userData)}");
      EasyLoading.show(status: "Signing up...");

      final res = await http.post(
        Uri.parse("${baseURL}users/signup"),
        body: jsonEncode(userData),
      );

      if (res.statusCode == 201) {
        EasyLoading.dismiss();

        CustomSnackBar.showCustomSnackBar(
            errorList: [jsonDecode(res.body)["message"]],
            msg: ["Success"],
            isError: false);

        return true;
      } else {
        EasyLoading.dismiss();
        log("Error ${jsonDecode(res.body)}");
        log("Error ${res.statusCode}");
        CustomSnackBar.showCustomSnackBar(
            errorList: [jsonDecode(res.body)["errors"][0]["message"]],
            msg: ["Sign up Error"],
            isError: true);

        return false;
      }
    }
    return false;
  }
}
