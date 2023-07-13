import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
  var isPassVisible = true.obs;

  List<String> noteStr = [
    "This version is a \"simulation\"(demo) of what's to come!",
    "With this simulation, users can own social content",
    "Users have the onus of trading content using simulated (pseudo) coins across Tezos, Polygon & BNB",
    "This simulation gives users a fun way to experience the application completely free and shows a preview of the exciting things that will be achieved with Boom!",
  ];

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

  checkIfNewUser(BuildContext context) async {
    if (box.read("newInstall") == null) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
          builder: (context) {
            return Container(
              height: SizeConfig.screenHeight * 0.7,
              width: SizeConfig.screenWidth,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(
                            MdiIcons.closeCircleOutline,
                            color: kredCancelTextColor,
                          ),
                          onPressed: () async {
                            Get.back();
                            await box.write("newInstall", true);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Text(
                        "Welcome to Boom! 💥",
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(24),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          border: Border.all(
                            color: Colors.black,
                            width: .5,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8.0,
                          ),
                          child: Text(
                            "Important, please read:",
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(14),
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(25),
                      ),
                      Text(
                        "Boom is where Merchants & Social users win together!",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: getProportionateScreenHeight(16),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(25),
                      ),
                      Container(
                        height: SizeConfig.screenHeight * 0.3,
                        width: SizeConfig.screenWidth,
                        padding: const EdgeInsets.fromLTRB(15, 16, 16, 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: noteStr.map((e) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 7),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\u2022",
                                    style: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(16),
                                      height: 1.55,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(5),
                                  ),
                                  Expanded(
                                    child: Text(
                                      e,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(14),
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black54,
                                        height: 1.55,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(40),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            Get.back();
                            await box.write("newInstall", true);
                          },
                          child: Container(
                            width: SizeConfig.screenWidth * 0.7,
                            height: getProportionateScreenHeight(40),
                            decoration: BoxDecoration(
                              color: kgreenSuccessColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "GOT IT",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });

      // Future.delayed(const Duration(seconds: 5)).then((value) {
      //   Get.back();
      // });
    }
  }

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

      final res = await http.post(
        Uri.parse("${baseURL}users/signin"),
        headers: headers,
        body: jsonEncode(
          {
            "email": userNameController.text.trim(),
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
