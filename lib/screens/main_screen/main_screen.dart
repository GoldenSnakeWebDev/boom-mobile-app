import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:boom_mobile/repo/get_user/get_curr_user.dart';
import 'package:boom_mobile/screens/explore/explore_screen.dart';
import 'package:boom_mobile/screens/home_screen/home_screen.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/screens/notifications/notifications_screen.dart';
import 'package:boom_mobile/screens/profile_screen/ui/profile_screen.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/fab_button.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: false,
      floatingActionButton: const FabButton(),
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
                child: index == 2
                    ? Badge(
                        isLabelVisible: true,
                        child: Icon(
                          _icons[index],
                          size: 24,
                          color: isActive ? kPrimaryColor : Colors.black,
                        ),
                      )
                    : Icon(
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
