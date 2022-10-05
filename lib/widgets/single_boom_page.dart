import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleBoomPage extends StatelessWidget {
  const SingleBoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kContBgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Boom",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        backgroundColor: kContBgColor,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/dog.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                height: getProportionateScreenHeight(45),
                                width: getProportionateScreenHeight(45),
                                "assets/images/seven.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Text(
                              "!Rottie",
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(11),
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: const [],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: kPrimaryColor,
                          ),
                          child: const Text("Obtain"),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(5),
                        ),
                        Column(
                          children: [
                            Text(
                              "50",
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(16),
                              ),
                            ),
                            const Text("(\$75)")
                          ],
                        ),
                        Image.asset(
                          height: getProportionateScreenHeight(20),
                          "assets/icons/bnb.png",
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            MdiIcons.dotsHorizontal,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "A view of a cute dog bud",
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(16),
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          height: getProportionateScreenHeight(26),
                          color: kPrimaryColor,
                          "assets/icons/applaud.png",
                        ),
                        Text(
                          "4780",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(12),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          height: getProportionateScreenHeight(18),
                          "assets/icons/love.svg",
                        ),
                        Text(
                          "1200",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(12),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          height: getProportionateScreenHeight(22),
                          "assets/icons/smile.png",
                        ),
                        Text(
                          "550",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(12),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(
                          height: getProportionateScreenHeight(18),
                          "assets/icons/reboom.svg",
                        ),
                        Text(
                          "900",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(12),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(
                          MdiIcons.alert,
                          color: kYellowTextColor,
                        ),
                        Text(
                          "58",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(12),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          MdiIcons.chatOutline,
                          size: 24,
                        ),
                        Text(
                          "612",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(12),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
