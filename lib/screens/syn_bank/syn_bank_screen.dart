import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SyntheticBankScreen extends StatelessWidget {
  const SyntheticBankScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.8,
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
              icon: const Icon(MdiIcons.close),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "SYN ID: 9815673450",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Container(
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
                        const Icon(
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
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              children: [
                ChainBalanceWidget(
                  icon: Image.asset(
                    height: getProportionateScreenHeight(20),
                    "assets/icons/polygon.png",
                  ),
                  balance: "236",
                  fiatBalance: "155.76",
                ),
                ChainBalanceWidget(
                  icon: Image.network(
                    height: getProportionateScreenHeight(20),
                    "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/ethereum.png",
                  ),
                  balance: "3",
                  fiatBalance: "5832",
                ),
                ChainBalanceWidget(
                  icon: SvgPicture.asset(
                    height: getProportionateScreenHeight(20),
                    "assets/icons/bnb.svg",
                  ),
                  balance: "6",
                  fiatBalance: "1920",
                ),
                ChainBalanceWidget(
                  icon: Image.asset(
                    height: getProportionateScreenHeight(20),
                    "assets/icons/tezos.png",
                  ),
                  balance: "5",
                  fiatBalance: "225",
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
                    text: "\$8,132.76",
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
            Container(
              width: SizeConfig.screenWidth,
              height: getProportionateScreenHeight(40),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 0.4),
                borderRadius: BorderRadius.circular(4),
                gradient: const LinearGradient(
                  colors: [
                    kPrimaryColor,
                    kSecondaryColor,
                  ],
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Withdraw",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: getProportionateScreenHeight(15),
                ),
              ),
            )
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
