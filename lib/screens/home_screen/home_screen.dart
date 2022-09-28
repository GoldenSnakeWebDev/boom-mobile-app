import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(100),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: talesDetails.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Column(
                        children: [
                          Container(
                            width: getProportionateScreenWidth(56),
                            height: getProportionateScreenHeight(56),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/${talesDetails[index]["img"]}.jpeg"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          Text(
                            talesDetails[index]["title"].toString(),
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(12),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: brandDetails.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      height: SizeConfig.screenHeight * 0.38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kContBgColor,
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Image.asset(
                              width: getProportionateScreenWidth(30),
                              height: getProportionateScreenHeight(30),
                              "assets/icons/verification.png",
                            ),
                          ),
                          Positioned(
                            top: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Text(
                                  brandDetails[index]["title"].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getProportionateScreenHeight(16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 45,
                            right: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      kPrimaryColor,
                                      kPrimaryColor,
                                      kSecondaryColor,
                                      kPrimaryColor,
                                      kPrimaryColor,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(color: Colors.black)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  "SOCIAL",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: getProportionateScreenHeight(11),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  width: SizeConfig.screenWidth * 0.9,
                                  height: SizeConfig.screenHeight * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/${brandDetails[index]["img"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 15,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: kPrimaryColor,
                                border: Border.all(color: Colors.black),
                              ),
                              child: Image.asset(
                                width: getProportionateScreenWidth(20),
                                height: getProportionateScreenHeight(20),
                                "assets/icons/promote.png",
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: 60,
                            child: Text(
                              brandDetails[index]["likes"].toString(),
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(12),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: 90,
                            child: Image.asset(
                              width: getProportionateScreenWidth(16),
                              height: getProportionateScreenHeight(16),
                              "assets/icons/clap.png",
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: SizeConfig.screenWidth * 0.44,
                            child: Text(
                              brandDetails[index]["reboom"].toString(),
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(12),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: (SizeConfig.screenWidth * 0.44) + 24,
                            child: SvgPicture.asset("assets/icons/reboom.svg"),
                          ),
                          Positioned(
                            bottom: 12,
                            right: 35,
                            child: Text(
                              brandDetails[index]["comments"].toString(),
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(12),
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 12,
                            right: 15,
                            child: Icon(
                              MdiIcons.commentProcessingOutline,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
