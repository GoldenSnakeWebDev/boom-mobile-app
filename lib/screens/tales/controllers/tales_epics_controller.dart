import 'dart:io';

import 'package:boom_mobile/models/fetch_tales_model.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/screens/tales/services/tales_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class TalesEpicsController extends GetxController {
  final _talesService = TalesService();

  List<UserStatus>? _tales;
  List<UserStatus>? get tales => _tales;
  // final List<Map<String, List<UserStatus>>> talesByUser = [];

  var isLoading = false.obs;

  final taleService = TalesService();

  setLoading(bool value) {
    isLoading.value = value;
  }

  @override
  void onInit() async {
    fetchTales();

    update();
    super.onInit();
  }

  // fetchTales
  Future<dynamic> fetchTales() async {
    setLoading(true);
    var talesRess = await _talesService.fetchTales();
    // log("talesRess ::: $talesRess");
    setLoading(false);
    if (talesRess != null) {
      _tales = [...talesRess];
      // filterStatuses();
      setLoading(false);
      update();
    }
  }

  // filterStatuses() {
  //   talesByUser.add({
  //     _tales![0].user!.id.toString(): [_tales![0]]
  //   });

  //   for (var item in _tales!) {
  //     var isExist = false;
  //     for (var user in talesByUser) {
  //       if (user.containsKey(item.user!.id.toString())) {
  //         user[item.user!.id.toString()]!.add(item);
  //         isExist = true;
  //       }
  //     }
  //     if (!isExist) {
  //       talesByUser.add({
  //         item.user!.id.toString(): [item]
  //       });
  //     }
  //   }

  //   // for (var i = 0; i < _tales!.length; i++) {
  //   //   if (talesByUser[i].containsKey(_tales![i].user!.id.toString())) {
  //   //     talesByUser[i][_tales![i].user!.id.toString()]!.add(_tales![i]);
  //   //   } else {
  //   //     talesByUser.add({
  //   //       _tales![i].user!.id.toString(): [_tales![i]]
  //   //     });
  //   //   }
  //   // }

  //   log("talesByUser ::: ${talesByUser[1]["636a2c62a59ab2d87f220cd7"]}");

  //   update();
  // }

  // postTale
  Future<dynamic> postTale(File imageFile, String statusType) async {
    setLoading(true);
    EasyLoading.show(status: "Uploading ${statusType.capitalizeFirst}...");
    var imgURL = await taleService.uploadPhoto(imageFile, "Image Uploaded");

    var postTaleRess = await _talesService.postTale(imgURL, statusType);
    setLoading(false);
    if (postTaleRess != null) {
      // _tales?.insert(0, postTaleRess);
      fetchTales();
      EasyLoading.dismiss();
      update();
      Get.to(() => const MainScreen());
    }
    EasyLoading.dismiss();
  }
}
