import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: Container(
        height: getProportionateScreenHeight(70),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // stops: [0.05, 0.35, 0.65, 0.85],
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              width: 10,
            ),
            const Image(
              width: 45,
              height: 40,
              image: AssetImage(
                "assets/icons/boom_logo.png",
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white70,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.mail,
                color: Colors.blueGrey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                MdiIcons.faceAgent,
                color: Colors.blueGrey.shade500,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                MdiIcons.bagPersonal,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                MdiIcons.bank,
                color: Colors.blueGrey,
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(
            //     Icons.shopping_cart,
            //     color: Colors.blueAccent,
            //   ),
            // ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
