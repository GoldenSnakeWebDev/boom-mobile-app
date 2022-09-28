import 'package:boom_mobile/screens/brand_page/brand_page.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:boom_mobile/widgets/single_brand_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(100),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: talesDetails.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Column(
                        children: [
                          Container(
                            width: getProportionateScreenWidth(56),
                            height: getProportionateScreenHeight(56),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/${talesDetails[index]["img"]}.jpeg"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          Text(
                            talesDetails[index]["title"].toString(),
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(12),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: brandDetails.length,
                  itemBuilder: (context, index) {
                    return SingleBrandPost(
                      index: index,
                      title: brandDetails[index]["title"].toString(),
                      image: brandDetails[index]["img"].toString(),
                      likes: brandDetails[index]["likes"].toString(),
                      rebooms: brandDetails[index]["reboom"].toString(),
                      comments: brandDetails[index]["comments"].toString(),
                      onTap: () {
                        Get.to(() => BrandPage(
                              title: brandDetails[index]["title"].toString(),
                            ));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
