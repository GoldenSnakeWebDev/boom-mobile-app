import 'package:boom_mobile/screens/splash_screen/controllers/splash_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SyntheticBankScreen extends StatelessWidget {
  const SyntheticBankScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myCtrl = Get.find<SplashController>();
    return Container(
      width: SizeConfig.screenWidth * 0.9,
      height: SizeConfig.screenHeight * 0.45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(MdiIcons.close),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.4,
                  child: Text(
                    "SYN ID: ${myCtrl.user!.syncBank!.syncId}",
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(
                      ClipboardData(text: myCtrl.user!.syncBank!.syncId!),
                    );

                    Get.snackbar("Copied", "Sync Bank Id Copied to clipboard",
                        backgroundColor: kPrimaryColor,
                        snackPosition: SnackPosition.BOTTOM);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 0.5),
                      borderRadius: BorderRadius.circular(4),
                      gradient: const LinearGradient(
                        colors: [
                          kPrimaryColor,
                          kSecondaryColor,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                      child: Row(
                        children: [
                          Icon(
                            MdiIcons.contentCopy,
                            size: 20,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          Text(
                            "Copy",
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(11),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChainBalanceWidget(
                  icon: Image.asset(
                    "assets/icons/matic.png",
                    height: getProportionateScreenHeight(20),
                  ),
                  balance: "${myCtrl.user!.syncBank!.polygon!.amountBalance!}",
                  fiatBalance:
                      "${myCtrl.user!.syncBank!.polygon!.amountBalance}",
                ),
                // ChainBalanceWidget(
                //   icon: Image.network(
                //     height: getProportionateScreenHeight(20),
                //     "https://boomIconUrl/ethereum.png",
                //   ),
                //   balance: "${myCtrl.user!.syncBank!.polygon!.amountBalance}",
                //   fiatBalance:
                //       "${myCtrl.user!.syncBank!.polygon!.amountBalance}",
                // ),
                ChainBalanceWidget(
                  icon: SvgPicture.asset(
                    height: getProportionateScreenHeight(20),
                    "assets/icons/bnb.svg",
                  ),
                  balance: "${myCtrl.user!.syncBank!.binance!.amountBalance}",
                  fiatBalance:
                      "${myCtrl.user!.syncBank!.binance!.amountBalance}",
                ),
                ChainBalanceWidget(
                  icon: CachedNetworkImage(
                    height: getProportionateScreenHeight(20),
                    imageUrl:
                        "https://lh3.googleusercontent.com/pw/AJFCJaWVmPcwYmSc_CQs5ojp4VCRIZb7-T-kc6ILN4BUvoXXoij0GfabGjQSyei3oE-391ZHZTNSOqWcgD3DWZx6zX4V086LRlHfr8CJN9rnxkBuSBNDs9xSTerU7JWhmz6H9fC3iiAds-bDEmR4qA7a9QTKvw=w805-h988-s-no?authuser=0",
                  ),
                  balance: "${myCtrl.user!.syncBank!.tezos!.amountBalance}",
                  fiatBalance: "${myCtrl.user!.syncBank!.tezos!.amountBalance}",
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            RichText(
              text: TextSpan(
                text: "Total Value: ",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: getProportionateScreenHeight(14),
                ),
                children: [
                  TextSpan(
                    text:
                        "\$${myCtrl.user!.syncBank!.tezos!.amountBalance! + myCtrl.user!.syncBank!.polygon!.amountBalance! + myCtrl.user!.syncBank!.binance!.amountBalance!}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: getProportionateScreenHeight(16),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Container(
            //   width: SizeConfig.screenWidth,
            //   height: getProportionateScreenHeight(40),
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.black38, width: 0.4),
            //     borderRadius: BorderRadius.circular(4),
            //     gradient: const LinearGradient(
            //       colors: [
            //         kPrimaryColor,
            //         kSecondaryColor,
            //       ],
            //     ),
            //   ),
            //   alignment: Alignment.center,
            //   child: Text(
            //     "Withdraw",
            //     style: TextStyle(
            //       fontWeight: FontWeight.w800,
            //       fontSize: getProportionateScreenHeight(15),
            //     ),
            //   ),
            // ),

            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            // GestureDetector(
            //   onTap: () async {
            //     Navigator.of(context).pop();
            //     Get.to(() => const PurchaseSyntheticCoinsScreen());
            //   },
            //   child: Container(
            //     width: SizeConfig.screenWidth,
            //     height: getProportionateScreenHeight(40),
            //     decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black38, width: 0.4),
            //       borderRadius: BorderRadius.circular(4),
            //       gradient: const LinearGradient(
            //         colors: [
            //           kPrimaryColor,
            //           kSecondaryColor,
            //         ],
            //       ),
            //     ),
            //     alignment: Alignment.center,
            //     child: Text(
            //       "Deposit",
            //       style: TextStyle(
            //         fontWeight: FontWeight.w800,
            //         fontSize: getProportionateScreenHeight(15),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class ChainBalanceWidget extends StatelessWidget {
  final Widget icon;
  final String balance;
  final String fiatBalance;
  const ChainBalanceWidget({
    Key? key,
    required this.icon,
    required this.balance,
    required this.fiatBalance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          icon,
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
              child: Text(balance),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 0.4),
              borderRadius: BorderRadius.circular(3.0),
              gradient: const LinearGradient(
                colors: [
                  kSecondaryColor,
                  kPrimaryColor,
                  kPrimaryColor,
                  kPrimaryColor,
                  kPrimaryColor,
                  kSecondaryColor,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 3, 8, 3),
              child: Text("\$$fiatBalance"),
            ),
          )
        ],
      ),
    );
  }
}
