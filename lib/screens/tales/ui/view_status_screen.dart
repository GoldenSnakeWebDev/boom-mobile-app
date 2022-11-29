import 'package:boom_mobile/models/fetch_tales_model.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:story/story.dart';

class ViewStatusScreen extends StatelessWidget {
  final List<Statue>? imagesUrl;
  final String? uname;
  const ViewStatusScreen({super.key, required this.imagesUrl, this.uname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          StoryPageView(
            backgroundColor: Colors.white,
            itemBuilder: (context, pageIndex, storyIndex) {
              final imageUrl = imagesUrl![storyIndex].imageUrl;
              return Center(
                  child: CachedNetworkImage(
                imageUrl: "$imageUrl",
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ));
            },
            storyLength: (pageIndex) {
              return imagesUrl!.length;
            },
            indicatorVisitedColor: kPrimaryColor,
            pageLength: imagesUrl!.length,
            onPageLimitReached: () {
              Get.back();
            },
            gestureItemBuilder: (context, pageIndex, storyIndex) {
              return Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    color: Colors.red,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: getProportionateScreenHeight(30),
            left: getProportionateScreenWidth(1),
            child: Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(10),
                top: getProportionateScreenHeight(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        "TODO",
                        "Show $uname's profile",
                        backgroundColor: kPrimaryColor,
                        colorText: Colors.black,
                      );
                    },
                    child: CircleAvatar(
                      radius: getProportionateScreenHeight(25),
                      backgroundColor: Colors.red,
                      child: Icon(
                        MdiIcons.accountCircleOutline,
                        color: Colors.white,
                        size: getProportionateScreenHeight(30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$uname',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenHeight(16),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Tap to view profile',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: getProportionateScreenHeight(12),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
