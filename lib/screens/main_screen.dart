import 'dart:developer';
import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:boom_mobile/screens/explore/expore_screen.dart';
import 'package:boom_mobile/screens/home_screen/home_screen.dart';
import 'package:boom_mobile/screens/new_post/ui/create_new_post.dart';
import 'package:boom_mobile/screens/notifications/notifications_screen.dart';
import 'package:boom_mobile/screens/profile_screen/profile_screen.dart';
import 'package:boom_mobile/screens/tales/ui/capture_tale_screen.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
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
    MdiIcons.lightningBoltOutline,
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
    _pages = [
      const HomeScreen(),
      const ExploreScreen(),
      const NotificationScreen(),
      ProfileScreen(),
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
                          children: [
                            ListTile(
                              leading: Image.asset(
                                height: getProportionateScreenHeight(20),
                                "assets/icons/post.png",
                              ),
                              title: const Text('Post'),
                              onTap: () {
                                Navigator.of(context).pop();
                                Get.to(() => const CreateNewPost());
                              },
                            ),
                            ListTile(
                              leading: Image.asset(
                                height: getProportionateScreenHeight(20),
                                "assets/icons/tales.png",
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                Get.to(() => const CaptureTaleScreen());
                              },
                              title: const Text('Tales'),
                            ),
                            ListTile(
                              leading: SizedBox(
                                width: getProportionateScreenWidth(50),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      height: getProportionateScreenHeight(20),
                                      "assets/icons/tales.png",
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(5),
                                    ),
                                    Image.asset(
                                      height: getProportionateScreenHeight(20),
                                      "assets/icons/tales.png",
                                    ),
                                  ],
                                ),
                              ),
                              title: const Text('Epics'),
                            ),
                            const ListTile(
                              leading: Icon(Icons.mail),
                              title: Text('DM'),
                            ),
                            ListTile(
                              leading: Image.asset(
                                height: getProportionateScreenHeight(20),
                                "assets/icons/frens.png",
                              ),
                              title: const Text('Fans'),
                            ),
                            ListTile(
                              leading: Image.asset(
                                height: getProportionateScreenHeight(20),
                                "assets/icons/frens.png",
                              ),
                              title: const Text('Frens'),
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
            child: Image.asset(
              "assets/icons/boom_logo.png",
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
