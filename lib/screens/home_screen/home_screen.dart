import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/screens/tales/controllers/tales_epics_controller.dart';
import 'package:boom_mobile/screens/tales/ui/capture_tale_screen.dart';
import 'package:boom_mobile/screens/tales/ui/view_status_screen.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:boom_mobile/widgets/single_boom_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

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
    Get.put(TalesEpicsController);
  }

  final mainController = Get.find<MainScreenController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        Future.delayed(const Duration(seconds: 3)).then((value) =>
            controller.getMyBooms(controller.allBooms, mainController.user!));

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
                          GetBuilder<TalesEpicsController>(
                              init: TalesEpicsController(),
                              builder: (ctrllr) => SizedBox(
                                    height: getProportionateScreenHeight(80),
                                    child: Obx(
                                      () => (ctrllr.isLoading.value)
                                          ? _buildTalesShimmer()
                                          : ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: ctrllr.tales!.length,
                                              itemBuilder: (context, index) {
                                                return index == 0
                                                    ? GestureDetector(
                                                        onTap: () async {
                                                          Get.to(() =>
                                                              const CaptureTaleScreen());
                                                        },
                                                        child: SizedBox(
                                                          height:
                                                              getProportionateScreenHeight(
                                                                  70),
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  75),
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                top: 0,
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      getProportionateScreenHeight(
                                                                          60),
                                                                  height:
                                                                      getProportionateScreenHeight(
                                                                          60),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            2.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        width: getProportionateScreenWidth(
                                                                            56),
                                                                        height:
                                                                            getProportionateScreenHeight(56),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            Image.network(
                                                                          "https://bafkreihauwrqu5wrcwsi53fkmm75pcdlmbzcg7eorw6avmb3o3cx4tk33e.ipfs.nftstorage.link/",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        imageUrl:
                                                                            mainController.user?.photo ??
                                                                                "https://bafkreihauwrqu5wrcwsi53fkmm75pcdlmbzcg7eorw6avmb3o3cx4tk33e.ipfs.nftstorage.link/",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const Positioned(
                                                                bottom: 20,
                                                                right: 17,
                                                                child: Icon(
                                                                  MdiIcons
                                                                      .plusCircle,
                                                                  size: 18,
                                                                  color: Colors
                                                                      .blueAccent,
                                                                ),
                                                              ),
                                                              Positioned(
                                                                bottom: 5,
                                                                left: 10,
                                                                child: Text(
                                                                  "Your Tale",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        getProportionateScreenHeight(
                                                                            12),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                            () =>
                                                                ViewStatusScreen(
                                                              imagesUrl: [
                                                                ctrllr
                                                                    .tales![
                                                                        index]
                                                                    .imageUrl
                                                                    .toString()
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 17),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                width:
                                                                    getProportionateScreenHeight(
                                                                        60),
                                                                height:
                                                                    getProportionateScreenHeight(
                                                                        60),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border
                                                                      .all(
                                                                    color: index %
                                                                                2 ==
                                                                            0
                                                                        ? Colors
                                                                            .grey
                                                                        : kPrimaryColor,
                                                                    width: 1.5,
                                                                  ),
                                                                  // shape: BoxShape.circle,
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        getProportionateScreenWidth(
                                                                            56),
                                                                    height:
                                                                        getProportionateScreenHeight(
                                                                            56),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      // shape: BoxShape.circle,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(
                                                                            ctrllr.tales![index].imageUrl.toString(),
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
                                                                "${ctrllr.tales?[index].user?.username}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      getProportionateScreenHeight(
                                                                          12),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                              },
                                            ),
                                    ),
                                  )),
                          Divider(
                            color: Colors.grey.shade200,
                            thickness: 1,
                          ),
                          (controller.homeBooms!.isEmpty)
                              ? const Center(
                                  child: Text("No Booms available",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: controller.homeBooms!.length,
                                    itemBuilder: (context, index) {
                                      SingleBoomPost boomPost = controller
                                          .getSingleBoomDetails(index);

                                      return SingleBoomWidget(
                                        post: boomPost,
                                        controller: controller,
                                        boomId: controller.homeBooms![index].id,
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

  _buildTalesShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: kPrimaryColor,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => Container(
          height: getProportionateScreenHeight(40),
          width: getProportionateScreenWidth(75),
          margin: EdgeInsets.only(
            right: getProportionateScreenWidth(10),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: const Text(""),
        ),
      ),
    );
  }
}
