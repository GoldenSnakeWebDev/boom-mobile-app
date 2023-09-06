import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/splash_screen/controllers/splash_controller.dart';
import 'package:boom_mobile/screens/tales/controllers/tales_epics_controller.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/archery_header/archery_header.dart';
import 'package:boom_mobile/widgets/bottom_navigation_bar.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:boom_mobile/widgets/fab_button.dart';
import 'package:boom_mobile/widgets/single_boom_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:visual_effect/visual_effect.dart';

class _IndexScope extends InheritedWidget {
  const _IndexScope({
    required this.index,
    required super.child,
  });

  final int index;
  static int of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_IndexScope>();
    return scope?.index ?? 0;
  }

  @override
  bool updateShouldNotify(_IndexScope oldWidget) {
    return oldWidget.index != index;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();

    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    Get.put(SplashController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(TalesEpicsController);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(),
          bottomNavigationBar: CustomBottomNavBar(
            currIndex: 0,
            onHomePressed: () => controller.fetchAllBooms(),
          ),
          floatingActionButton: const FabButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          resizeToAvoidBottomInset: false,
          extendBody: false,
          body: SafeArea(
            child: controller.isLoading
                ? SizedBox(
                    height: SizeConfig.screenHeight * 0.95,
                    width: SizeConfig.screenWidth,
                    child: Shimmer.fromColors(
                      baseColor: Colors.blueGrey.shade100,
                      highlightColor: Colors.white,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight * 0.2,
                                margin: const EdgeInsets.only(bottom: 25),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight * 0.2,
                                margin: const EdgeInsets.only(bottom: 25),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight * 0.2,
                                margin: const EdgeInsets.only(bottom: 25),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight * 0.2,
                                margin: const EdgeInsets.only(bottom: 25),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onHorizontalDragStart: (details) {
                      // details.globalPosition.dx > SizeConfig.screenWidth / 2
                      //     ? Get.to(() => const CaptureTaleScreen())
                      //     : null;

                      // Get.to(() => const CaptureTaleScreen());
                    },
                    child: EasyRefresh(
                      controller: _controller,
                      // scrollController: controller.scrollController,
                      header: const ArcheryHeader(
                        position: IndicatorPosition.locator,
                        processedDuration: Duration(seconds: 1),
                      ),
                      onRefresh: () async {
                        _controller.callRefresh();
                        await controller.fetchAllBooms();

                        _controller.finishRefresh();
                        _controller.resetFooter();

                        // await TalesEpicsController().fetchTales();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            // GetBuilder<TalesEpicsController>(
                            //   init: TalesEpicsController(),
                            //   builder: (ctrllr) {
                            //     return SizedBox(
                            //       height: getProportionateScreenHeight(80),
                            //       child: Obx(
                            //         () => (ctrllr.isLoading.value ||
                            //                 controller.isLoading)
                            //             ? _buildTalesShimmer()
                            //             : Row(
                            //                 children: [
                            //                   GestureDetector(
                            //                     onTap: () async {
                            //                       final List<CameraDescription>
                            //                           cameras =
                            //                           await availableCameras();
                            //                       Get.to(
                            //                           () =>
                            //                               const CaptureTaleScreen(),
                            //                           arguments: [cameras]);
                            //                     },
                            //                     child: SizedBox(
                            //                       height:
                            //                           getProportionateScreenHeight(
                            //                               75),
                            //                       width:
                            //                           getProportionateScreenWidth(
                            //                               75),
                            //                       child: Stack(
                            //                         children: [
                            //                           Positioned(
                            //                             top: 0,
                            //                             child: Container(
                            //                               width:
                            //                                   getProportionateScreenHeight(
                            //                                       60),
                            //                               height:
                            //                                   getProportionateScreenHeight(
                            //                                       60),
                            //                               decoration:
                            //                                   const BoxDecoration(
                            //                                 shape:
                            //                                     BoxShape.circle,
                            //                               ),
                            //                               child: Container(
                            //                                 width:
                            //                                     getProportionateScreenHeight(
                            //                                         53),
                            //                                 height:
                            //                                     getProportionateScreenHeight(
                            //                                         60),
                            //                                 decoration:
                            //                                     BoxDecoration(
                            //                                   borderRadius:
                            //                                       BorderRadius
                            //                                           .circular(
                            //                                               10),
                            //                                   //
                            //                                 ),
                            //                                 child: Padding(
                            //                                   padding:
                            //                                       const EdgeInsets
                            //                                           .all(2.0),
                            //                                   child: ClipRRect(
                            //                                     borderRadius:
                            //                                         BorderRadius
                            //                                             .circular(
                            //                                                 10),
                            //                                     child:
                            //                                         CachedNetworkImage(
                            //                                       width:
                            //                                           getProportionateScreenWidth(
                            //                                               56),
                            //                                       height:
                            //                                           getProportionateScreenHeight(
                            //                                               56),
                            //                                       errorWidget: (context,
                            //                                               url,
                            //                                               error) =>
                            //                                           Image
                            //                                               .network(
                            //                                         "https://bafkreihauwrqu5wrcwsi53fkmm75pcdlmbzcg7eorw6avmb3o3cx4tk33e.ipfs.nftstorage.link/",
                            //                                         fit: BoxFit
                            //                                             .cover,
                            //                                       ),
                            //                                       imageUrl: mainController
                            //                                               .user
                            //                                               ?.photo ??
                            //                                           "https://bafkreihauwrqu5wrcwsi53fkmm75pcdlmbzcg7eorw6avmb3o3cx4tk33e.ipfs.nftstorage.link/",
                            //                                       fit: BoxFit
                            //                                           .cover,
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ),
                            //                           const Visibility(
                            //                             // visible: !ctrllr
                            //                             //     .talesByUser[
                            //                             //         index]
                            //                             //     .containsKey(
                            //                             //         controller
                            //                             //             .userId),
                            //                             child: Positioned(
                            //                               bottom: 10,
                            //                               right: 17,
                            //                               child: Icon(
                            //                                 MdiIcons.plusCircle,
                            //                                 size: 18,
                            //                                 color: Colors
                            //                                     .blueAccent,
                            //                               ),
                            //                             ),
                            //                           ),
                            //                           Positioned(
                            //                             bottom: 0,
                            //                             left: 10,
                            //                             child: Text(
                            //                               "Your Tale",
                            //                               style: TextStyle(
                            //                                 fontSize:
                            //                                     getProportionateScreenHeight(
                            //                                         12),
                            //                                 fontWeight:
                            //                                     FontWeight.w500,
                            //                               ),
                            //                             ),
                            //                           )
                            //                         ],
                            //                       ),
                            //                     ),
                            //                   ),
                            //                   Expanded(
                            //                     child: ListView.builder(
                            //                       scrollDirection:
                            //                           Axis.horizontal,
                            //                       itemCount:
                            //                           ctrllr.tales?.length ?? 0,
                            //                       itemBuilder:
                            //                           (context, index) {
                            //                         return GestureDetector(
                            //                           onTap: () {
                            //                             Get.to(
                            //                               () =>
                            //                                   ViewStatusScreen(
                            //                                 imagesUrl:
                            //                                     ctrllr.tales!,
                            //                               ),
                            //                               arguments: [index],
                            //                             );
                            //                           },
                            //                           child: Container(
                            //                             margin: const EdgeInsets
                            //                                 .only(right: 17),
                            //                             child: Column(
                            //                               children: [
                            //                                 Container(
                            //                                   width:
                            //                                       getProportionateScreenHeight(
                            //                                           60),
                            //                                   height:
                            //                                       getProportionateScreenHeight(
                            //                                           60),
                            //                                   decoration:
                            //                                       BoxDecoration(
                            //                                     borderRadius:
                            //                                         BorderRadius
                            //                                             .circular(
                            //                                                 10),
                            //                                     border:
                            //                                         Border.all(
                            //                                       color: index %
                            //                                                   2 ==
                            //                                               0
                            //                                           ? Colors
                            //                                               .grey
                            //                                           : kPrimaryColor,
                            //                                       width: 1.5,
                            //                                     ),
                            //                                     // shape: BoxShape.circle,
                            //                                   ),
                            //                                   child: Padding(
                            //                                     padding:
                            //                                         const EdgeInsets
                            //                                                 .all(
                            //                                             2.0),
                            //                                     child:
                            //                                         Container(
                            //                                       width:
                            //                                           getProportionateScreenWidth(
                            //                                               56),
                            //                                       height:
                            //                                           getProportionateScreenHeight(
                            //                                               56),
                            //                                       decoration:
                            //                                           BoxDecoration(
                            //                                         // shape: BoxShape.circle,
                            //                                         borderRadius:
                            //                                             BorderRadius.circular(
                            //                                                 10),
                            //                                         image:
                            //                                             DecorationImage(
                            //                                           image:
                            //                                               CachedNetworkImageProvider(
                            //                                             ctrllr
                            //                                                 .tales![index]
                            //                                                 .statues[0]
                            //                                                 .imageUrl,
                            //                                           ),
                            //                                           fit: BoxFit
                            //                                               .cover,
                            //                                         ),
                            //                                       ),
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                                 SizedBox(
                            //                                   height:
                            //                                       getProportionateScreenHeight(
                            //                                           5),
                            //                                 ),
                            //                                 Text(
                            //                                   "${ctrllr.tales?[index].id.username}",
                            //                                   style: TextStyle(
                            //                                     fontSize:
                            //                                         getProportionateScreenHeight(
                            //                                             12),
                            //                                     fontWeight:
                            //                                         FontWeight
                            //                                             .w500,
                            //                                   ),
                            //                                 ),
                            //                               ],
                            //                             ),
                            //                           ),
                            //                         );
                            //                       },
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //       ),
                            //     );
                            //   },
                            // ),
                            // SizedBox(
                            //   height: getProportionateScreenHeight(80),
                            //   width: SizeConfig.screenWidth,
                            //   child: ListView.builder(
                            //       scrollDirection: Axis.horizontal,
                            //       addAutomaticKeepAlives: true,
                            //       addSemanticIndexes: true,
                            //       key: const PageStorageKey("BoomBoxesKey"),
                            //       itemCount: controller.boomBoxes.length,
                            //       itemBuilder: (context, index) {
                            //         return GestureDetector(
                            //           onTap: () {
                            //             if (controller
                            //                         .boomBoxes[index].user.id ==
                            //                     controller.userId ||
                            //                 controller.boomBoxes[index].members
                            //                         .indexWhere((element) =>
                            //                             element.user.id ==
                            //                             controller.userId) !=
                            //                     -1) {
                            //               Get.to(
                            //                 () => const SingleBoomBoxMessage(),
                            //                 arguments: [
                            //                   controller.boomBoxes[index],
                            //                 ],
                            //               );
                            //             } else {
                            //               Get.snackbar(
                            //                 "Error",
                            //                 "Could not view BoomBox since you are not a memeber",
                            //                 backgroundColor:
                            //                     kredCancelTextColor,
                            //                 colorText: Colors.white,
                            //               );
                            //             }
                            //           },
                            //           child: Container(
                            //             margin:
                            //                 const EdgeInsets.only(right: 24),
                            //             child: Column(
                            //               children: [
                            //                 Container(
                            //                   width:
                            //                       getProportionateScreenHeight(
                            //                           60),
                            //                   height:
                            //                       getProportionateScreenHeight(
                            //                           60),
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(10),
                            //                     border: Border.all(
                            //                       color: kPrimaryColor,
                            //                       width: 1.5,
                            //                     ),
                            //                     // shape: BoxShape.circle,
                            //                   ),
                            //                   child: Padding(
                            //                     padding:
                            //                         const EdgeInsets.all(2.0),
                            //                     child: Container(
                            //                       width:
                            //                           getProportionateScreenWidth(
                            //                               56),
                            //                       height:
                            //                           getProportionateScreenHeight(
                            //                               56),
                            //                       decoration: BoxDecoration(
                            //                         // shape: BoxShape.circle,
                            //                         borderRadius:
                            //                             BorderRadius.circular(
                            //                                 10),
                            //                         image: DecorationImage(
                            //                           image: CachedNetworkImageProvider(
                            //                               controller
                            //                                           .boomBoxes[
                            //                                               index]
                            //                                           .imageUrl ==
                            //                                       ""
                            //                                   ? boomIconUrl
                            //                                   : controller
                            //                                       .boomBoxes[
                            //                                           index]
                            //                                       .imageUrl),
                            //                           fit: BoxFit.cover,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 SizedBox(
                            //                   height:
                            //                       getProportionateScreenHeight(
                            //                           5),
                            //                 ),
                            //                 Text(
                            //                   controller.boomBoxes[index].label
                            //                               .length >
                            //                           12
                            //                       ? "${controller.boomBoxes[index].label.substring(0, 11)}..."
                            //                       : controller
                            //                           .boomBoxes[index].label,
                            //                   style: TextStyle(
                            //                     fontSize:
                            //                         getProportionateScreenHeight(
                            //                             11),
                            //                     fontWeight: FontWeight.w800,
                            //                     color: Colors.black,
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         );
                            //       }),
                            // ),
                            // Divider(
                            //   color: Colors.grey.shade200,
                            //   thickness: 1,
                            // ),
                            (controller.homeBooms!.isEmpty)
                                ? const Center(
                                    child: Text(
                                      "No Booms available",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: CustomScrollView(
                                    key: const PageStorageKey("homeBooms"),
                                    controller: controller.scrollController,
                                    slivers: [
                                      const HeaderLocator.sliver(),
                                      SliverList.builder(
                                        key: const PageStorageKey<String>(
                                            "homeKey"),
                                        itemCount:
                                            controller.homeBooms?.length ?? 0,
                                        addRepaintBoundaries: false,
                                        itemBuilder: (context, index) {
                                          List<SingleBoomPost> boomPost =
                                              controller.getSingleBoomDetails(
                                                  controller.homeBooms!);

                                          return _IndexScope(
                                            index: index,
                                            child: ScrollEffect(
                                              onGenerateVisualEffect:
                                                  (effect, phase) {
                                                return effect
                                                    .grayscale(phase
                                                        .leadingLerp(to: 0.5))
                                                    .scale(
                                                      x: phase.isLeading
                                                          ? phase.leadingLerp(
                                                              from: 1, to: 0.9)
                                                          : 1,
                                                      anchor:
                                                          Alignment.topCenter,
                                                    )
                                                    .translate(
                                                        y: effect.childSize
                                                                .height *
                                                            phase.leading);
                                              },
                                              child: SingleBoomWidget(
                                                  post: boomPost[index],
                                                  controller: controller,
                                                  boomId: controller
                                                      .homeBooms![index].id!,
                                                  boom: controller
                                                      .homeBooms![index]),
                                            ),
                                          );
                                        },
                                        // delegate: SliverChildBuilderDelegate (
                                        //   (context, index) {
                                        //     List<SingleBoomPost> boomPost =
                                        //         controller.getSingleBoomDetails(
                                        //             controller.homeBooms!);

                                        //     return SingleBoomWidget(
                                        //       post: boomPost[index],
                                        //       controller: controller,
                                        //       boomId: controller
                                        //           .homeBooms![index].id!,
                                        //     );
                                        //   },

                                        //   // childCount:
                                        //   //     controller.homeBooms!.length,
                                        // ),
                                      )
                                    ],
                                  )

                                    // ListView.builder(
                                    //   key: const PageStorageKey<String>(
                                    //       "homeKey"),
                                    //   controller: controller.scrollController,
                                    //   itemCount: controller.homeBooms!.length,
                                    //   itemBuilder: (context, index) {
                                    //     List<SingleBoomPost> boomPost =
                                    //         controller.getSingleBoomDetails(
                                    //             controller.homeBooms!);

                                    //     return SingleBoomWidget(
                                    //       post: boomPost[index],
                                    //       controller: controller,
                                    //       boomId:
                                    //           controller.homeBooms![index].id!,
                                    //     );
                                    //   },
                                    // ),
                                    ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  // _buildTalesShimmer() {
  //   return Shimmer.fromColors(
  //     baseColor: Colors.grey[300]!,
  //     highlightColor: kPrimaryColor,
  //     child: ListView.builder(
  //       itemCount: 5,
  //       shrinkWrap: true,
  //       scrollDirection: Axis.horizontal,
  //       itemBuilder: (context, i) => Container(
  //         height: getProportionateScreenHeight(40),
  //         width: getProportionateScreenWidth(75),
  //         margin: EdgeInsets.only(
  //           right: getProportionateScreenWidth(10),
  //         ),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(12),
  //           color: Colors.white,
  //         ),
  //         child: const Text(""),
  //       ),
  //     ),
  //   );
  // }
}
