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
                                        fontSize:
                                            getProportionateScreenHeight(15),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      "${controller.boomBoxModel.members.length} Members",
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
                                        color: controller
                                                    .boomBoxModel.user.userId !=
                                                controller.userId
                                            ? kPrimaryColor
                                            : Colors.red,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        controller.boomBoxModel.user.userId !=
                                                controller.userId
                                            ? "Leave BoomBox"
                                            : "Delete BoomBox",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              getProportionateScreenHeight(14),
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
                                itemCount:
                                    controller.boomBoxModel.members.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    minVerticalPadding:
                                        getProportionateScreenHeight(2),
                                    visualDensity: VisualDensity.compact,
                                    leading: CircleAvatar(
                                      radius: getProportionateScreenHeight(16),
                                      backgroundImage: NetworkImage(
                                        controller.boomBoxModel.members[index]
                                                    .user.photo !=
                                                ""
                                            ? controller.boomBoxModel
                                                .members[index].user.photo
                                                .toString()
                                            : "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
                                      ),
                                    ),
                                    title: Text(
                                      controller.boomBoxModel.members[index]
                                          .user.username,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            getProportionateScreenHeight(14),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    trailing: controller.boomBoxModel
                                                .members[index].user.userId ==
                                            controller.userId
                                        ? const SizedBox()
                                        : controller.boomBoxModel.members[index]
                                                    .user.userId ==
                                                controller
                                                    .boomBoxModel.user.userId
                                            ? TextButton(
                                                onPressed: () {},
                                                child: const Text("Admin"),
                                              )
                                            : controller.boomBoxModel.user
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
                                                          BorderRadius.circular(
                                                              4),
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
                                        arguments: controller.boomBoxModel
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
                              return _buildChatMessages(snapshot.data!);
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

  _buildChatMessages(List<Message>? messages) {
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
