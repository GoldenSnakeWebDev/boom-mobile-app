import 'dart:convert';

import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/screens/home_screen/services/home_service.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  AllBooms? allBooms;
  HomeService homeService = HomeService();
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchAllBooms();
  }

  fetchAllBooms() async {
    EasyLoading.show(status: "Loading");
    final res = await homeService.fetchBooms();

    if (res.statusCode == 200) {
      isLoading = false;
      // CustomSnackBar.showCustomSnackBar(
      //     errorList: ["Booms Fetched"], msg: ["Success"], isError: false);
      allBooms = AllBooms.fromJson(jsonDecode(res.body));
      EasyLoading.dismiss();
      update();
    } else {
      isLoading = false;
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Could not fetch Booms"], msg: ["Error"], isError: true);
      EasyLoading.dismiss();
    }
  }
}
