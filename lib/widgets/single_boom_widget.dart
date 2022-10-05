import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/single_boom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleBoomWidget extends StatelessWidget {
  const SingleBoomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const SingleBoomPage());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kContBgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    height: getProportionateScreenHeight(24),
                    "assets/icons/bnb.png",
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(5),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 0.5),
                        borderRadius: BorderRadius.circular(6),
                        gradient: const LinearGradient(
                          colors: [
                            kPrimaryColor,
                            kSecondaryColor,
                            kPrimaryColor,
                            kPrimaryColor,
                            kSecondaryColor,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: const [
                            Icon(
                              MdiIcons.mapMarker,
                              size: 16,
                            ),
                            Text("North Carolina"),
                          ],
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Container(
                width: SizeConfig.screenWidth,
                height: getProportionateScreenHeight(200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/dog.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Text(
                "Cute puppy enjoying his day. Ah, happy happy!",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
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
    );
  }
}
