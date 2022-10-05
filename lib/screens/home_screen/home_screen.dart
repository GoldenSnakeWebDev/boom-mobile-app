import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:boom_mobile/widgets/single_boom_widget.dart';
import 'package:flutter/material.dart';

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
                height: getProportionateScreenHeight(80),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: talesDetails.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Column(
                        children: [
                          Container(
                            width: getProportionateScreenHeight(60),
                            height: getProportionateScreenHeight(60),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: index % 2 == 0
                                    ? Colors.grey
                                    : kPrimaryColor,
                                width: 1.5,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                width: getProportionateScreenWidth(56),
                                height: getProportionateScreenHeight(56),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/${talesDetails[index]["img"]}.jpeg"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
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
              Divider(
                color: Colors.grey.shade200,
                thickness: 1,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return const SingleBoomWidget();
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
