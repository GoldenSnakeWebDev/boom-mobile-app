import 'dart:developer';

import 'package:boom_mobile/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story/story.dart';

class ViewStatusScreen extends StatelessWidget {
  final List<String> imagesUrl;
  const ViewStatusScreen({super.key, required this.imagesUrl});

  @override
  Widget build(BuildContext context) {
    log(imagesUrl.length.toString());
    return Scaffold(
        body: SafeArea(
      child: StoryPageView(
        itemBuilder: (context, pageIndex, storyIndex) {
          final imageUrl = imagesUrl[storyIndex];
          return Center(
              child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
          ));
        },
        storyLength: (pageIndex) {
          return imagesUrl.length;
        },
        indicatorVisitedColor: kPrimaryColor,
        pageLength: imagesUrl.length,
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
    ));
  }
}
