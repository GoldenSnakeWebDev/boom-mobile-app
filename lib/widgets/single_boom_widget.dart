import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/single_boom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleBoomWidget extends StatelessWidget {
  final SingleBoomPost post;
  const SingleBoomWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SingleBoomPage(
              post: post,
            ));
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
                    post.chain == "bnb"
                        ? "assets/icons/bnb.png"
                        : post.chain == "tezos"
                            ? "assets/icons/tezos.png"
                            : "assets/icons/polygon.png",
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
                          children: [
                            const Icon(
                              MdiIcons.mapMarker,
                              size: 16,
                            ),
                            Text(post.location),
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
                  image: DecorationImage(
                    image: NetworkImage(post.imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Text(
                post.desc,
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
                        post.likes.toString(),
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
                        post.loves.toString(),
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
                        post.smiles.toString(),
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
                        post.rebooms.toString(),
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
                        post.reported.toString(),
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
                        size: 22,
                      ),
                      Text(
                        post.comments.toString(),
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
