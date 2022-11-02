import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleBrandPost extends StatelessWidget {
  final String title;
  final String image;
  final String likes;
  final String rebooms;
  final String comments;
  final int index;
  final Function() onTap;
  const SingleBrandPost(
      {Key? key,
      required this.title,
      required this.image,
      required this.likes,
      required this.rebooms,
      required this.comments,
      required this.index,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        height: SizeConfig.screenHeight * 0.38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kContBgColor,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.network(
                width: getProportionateScreenWidth(30),
                height: getProportionateScreenHeight(30),
                "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/verification.png",
              ),
            ),
            Positioned(
              top: 40,
              child: Container(
                decoration: BoxDecoration(
                  color: index % 2 != 0 ? kContBgColor : Colors.black,
                  border: index % 2 != 0
                      ? Border.all(color: Colors.black)
                      : Border.all(),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: index % 2 != 0 ? Colors.black : Colors.white,
                      fontSize: getProportionateScreenHeight(16),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 45,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        kPrimaryColor,
                        kPrimaryColor,
                        kSecondaryColor,
                        kPrimaryColor,
                        kPrimaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text(
                    "SOCIAL",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: getProportionateScreenHeight(11),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: SizeConfig.screenWidth * 0.9,
                    height: SizeConfig.screenHeight * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage("assets/images/$image"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Positioned(
              bottom: 8,
              left: 15,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: kPrimaryColor,
                  border: Border.all(color: Colors.black),
                ),
                child: Image.network(
                  width: getProportionateScreenWidth(20),
                  height: getProportionateScreenHeight(20),
                  "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/promote.png",
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 60,
              child: Text(
                likes,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(12),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 90,
              child: Image.network(
                width: getProportionateScreenWidth(16),
                height: getProportionateScreenHeight(16),
                "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/clap.png",
              ),
            ),
            Positioned(
              bottom: 12,
              left: SizeConfig.screenWidth * 0.44,
              child: Text(
                rebooms,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(12),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: (SizeConfig.screenWidth * 0.44) + 24,
              child: SvgPicture.asset("assets/icons/reboom.svg"),
            ),
            Positioned(
              bottom: 12,
              right: 35,
              child: Text(
                comments,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(12),
                ),
              ),
            ),
            const Positioned(
              bottom: 12,
              right: 15,
              child: Icon(
                MdiIcons.commentProcessingOutline,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
