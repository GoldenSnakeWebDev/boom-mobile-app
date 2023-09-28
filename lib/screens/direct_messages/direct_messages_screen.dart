import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../profile_screen/models/boom_box_model.dart';
import 'controllers/dm_controller.dart';
import 'single_message.dart';

class DirectMessagesScreen extends GetView<DMCrontroller> {
  const DirectMessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
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
            "Messages",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenHeight(16),
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: kPrimaryColor,
            tabs: [
              Tab(
                child: Text(
                  "Direct Message",
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      fontWeight: FontWeight.bold),
                ),
              ),
              // Tab(
              //   child: Text(
              //     "BoomBox Message",
              //     style: TextStyle(
              //         fontSize: getProportionateScreenHeight(14),
              //         fontWeight: FontWeight.bold),
              //   ),
              // )
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchBoomBoxMessages();
          },
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SafeArea(
                child: Obx(
                  () => (controller.isLoading.value)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : (controller.dmMessages.isNotEmpty)
                          ? _buildChatsList(controller.dmMessages, false)
                          : const Center(
                              child: Text("No messages"),
                            ),
                ),
              ),
              // SafeArea(
              //   child: Obx(
              //     () => (controller.isLoading.value)
              //         ? const Center(
              //             child: CircularProgressIndicator(),
              //           )
              //         : (controller.groupMessages.isNotEmpty)
              //             ? _buildChatsList(controller.groupMessages, true)
              //             : const Center(
              //                 child: Text("No messages"),
              //               ),
              //   ),
              // )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    getProportionateScreenHeight(15),
                  ),
                ),
              ),
              context: context,
              builder: (context) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15),
                  vertical: getProportionateScreenHeight(20),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      getProportionateScreenHeight(15),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Container(
                    //   height: getProportionateScreenHeight(50),
                    //   margin: EdgeInsets.only(
                    //     bottom: getProportionateScreenHeight(15),
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey[200],
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: TextFormField(
                    //     onChanged: (value) {},
                    //     decoration: const InputDecoration(
                    //       border: InputBorder.none,
                    //       prefixIcon: Icon(
                    //         Icons.search,
                    //         color: Colors.grey,
                    //       ),
                    //       hintText: 'Search',
                    //       hintStyle: TextStyle(
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Text(
                      "New Message",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(16),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Expanded(
                      child: _buildUsersList(),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Icon(
            MdiIcons.messageText,
          ),
        ),
      ),
    );
  }

  _buildUsersList() {
    return ListView.builder(
      itemCount: controller.boxUsers?.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            radius: getProportionateScreenHeight(20),
            // backgroundColor: Colors.grey[200],
            backgroundImage: NetworkImage(
              controller.boxUsers![index].photo != ""
                  ? controller.boxUsers![index].photo.toString()
                  : "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
            ),
          ),
          title: Text(
            "${controller.boxUsers![index].username}",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenHeight(14),
              fontWeight: FontWeight.w700,
            ),
          ),
          // subtitle: Text(
          //   "${controller.boxUsers![index].firstName} ${controller.boxUsers![index].lastName}",
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontSize: getProportionateScreenHeight(12),
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
          trailing: Icon(
            MdiIcons.messageText,
            color: Colors.black,
          ),
          onTap: () {
            controller.goToSingleUserMessage(index);
          },
        );
      },
    );
  }

  _buildChatsList(List<BoomBox> boomBoxes, bool isGroup) {
    return GetBuilder(
      init: DMCrontroller(),
      builder: (ctrllerr) => Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.fetchBoomBoxMessages();
              },
              child: ListView.builder(
                itemCount: boomBoxes.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: ((context, index) {
                  return ListTile(
                    minVerticalPadding: 10,
                    onTap: () async {
                      Get.to(
                        () => SingleMessage(
                          boomBoxModel: boomBoxes[index],
                          isBoomBox: isGroup,
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        isGroup
                            ? boomBoxes[index].imageUrl
                            : boomBoxes[index].imageUrl != ""
                                ? controller.userId ==
                                        boomBoxes[index].user.userId
                                    ? boomBoxes[index].members.first.user.photo
                                    : boomBoxes[index].user.photo
                                : "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
                      ),
                    ),
                    title: Text(
                      isGroup
                          ? boomBoxes[index].label
                          : controller.userId == boomBoxes[index].user.userId
                              ? boomBoxes[index].members.first.user.username
                              : boomBoxes[index].user.username,
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(15),
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                        text: "${boomBoxes[index].messages.last.content}   ",
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(12),
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: DateFormat('EEE, dd MMM HH:mm a').format(
                                boomBoxes[index]
                                    .messages
                                    .last
                                    .createdAt
                                    .toLocal()),
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: getProportionateScreenHeight(10)),
                          ),
                        ],
                      ),
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            height: getProportionateScreenHeight(20),
                            value: "delete",
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: kredCancelTextColor,
                                fontSize: getProportionateScreenHeight(12),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ];
                      },
                      onSelected: (value) async {
                        switch (value) {
                          case "delete":
                            Future.delayed(
                              const Duration(seconds: 0),
                              () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Delete ${isGroup ? "BoomBox Chat" : "Chat"}"),
                                      content: Text(
                                          "Are you sure you want to delete ${isGroup ? "BoomBox Chat" : "Chat with ${boomBoxes[index].members.last.user.username}"}?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await controller.deleteBoomBox(
                                                boomBoxes[index].id, isGroup);
                                          },
                                          child: Text(
                                              "Yes, Delete ${isGroup ? "BoomBox Chat" : "Chat"}"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );

                            break;
                          default:
                            break;
                        }
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black54,
                      ),
                    ),

                    // SizedBox(
                    //   width: getProportionateScreenWidth(55),
                    //   child: Row(
                    //     children: [
                    //       // (ctrllerr.boomBoxes?[index].messages?.last.isDelete ==
                    //       //         true)
                    //       //     ? const SizedBox(
                    //       //         width: 10,
                    //       //       )
                    //       //     : const Icon(
                    //       //         Icons.circle_rounded,
                    //       //         size: 10,
                    //       //         color: kBlueColor,
                    //       //       ),
                    //       // SizedBox(
                    //       //   width: getProportionateScreenWidth(20),
                    //       // ),
                    //       IconButton(
                    //         onPressed: () {},
                    //         icon: const Icon(
                    //           Icons.more_vert,
                    //           color: Colors.black54,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
