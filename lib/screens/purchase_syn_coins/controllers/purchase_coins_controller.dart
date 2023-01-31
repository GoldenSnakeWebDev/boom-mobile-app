import 'dart:async';
import 'dart:convert';

import 'package:boom_mobile/models/network_model.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:http/http.dart' as http;

class PurchaseCoinsController extends GetxController {
  final String testID = 'dev.boom.boom_mobile';

  //Instantiates the InAppPurchase instance
  final InAppPurchase _iap = InAppPurchase.instance;

  //A boolean value to check if the device is available for in app purchases
  bool _isAvailable = false;

  List<ProductDetails> _products = [];

  final List<PurchaseDetails> _purchases = [];

  late StreamSubscription _subscription;

  final int _coins = 0;

  NetworkModel? networkModel = Get.find<MainScreenController>().networkModel;

  String? selectedNetwork;
  Network? selectedNetworkModel;
  List<Network> networks = [];

  final box = GetStorage();

  @override
  void onInit() {
    selectedNetwork = networkModel!.networks![0].symbol;

    selectedNetworkModel = networkModel!.networks![0];
    networks.clear();
    for (var element in networkModel!.networks!) {
      networks.add(element);
    }
    _initializeIAP();
    super.onInit();
  }

  changeChain(String value) {
    selectedNetwork = value;
    for (var element in networkModel!.networks!) {
      if (element.symbol == value) {
        selectedNetworkModel = element;
      }
    }
    update();
  }

  _initializeIAP() async {
    _isAvailable = await _iap.isAvailable();

    if (_isAvailable) {
      await _getUserProducts();
    } else {
      Get.snackbar("Error", "In app purchases are not available on this device",
          backgroundColor: Colors.red);
    }
  }

  _getUserProducts() async {
    Set<String> ids = {
      "com.boomsocial.tencoins",
      "com.boomsocial.twentycoins",
      "com.boomsocial.fortycoins",
      "com.boomsocial.fiftycoins",
      "com.boomsocial.sixtycoins",
      "com.boomsocial.seventyfivecoins",
      "com.boomsocial.hundredcoins",
    };
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    _products = response.productDetails;

    update();
  }

  purchaseCoins(int index, String coins) async {
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: _products[index]);

    await _iap
        .buyConsumable(purchaseParam: purchaseParam, autoConsume: false)
        .then((value) {
      if (value) {
        callBackPurchase(coins);
      } else {
        Get.snackbar("Error", "Something went wrong",
            backgroundColor: Colors.red);
      }
    });
  }

  PurchaseDetails _hasUserPurchased(String prductID) {
    return _purchases.firstWhere((purchase) => purchase.productID == prductID);
  }

  verifyPurchase() async {
    PurchaseDetails purchase = _hasUserPurchased(testID);
    if (purchase.status == PurchaseStatus.purchased) {
      Get.snackbar("Success", "You have purchased 100 Synthetic coins");
      //Make a request to Boom Backend to deposit the Synthetic coins
    }
  }

  callBackPurchase(String coins) async {
    String token = box.read("token");
    var time = DateTime.now().toString();
    final response = await http.post(
      Uri.parse("${baseURL}callback-urls/google-plays-tore"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "amount": coins,
          "networkType": selectedNetwork,
          "timestamp": time,
          "actionType": "deposit"
        },
      ),
    );

    if (response.statusCode == 200) {
      Get.snackbar("Success", "You have purchased $coins Synthetic coins");
    } else {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }
}
