import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/models/network_model.dart';
import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/screens/home_screen/services/home_service.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  AllBooms? allBooms;
  HomeService homeService = HomeService();
  bool isLoading = true;
  NetworkModel? networkModel;
  bool isLiked = false;

  @override
  void onInit() {
    super.onInit();
    getNetworks();
    fetchAllBooms();
  }

  likeImage() {
    isLiked = !isLiked;
    update();
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
    } else {
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Networks not fetched"], msg: ["Error"], isError: true);
    }
  }

  getNetworkById(String networkId) {
    log("The networkModel :: $networkModel");
    Network? network;
    if (networkModel == null) {
      isLoading = true;
      MainScreenController(repo: Get.find()).getNetworks();
      log("networkModel is $networkModel");

      isLoading = false;
      for (var element in networkModel!.networks) {
        if (element.id == networkId) {
          network = element;
        }
      }
      return network;
    } else {
      log(networkModel?.networks[0].id ?? "No Networks");
      for (var element in networkModel!.networks) {
        if (element.id == networkId) {
          network = element;
        }
      }
      isLoading = false;
      return network;
    }
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
