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
      length: 2,
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
              Tab(
                child: Text(
                  "BoomBox Message",
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SafeArea(
              child: Obx(
                () => (controller.isLoading.value)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : (controller.boomBoxes != null &&
                            controller.boomBoxes!.boomBoxes.isNotEmpty)
                        ? _buildChatsList(controller.dmMessages)
                        : const Center(
                            child: Text("No messages"),
                          ),
              ),
            ),
            SafeArea(
              child: Obx(
                () => (controller.isLoading.value)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : (controller.boomBoxes != null &&
                            controller.boomBoxes!.boomBoxes.isNotEmpty)
                        ? _buildChatsList(controller.groupMessages)
                        : const Center(
                            child: Text("No messages"),
                          ),
              ),
            )
          ],
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
                )),
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
                    Expanded(child: _buildUsersList()),
                  ],
                ),
              ),
            );
          },
          child: const Icon(
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
          trailing: const Icon(
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

  _buildChatsList(List<BoomBox> boomBoxes) {
    return GetBuilder(
      init: DMCrontroller(),
      builder: (ctrllerr) => Column(
        children: [
          Expanded(
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
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      boomBoxes[index].imageUrl != ""
                          ? boomBoxes[index].imageUrl
                          : "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
                    ),
                  ),
                  title: Text(
                    boomBoxes[index].label,
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
                          text: DateFormat('EEE, MMM dd HH:mm a')
                              .format(boomBoxes[index].messages.last.createdAt),
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: getProportionateScreenHeight(10)),
                        ),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
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
        ],
      ),
    );
  }
}
