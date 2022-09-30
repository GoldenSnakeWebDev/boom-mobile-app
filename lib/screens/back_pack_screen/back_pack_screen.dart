import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BackPackScreen extends StatelessWidget {
  const BackPackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.8,
      height: SizeConfig.screenHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(MdiIcons.close),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(4),
                    gradient: const LinearGradient(
                      colors: [
                        kPrimaryColor,
                        kSecondaryColor,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    child: Row(
                      children: [
                        const Icon(
                          MdiIcons.contentCopy,
                          size: 20,
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(5),
                        ),
                        Text(
                          "Copy",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(11),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            RichText(
              text: const TextSpan(
                text: "Backpack ID: ",
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                      text: "KA265890OQ",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Container(
              width: SizeConfig.screenWidth,
              height: getProportionateScreenHeight(40),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
                gradient: const LinearGradient(
                  colors: [
                    kSecondaryColor,
                    kPrimaryColor,
                    kPrimaryColor,
                    kPrimaryColor,
                    kPrimaryColor,
                    kSecondaryColor,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: SizeConfig.screenWidth * 0.3,
                    child: Text(
                      "Syn. NFT",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(16),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: Text(
                          "18",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(12),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemBuilder: (context, index) {
            //       return Container();
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
