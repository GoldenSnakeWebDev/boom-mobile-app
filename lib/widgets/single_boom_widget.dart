import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
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
  final String boomId;
  final HomeController? controller;

  const SingleBoomWidget({
    Key? key,
    required this.post,
    this.controller,
    required this.boomId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => const SingleBoomPage(),
          arguments: [boomId, post.title],
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
                  Text(
                    "!${post.user.username}",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: getProportionateScreenHeight(15),
                    ),
                  ),
                  const Spacer(),
                  CachedNetworkImage(
                    height: getProportionateScreenHeight(20),
                    imageUrl: post.network.imageUrl!,
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/icons/${post.network.symbol!.toLowerCase()}.png',
                      height: getProportionateScreenHeight(20),
                    ),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(5),
                  ),
                  Visibility(
                    visible: post.location.isNotEmpty,
                    child: Container(
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
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              post.boomType == "text"
                  ? Text(post.imgUrl)
                  : post.boomType == "video"
                      ? SizedBox(
                          width: SizeConfig.screenWidth,
                          height: getProportionateScreenHeight(200),
                          child: const AspectRatio(
                            aspectRatio: 1,
                            child: SizedBox(),
                            // aspectRatio: controller!.videoPlayerControllers[0]
                            //             .value.aspectRatio <
                            //         1
                            //     ? 1
                            //     : controller!.videoPlayerControllers[0].value
                            //         .aspectRatio,
                            // child: GestureDetector(
                            //   onTap: () {
                            //     log(controller!
                            //         .videoPlayerControllers[0].value.isPlaying
                            //         .toString());
                            //     log(controller!
                            //         .videoPlayerControllers[0].value.aspectRatio
                            //         .toString());
                            //     controller!.videoPlayerControllers[0].value
                            //             .isPlaying
                            //         ? controller!.videoPlayerControllers[0]
                            //             .pause()
                            //         : controller!.videoPlayerControllers[0]
                            //             .play();
                            //   },
                            //   child: CachedVideoPlayer(
                            //     controller!.videoPlayerControllers[0],
                            //   ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            height: getProportionateScreenHeight(200),
                            width: SizeConfig.screenWidth,
                            imageUrl: post.imgUrl,
                            placeholder: (context, url) => SizedBox(
                              height: getProportionateScreenHeight(200),
                              width: SizeConfig.screenWidth,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: getProportionateScreenHeight(200),
                              width: SizeConfig.screenWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey,
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Text(
                post.title,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(15),
                  fontWeight: FontWeight.w900,
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
                        isLiked: post.isLiked,
                        onTap: (isLiked) async {
                          controller?.reactToBoom("likes", boomId, post.index);
                          isLiked
                              ? post.likes + 1
                              : post.likes > 0
                                  ? post.likes - 1
                                  : post.likes;
                          // controller.reactChange("like");
                          return post.isLiked = !isLiked;
                        },
                        likeCount: post.likes,
                        countPostion: CountPostion.bottom,
                        likeBuilder: ((isLiked) {
                          return CachedNetworkImage(
                            height: getProportionateScreenHeight(26),
                            color: post.isLiked ? kPrimaryColor : Colors.black,
                            imageUrl: likeIconUrl,
                          );
                        }),
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
                        isLiked: post.isLoves,
                        onTap: (isLiked) async {
                          controller?.reactToBoom("loves", boomId, post.index);
                          // controller.reactChange("love");

                          return post.isLoves = !isLiked;
                        },
                        likeCount: post.loves,
                        countPostion: CountPostion.bottom,
                        likeBuilder: ((isLoves) {
                          return SvgPicture.asset(
                            height: getProportionateScreenHeight(15),
                            "assets/icons/love.svg",
                            color: post.isLoves ? Colors.red : Colors.grey,
                          );
                        }),
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
                        isLiked: post.isSmiles,
                        onTap: (isLiked) async {
                          controller?.reactToBoom("smiles", boomId, post.index);
                          return controller?.isSmiles = !isLiked;
                        },
                        likeCount: post.smiles,
                        countPostion: CountPostion.bottom,
                        likeBuilder: ((isLiked) {
                          return isLiked
                              ? CachedNetworkImage(
                                  height: getProportionateScreenHeight(26),
                                  imageUrl: smileIconUrl,
                                )
                              : CachedNetworkImage(
                                  height: getProportionateScreenHeight(26),
                                  imageUrl: smileIconUrl,
                                  color: Colors.grey,
                                );
                        }),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LikeButton(
                          animationDuration: const Duration(milliseconds: 600),
                          size: getProportionateScreenHeight(20),
                          isLiked: post.isRebooms,
                          onTap: (isLiked) async {
                            controller?.reactToBoom(
                                "rebooms", boomId, post.index);

                            return controller?.isRebooms = !isLiked;
                          },
                          bubblesColor: const BubblesColor(
                              dotPrimaryColor: kPrimaryColor,
                              dotSecondaryColor: kSecondaryColor),
                          likeCount: post.rebooms,
                          countPostion: CountPostion.bottom,
                          likeBuilder: (isLiked) {
                            return SvgPicture.asset(
                                height: getProportionateScreenHeight(18),
                                "assets/icons/reboom.svg",
                                color: isLiked ? kPrimaryColor : Colors.grey);
                          }),
                    ],
                  ),
                  Column(
                    children: [
                      LikeButton(
                        animationDuration: const Duration(milliseconds: 600),
                        size: getProportionateScreenHeight(20),
                        isLiked: post.isReported,
                        onTap: (isLiked) async {
                          controller?.reactToBoom(
                              "reports", boomId, post.index);

                          return controller?.isReported = !isLiked;
                        },
                        likeCount: post.reported,
                        countPostion: CountPostion.bottom,
                        bubblesColor: const BubblesColor(
                            dotPrimaryColor: kPrimaryColor,
                            dotSecondaryColor: kSecondaryColor),
                        likeBuilder: ((isReported) {
                          return Icon(
                            MdiIcons.alert,
                            color: isReported ? kYellowTextColor : Colors.grey,
                          );
                        }),
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
                          Get.to(
                            () => const SingleBoomPage(),
                            arguments: boomId,
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
