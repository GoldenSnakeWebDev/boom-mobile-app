import 'package:boom_mobile/screens/nft_page/single_nft_page.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandPage extends StatelessWidget {
  final String title;
  const BrandPage({Key? key, required this.title}) : super(key: key);

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
                  "$title: Home",
                  style: TextStyle(
                    color: kYellowTextColor,
                    fontSize: getProportionateScreenHeight(18),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.63,
                    crossAxisSpacing: 30,
                  ),
                  itemCount: brandNFTs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => SingleNFTPage(
                            title: brandNFTs[index]["title"].toString(),
                            brandName: title,
                            image: brandNFTs[index]["img"].toString(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Container(
                              height: getProportionateScreenHeight(200),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      brandNFTs[index]["img"].toString(),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: Colors.black)),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(7),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  brandNFTs[index]["title"].toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
