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

import 'controllers/search_controller.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final mainController = Get.find<MainScreenController>();
  final homeController = Get.find<HomeController>();
  final _searchController = Get.find<SearchController>();
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
                      Container(
                        height: getProportionateScreenHeight(50),
                        margin: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(15),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _searchController.searchFormController,
                          onChanged: (value) {
                            _searchController.searchBooms();
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
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
                                  final singlePostDets =
                                      Get.find<HomeController>();
                                  SingleBoomPost boomPost = singlePostDets
                                      .getSingleBoomDetails(index);
                                  return SingleBoomWidget(
                                    post: boomPost,
                                    controller: homeController,
                                    boomId: _shuffledBooms![index].id!,
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
