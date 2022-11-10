import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:boom_mobile/widgets/single_boom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final mainController = Get.find<MainScreenController>();
  final homeController = Get.find<HomeController>();
  List<Boom>? _shuffledBooms;

  @override
  void initState() {
    _shuffleBooms();
    super.initState();
  }

  _shuffleBooms() {
    _shuffledBooms = homeController.homeBooms;
    _shuffledBooms!.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return homeController.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppBar(),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await homeController.fetchAllBooms();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (_shuffledBooms!.isEmpty)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo_album_outlined,
                                  size: getProportionateScreenHeight(100),
                                  color: kPrimaryColor,
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                                Center(
                                  child: Text(
                                    'Feeds coming right up',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(14),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: _shuffledBooms!.length,
                                itemBuilder: (context, index) {
                                  SingleBoomPost boomPost = SingleBoomPost(
                                    boomType: _shuffledBooms![index].boomType,
                                    location: "Location",
                                    chain:
                                        _shuffledBooms![index].network.symbol,
                                    imgUrl: _shuffledBooms![index].imageUrl,
                                    desc: _shuffledBooms![index].description,
                                    network: _shuffledBooms![index].network,
                                    isLiked: homeController.isLiked,
                                    likes: _shuffledBooms![index]
                                        .reactions
                                        .likes
                                        .length,
                                    loves: _shuffledBooms![index]
                                        .reactions
                                        .loves
                                        .length,
                                    smiles: _shuffledBooms![index]
                                        .reactions
                                        .smiles
                                        .length,
                                    rebooms: _shuffledBooms![index]
                                        .reactions
                                        .rebooms
                                        .length,
                                    reported: _shuffledBooms![index]
                                        .reactions
                                        .reports
                                        .length,
                                    comments:
                                        _shuffledBooms![index].comments.length,
                                  );

                                  return SingleBoomWidget(
                                    post: boomPost,
                                    controller: homeController,
                                    boomId: _shuffledBooms![index].id,
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
  }
}
