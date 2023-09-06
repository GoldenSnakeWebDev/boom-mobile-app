import 'dart:developer';

import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController implements GetxService {
  bool isNetworkAvailable = false;

  NetworkController() {
    _checkNetwork();
  }

  _checkNetwork() async {
    FlutterNetworkConnectivity connectivity = FlutterNetworkConnectivity(
      isContinousLookUp: true,
      lookUpDuration: const Duration(seconds: 5),
      lookUpUrl: "https://www.google.com",
    );

    await connectivity.registerAvailabilityListener();

    connectivity.getInternetAvailabilityStream().listen((event) {
      if (event) {
        log("Yes there is network connection");
        return;
      } else {
        log("There is no net");
        Get.snackbar("No Internet", "Please check your internet connection");
      }
    });
  }

  @override
  void onInit() async {
    await _checkNetwork();
    super.onInit();
  }
}
