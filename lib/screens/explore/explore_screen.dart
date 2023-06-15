import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/explore/controllers/search_controller.dart';
import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/profile_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:boom_mobile/widgets/single_boom_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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
  // final _searchController = Get.find<SearchPageController>();
  List<Boom>? _shuffledBooms;
  var _isSearching = false;

  @override
  void initState() {
    _shuffleBooms();
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    analytics.setCurrentScreen(screenName: "Explore Screen");
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
                  child: GetBuilder<SearchPageController>(
                    init: SearchPageController(),
                    builder: (searchCtrller) => Column(
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
                            controller: searchCtrller.searchFormController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  _isSearching = false;
                                });
                              } else {
                                setState(() {
                                  _isSearching = true;
                                });
                                searchCtrller.searchBooms();
                              }
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
                            : (_isSearching == false)
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount: _shuffledBooms!.length,
                                      itemBuilder: (context, index) {
                                        final singlePostDets =
                                            Get.find<HomeController>();
                                        List<SingleBoomPost> boomPost =
                                            singlePostDets.getSingleBoomDetails(
                                                _shuffledBooms!);
                                        return SingleBoomWidget(
                                          post: boomPost[index],
                                          controller: homeController,
                                          boomId: _shuffledBooms![index].id!,
                                        );
                                      },
                                    ),
                                  )
                                : Expanded(
                                    child: Obx(
                                      () => searchCtrller.isLoading.value
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : searchCtrller.searchResults ==
                                                      null ||
                                                  searchCtrller.searchResults!
                                                      .search.booms.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    "No results",
                                                    style: TextStyle(
                                                        fontSize:
                                                            getProportionateScreenHeight(
                                                                17),
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              : ListView.builder(
                                                  itemCount: searchCtrller
                                                      .searchResults
                                                      ?.search
                                                      .booms
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    SingleBoomPost boomPost = Get
                                                            .find<
                                                                ProfileController>()
                                                        .getSingleBoomDetails(
                                                      searchCtrller
                                                          .searchResults!
                                                          .search
                                                          .booms[index],
                                                      index,
                                                    );
                                                    return SingleBoomWidget(
                                                      post: boomPost,
                                                      controller:
                                                          homeController,
                                                      boomId: searchCtrller
                                                          .searchResults!
                                                          .search
                                                          .booms[index]
                                                          .id!,
                                                    );
                                                  },
                                                ),
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
