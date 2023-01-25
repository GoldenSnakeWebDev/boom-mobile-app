import 'package:boom_mobile/screens/purchase_syn_coins/controllers/purchase_coins_controller.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PurchaseSyntheticCoinsScreen extends StatelessWidget {
  const PurchaseSyntheticCoinsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PurchaseCoinsController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            leadingWidget: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Get.back(),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Purchase Synthetic Coins",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(
                    "You can purchase synthetic coins to use in the app. You can use them to synthetically mint booms, or to send them to other users as tips.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: getProportionateScreenHeight(14),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  SynCoinOption(
                    coinAmount: "10",
                    coinPrice: "2.50",
                    index: 0,
                    controller: controller,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  SynCoinOption(
                    coinAmount: "20",
                    coinPrice: "5.00",
                    index: 1,
                    controller: controller,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  SynCoinOption(
                    coinAmount: "40",
                    coinPrice: "10.00",
                    index: 2,
                    controller: controller,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  SynCoinOption(
                    coinAmount: "50",
                    coinPrice: "20.00",
                    index: 3,
                    controller: controller,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  SynCoinOption(
                    coinAmount: "60",
                    coinPrice: "25.00",
                    index: 4,
                    controller: controller,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  SynCoinOption(
                    coinAmount: "75",
                    coinPrice: "50.00",
                    index: 5,
                    controller: controller,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  SynCoinOption(
                    coinAmount: "100",
                    coinPrice: "75.00",
                    index: 6,
                    controller: controller,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  SynCoinOption(
                    coinAmount: "200",
                    coinPrice: "100.00",
                    index: 7,
                    controller: controller,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SynCoinOption extends StatelessWidget {
  final String coinAmount;
  final String coinPrice;
  final int index;
  final PurchaseCoinsController controller;
  const SynCoinOption({
    Key? key,
    required this.coinAmount,
    required this.coinPrice,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.purchaseCoins(index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(MdiIcons.circleMultiple),
              Text(
                "$coinAmount Synthetic Coins",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: getProportionateScreenHeight(14),
                  color: Colors.black,
                ),
              ),
              Text(
                "\$ $coinPrice",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: getProportionateScreenHeight(14),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
