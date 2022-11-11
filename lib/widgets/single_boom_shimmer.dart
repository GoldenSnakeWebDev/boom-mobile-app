import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SingleBoomShimmer extends StatelessWidget {
  const SingleBoomShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Shimmer.fromColors(
              baseColor: Colors.blueGrey.shade100,
              highlightColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: SizeConfig.screenHeight * 0.4,
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(100),
                          height: getProportionateScreenHeight(50),
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          width: getProportionateScreenWidth(150),
                          height: getProportionateScreenHeight(50),
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Container(
                      width: getProportionateScreenWidth(100),
                      height: getProportionateScreenHeight(30),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(8),
                    ),
                    Container(
                      width: getProportionateScreenWidth(100),
                      height: getProportionateScreenHeight(20),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: getProportionateScreenHeight(40),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    ListTile(
                      leading: Container(
                        width: getProportionateScreenHeight(40),
                        height: getProportionateScreenHeight(40),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: SizeConfig.screenWidth * 0.8,
                            height: getProportionateScreenHeight(20),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.2,
                            height: getProportionateScreenHeight(20),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    ListTile(
                      leading: Container(
                        width: getProportionateScreenHeight(40),
                        height: getProportionateScreenHeight(40),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: SizeConfig.screenWidth * 0.8,
                            height: getProportionateScreenHeight(20),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.2,
                            height: getProportionateScreenHeight(20),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
