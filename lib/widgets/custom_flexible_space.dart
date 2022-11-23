import 'dart:ui';

import 'package:boom_mobile/screens/profile_screen/ui/edit_profile.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoomProfileCustomFlexibleSpace extends StatelessWidget {
  final String? imageUrl;
  final String boomsCount;
  final String fansCount;
  final String frensCount;
  final double titleOpacity;
  final bool isNewUser;
  final String userBio;
  const BoomProfileCustomFlexibleSpace(
      {Key? key,
      this.imageUrl,
      required this.titleOpacity,
      required this.boomsCount,
      required this.fansCount,
      required this.frensCount,
      required this.isNewUser,
      required this.userBio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl!),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: titleOpacity * 20,
            sigmaY: titleOpacity * 20,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionalTranslation(
              translation: Offset(
                0,
                (1 - titleOpacity),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            boomsCount,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: getProportionateScreenHeight(16),
                            ),
                          ),
                          Text(
                            "Booms",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenHeight(12),
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
                            fansCount,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: getProportionateScreenHeight(16),
                            ),
                          ),
                          Text(
                            "Fans",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenHeight(12),
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
                            frensCount,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: getProportionateScreenHeight(16),
                            ),
                          ),
                          Text(
                            "Frens",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenHeight(12),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(4),
                  ),
                  isNewUser
                      ? TextButton(
                          onPressed: () {
                            Get.to(() => const EditProfile());
                          },
                          child: const Text(
                            "You have no Bio yet please add one",
                          ),
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                // const Icon(MdiIcons
                                //     .circleSmall),
                                Text(userBio)
                              ],
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
