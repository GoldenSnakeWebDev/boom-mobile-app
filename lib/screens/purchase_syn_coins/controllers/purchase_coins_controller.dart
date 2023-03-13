import 'dart:async';
import 'dart:convert';

import 'package:boom_mobile/models/network_model.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/screens/purchase_syn_coins/models/products_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
  late StripeProducts stripeProducts;
  bool isLoading = false;
  String selectedPaymentMethod = "Stripe";

  final box = GetStorage();

  bool isSuccess = false;

  @override
  void onInit() {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    analytics.setCurrentScreen(screenName: "Buy Syn Coins Screen");
    selectedNetwork = networkModel!.networks![0].symbol;

    selectedNetworkModel = networkModel!.networks![0];
    networks.clear();
    for (var element in networkModel!.networks!) {
      networks.add(element);
    }
    getStripeProducts();
    // _initializeIAP();
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

  changeCheckoutMethod(String value) {
    if (selectedPaymentMethod == value) {
      return;
    } else {
      selectedPaymentMethod = value;
    }

    update();
  }

  // Get Stripe Products
  getStripeProducts() async {
    isLoading = true;
    update();
    String token = box.read("token");
    final response = await http.get(
      Uri.parse("${baseURL}stripe/products?is_active=true"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      stripeProducts = StripeProducts.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
    } else {
      isLoading = false;
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);

      update();
    }
  }

  //Stripe Checkout
  stripeCheckout(String id) async {
    String token = box.read("token");
    EasyLoading.show(status: "Loading");
    final response = await http.post(
      Uri.parse("${baseURL}stripe/checkout"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "items": [
            {
              "id": id,
              "quantity": 1,
            }
          ],
          "networkType": selectedNetwork,
          "timestamp": DateTime.now().toString(),
          "actionType": "deposit"
        },
      ),
    );

    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      String url = jsonDecode(response.body)["url"];
      await launchURL(url);
    } else {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  //Paypal Checkout
  paypalCheckout(String id) async {
    String token = box.read("token");
    EasyLoading.show(status: "Loading");
    final response = await http.post(
      Uri.parse("${baseURL}paypal/checkout"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "items": [
            {
              "id": id,
              "quantity": 1,
            }
          ],
          "networkType": selectedNetwork,
          "timestamp": DateTime.now().toString(),
          "actionType": "deposit"
        },
      ),
    );

    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      String url = jsonDecode(response.body)["url"];
      await launchURL(url);
    } else {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  //Checkout

  checkout(String id) async {
    // EasyLoading.show(status: "Loading...");
    // Future.delayed(const Duration(seconds: 5), () {
    //   EasyLoading.dismiss();
    //   Get.snackbar("Browser error", "Error opening checkout page");
    // });

    if (selectedPaymentMethod == "Stripe") {
      stripeCheckout(id);
    } else if (selectedPaymentMethod == "Paypal") {
      paypalCheckout(id);
    }
  }

  launchURL(String url) async {
    if (url.isNotEmpty) {
      final Uri uri = Uri.parse(url);
      isSuccess = true;
      update();
      await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webViewConfiguration: const WebViewConfiguration(
          enableDomStorage: true,
          enableJavaScript: true,
        ),
      );
    } else {
      EasyLoading.showError("Error opening checkout page");
      throw 'Could not launch $url';
    }
  }
}
