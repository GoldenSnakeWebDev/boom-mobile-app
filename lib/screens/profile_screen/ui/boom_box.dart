import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BoomBoxScreen extends StatelessWidget {
  const BoomBoxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.45,
              height: getProportionateScreenHeight(35),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create your box",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(7),
                  ),
                  const Icon(
                    MdiIcons.cog,
                    size: 20,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }
}
