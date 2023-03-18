import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/screens/back_pack_screen/back_pack_screen.dart';
import 'package:boom_mobile/screens/direct_messages/direct_messages_screen.dart';
import 'package:boom_mobile/screens/syn_bank/syn_bank_screen.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingWidget;
  const CustomAppBar({
    Key? key,
    this.leadingWidget,
  }) : super(key: key);

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
            leadingWidget ??
                const Image(
                  width: 45,
                  height: 40,
                  image: NetworkImage(
                    "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/boom_logo.png",
                  ),
                ),
            const SizedBox(
              width: 10,
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(
            //     Icons.search,
            //     color: Colors.white70,
            //   ),
            // ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Get.to(
                  () => const DirectMessagesScreen(),
                  binding: AppBindings(),
                );
              },
              icon: Badge(
                child: SizedBox(
                  width: getProportionateScreenWidth(30),
                  height: getProportionateScreenHeight(30),
                  child: Image.asset(
                    "assets/icons/dm_icon.png",
                    height: getProportionateScreenHeight(30),
                    width: getProportionateScreenWidth(30),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: SizedBox(
                  width: getProportionateScreenWidth(20),
                  height: getProportionateScreenHeight(20),
                  child: Image.asset(
                    "assets/icons/support_icon.png",
                    height: getProportionateScreenHeight(25),
                    width: getProportionateScreenWidth(25),
                    fit: BoxFit.cover,
                  ),
                )),
            IconButton(
              onPressed: () {
                showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (context) {
                    // Get.put(BackPackController());
                    return const AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: BackPackScreen(),
                    );
                  },
                );
              },
              icon: SizedBox(
                width: getProportionateScreenWidth(30),
                height: getProportionateScreenHeight(30),
                child: Image.asset(
                  "assets/icons/backpack_icon.png",
                  height: getProportionateScreenHeight(25),
                  width: getProportionateScreenWidth(25),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: SyntheticBankScreen(),
                    );
                  },
                );
              },
              icon: SizedBox(
                width: getProportionateScreenWidth(40),
                height: getProportionateScreenHeight(40),
                child: Image.asset(
                  "assets/icons/syncBank_icon.png",
                  height: getProportionateScreenHeight(40),
                  width: getProportionateScreenWidth(40),
                  fit: BoxFit.cover,
                ),
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
