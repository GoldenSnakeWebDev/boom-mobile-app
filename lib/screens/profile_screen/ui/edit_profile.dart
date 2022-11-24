import 'dart:io';

import 'package:boom_mobile/screens/profile_screen/controllers/edit_profile_controller.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/profile_controller.dart';
import 'package:boom_mobile/screens/profile_screen/ui/pick_from_booms.dart';
import 'package:boom_mobile/screens/profile_screen/ui/pick_profile_from_booms.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    Get.put(EditProfileController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: kBlueColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: kBlueColor,
              fontSize: getProportionateScreenHeight(19),
              fontWeight: FontWeight.w800,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await controller.updateProfile();
                Get.back();
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(16),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(170),
                    width: SizeConfig.screenWidth * 0.95,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: SizeConfig.screenHeight * 0.3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Choose from",
                                              style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          15),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      30),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                controller
                                                    .handlePickHeaderImage(
                                                  ImageSource.camera,
                                                );
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                width: SizeConfig.screenWidth *
                                                    0.8,
                                                height:
                                                    getProportionateScreenHeight(
                                                        30),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Camera",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              16)),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                controller
                                                    .handlePickHeaderImage(
                                                  ImageSource.gallery,
                                                );
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                width: SizeConfig.screenWidth *
                                                    0.8,
                                                height:
                                                    getProportionateScreenHeight(
                                                        30),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Gallery",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              16)),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                Get.to(
                                                    () => const PickFromBoom());
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                width: SizeConfig.screenWidth *
                                                    0.8,
                                                height:
                                                    getProportionateScreenHeight(
                                                        30),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Booms",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              16)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                              // controller.handlePickHeaderImage();
                            },
                            child: Container(
                              width: SizeConfig.screenWidth * 0.92,
                              height: getProportionateScreenHeight(125),
                              decoration: BoxDecoration(
                                color: kContBgColor,
                                borderRadius: BorderRadius.circular(12),
                                // border: Border.all(color: kBlueColor),
                              ),
                              child: controller.pickedHeaderImage != null
                                  ? Image.file(
                                      File(controller.pickedHeaderImage!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Add header Image",
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    14),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(10),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black26),
                                              shape: BoxShape.circle),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.add,
                                              size: 16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: SizeConfig.screenHeight * 0.3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Choose from",
                                              style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          15),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      20),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                controller
                                                    .handlePickProfileImage(
                                                  ImageSource.camera,
                                                );
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                width: SizeConfig.screenWidth *
                                                    0.8,
                                                height:
                                                    getProportionateScreenHeight(
                                                        30),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Camera",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              16)),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                controller
                                                    .handlePickProfileImage(
                                                  ImageSource.gallery,
                                                );
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                width: SizeConfig.screenWidth *
                                                    0.8,
                                                height:
                                                    getProportionateScreenHeight(
                                                        30),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Gallery",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              16)),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                Get.to(() =>
                                                    const PickProfileImg());
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                width: SizeConfig.screenWidth *
                                                    0.8,
                                                height:
                                                    getProportionateScreenHeight(
                                                        30),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Booms",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              16)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              width: getProportionateScreenWidth(70),
                              height: getProportionateScreenHeight(70),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kContBgColor,
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.5,
                                ),
                              ),
                              child: controller.pickedProfileImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(70),
                                      child: Image.file(
                                        File(controller
                                            .pickedProfileImage!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.add,
                                      size: 24,
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Username *",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  TextFormField(
                    controller: controller.usernameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4.0,
                        left: 4.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text(
                    "Bio",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  TextFormField(
                    controller: controller.bioController,
                    maxLines: 5,
                    maxLength: 180,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4.0,
                        left: 4.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text(
                    "Location",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  TextFormField(
                    controller: controller.locationController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4.0,
                        left: 4.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text(
                    "Twitter Username",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  TextFormField(
                    controller: controller.twitterController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4.0,
                        left: 4.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text(
                    "Facebook Username",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  TextFormField(
                    controller: controller.facebookController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4.0,
                        left: 4.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text(
                    "Instagram Username",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  TextFormField(
                    controller: controller.instagramController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4.0,
                        left: 4.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text(
                    "TikTok Username",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  TextFormField(
                    controller: controller.tiktokController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4.0,
                        left: 4.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  // const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.find<ProfileController>().signOut();
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: getProportionateScreenHeight(16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
