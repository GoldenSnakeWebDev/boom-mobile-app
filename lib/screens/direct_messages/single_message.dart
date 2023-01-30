import 'package:boom_mobile/screens/direct_messages/controllers/dm_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'models/messages_model.dart';

class SingleMessage extends GetView<DMCrontroller> {
  final String username;
  final String receiverId;
  final String img;
  final String boomBox;
  SingleMessage({
    Key? key,
    required this.username,
    required this.receiverId,
    required this.img,
    required this.boomBox,
  }) : super(key: key);

  final TextEditingController _messageController = TextEditingController();
  final _storage = GetStorage();

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
        actions: const [
          // IconButton(
          //   onPressed: () {
          //     Get.snackbar(
          //       "Hang in there.",
          //       "Shipping soon..",
          //       backgroundColor: kPrimaryColor,
          //       snackPosition: SnackPosition.TOP,
          //       colorText: Colors.black,
          //       overlayBlur: 5.0,
          //       margin: EdgeInsets.only(
          //         top: SizeConfig.screenHeight * 0.05,
          //         left: SizeConfig.screenWidth * 0.05,
          //         right: SizeConfig.screenWidth * 0.05,
          //       ),
          //     );
          //   },
          //   icon: const Icon(
          //     MdiIcons.phone,
          //     color: kPrimaryColor,
          //   ),
          // ),
        ],
        title: Row(
          children: [
            (img.isNotEmpty)
                ? CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      img,
                    ),
                  )
                : const CircleAvatar(
                    radius: 20,
                    backgroundColor: kPrimaryColor,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
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
                    child: StreamBuilder<DMBoomBox?>(
                      stream: controller.service.fetchDMs(boomBox),
                      builder: (context, AsyncSnapshot<DMBoomBox?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ));
                        } else if (snapshot.connectionState ==
                                ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Center(child: Text('Error'));
                          } else if (snapshot.hasData) {
                            return _buildChatMessages(snapshot.data!.messages);
                          } else {
                            return const Center(
                              child: Text(
                                'Empty data',
                              ),
                            );
                          }
                        } else {
                          return Center(
                            child: Text(
                              'State: ${snapshot.connectionState}',
                            ),
                          );
                        }
                      },
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
                      suffixIcon: Obx(
                        () => (controller.isLoading.value)
                            ? const CircularProgressIndicator(
                                color: kPrimaryColor,
                              )
                            : IconButton(
                                onPressed: () async {
                                  controller.chatWithUser(
                                    "send_message",
                                    _messageController.text,
                                    receiverId,
                                    boomBox,
                                  );
                                  _messageController.clear();
                                  FocusScope.of(context).unfocus();
                                },
                                icon: const Icon(
                                  MdiIcons.send,
                                  color: Color(0xFF454C4D),
                                ),
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

  _buildChatMessages(List<DMMessage>? messages) {
    String userid = _storage.read('userId');
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: messages!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            bottom: getProportionateScreenHeight(10),
            top: getProportionateScreenHeight(10),
          ),
          child: Row(
            mainAxisAlignment: (messages[index].author!.id != userid)
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.7,
                    decoration: BoxDecoration(
                      color: (messages[index].author!.id != userid)
                          ? const Color(0xFFF8F8F8)
                          : const Color(0XFF4B5259),
                      borderRadius: (messages[index].author!.id == userid)
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
                        "${messages[index].content}",
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(12),
                          color: (messages[index].author!.id != userid)
                              ? const Color(0xFF5F5F5F)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm a').format(messages[index].timestamp!),
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
