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

                        // final qrCodeModal = WalletConnectQrCodeModal(
                        //   connector: WalletConnect(
                        //     bridge: 'https://bridge.walletconnect.org',
                        //     clientMeta: const PeerMeta(
                        //       name: "Boom Mobile",
                        //       description: "Boom Mobile",
                        //       url: "https://boooooooooom.com",
                        //       icons: ["https://boooooooooom.com/favicon.ico"],
                        //     ),
                        //   ),
                        // );
                        // final session = await qrCodeModal
                        //     .connect(context)
                        //     .catchError((error) {
                        //   log("QR Modal Error $error");
                        //   return null;
                        // });

                        // qrCodeModal.registerListeners(
                        //   onConnect: (session) {
                        //     log("QR Modal onConnect $session");
                        //   },
                        //   onSessionUpdate: (response) {
                        //     log("QR Modal onSessionUpdate $response");
                        //   },
                        //   onDisconnect: () {
                        //     log("QR Modal onDisconnect $session");
                        //   },
                        // );

                        // log("Accounts ${session!.accounts[0]} ${session.accounts.length} RPC URL ${session.rpcUrl} ${session.networkId}");

                        // EasyLoading.show(status: 'loading...');

                        // final tezartClient =
                        //     TezartClient("https://ghostnet.smartpy.io");

                        // final contractEntryPoints = await tezartClient
                        //     .rpcInterface
                        //     .getContract("tz1i8SuqB9wrLJMWcgSbU1xjJ6vQMMjVGAMx")
                        //     .catchError((error) {
                        //   log("Error occurred + $error");
                        // });

                        // final walletBalance = await tezartClient.getBalance(
                        //     address: "tz1XcL2YgfLUcAAydb8mdGzV7aYyApgHPWhX");

                        // final result = await tezartClient.transferOperation(
                        //   source: Keystore.fromSecretKey(
                        //       "edskS8vvBRooTqGjVB8EKAXJjb3sB1yRTSCwPxacCAwrgbwCtFnyj5PNHZUermQKcuB7xLRfgw3UriizrvwfP1RFVGW6L4tj32"),
                        //   destination: "tz1QghCpzA6SKPfx4kCN3hsDoKVrXEDpVRJY",
                        //   amount: 1000,
                        //   customFee: 1001,
                        //   reveal: true,
                        //   customGasLimit: 1101,
                        // );

                        // await result.execute();

                        // // log("Contract Entry Points $contractEntryPoints");
                        // log("Wallet Balance $walletBalance");
                        // log("Transfer Result Balance ${result.operations.last.balance}");
                        // log("Transfer Result Balance ${result.operations.last.publicKey}");
                        // log("Transfer Result Balance ${result.operations.last.amount}");
                        // log("Transfer Result Balance ${result.operations.last.kind.toString()}");
                        // EasyLoading.dismiss();
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
