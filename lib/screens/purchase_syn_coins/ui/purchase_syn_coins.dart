import 'package:boom_mobile/screens/purchase_syn_coins/controllers/purchase_coins_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                  Expanded(
                    child: controller.isLoading
                        ? const SizedBox()
                        : ListView.builder(
                            itemCount:
                                controller.stripeProducts.products.length,
                            itemBuilder: (context, index) {
                              return SynCoinOption(
                                coinAmount: controller
                                    .stripeProducts.products[index].description,
                                coinPrice: controller
                                    .stripeProducts.products[index].priceInCents
                                    .toString(),
                                index: index,
                                controller: controller,
                                productId: controller
                                    .stripeProducts.products[index].id,
                              );
                            },
                          ),
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
  final String productId;
  final PurchaseCoinsController controller;
  const SynCoinOption({
    Key? key,
    required this.coinAmount,
    required this.coinPrice,
    required this.index,
    required this.controller,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (context) {
              return GetBuilder<PurchaseCoinsController>(builder: (controller) {
                return DraggableScrollableSheet(
                    initialChildSize: 0.6,
                    expand: false,
                    maxChildSize: 0.7,
                    minChildSize: 0.6,
                    builder: (context, scrollController) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Purchase $coinAmount Synthetic Coins",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: getProportionateScreenHeight(16),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Text(
                              "Please choose the chain you would like to purchase your synthetic coins on.",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: getProportionateScreenHeight(14),
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(10)),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.7),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    height: getProportionateScreenHeight(16),
                                    imageUrl: controller
                                        .selectedNetworkModel!.imageUrl!,
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(5),
                                  ),
                                  Text(controller.selectedNetworkModel!.name!),
                                  const Spacer(),
                                  DropdownButton(
                                    icon: const Icon(
                                      Icons.arrow_drop_down_circle_outlined,
                                      color: Colors.grey,
                                      size: 24,
                                    ),
                                    underline: const SizedBox(),
                                    style: const TextStyle(color: Colors.black),
                                    items: controller.networks.map((e) {
                                      return DropdownMenuItem(
                                          value: e,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CachedNetworkImage(
                                                height:
                                                    getProportionateScreenHeight(
                                                        16),
                                                imageUrl: e.imageUrl!,
                                              ),
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        4),
                                              ),
                                              Text(
                                                e.symbol!,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          12),
                                                ),
                                              )
                                            ],
                                          ));
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.changeChain(value!.symbol!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(30),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                spacing: getProportionateScreenWidth(40),
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.changeCheckoutMethod("Stripe");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black38, width: 0.4),
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: controller
                                                      .selectedPaymentMethod ==
                                                  "Stripe"
                                              ? [
                                                  kPrimaryColor,
                                                  kSecondaryColor,
                                                ]
                                              : [Colors.grey, Colors.grey],
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Stripe Checkout",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.changeCheckoutMethod("Paypal");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black38, width: 0.4),
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: controller
                                                      .selectedPaymentMethod ==
                                                  "Paypal"
                                              ? [
                                                  kPrimaryColor,
                                                  kSecondaryColor,
                                                ]
                                              : [Colors.grey, Colors.grey],
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Paypal Checkout",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await controller.checkout(productId);
                                if (controller.isSuccess) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Container(
                                width: SizeConfig.screenWidth,
                                height: getProportionateScreenHeight(40),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black38, width: 0.4),
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    colors: [
                                      kPrimaryColor,
                                      kSecondaryColor,
                                    ],
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Purchase",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: getProportionateScreenHeight(14),
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              });
            });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                MdiIcons.circleMultiple,
              ),
              Text(
                coinAmount,
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
