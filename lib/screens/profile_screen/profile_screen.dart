import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:boom_mobile/widgets/single_boom_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: getProportionateScreenHeight(28),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(MdiIcons.mapMarker),
                    Container(
                      height: getProportionateScreenHeight(28),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: const Text(
                        "Texas",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "!Seven22",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenHeight(15),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    height: getProportionateScreenHeight(150),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/header_img.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      height: getProportionateScreenHeight(150),
                      width: getProportionateScreenWidth(44),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            MdiIcons.twitter,
                            color: Colors.blueAccent,
                          ),
                          Icon(
                            MdiIcons.facebook,
                            color: Colors.blue,
                          ),
                          Icon(
                            MdiIcons.instagram,
                            color: Colors.purpleAccent,
                          ),
                          Icon(MdiIcons.musicNote)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 95,
                    left: 70,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kBlueColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "B",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 15,
                    child: Container(
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(
                            "assets/images/seven.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: getProportionateScreenWidth(70),
                      height: getProportionateScreenHeight(70),
                    ),
                  ),
                  Positioned(
                    top: 210,
                    left: 35,
                    child: Image.asset(
                      height: getProportionateScreenHeight(30),
                      "assets/images/noob_talk.png",
                    ),
                  ),
                  Positioned(
                      top: 260,
                      left: 35,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              kPrimaryColor,
                              kSecondaryColor,
                            ],
                          ),
                        ),
                        child: const Icon(MdiIcons.swapVertical),
                      )),
                  Positioned(
                    top: 175,
                    left: 110,
                    child: SizedBox(
                      width: getProportionateScreenWidth(250),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "256",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize:
                                          getProportionateScreenHeight(16),
                                    ),
                                  ),
                                  Text(
                                    "Content",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          getProportionateScreenHeight(12),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(40),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "180",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize:
                                          getProportionateScreenHeight(16),
                                    ),
                                  ),
                                  Text(
                                    "Fans",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          getProportionateScreenHeight(12),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(40),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "79",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize:
                                          getProportionateScreenHeight(16),
                                    ),
                                  ),
                                  Text(
                                    "Frens",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          getProportionateScreenHeight(12),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(5),
                          ),
                          Row(
                            children: const [
                              Icon(MdiIcons.circleSmall),
                              Text("Blockchain dev, Calle me Seven")
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(MdiIcons.circleSmall),
                              Text("All posts are opinionated, NFA")
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(MdiIcons.circleSmall),
                              Text("Lead Dev Ngeni Devs")
                            ],
                          ),

                          // const ListTile(
                          //   leading: Icon(MdiIcons.circleSmall),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 320,
                    child: Container(
                      color: kContBgColor,
                      width: SizeConfig.screenWidth,
                      height: getProportionateScreenHeight(120),
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GridView.builder(
                          itemCount: profileOptions.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              width: getProportionateScreenWidth(70),
                              height: getProportionateScreenHeight(20),
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                gradient: index == 0
                                    ? const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          kSecondaryColor,
                                          kPrimaryColor,
                                          kPrimaryColor,
                                          kPrimaryColor,
                                          kSecondaryColor
                                        ],
                                      )
                                    : null,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(profileOptions[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: kContBgColor,
              height: SizeConfig.screenHeight * 0.32,
              width: SizeConfig.screenWidth,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const SingleBoomWidget();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
