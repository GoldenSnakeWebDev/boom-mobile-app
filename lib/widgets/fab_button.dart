import 'package:boom_mobile/screens/direct_messages/direct_messages_screen.dart';
import 'package:boom_mobile/screens/fans_frens_screen/ui/fans_screen.dart';
import 'package:boom_mobile/screens/new_post/controllers/new_post_controller.dart';
import 'package:boom_mobile/screens/new_post/ui/create_new_post.dart';
import 'package:boom_mobile/screens/splash_screen/controllers/splash_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FabButton extends StatelessWidget {
  const FabButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isDismissible: true,
            isScrollControlled: true,
            enableDrag: true,
            context: context,
            backgroundColor: Colors.white,
            constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.5),
            builder: (context) {
              return DraggableScrollableSheet(
                  minChildSize: 0.15,
                  initialChildSize: 0.27,
                  expand: false,
                  maxChildSize: 0.5,
                  builder: ((context, scrollController) {
                    return Container(
                      height: SizeConfig.screenHeight * 0.27,
                      width: SizeConfig.screenWidth * 0.5,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                ListTile(
                                  leading: const FloatingActionWidget(
                                    "https://lh3.googleusercontent.com/pw/AJFCJaUe3cATBXkuzVcWUHuoe6hYr5Gu6FKbIhe88J2hKUKjIbVjMnNoKTuUQdQsiym-cGQqY3S4TYVpD_UfdDrOd_upNmnfAs1uxgYhG3IQhVT3_hO4DKnqQMZWyJrsPOCdP4ww6maMYlaUTJWK_fdrSXqOzA=w45-h46-s-no?authuser=0",
                                  ),
                                  title: const Text(
                                    'Post',
                                  ),
                                  onTap: () {
                                    Get.back();
                                    Get.find<NewPostController>().onInit();
                                    Get.to(
                                      () => const CreateNewPost(),
                                    );
                                  },
                                ),
                                // ListTile(
                                //   leading: const FloatingActionWidget(
                                //     "https://boomIconUrl/tales.png",
                                //   ),
                                //   onTap: () {
                                //     Get.back();
                                //     Get.to(() => const CaptureTaleScreen());
                                //   },
                                //   title: const Text(
                                //     'Tales',
                                //   ),
                                // ),
                                // ListTile(
                                //   leading: SizedBox(
                                //     width: getProportionateScreenWidth(50),
                                //     child: Row(
                                //       children: [
                                //         const FloatingActionWidget(
                                //           "https://boomIconUrl/tales.png",
                                //         ),
                                //         SizedBox(
                                //           width:
                                //               getProportionateScreenWidth(5),
                                //         ),
                                //         const FloatingActionWidget(
                                //           "https://boomIconUrl/tales.png",
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                //   title: const Text(
                                //     'Epics',
                                //   ),
                                // ),
                                ListTile(
                                  onTap: () {
                                    Get.to(() => const DirectMessagesScreen());
                                  },
                                  leading: const Icon(Icons.mail),
                                  title: const Text(
                                    'DM',
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    final controller =
                                        Get.put(SplashController());
                                    Get.to(
                                      () => const FansScreen(),
                                      arguments: [
                                        controller.user!.funs!,
                                        "Fans"
                                      ],
                                    );
                                  },
                                  leading: const FloatingActionWidget(
                                    "https://lh3.googleusercontent.com/pw/AJFCJaX3HCS7Vg9yXWWPBshcjeBEtLO7lF5t4bHUC8Kk8glTdeXnR18Fv_bdVWmggosE59rMQ8THWBeuZmCzNdZ_UjJQaJwqlXgN7eGV2mmZimrdqA69ifSiy4UEfBhaX4FcHpMD0SnxnkvrYGMcfLyvKNmoGA=w64-h38-s-no?authuser=0",
                                  ),
                                  title: const Text(
                                    'Fans',
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    final controller =
                                        Get.put(SplashController());
                                    Get.to(
                                      () => const FansScreen(),
                                      arguments: [
                                        controller.user!.friends!,
                                        "Frens"
                                      ],
                                    );
                                  },
                                  leading: const FloatingActionWidget(
                                    "https://lh3.googleusercontent.com/pw/AJFCJaX3HCS7Vg9yXWWPBshcjeBEtLO7lF5t4bHUC8Kk8glTdeXnR18Fv_bdVWmggosE59rMQ8THWBeuZmCzNdZ_UjJQaJwqlXgN7eGV2mmZimrdqA69ifSiy4UEfBhaX4FcHpMD0SnxnkvrYGMcfLyvKNmoGA=w64-h38-s-no?authuser=0",
                                  ),
                                  title: const Text(
                                    'Frens',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }));
            });
      },
      child: Container(
        decoration: BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CachedNetworkImage(
            imageUrl: boomIconUrl,
            width: getProportionateScreenHeight(22),
            height: getProportionateScreenHeight(22),
          ),
        ),
      ),
    );
  }
}

class FloatingActionWidget extends StatelessWidget {
  final String imageUrl;
  const FloatingActionWidget(
    this.imageUrl, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.06,
      child: CachedNetworkImage(
        height: getProportionateScreenHeight(20),
        imageUrl: imageUrl,
        errorWidget: (context, url, error) => Image.asset(
          "assets/icons/playstore.png",
        ),
      ),
    );
  }
}
