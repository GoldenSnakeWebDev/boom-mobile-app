import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SingleNFTPage extends StatelessWidget {
  final String title;
  final String brandName;
  const SingleNFTPage({
    Key? key,
    required this.title,
    required this.brandName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              decoration: const BoxDecoration(color: Colors.black),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                child: Text(
                  "$brandName: Home: $title ",
                  style: TextStyle(
                    color: kYellowTextColor,
                    fontSize: getProportionateScreenHeight(16),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
