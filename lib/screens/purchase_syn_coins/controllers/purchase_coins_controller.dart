import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

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

  @override
  void onInit() {
    _initializeIAP();
    super.onInit();
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

  purchaseCoins(int index) async {
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: _products[index]);

    await _iap
        .buyConsumable(purchaseParam: purchaseParam, autoConsume: false)
        .then((value) {
      if (value) {
        Get.snackbar("Success", "You have purchased 100 Synthetic coins",
            backgroundColor: Colors.green);
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
    }
  }
}
