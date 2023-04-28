import 'package:boom_mobile/screens/direct_messages/controllers/dm_controller.dart';
import 'package:boom_mobile/screens/other_user_profile/other_user_profile.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../profile_screen/models/boom_box_model.dart';

class SingleMessage extends StatefulWidget {
  final BoomBox boomBoxModel;
  final bool isBoomBox;
  const SingleMessage({
    Key? key,
    required this.boomBoxModel,
    required this.isBoomBox,
  }) : super(key: key);

  @override
  State<SingleMessage> createState() => _SingleMessageState();
}

class _SingleMessageState extends State<SingleMessage> {
  final TextEditingController _messageController = TextEditingController();

  final _storage = GetStorage();
  @override
  void initState() {
    super.initState();
    Get.put(DMCrontroller());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DMCrontroller>(builder: (controller) {
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
              controller.fetchBoomBoxMessages();
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
          title: GestureDetector(
            onTap: () {
              if (!widget.isBoomBox) {
                Get.to(
                  () => const OtherUserProfileScreen(),
                  arguments: widget.boomBoxModel.members.first.user.id,
                );
              } else {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        height: SizeConfig.screenHeight * 0.55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      widget.boomBoxModel.imageUrl,
                                    ),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(30),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.boomBoxModel.label,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenHeight(15),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        "${widget.boomBoxModel.members.length} Members",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenHeight(12),
                                        ),
                                      ),
                                      SizedBox(
                                        height: getProportionateScreenHeight(5),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              widget.boomBoxModel.user.userId !=
                                                      controller.userId
                                                  ? kPrimaryColor
                                                  : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          widget.boomBoxModel.user.userId !=
                                                  controller.userId
                                              ? "Leave BoomBox"
                                              : "Delete BoomBox",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    14),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(8),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: widget.boomBoxModel.members.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      minVerticalPadding:
                                          getProportionateScreenHeight(2),
                                      visualDensity: VisualDensity.compact,
                                      leading: CircleAvatar(
                                        radius:
                                            getProportionateScreenHeight(16),
                                        backgroundImage: NetworkImage(
                                          widget.boomBoxModel.members[index]
                                                      .user.photo !=
                                                  ""
                                              ? widget.boomBoxModel
                                                  .members[index].user.photo
                                                  .toString()
                                              : "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
                                        ),
                                      ),
                                      title: Text(
                                        widget.boomBoxModel.members[index].user
                                            .username,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenHeight(14),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      trailing: widget.boomBoxModel
                                                  .members[index].user.userId ==
                                              controller.userId
                                          ? const SizedBox()
                                          : widget.boomBoxModel.members[index]
                                                      .user.userId ==
                                                  widget
                                                      .boomBoxModel.user.userId
                                              ? TextButton(
                                                  onPressed: () {},
                                                  child: const Text("Admin"),
                                                )
                                              : widget.boomBoxModel.user
                                                          .userId !=
                                                      controller.userId
                                                  ? const SizedBox()
                                                  : Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            getProportionateScreenWidth(
                                                                10),
                                                        vertical:
                                                            getProportionateScreenHeight(
                                                                5),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: kPrimaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                      child: Text(
                                                        "Ban",
                                                        style: TextStyle(
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    13)),
                                                      ),
                                                    ),
                                      onTap: () {
                                        Get.back();
                                        Get.to(
                                          () => const OtherUserProfileScreen(),
                                          arguments: widget.boomBoxModel
                                              .members[index].user.id,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            },
            child: Row(
              children: [
                (widget.boomBoxModel.members.first.user.photo != "" &&
                        widget.boomBoxModel.imageUrl != "")
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          widget.isBoomBox
                              ? widget.boomBoxModel.imageUrl
                              : widget.boomBoxModel.members.first.user.photo !=
                                      ""
                                  ? widget.boomBoxModel.members.first.user.photo
                                  : "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
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
                  widget.isBoomBox
                      ? widget.boomBoxModel.label
                      : widget.boomBoxModel.members.first.user.username,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenHeight(15),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
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
                      child: StreamBuilder(
                        stream: controller.service
                            .fetchMessages(widget.boomBoxModel.id),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ));
                          } else if (snapshot.connectionState ==
                                  ConnectionState.active ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Center(child: Text('Error'));
                            } else if (snapshot.hasData) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (controller.listViewController.hasClients) {
                                  controller.listViewController.jumpTo(
                                      controller.listViewController.position
                                          .maxScrollExtent);
                                }
                              });
                              return _buildChatMessages(
                                  snapshot.data!, widget.isBoomBox, controller);
                            } else {
                              return const Center(
                                child: Text(
                                  'No Messages',
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
                        // prefixIcon: IconButton(
                        //   icon: const Icon(
                        //     MdiIcons.cameraOutline,
                        //     color: Color(0xFF454C4D),
                        //   ),
                        //   onPressed: () {},
                        // ),
                        suffixIcon: Obx(
                          () => (controller.isLoading.value)
                              ? const CircularProgressIndicator(
                                  color: kPrimaryColor,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    controller.chatWithUser(
                                        _messageController.text,
                                        widget.boomBoxModel.id);
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
    });
  }

  _buildChatMessages(
      List<Message>? messages, bool isBoomBox, DMCrontroller controller) {
    String userid = _storage.read('userId');

    return ListView.builder(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),

      controller: controller.listViewController,
      itemCount: messages!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            bottom: getProportionateScreenHeight(10),
            top: getProportionateScreenHeight(10),
          ),
          child: Row(
            mainAxisAlignment: (messages[index].sender.id != userid)
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: (messages[index].sender.id != userid)
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  isBoomBox && messages[index].sender.id != userid
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const OtherUserProfileScreen(),
                                arguments: messages[index].sender.id,
                              );
                            },
                            child: Wrap(
                              children: [
                                CircleAvatar(
                                  radius: getProportionateScreenWidth(10),
                                  backgroundImage: NetworkImage(
                                    messages[index].sender.photo,
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(5),
                                ),
                                Text(
                                  messages[index].sender.username,
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(12),
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Container(
                    width: SizeConfig.screenWidth * 0.7,
                    decoration: BoxDecoration(
                      color: (messages[index].sender.id != userid)
                          ? const Color(0xFFF8F8F8)
                          : const Color(0XFF4B5259),
                      borderRadius: (messages[index].sender.id == userid)
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 8.0),
                      child: Text(
                        messages[index].content,
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(12),
                          color: (messages[index].sender.id != userid)
                              ? const Color(0xFF5F5F5F)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm a').format(messages[index].createdAt),
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
