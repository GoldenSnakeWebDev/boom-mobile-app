import 'package:boom_mobile/screens/profile_screen/controllers/boomBox_controller.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/single_box_controller.dart';
import 'package:boom_mobile/screens/profile_screen/models/boom_box_model.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../other_user_profile/other_user_profile.dart';

class SingleBoomBoxMessage extends StatefulWidget {
  const SingleBoomBoxMessage({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleBoomBoxMessage> createState() => _SingleBoomBoxMessageState();
}

class _SingleBoomBoxMessageState extends State<SingleBoomBoxMessage> {
  final _storage = GetStorage();

  @override
  void initState() {
    Get.put(SingleBoxController());
    Get.put(BoomBoxController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleBoxController>(builder: (controller) {
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
              // controller.fetchBoomBoxMessages();
              Get.back();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                MdiIcons.dotsVertical,
                color: Colors.black,
              ),
            )
          ],
          title: GestureDetector(
            onTap: () {
              //show BoomBox Settings

              _buildChatSettings(controller);
            },
            child: Wrap(
              children: [
                (controller.boomBoxModel.imageUrl.isNotEmpty)
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          controller.boomBoxModel.imageUrl,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.boomBoxModel.label,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(15),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "${controller.boomBoxModel.members.length} Members",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(12),
                      ),
                    )
                  ],
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
                        stream: controller.fetchMessages(),
                        builder: (context, AsyncSnapshot snapshot) {
                          // if (snapshot.connectionState ==
                          //     ConnectionState.waiting) {
                          //   return const Center(
                          //       child: CircularProgressIndicator(
                          //     color: kPrimaryColor,
                          //   ));
                          // } else

                          if (snapshot.connectionState ==
                                  ConnectionState.active ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Error'),
                              );
                            } else if (snapshot.hasData) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (controller.listViewController.hasClients) {
                                  controller.listViewController.jumpTo(
                                      controller.listViewController.position
                                          .maxScrollExtent);
                                }
                              });
                              return _buildChatMessages(
                                  snapshot.data!, controller);
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
                      controller: controller.messageController,
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
                                    controller.chatWithUser();
                                    controller.messageController.clear();
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

  //Function to build chat ssettings ModalBottomSheet
  _buildUsersList(String boomBoxName) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              getProportionateScreenHeight(15),
            ),
          ),
        ),
        context: context,
        builder: (context) {
          return GetBuilder<SingleBoxController>(builder: (controller) {
            return Container(
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
                    Text(
                      "Add Fans and Frens to $boomBoxName",
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
                      child: ListView.builder(
                        itemCount: controller.users?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              radius: getProportionateScreenHeight(20),
                              backgroundImage: NetworkImage(
                                controller.users![index].photo != ""
                                    ? controller.users![index].photo.toString()
                                    : "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
                              ),
                            ),
                            title: Text(
                              "${controller.users![index].username}",
                              style: TextStyle(
                                color: controller.selectedUsers
                                        .contains(controller.users![index])
                                    ? kPrimaryColor
                                    : Colors.black,
                                fontSize: getProportionateScreenHeight(14),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            trailing: Icon(
                              controller.selectedUsers
                                      .contains(controller.users![index])
                                  ? MdiIcons.checkboxMarked
                                  : MdiIcons.checkboxBlankOutline,
                              size: getProportionateScreenHeight(20),
                              color: controller.selectedUsers
                                      .contains(controller.users![index])
                                  ? kPrimaryColor
                                  : Colors.black,
                            ),
                            onTap: () {
                              controller.selectUsers(index);
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.selectedUsers.isNotEmpty) {
                          controller.addUser();
                        }
                      },
                      child: Container(
                        width: SizeConfig.screenWidth * 0.45,
                        height: getProportionateScreenHeight(35),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add User(s)",
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(14),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(7),
                            ),
                            const Icon(
                              MdiIcons.cog,
                              size: 20,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          });
        });
  }

  _buildChatSettings(SingleBoxController controller) {
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
            width: SizeConfig.screenWidth,
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
                          controller.boomBoxModel.imageUrl,
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(30),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.boomBoxModel.label,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(15),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "${controller.boomBoxModel.members.length} Members",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(12),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(5),
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                controller.boomBoxModel.user.userId !=
                                        controller.userId
                                    ? const SizedBox()
                                    : GestureDetector(
                                        onTap: () async {
                                          //Add Users to BoomBox
                                          // await controller.addUser();
                                          await controller.fetchUsers();
                                          _buildUsersList(
                                              controller.boomBoxModel.label);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            "Add Member",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      14),
                                            ),
                                          ),
                                        ),
                                      ),
                                GestureDetector(
                                  onTap: () async {
                                    Future.delayed(const Duration(seconds: 0),
                                        () {
                                      //Open the Dialog Box to confirm leaving the BoomBox
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                "${controller.boomBoxModel.user.userId != controller.userId ? "Leave" : "Delete"} ${controller.boomBoxModel.label}"),
                                            content: Text(
                                                "Are you sure you want to ${controller.boomBoxModel.user.userId != controller.userId ? "leave" : "delete"} this BoomBox?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  Get.back();
                                                  //Leave BoomBox Logic
                                                  if (controller.boomBoxModel
                                                          .user.userId !=
                                                      controller.userId) {
                                                    //Leave BoomBox
                                                    await controller
                                                        .leaveBoomBox();
                                                  } else {
                                                    //Delete BoomBox
                                                    await controller
                                                        .deleteBoomBox();
                                                  }
                                                },
                                                child: Text(controller
                                                            .boomBoxModel
                                                            .user
                                                            .userId !=
                                                        controller.userId
                                                    ? "Leave"
                                                    : "Delete"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          controller.boomBoxModel.user.userId !=
                                                  controller.userId
                                              ? kPrimaryColor
                                              : Colors.red,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      controller.boomBoxModel.user.userId !=
                                              controller.userId
                                          ? "Leave "
                                          : "Delete ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            getProportionateScreenHeight(14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                      itemCount: controller.boomBoxModel.members.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          minVerticalPadding: getProportionateScreenHeight(2),
                          visualDensity: VisualDensity.compact,
                          leading: CircleAvatar(
                            radius: getProportionateScreenHeight(16),
                            backgroundImage: NetworkImage(
                              controller.boomBoxModel.members[index].user
                                          .photo !=
                                      ""
                                  ? controller
                                      .boomBoxModel.members[index].user.photo
                                      .toString()
                                  : "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
                            ),
                          ),
                          title: Text(
                            controller
                                .boomBoxModel.members[index].user.username,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(14),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          trailing: controller.boomBoxModel.members[index].user
                                      .userId ==
                                  controller.userId
                              ? const SizedBox()
                              : controller.boomBoxModel.members[index].user
                                          .userId ==
                                      controller.boomBoxModel.user.userId
                                  ? TextButton(
                                      onPressed: () {},
                                      child: const Text("Admin"),
                                    )
                                  : controller.boomBoxModel.user.userId !=
                                          controller.userId
                                      ? const SizedBox()
                                      : GestureDetector(
                                          onTap: () async {
                                            Future.delayed(Duration.zero, () {
                                              //Open the Dialog Box to confirm leaving the BoomBox
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Ban & Remove ${controller.boomBoxModel.members[index].user.username}"),
                                                    content: Text(
                                                        "Are you sure you want to remove ${controller.boomBoxModel.members[index].user.username} from this BoomBox?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Cancel"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          Get.back();
                                                          await controller
                                                              .removeUser(
                                                                  controller
                                                                      .boomBoxModel
                                                                      .members[
                                                                          index]
                                                                      .user
                                                                      .id);
                                                        },
                                                        child: const Text(
                                                            "Proceed"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
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
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              "Ban",
                                              style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          13)),
                                            ),
                                          ),
                                        ),
                          onTap: () {
                            Get.back();
                            Get.to(
                              () => const OtherUserProfileScreen(),
                              arguments: controller
                                  .boomBoxModel.members[index].user.id,
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

  //Function to build chat messages
  _buildChatMessages(List<Message>? messages, SingleBoxController controller) {
    String userid = _storage.read('userId');
    return ListView.builder(
      shrinkWrap: true,
      itemCount: messages!.length,
      controller: controller.listViewController,
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
                  messages[index].sender.id != userid
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8),
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
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm a').format(messages[index].createdAt),
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(10),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
