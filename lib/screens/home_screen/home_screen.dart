import 'dart:developer';

import 'package:boom_mobile/models/network_model.dart';
import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/screens/tales/ui/capture_tale_screen.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:boom_mobile/widgets/single_boom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Get.put(HomeController());
  }

  final mainController = Get.find<MainScreenController>();

  @override
  Widget build(BuildContext context) {
    log("Main User: ${mainController.user}");
    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: const CustomAppBar(),
                body: SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.fetchAllBooms();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(80),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.allBooms!.booms.length,
                              itemBuilder: (context, index) {
                                return index == 0
                                    ? GestureDetector(
                                        onTap: () async {
                                          Get.to(
                                              () => const CaptureTaleScreen());
                                        },
                                        child: SizedBox(
                                          height:
                                              getProportionateScreenHeight(70),
                                          width:
                                              getProportionateScreenWidth(75),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 0,
                                                child: Container(
                                                  width:
                                                      getProportionateScreenHeight(
                                                          60),
                                                  height:
                                                      getProportionateScreenHeight(
                                                          60),
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Container(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              56),
                                                      height:
                                                          getProportionateScreenHeight(
                                                              56),
                                                      decoration: BoxDecoration(
                                                        // shape: BoxShape.circle,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                talesDetails[
                                                                            index]
                                                                        ["img"]
                                                                    .toString()),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Positioned(
                                                bottom: 20,
                                                right: 17,
                                                child: Icon(
                                                  MdiIcons.plusCircle,
                                                  size: 18,
                                                  color: Colors.blueAccent,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 5,
                                                left: 10,
                                                child: Text(
                                                  "Your Tale",
                                                  style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            12),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        margin:
                                            const EdgeInsets.only(right: 17),
                                        child: Column(
                                          children: [
                                            Container(
                                              width:
                                                  getProportionateScreenHeight(
                                                      60),
                                              height:
                                                  getProportionateScreenHeight(
                                                      60),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: index % 2 == 0
                                                      ? Colors.grey
                                                      : kPrimaryColor,
                                                  width: 1.5,
                                                ),
                                                // shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  width:
                                                      getProportionateScreenWidth(
                                                          56),
                                                  height:
                                                      getProportionateScreenHeight(
                                                          56),
                                                  decoration: BoxDecoration(
                                                    // shape: BoxShape.circle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          talesDetails[index]
                                                                  ["img"]
                                                              .toString(),
                                                        ),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      5),
                                            ),
                                            Text(
                                              talesDetails[index]["title"]
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        12),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                              },
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade200,
                            thickness: 1,
                          ),
                          controller.allBooms!.booms.isEmpty
                              ? const Center(
                                  child: Text("No Booms available",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        controller.allBooms!.booms.length,
                                    itemBuilder: (context, index) {
                                      Network? network =
                                          controller.getNetworkById(controller
                                              .allBooms!.booms[index].network);

                                      SingleBoomPost boomPost = SingleBoomPost(
                                        boomType: controller
                                            .allBooms!.booms[index].boomType,
                                        location: "Location",
                                        chain: controller
                                            .allBooms!.booms[index].network,
                                        imgUrl: controller
                                            .allBooms!.booms[index].imageUrl,
                                        desc: controller
                                            .allBooms!.booms[index].description,
                                        network: network,
                                        isLiked: controller.isLiked,
                                        likes: 100 + index,
                                        loves: 76 + index,
                                        smiles: 20 + index,
                                        rebooms: 5 + index,
                                        reported: 2 + index,
                                        comments: 3 + index,
                                      );

                                      return SingleBoomWidget(
                                        post: boomPost,
                                        controller: controller,
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
