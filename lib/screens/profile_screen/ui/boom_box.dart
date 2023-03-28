import 'package:boom_mobile/screens/profile_screen/controllers/boomBox_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BoomBoxScreen extends StatefulWidget {
  const BoomBoxScreen({Key? key}) : super(key: key);

  @override
  State<BoomBoxScreen> createState() => _BoomBoxScreenState();
}

class _BoomBoxScreenState extends State<BoomBoxScreen> {
  @override
  void initState() {
    Get.put(BoomBoxController());
    super.initState();
  }

  @override
  void dispose() {
    BoomBoxController().onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoomBoxController>(
      builder: (controller) {
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return Container(
                          height: SizeConfig.screenHeight * 0.25,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  Text(
                                    'Create Your Box',
                                    style: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(16),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(20),
                                  ),
                                  TextFormField(
                                    controller:
                                        controller.boomBoxNameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(8.0),
                                      hintText: "Box Name",
                                      hintStyle: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(20),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        Get.back();
                                        _buildUsersList(controller
                                            .boomBoxNameController.text
                                            .trim());
                                      }
                                    },
                                    child: Container(
                                      width: SizeConfig.screenWidth * 0.7,
                                      height: getProportionateScreenHeight(35),
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Create your box",
                                            style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      14),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                getProportionateScreenWidth(7),
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
                              ),
                            ),
                          ),
                        );
                      },
                    );
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
                          "Create your box",
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
                const Expanded(
                  child: SizedBox(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

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
          return GetBuilder<BoomBoxController>(builder: (controller) {
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
                      "Add Fans and Frens to your box",
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
                          controller.createBox();
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
                              "Create your box",
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
}
