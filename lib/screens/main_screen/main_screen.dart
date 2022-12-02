import 'dart:developer';
import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/repo/get_user/get_curr_user.dart';
import 'package:boom_mobile/screens/direct_messages/direct_messages_screen.dart';
import 'package:boom_mobile/screens/explore/expore_screen.dart';
import 'package:boom_mobile/screens/fans_frens_screen/ui/fans_screen.dart';
import 'package:boom_mobile/screens/home_screen/home_screen.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/screens/new_post/controllers/new_post_controller.dart';
import 'package:boom_mobile/screens/new_post/ui/create_new_post.dart';
import 'package:boom_mobile/screens/notifications/notifications_screen.dart';
import 'package:boom_mobile/screens/profile_screen/ui/profile_screen.dart';
import 'package:boom_mobile/screens/tales/ui/capture_tale_screen.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _pages = [];
  int _currPage = 0;
  final List<IconData> _icons = [
    MdiIcons.home,
    MdiIcons.magnify,
    MdiIcons.bellOutline,
    MdiIcons.account,
  ];

  onPageChanged(int index) {
    setState(() {
      _currPage = index;
    });
  }

  final box = GetStorage();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Get.put(FetchCurrUserRepo());
      Get.put(MainScreenController(repo: Get.find()));
    });
    _pages = [
      const HomeScreen(),
      const ExploreScreen(),
      const NotificationScreen(),
      const ProfileScreen(),
    ];
    log(box.read("token"));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              isDismissible: true,
              isScrollControlled: true,
              enableDrag: true,
              context: context,
              backgroundColor: Colors.white,
              constraints:
                  BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.5),
              builder: (context) {
                return Container(
                  height: SizeConfig.screenHeight * 0.4,
                  width: SizeConfig.screenWidth * 0.5,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              leading: const FloatingActionWidget(
                                "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/post.png",
                              ),
                              title: const Text(
                                'Post',
                              ),
                              onTap: () {
                                Get.back();
                                Get.find<NewPostController>().onInit();
                                Get.to(() => const CreateNewPost(),
                                    binding: AppBindings());
                              },
                            ),
                            ListTile(
                              leading: const FloatingActionWidget(
                                "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/tales.png",
                              ),
                              onTap: () {
                                Get.back();
                                Get.to(() => const CaptureTaleScreen());
                              },
                              title: const Text(
                                'Tales',
                              ),
                            ),
                            ListTile(
                              leading: SizedBox(
                                width: getProportionateScreenWidth(50),
                                child: Row(
                                  children: [
                                    const FloatingActionWidget(
                                      "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/tales.png",
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(5),
                                    ),
                                    const FloatingActionWidget(
                                      "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/tales.png",
                                    ),
                                  ],
                                ),
                              ),
                              title: const Text(
                                'Epics',
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Get.to(() => const DirectMessagesScreen());
                              },
                              leading: const Icon(Icons.mail),
                              title: const Text(
                                'DM',
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                final controller = Get.put(
                                    MainScreenController(repo: Get.find()));
                                Get.to(
                                  () => const FansScreen(),
                                  arguments: [controller.user!.funs!, "Fans"],
                                );
                              },
                              leading: const FloatingActionWidget(
                                "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/frens.png",
                              ),
                              title: const Text(
                                'Fans',
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                final controller = Get.put(
                                    MainScreenController(repo: Get.find()));
                                Get.to(
                                  () => const FansScreen(),
                                  arguments: [
                                    controller.user!.friends!,
                                    "Frens"
                                  ],
                                );
                              },
                              leading: const FloatingActionWidget(
                                "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/frens.png",
                              ),
                              title: const Text(
                                'Frens',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Container(
          decoration: BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.network(
              "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/boom_logo.png",
              width: getProportionateScreenHeight(22),
              height: getProportionateScreenHeight(22),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: Platform.isIOS
            ? getProportionateScreenHeight(30)
            : getProportionateScreenHeight(40),
        activeIndex: _currPage,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        itemCount: _icons.length,
        backgroundColor: Colors.white,
        tabBuilder: ((index, isActive) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Icon(
                  _icons[index],
                  size: 24,
                  color: isActive ? kPrimaryColor : Colors.black,
                ),
              )
            ],
          );
        }),
        leftCornerRadius: 4,
        rightCornerRadius: 4,
        onTap: onPageChanged,
      ),
      body: _pages.elementAt(_currPage),
    );
  }
}

class FloatingActionWidget extends StatelessWidget {
  final String imageUrl;
  const FloatingActionWidget(
    this.imageUrl, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.06,
      child: CachedNetworkImage(
        height: getProportionateScreenHeight(20),
        imageUrl: imageUrl,
      ),
    );
  }
}
