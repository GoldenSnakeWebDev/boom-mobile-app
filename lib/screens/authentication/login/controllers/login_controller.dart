import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:unique_identifier/unique_identifier.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final box = GetStorage();
  UserModel? user;

  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  @override
  void onInit() async {
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
    String deviceId = '';
    if (Platform.isAndroid) {
      final device = await UniqueIdentifier.serial;
      deviceId = device.toString();
      log("Device ID: $deviceId");
    } else {
      final device = await UniqueIdentifier.serial;
      deviceId = device.toString();
      log("Device ID: $deviceId");
    }

    if (loginformKey.currentState!.validate()) {
      EasyLoading.show(status: "Signing in...");
      String username = '';
      if (userNameController.text.trim().startsWith("!")) {
        username = userNameController.text.trim().substring(1);
      } else {
        username = userNameController.text.trim();
      }
      final res = await http.post(
        Uri.parse("${baseURL}users/signin"),
        headers: headers,
        body: jsonEncode(
          {
            "email": username,
            "password": passwordController.text.trim(),
            "deviceId": deviceId,
          },
        ),
      );

      if (res.statusCode == 200) {
        user = UserModel.fromJson(jsonDecode(res.body));
        await OneSignal.shared.setExternalUserId(deviceId).then((value) {
          log("OneSignal External User ID: $deviceId");
        }).catchError((error) {
          log("OneSignal External User ID Error: $error");
        });
        EasyLoading.dismiss();
        CustomSnackBar.showCustomSnackBar(
          errorList: [jsonDecode(res.body)["message"]],
          msg: [],
          isError: false,
        );
        box.write("token", "Bearer ${jsonDecode(res.body)["token"]}");
        box.write("userId", user!.user!.id);
        update();
        return true;
      } else {
        EasyLoading.dismiss();
        log(res.body);
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
        log("Reset password response: ${res.statusCode}");
        if (res.statusCode == 201) {
          EasyLoading.dismiss();
          CustomSnackBar.showCustomSnackBar(
            errorList: ["Password reset code sent to your email"],
            msg: ["Password reset code sent to your email"],
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

  Future<dynamic> changePassword() async {
    var headers = {'Content-Type': 'application/json'};

    if (resetPasswordFormKey.currentState!.validate()) {
      EasyLoading.show(status: "Changing password...");
      final response = await http.post(
        Uri.parse("${baseURL}users/password-reset"),
        headers: headers,
        body: jsonEncode(
          {
            "code": codeController.text.trim(),
            "password": newPasswordController.text.trim(),
            "confirm_password": confirmPasswordController.text.trim()
          },
        ),
      );

      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        CustomSnackBar.showCustomSnackBar(
          errorList: ["Password reset successful"],
          msg: ["Password reset successful"],
          isError: false,
        );
        return true;
      } else {
        EasyLoading.dismiss();
        log(response.body);
        CustomSnackBar.showCustomSnackBar(
          errorList: [jsonDecode(response.body)["errors"][0]["message"]],
          msg: [],
          isError: true,
        );
        log(response.statusCode.toString());
        return false;
      }
    }
  }
}
