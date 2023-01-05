import 'package:boom_mobile/models/fetch_tales_model.dart';
import 'package:boom_mobile/screens/other_user_profile/other_user_profile.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:story/story.dart';

class ViewStatusScreen extends StatefulWidget {
  final List<Statue>? imagesUrl;
  final String? uname;
  final String? uid;
  const ViewStatusScreen(
      {super.key, required this.imagesUrl, this.uname, this.uid});

  @override
  State<ViewStatusScreen> createState() => _ViewStatusScreenState();
}

class _ViewStatusScreenState extends State<ViewStatusScreen> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          StoryPageView(
            backgroundColor: Colors.white,
            itemBuilder: (context, pageIndex, storyIndex) {
              final imageUrl = widget.imagesUrl![storyIndex].imageUrl;
              return Center(
                  child: CachedNetworkImage(
                imageUrl: "$imageUrl",
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  if (downloadProgress.progress != null &&
                      downloadProgress.progress! < 100) {
                    indicatorAnimationController.value =
                        IndicatorAnimationCommand.pause;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    indicatorAnimationController.value =
                        IndicatorAnimationCommand.resume;
                    return Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    );
                  }
                },
              ));
            },
            storyLength: (pageIndex) {
              return widget.imagesUrl!.length;
            },
            indicatorVisitedColor: kPrimaryColor,
            pageLength: widget.imagesUrl!.length,
            onPageLimitReached: () {
              Get.back();
            },
            indicatorAnimationController: indicatorAnimationController,
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
                      Get.to(() => const OtherUserProfileScreen(),
                          arguments: widget.uid!);
                    },
                    child: CircleAvatar(
                      radius: getProportionateScreenHeight(20),
                      backgroundColor: Colors.red,
                      child: Icon(
                        MdiIcons.accountCircleOutline,
                        color: Colors.white,
                        size: getProportionateScreenHeight(25),
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
                        '${widget.uname}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenHeight(14),
                          fontWeight: FontWeight.w700,
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
