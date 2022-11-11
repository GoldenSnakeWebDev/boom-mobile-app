import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/models/network_model.dart';
import 'package:boom_mobile/repo/get_user/get_curr_user.dart';
import 'package:boom_mobile/screens/authentication/login/login_screen.dart';
import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class MainScreenController extends GetxController {
  FetchCurrUserRepo repo;
  MainScreenController({required this.repo});

  User? user;
  final box = GetStorage();
  NetworkModel? networkModel;

  @override
  void onInit() {
    super.onInit();
    getCurrenUser();
    getNetworks();
  }

  getNetworks() async {
    final res = await http.get(
      Uri.parse("${baseURL}networks?page=all"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
    if (res.statusCode == 200) {
      networkModel = NetworkModel.fromJson(jsonDecode(res.body));
      log("networkModel is $networkModel");
      update();
    } else {
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Networks not fetched"], msg: ["Error"], isError: true);
    }
  }

  getCurrenUser() async {
    String token = box.read("token");
    final res = await repo.fetchCurrUser(token);
    if (res.statusCode == 200) {
      user = User.fromJson(jsonDecode(res.body)["user"]);
      box.write("userId", user!.id);
      // CustomSnackBar.showCustomSnackBar(
      //     errorList: ["User Details Fetched"],
      //     msg: ["Success"],
      //     isError: false);
      update();
    } else {
      CustomSnackBar.showCustomSnackBar(
        errorList: ["User Details Not Fetched"],
        msg: ["Error"],
        isError: true,
      );
      box.erase();
      Get.offAll(() => const LoginScreen(), binding: AppBindings());
    }
  }
}
