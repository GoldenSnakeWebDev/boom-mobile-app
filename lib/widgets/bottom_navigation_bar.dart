import 'dart:developer';
import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:boom_mobile/routes/route_helper.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currIndex;
  final Function()? onHomePressed;
  const CustomBottomNavBar({
    Key? key,
    required this.currIndex,
    this.onHomePressed,
  }) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int bottomNavIndex = 0;

  final List<IconData> _icons = [
    MdiIcons.home,
    MdiIcons.magnify,
    MdiIcons.bellOutline,
    MdiIcons.account,
  ];

  onPageChanged(int index) {
    if (index == 0) {
      if (!(widget.currIndex == 0)) {
        Get.offAndToNamed(RouteHelper.homeScreen);
      } else {
        log("Pressed for second Time");
        widget.onHomePressed ?? () {};
      }
    } else if (index == 1) {
      if (!(widget.currIndex == 1)) {
        Get.offAndToNamed(RouteHelper.exploreScreen);
      }
    } else if (index == 2) {
      if (!(widget.currIndex == 2)) {
        Get.offAndToNamed(RouteHelper.notificationScreen);
      }
    } else if (index == 3) {
      if (!(widget.currIndex == 3)) {
        Get.offAndToNamed(RouteHelper.profileScreen);
      }
    }
  }

  @override
  void initState() {
    bottomNavIndex = widget.currIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      height: Platform.isIOS
          ? getProportionateScreenHeight(30)
          : getProportionateScreenHeight(40),
      activeIndex: bottomNavIndex,
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
    );
  }
}
