import 'package:boom_mobile/screens/profile_screen/controllers/edit_profile_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PickFromBoom extends StatefulWidget {
  const PickFromBoom({Key? key}) : super(key: key);

  @override
  State<PickFromBoom> createState() => _PickFromBoomState();
}

class _PickFromBoomState extends State<PickFromBoom> {
  var controller;
  @override
  void initState() {
    super.initState();
    Get.put(EditProfileController());
    controller = Get.find<EditProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'Pick Header Image',
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenHeight(16),
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
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
            actions: [
              TextButton(
                onPressed: () {
                  controller.proceedWithUpload(
                      controller.selectedHeaderImage, "header");
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: getProportionateScreenHeight(15),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.boomsURL.isEmpty
                  ? Center(
                      child: Text(
                        "You have no image Booms",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(16),
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  : GridView.builder(
                      itemCount: controller.boomsURL.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller
                                .selectHeaderImage(controller.boomsURL[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: controller.selectedHeaderImage ==
                                      controller.boomsURL[index]
                                  ? Border.all(
                                      color: kPrimaryColor,
                                      width: 2,
                                    )
                                  : null,
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    height: getProportionateScreenHeight(400),
                                    width: getProportionateScreenWidth(250),
                                    imageUrl: controller.boomsURL[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                controller.selectedHeaderImage !=
                                        controller.boomsURL[index]
                                    ? const SizedBox()
                                    : Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            MdiIcons.check,
                                            color: kPrimaryColor,
                                            size: 16,
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        );
                      }),
            ),
          ));
    });
  }
}
