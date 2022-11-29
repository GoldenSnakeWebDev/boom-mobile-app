import 'dart:developer';

import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

import 'single_message.dart';

class DirectMessagesScreen extends StatelessWidget {
  DirectMessagesScreen({Key? key}) : super(key: key);

  final IOWebSocketChannel channel = IOWebSocketChannel.connect(
    'ws://170.16.2.44:4000',
  );

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
        child: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('No connection');
              case ConnectionState.waiting:
                return const Text('Connected');
              case ConnectionState.active:
                log('${snapshot.data}');
                return _buildChatsList();
              case ConnectionState.done:
                return Text('${snapshot.data} (closed)');
            }
          },
        ),
      ),
    );
  }

  _buildChatsList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: dmDetails.length,
            physics: const BouncingScrollPhysics(),
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
                          style: const TextStyle(fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                trailing: SizedBox(
                  width: getProportionateScreenWidth(55),
                  child: Row(
                    children: [
                      dmDetails[index]["read"]
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
