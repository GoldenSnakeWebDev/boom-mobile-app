import 'dart:developer';

import 'package:boom_mobile/screens/new_post/controllers/instagram_web_controller.dart';
import 'package:boom_mobile/screens/new_post/ui/create_new_post.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InstagramPosts extends StatefulWidget {
  const InstagramPosts({
    Key? key,
  }) : super(key: key);

  @override
  State<InstagramPosts> createState() => _InstagramPostsState();
}

class _InstagramPostsState extends State<InstagramPosts>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  List<Tab> tabs = [
    const Tab(text: "Photos"),
    const Tab(text: "Videos"),
  ];
  List<Widget> tabViews = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    tabViews = [
      const IGPhotosPage(),
      const IGVideosPage(),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.addListener(() {
      log("Anything");
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
    // return GetBuilder<InstagramWebController>(
    //     init: InstagramWebController(),
    //     builder: (controller) {
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
          "Title",
          // '${controller.medias.isNotEmpty ? controller.medias[0].username : ""} Instagram ${_currentTabIndex == 0 ? "Photos" : "Videos"}',
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
                // controller.proceedWithUpload(controller.selectedIgMedia);
              },
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
      body: DefaultTabController(
        length: tabViews.length,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: TabBar(
                tabs: [
                  tabs[0],
                  tabs[1],
                ],
                controller: _tabController,
                unselectedLabelColor: Colors.black,
                labelColor: kPrimaryColor,
                labelStyle: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
                  fontWeight: FontWeight.w700,
                  color: kPrimaryColor,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                indicatorColor: Colors.transparent,
                isScrollable: true,
              ),
            ),
            Positioned(
              top: getProportionateScreenHeight(40),
              child: SizedBox(
                height: SizeConfig.screenHeight * 0.9,
                width: SizeConfig.screenWidth,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: tabs.map((Tab e) {
                    return tabViews[_currentTabIndex];
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
    // });
    // const IGPhotosPage();
  }
}

class IGPhotosPage extends StatelessWidget {
  const IGPhotosPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstagramWebController>(
      init: InstagramWebController(),
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: controller.igPhotos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9,
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.selectImage(controller.igPhotos[index]);
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => PreviewIgPostDialog(
                        image: controller.igPhotos[index].media_url,
                      ),
                    );
                  },
                  child: Container(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(50),
                    decoration: BoxDecoration(
                      border: controller.selectedIgMedia != null &&
                              controller.selectedIgMedia ==
                                  controller.igPhotos[index]
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
                          imageUrl: controller.igPhotos[index].media_url,
                          fit: BoxFit.cover,
                        ),
                        controller.selectedIgMedia == null ||
                                controller.selectedIgMedia !=
                                    controller.igPhotos[index]
                            ? const SizedBox()
                            : Positioned(
                                bottom: 5,
                                right: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
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

class IGVideosPage extends StatelessWidget {
  const IGVideosPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("IGVideosPage");
    return GetBuilder<InstagramWebController>(
      init: InstagramWebController(),
      builder: (controller) {
        return Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Import Instagram Videos coming soon",
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(18),
                      fontWeight: FontWeight.w800),
                ),
              )
              //  GridView.builder(
              //   itemCount: controller.igVideos.length,
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     childAspectRatio: 0.9,
              //     crossAxisCount: 3,
              //     mainAxisSpacing: 10,
              //     crossAxisSpacing: 10,
              //   ),
              //   itemBuilder: (context, index) {
              //     return VTImageView(
              //       videoUrl: controller.igVideos[index].media_url,
              //       height: getProportionateScreenHeight(200),
              //       width: getProportionateScreenWidth(200),
              //       assetPlaceHolder: "IG VIDEO",
              //       errorBuilder: (context, error, stackTrace) {
              //         return Container(
              //           height: getProportionateScreenHeight(200),
              //           width: getProportionateScreenWidth(200),
              //           color: Colors.grey,
              //           child: const Center(
              //             child: Text(
              //               "Error loading video",
              //               style: TextStyle(
              //                 color: Colors.white,
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //     );
              // height: getProportionateScreenHeight(400),
              // width: getProportionateScreenWidth(250),
              // imageUrl: controller.thumbNails[index],
              // fit: BoxFit.cover,

              // controller.igVideos[index].media_type == "VIDEO"
              //     ? GestureDetector(
              //         onTap: () {
              //           log("Playing video");
              //           controller.videoControllers[0]
              //                   [controller.igVideos[index].id]!
              //               .play();
              //         },
              //         child: VideoPlayer(
              //           VideoPlayerController.network(
              //               controller.igVideos[index].media_url),
              //         ),
              //       )
              //     : GestureDetector(
              //         onTap: () {
              //           controller.selectImage(controller.igVideos[index]);
              //         },
              //         onLongPress: () {
              //           showDialog(
              //             context: context,
              //             builder: (BuildContext context) =>
              //                 PreviewIgPostDialog(
              //               image: controller.igVideos[index].media_url,
              //             ),
              //           );
              //         },
              //         child: Container(
              //           height: getProportionateScreenHeight(50),
              //           width: getProportionateScreenWidth(50),
              //           decoration: BoxDecoration(
              //             border: controller.selectedIgMedia != null &&
              //                     controller.selectedIgMedia ==
              //                         controller.igVideos[index]
              //                 ? Border.all(
              //                     color: kPrimaryColor,
              //                     width: 2,
              //                   )
              //                 : null,
              //           ),
              //           child: Stack(
              //             children: [
              //               CachedNetworkImage(
              //                 height: getProportionateScreenHeight(400),
              //                 width: getProportionateScreenWidth(250),
              //                 imageUrl: controller.igVideos[index].media_url,
              //                 fit: BoxFit.cover,
              //               ),
              //               controller.selectedIgMedia == null ||
              //                       controller.selectedIgMedia !=
              //                           controller.igVideos[index]
              //                   ? const SizedBox()
              //                   : Positioned(
              //                       bottom: 5,
              //                       right: 5,
              //                       child: Container(
              //                         decoration: BoxDecoration(
              //                             color:
              //                                 Colors.white.withOpacity(0.6),
              //                             shape: BoxShape.circle),
              //                         child: const Icon(
              //                           MdiIcons.check,
              //                           color: kPrimaryColor,
              //                           size: 16,
              //                         ),
              //                       ),
              //                     )
              //             ],
              //           ),
              //         ),
              //       );
              //   },
              // ),
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
                    color: Theme.of(context).colorScheme.background,
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
