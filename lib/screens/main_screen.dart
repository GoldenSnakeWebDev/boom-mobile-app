import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:boom_mobile/screens/explore/expore_screen.dart';
import 'package:boom_mobile/screens/home_screen/home_screen.dart';
import 'package:boom_mobile/screens/notifications/notifications_screen.dart';
import 'package:boom_mobile/screens/profile_screen/profile_screen.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      extendBody: true,
      floatingActionButton: GestureDetector(
        onTap: () {
          log("Docked Button pressed");
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
        height: getProportionateScreenHeight(30),
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
