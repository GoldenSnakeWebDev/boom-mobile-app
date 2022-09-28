import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingleNFTPage extends StatelessWidget {
  final String title;
  final String brandName;
  final String image;
  const SingleNFTPage({
    Key? key,
    required this.title,
    required this.brandName,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                decoration: const BoxDecoration(color: Colors.black),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                  child: Text(
                    "$brandName: Home: $title ",
                    style: TextStyle(
                      color: kYellowTextColor,
                      fontSize: getProportionateScreenHeight(16),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: getProportionateScreenWidth(310),
                      height: getProportionateScreenHeight(280),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.32,
                      height: getProportionateScreenHeight(36),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        gradient: const LinearGradient(
                          colors: [
                            kPrimaryColor,
                            kSecondaryColor,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text("118"),
                                SizedBox(
                                  width: getProportionateScreenWidth(5),
                                ),
                                Image.asset(
                                  width: getProportionateScreenWidth(16),
                                  height: getProportionateScreenHeight(16),
                                  "assets/icons/clap.png",
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("36"),
                                SizedBox(
                                  width: getProportionateScreenWidth(5),
                                ),
                                SvgPicture.asset("assets/icons/reboom.svg")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(18),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Text(
                              "This is a hand crafted collection of fine digital art that elegantly mimics the grace of the House of Versace",
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Rarity:",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(10),
                                ),
                                Text(
                                  "Ultra Rare",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Rarity%:",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(10),
                                ),
                                Text(
                                  "4%",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF4FEFF),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Details",
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            const DetailsWidget(
                              title: "Contract Address:",
                              subTitle: "0x3d....567gh",
                            ),
                            const DetailsWidget(
                              title: "Token ID:",
                              subTitle: "239",
                            ),
                            const DetailsWidget(
                              title: "Token Standard:",
                              subTitle: "ERC-721",
                            ),
                            const DetailsWidget(
                              title: "Blockchain:",
                              subTitle: "Matic",
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const DetailsWidget({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: getProportionateScreenHeight(15),
            ),
          ),
          Text(subTitle)
        ],
      ),
    );
  }
}
