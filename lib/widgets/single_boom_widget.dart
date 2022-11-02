import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/single_boom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
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
                  Image.network(
                      height: getProportionateScreenHeight(24),
                      post.chain == "bnb"
                          ? "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/bnb.png"
                          : post.chain == "tezos"
                              ? "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/tezos.png"
                              : "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/polygon.png"),
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
                      LikeButton(
                        animationDuration: const Duration(milliseconds: 600),
                        size: getProportionateScreenHeight(28),
                        bubblesColor: const BubblesColor(
                            dotPrimaryColor: kPrimaryColor,
                            dotSecondaryColor: kSecondaryColor),
                        likeBuilder: ((isLiked) {
                          return Image.network(
                            height: getProportionateScreenHeight(26),
                            color: isLiked ? kPrimaryColor : Colors.black,
                            "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/applaud.png",
                          );
                        }),
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
                      LikeButton(
                        animationDuration: const Duration(milliseconds: 600),
                        size: getProportionateScreenHeight(22),
                        bubblesColor: const BubblesColor(
                            dotPrimaryColor: kPrimaryColor,
                            dotSecondaryColor: kSecondaryColor),
                        likeBuilder: ((isLiked) {
                          return SvgPicture.asset(
                            height: getProportionateScreenHeight(15),
                            "assets/icons/love.svg",
                            color: isLiked ? Colors.red : kPrimaryColor,
                          );
                        }),
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
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LikeButton(
                        animationDuration: const Duration(milliseconds: 600),
                        size: getProportionateScreenHeight(26),
                        bubblesColor: const BubblesColor(
                            dotPrimaryColor: kPrimaryColor,
                            dotSecondaryColor: kSecondaryColor),
                        likeBuilder: ((isLiked) {
                          return Image.network(
                            height: getProportionateScreenHeight(22),
                            "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/ipfs/bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu/smile.png",
                          );
                        }),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LikeButton(
                          animationDuration: const Duration(milliseconds: 600),
                          size: getProportionateScreenHeight(20),
                          bubblesColor: const BubblesColor(
                              dotPrimaryColor: kPrimaryColor,
                              dotSecondaryColor: kSecondaryColor),
                          likeBuilder: (isLiked) {
                            return SvgPicture.asset(
                              height: getProportionateScreenHeight(18),
                              "assets/icons/reboom.svg",
                            );
                          }),
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
