import 'dart:convert';

import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/screens/home_screen/services/home_service.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  AllBooms? allBooms;
  List<Boom>? _homeBooms;
  List<Boom>? get homeBooms => _homeBooms;
  List<Boom> myBooms = [];
  HomeService homeService = HomeService();
  bool isLoading = true;

  bool isLiked = false;

  @override
  void onInit() {
    super.onInit();

    fetchAllBooms();
  }

  likeImage() {
    isLiked = !isLiked;
    update();
  }

  getMyBooms(AllBooms? booms, User user) {
    myBooms =
        allBooms!.booms.where((element) => element.user.id == user.id).toList();
  }

  // getNetworkById(AllBooms? booms) {
  //   if (user.networkModel != null) {
  //     network.clear();
  //     for (int i = 0; i < booms!.booms.length; i++) {
  //       for (int j = 0; j < user.networkModel!.networks.length; j++) {
  //         if (booms.booms[i].network == user.networkModel!.networks[j].id) {
  //           log("We are adding network");
  //           network.add(user.networkModel!.networks[j]);

  //           update();
  //         } else {
  //           log("No Matching network for ${booms.booms[i].network}");
  //         }
  //       }
  //     }
  //     update();
  //   } else {
  //     update();
  //     log("User network is null");
  //   }
  // }

  fetchAllBooms() async {
    EasyLoading.show(status: "Loading");
    final res = await homeService.fetchBooms();

    if (res.statusCode == 200) {
      isLoading = false;
      // CustomSnackBar.showCustomSnackBar(
      //     errorList: ["Booms Fetched"], msg: ["Success"], isError: false);
      allBooms = AllBooms.fromJson(jsonDecode(res.body));
      _homeBooms = allBooms!.booms;
      EasyLoading.dismiss();
      // getNetworkById(allBooms);

      update();
    } else {
      isLoading = false;
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Could not fetch Booms"], msg: ["Error"], isError: true);
      EasyLoading.dismiss();
    }
  }
}
