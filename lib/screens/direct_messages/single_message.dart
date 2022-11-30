import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/direct_messages/controllers/dm_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rxdart/rxdart.dart';

import 'models/messages_model.dart';

class SingleMessage extends GetView<DMCrontroller> {
  final String username;
  final String img;
  SingleMessage({
    Key? key,
    required this.username,
    required this.img,
  }) : super(key: key);

  final TextEditingController _messageController = TextEditingController();
  final StreamController<dynamic> _controller = BehaviorSubject();
  final _storage = GetStorage();
  String? _boomBoxId;
  String? _receiverId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.snackbar(
                "Hang in there.",
                "Shipping soon..",
                backgroundColor: kPrimaryColor,
                snackPosition: SnackPosition.TOP,
                colorText: Colors.black,
                overlayBlur: 5.0,
                margin: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.05,
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                ),
              );
            },
            icon: const Icon(
              MdiIcons.phone,
              color: kPrimaryColor,
            ),
          ),
        ],
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                img,
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Text(
              username,
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenHeight(15),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: constraints.maxHeight,
                minHeight: constraints.minHeight,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      child: StreamBuilder(
                        stream: controller.channel?.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return const Text('No connection');
                            case ConnectionState.waiting:
                              return const Text('Connected');
                            case ConnectionState.active:
                              final messagesData =
                                  messagesDataFromJson(snapshot.data);
                              _boomBoxId = messagesData.box;
                              _receiverId =
                                  messagesData.messages?[0].receiver?.id;
                              return Obx(
                                () => (controller.isLoading.value)
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : _buildChatMessages(messagesData),
                                // Text(
                                //     snapshot.data.toString(),
                                //   ),
                              );
                            case ConnectionState.done:
                              return Text('${snapshot.data} (closed)');
                          }
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12.0),
                      fillColor: const Color(0xFFF8F8F8),
                      filled: true,
                      hintText: "Type a message...",
                      prefixIcon: IconButton(
                        icon: const Icon(
                          MdiIcons.cameraOutline,
                          color: Color(0xFF454C4D),
                        ),
                        onPressed: () {},
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          controller.channel?.sink.add(
                            jsonEncode({
                              "box": "$_boomBoxId",
                              "author": "${_storage.read('userId')}",
                              "receiver": "$_receiverId",
                              "content": _messageController.text,
                              "command": "send_message"
                            }),
                          );
                          _messageController.clear();
                        },
                        icon: const Icon(
                          MdiIcons.send,
                          color: Color(0xFF454C4D),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black45,
                          width: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black45,
                          width: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black45,
                          width: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  _buildChatMessages(MessagesData messagesData) {
    log("userid :: ${_storage.read('userId')}");
    String userid = _storage.read('userId');
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: messagesData.messages?.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            bottom: getProportionateScreenHeight(10),
            top: getProportionateScreenHeight(10),
          ),
          child: Row(
            mainAxisAlignment:
                (messagesData.messages![index].author!.id != userid)
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.7,
                    decoration: BoxDecoration(
                      color:
                          (messagesData.messages![index].author!.id != userid)
                              ? const Color(0xFFF8F8F8)
                              : const Color(0XFF4B5259),
                      borderRadius:
                          (messagesData.messages![index].author!.id == userid)
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                )
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${messagesData.messages?[index].content}",
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(12),
                          color: (messagesData.messages![index].author!.id !=
                                  userid)
                              ? const Color(0xFF5F5F5F)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm a')
                        .format(messagesData.messages![index].timestamp!),
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(10),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
