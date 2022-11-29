import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/direct_messages/single_message.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controllers/dm_controller.dart';
import 'models/boom_box_response.dart';

class DirectMessagesScreen extends GetView<DMCrontroller> {
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
          child: Obx(() => (controller.isLoading.value)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _buildChatsList(controller.boomBoxes))),
    );
  }

  _buildChatsList(List<BoomBox>? boomBoxes) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: boomBoxes?.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((context, index) {
              return ListTile(
                onTap: () async {
                  log('Author :: ${boomBoxes[index].messages?.last.author?.id}');
                  log('Recei :: ${boomBoxes[index].messages?.last.receiver?.id}');
                  controller.channel.sink.add(
                    jsonEncode({
                      "box": "${boomBoxes[index].box}",
                      "author": "${boomBoxes[index].messages?.last.author?.id}",
                      "receiver":
                          "${boomBoxes[index].messages?.last.receiver?.id}",
                      "content": "ROOM",
                      "command": "join_room"
                    }),
                  );
                  Get.to(
                    () => SingleMessage(
                      username:
                          "${boomBoxes[index].messages?.last.author?.username}",
                      img:
                          "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
                    ),
                  );
                },
                leading: const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
                  ),
                ),
                title: Text(
                  "${boomBoxes?[index].label}",
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(13),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: RichText(
                  text: TextSpan(
                    text: "${boomBoxes?[index].messages?.last.content}  ",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(12),
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: DateFormat.yMEd().add_jms().format(
                            boomBoxes![index].messages!.last.timestamp!),
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                trailing: SizedBox(
                  width: getProportionateScreenWidth(55),
                  child: Row(
                    children: [
                      (boomBoxes[index].messages?.last.isDelete == true)
                          ? const SizedBox(
                              width: 10,
                            )
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
    );
  }
}
