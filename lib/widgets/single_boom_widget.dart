import 'dart:developer';

import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/single_boom_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleBoomWidget extends StatelessWidget {
  final SingleBoomPost post;
  final Boom boom;
  final HomeController controller;
  const SingleBoomWidget({
    Key? key,
    required this.post,
    required this.controller,
    required this.boom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => SingleBoomPage(
            post: post,
            boom: boom,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kContBgColor,
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    height: getProportionateScreenHeight(20),
                    imageUrl: post.network.imageUrl,
                    fit: BoxFit.cover,
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
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              post.boomType == "text"
                  ? Text(post.imgUrl)
                  : post.boomType == "video"
                      ? const Text("Video")
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            height: getProportionateScreenHeight(200),
                            width: SizeConfig.screenWidth,
                            imageUrl: post.imgUrl,
                            fit: BoxFit.cover,
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
                        isLiked: controller.isLiked,
                        onTap: (isLiked) async {
                          controller.reactToBoom("likes", boom.id);
                          return controller.isLiked = !isLiked;
                        },
                        likeBuilder: ((isLiked) {
                          return Image.network(
                            height: getProportionateScreenHeight(26),
                            color: controller.isLiked
                                ? kPrimaryColor
                                : Colors.black,
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
                        isLiked: controller.isLoves,
                        onTap: (isLoves) async {
                          controller.reactToBoom("loves", boom.id);
                          return controller.isLoves = isLoves;
                        },
                        likeBuilder: ((isLoves) {
                          return SvgPicture.asset(
                            height: getProportionateScreenHeight(15),
                            "assets/icons/love.svg",
                            color:
                                controller.isLoves ? Colors.red : Colors.grey,
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
                        isLiked: controller.isSmiles,
                        onTap: (isSmiles) async {
                          log(isSmiles.toString());
                          controller.reactToBoom("smiles", boom.id);
                          return controller.isSmiles = isSmiles;
                        },
                        likeBuilder: ((isSmiles) {
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
                          isLiked: controller.isRebooms,
                          onTap: (isRebooms) async {
                            controller.reactToBoom("rebooms", boom.id);
                            post.rebooms++;
                            return controller.isRebooms = isRebooms;
                          },
                          bubblesColor: const BubblesColor(
                              dotPrimaryColor: kPrimaryColor,
                              dotSecondaryColor: kSecondaryColor),
                          likeBuilder: (isRebooms) {
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
                      LikeButton(
                        animationDuration: const Duration(milliseconds: 600),
                        size: getProportionateScreenHeight(20),
                        onTap: (_) async {
                          Get.snackbar(
                            "Hang in there.",
                            "Shipping soon..",
                            backgroundColor: kPrimaryColor,
                            snackPosition: SnackPosition.TOP,
                            colorText: Colors.black,
                            overlayBlur: 5.0,
                            margin: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.05,
                              left: SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                            ),
                          );
                          return null;
                        },
                        bubblesColor: const BubblesColor(
                            dotPrimaryColor: kPrimaryColor,
                            dotSecondaryColor: kSecondaryColor),
                        likeBuilder: ((isLiked) {
                          return const Icon(
                            MdiIcons.alert,
                            color: kYellowTextColor,
                          );
                        }),
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
                      LikeButton(
                        animationDuration: const Duration(milliseconds: 600),
                        size: getProportionateScreenHeight(20),
                        onTap: (_) async {
                          Get.snackbar(
                            "Hang in there.",
                            "Shipping soon..",
                            backgroundColor: kPrimaryColor,
                            snackPosition: SnackPosition.TOP,
                            colorText: Colors.black,
                            overlayBlur: 5.0,
                            margin: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.05,
                              left: SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                            ),
                          );
                          return null;
                        },
                        bubblesColor: const BubblesColor(
                            dotPrimaryColor: kPrimaryColor,
                            dotSecondaryColor: kSecondaryColor),
                        likeBuilder: ((isLiked) {
                          return const Icon(
                            MdiIcons.chatOutline,
                            size: 22,
                          );
                        }),
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
