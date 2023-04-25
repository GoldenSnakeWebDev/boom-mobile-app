import 'package:boom_mobile/screens/back_pack_screen/back_pack_screen.dart';
import 'package:boom_mobile/screens/direct_messages/direct_messages_screen.dart';
import 'package:boom_mobile/screens/syn_bank/syn_bank_screen.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';

import '../di/app_bindings.dart';

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
        height: getProportionateScreenHeight(65),
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
                    boomIconUrl,
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
            SizedBox(
              width: SizeConfig.screenWidth * 0.5,
              height: getProportionateScreenHeight(35),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const DirectMessagesScreen(),
                          binding: AppBindings(),
                        );
                      },
                      child: Badge(
                        child: Image.asset(
                          "assets/icons/dm_icon.png",
                          height: getProportionateScreenHeight(35),
                          width: getProportionateScreenWidth(35),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final Email email = Email(
                          body: '',
                          subject: 'Boom Mobile Support',
                          recipients: ['letstalk@boooooooooom.com'],
                          cc: [''],
                          bcc: [''],
                          isHTML: false,
                        );
                        await FlutterEmailSender.send(email);

                        // showModalBottomSheet(
                        //     context: context,
                        //     isScrollControlled: true,
                        //     isDismissible: true,
                        //     builder: (context) {
                        //       return SizedBox(
                        //         width: SizeConfig.screenWidth * 0.5,
                        //         height: SizeConfig.screenHeight * 0.5,
                        //         child: Stack(
                        //           children: [
                        //             // SizedBox(
                        //             //   width: SizeConfig.screenWidth * 0.45,
                        //             //   height: SizeConfig.screenHeight * 0.45,
                        //             //   child: const Text(
                        //             //     "assets/images/support_background.png",
                        //             //   ),
                        //             // ),
                        //             SizedBox(
                        //               height: SizeConfig.screenHeight * 0.5,
                        //               width: SizeConfig.screenWidth * 0.5,
                        //               child: Magic.instance.relayer,
                        //             ),
                        //             SizedBox(
                        //               height: getProportionateScreenHeight(20),
                        //             ),
                        //             TextButton(
                        //               onPressed: () async {
                        //                 final magic = Magic.instance;
                        //                 magic.auth.loginWithEmailOTP(
                        //                     email: "rennylngt@gmail.com");
                        //                 // final client =
                        //                 //     Web3Client.custom(magic.provider);
                        //                 // final credentials =
                        //                 //     MagicCredential(magic.provider);

                        //                 // var cred =
                        //                 //     await credentials.getAccount();

                        //                 // log("Results ${cred.hex} ${client.getChainId()}");
                        //               },
                        //               child: const Text(
                        //                 "Send",
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       );
                        //     });
                      },
                      child: Image.asset(
                        "assets/icons/support_icon.png",
                        height: getProportionateScreenHeight(30),
                        width: getProportionateScreenWidth(25),
                        fit: BoxFit.contain,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
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
                      child: SizedBox(
                        width: getProportionateScreenWidth(30),
                        height: getProportionateScreenHeight(30),
                        child: Image.asset(
                          "assets/icons/backpack_icon.png",
                          height: getProportionateScreenHeight(30),
                          width: getProportionateScreenWidth(30),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
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
                      child: Image.asset(
                        "assets/icons/syncBank_icon.png",
                        height: getProportionateScreenHeight(35),
                        width: getProportionateScreenWidth(35),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ]),
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
