import 'package:boom_mobile/screens/direct_messages/single_message.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DirectMessagesScreen extends StatelessWidget {
  const DirectMessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kContBgColor,
      appBar: AppBar(
        backgroundColor: kContBgColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Direct Messages",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenHeight(16),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dmDetails.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    onTap: () {
                      Get.to(
                        () => SingleMessage(
                          username: dmDetails[index]["username"],
                          img: dmDetails[index]["img"],
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        dmDetails[index]["img"],
                      ),
                    ),
                    title: Text(
                      dmDetails[index]["username"],
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(13),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                        text: "${dmDetails[index]["message"]}  ",
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(12),
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                              text: dmDetails[index]["time"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    trailing: SizedBox(
                      width: getProportionateScreenWidth(50),
                      child: Row(
                        children: [
                          dmDetails[index]["read"]
                              ? const SizedBox()
                              : const Icon(
                                  Icons.circle_rounded,
                                  size: 10,
                                  color: kBlueColor,
                                ),
                          SizedBox(
                            width: getProportionateScreenWidth(20),
                          ),
                          const Icon(
                            Icons.more_vert,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
