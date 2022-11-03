import 'dart:convert';

import 'package:boom_mobile/repo/get_user/get_curr_user.dart';
import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainScreenController extends GetxController {
  FetchCurrUserRepo repo;
  MainScreenController({required this.repo});

  User? user;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getCurrenUser();
  }

  getCurrenUser() async {
    String token = box.read("token");
    final res = await repo.fetchCurrUser(token);
    if (res.statusCode == 200) {
      user = User.fromJson(jsonDecode(res.body)["user"]);
      CustomSnackBar.showCustomSnackBar(
          errorList: ["User Details Fetched"],
          msg: ["Success"],
          isError: false);
      update();
    } else {
      CustomSnackBar.showCustomSnackBar(
        errorList: ["User Details Fetched"],
        msg: ["Error"],
        isError: true,
      );
    }
  }
}
