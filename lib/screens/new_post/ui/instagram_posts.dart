import 'dart:developer';

import 'package:boom_mobile/screens/new_post/controllers/instagram_web_controller.dart';
import 'package:boom_mobile/screens/new_post/ui/create_new_post.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:video_player/video_player.dart';

class InstagramPosts extends StatelessWidget {
  const InstagramPosts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstagramWebController>(
      init: InstagramWebController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Get.off(() => const CreateNewPost());
              },
            ),
            leadingWidth: getProportionateScreenWidth(70),
            title: Text(
              '${controller.medias.isNotEmpty ? controller.medias[0].username : ""} Instagram Posts',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: getProportionateScreenHeight(12),
              ),
            ),
            centerTitle: true,
            actions: [
              TextButton(
                  onPressed: () {
                    controller.proceedWithUpload(controller.selectedIgMedia);
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: controller.medias.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9,
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return controller.medias[index].media_type == "VIDEO"
                    ? GestureDetector(
                        onTap: () {
                          log("Playing video");
                          controller.videoControllers[0]
                                  [controller.medias[index].id]!
                              .play();
                        },
                        child: VideoPlayer(
                          VideoPlayerController.network(
                              controller.medias[index].media_url),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.selectImage(controller.medias[index]);
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                PreviewIgPostDialog(
                              image: controller.medias[index].media_url,
                            ),
                          );
                        },
                        child: Container(
                          height: getProportionateScreenHeight(50),
                          width: getProportionateScreenWidth(50),
                          decoration: BoxDecoration(
                            border: controller.selectedIgMedia != null &&
                                    controller.selectedIgMedia ==
                                        controller.medias[index]
                                ? Border.all(
                                    color: kPrimaryColor,
                                    width: 2,
                                  )
                                : null,
                          ),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                height: getProportionateScreenHeight(400),
                                width: getProportionateScreenWidth(250),
                                imageUrl: controller.medias[index].media_url,
                                fit: BoxFit.cover,
                              ),
                              controller.selectedIgMedia == null ||
                                      controller.selectedIgMedia !=
                                          controller.medias[index]
                                  ? const SizedBox()
                                  : Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          MdiIcons.check,
                                          color: kPrimaryColor,
                                          size: 16,
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      );
              },
            ),
          ),
        );
      },
    );
  }
}

class PreviewIgPostDialog extends StatelessWidget {
  final String image;
  const PreviewIgPostDialog({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                  minHeight: 100,
                  maxHeight: MediaQuery.of(context).size.height * 0.5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Image.network(
                image,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.3),
                  shape: BoxShape.circle),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  splashColor: Colors.grey,
                  onTap: () =>
                      Navigator.canPop(context) ? Navigator.pop(context) : null,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close, size: 28, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dialogContent(BuildContext context, int index, VoidCallback fct) {
    return FittedBox(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: fct,
          splashColor: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: const ClipOval(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
