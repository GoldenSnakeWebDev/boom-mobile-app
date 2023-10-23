import 'dart:io';

import 'package:boom_mobile/routes/route_helper.dart';
import 'package:boom_mobile/screens/new_post/controllers/instagram_web_controller.dart';
import 'package:boom_mobile/screens/new_post/controllers/new_post_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:slide_action/slide_action.dart';
import 'package:video_player/video_player.dart';

class CreateNewPost extends StatefulWidget {
  const CreateNewPost({Key? key}) : super(key: key);

  @override
  State<CreateNewPost> createState() => _CreateNewPostState();
}

class _CreateNewPostState extends State<CreateNewPost> {
  @override
  void initState() {
    Get.put(NewPostController());
    Get.put(InstagramWebController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewPostController>(builder: (controller) {
      return Scaffold(
        backgroundColor: kContBgColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            'New Post',
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenHeight(16),
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () async {
                // controller.connectWallet();
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
                      return GetBuilder<NewPostController>(
                          builder: (controller) {
                        return Container(
                          height: SizeConfig.screenHeight * 0.35,
                          width: SizeConfig.screenWidth,
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Import NFT from your wallet",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: getProportionateScreenHeight(15),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(25),
                                ),
                                TextFormField(
                                  controller: controller.nftContractAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter the contract address";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(12),
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(4),
                                    hintText: "NFT Contract Address",
                                    hintStyle: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: SizedBox(
                                      width: SizeConfig.screenWidth * 0.43,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CachedNetworkImage(
                                              height:
                                                  getProportionateScreenHeight(
                                                      16),
                                              imageUrl: controller
                                                  .selectedNetworkModel!
                                                  .imageUrl!,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                            SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      4),
                                            ),
                                            Obx(
                                              () => Text(
                                                "${controller.cryptoAmount} ${controller.selectedNetwork}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          12),
                                                ),
                                              ),
                                            ),
                                            DropdownButton(
                                                icon: const Icon(
                                                  Icons
                                                      .arrow_drop_down_circle_outlined,
                                                  color: Colors.grey,
                                                  size: 24,
                                                ),
                                                underline: const SizedBox(),
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                items: controller.networks
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                      value: e,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          CachedNetworkImage(
                                                            height:
                                                                getProportionateScreenHeight(
                                                                    16),
                                                            imageUrl:
                                                                e.imageUrl!,
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                getProportionateScreenWidth(
                                                                    4),
                                                          ),
                                                          Text(
                                                            e.symbol!,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontSize:
                                                                  getProportionateScreenHeight(
                                                                      12),
                                                            ),
                                                          )
                                                        ],
                                                      ));
                                                }).toList(),
                                                onChanged: (value) {
                                                  controller.changeChain(
                                                      value!.symbol!);
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(12),
                                ),
                                TextFormField(
                                  controller: controller.nftId,
                                  decoration: InputDecoration(
                                    hintText: "NFT ID",
                                    prefixIcon: Icon(
                                      MdiIcons.identifier,
                                      color: Colors.black,
                                    ),
                                    contentPadding: const EdgeInsets.all(4.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(12)),
                                TextFormField(
                                  controller: controller.nftURI,
                                  decoration: InputDecoration(
                                    hintText: "Image URI",
                                    prefixIcon: Icon(
                                      MdiIcons.web,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                    contentPadding: const EdgeInsets.all(4.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(28),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    //TODO: Add Import NFT Function
                                    // await controller.connectWallet(true);
                                  },
                                  child: Container(
                                    width: SizeConfig.screenWidth,
                                    height: getProportionateScreenHeight(35),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Import NFT",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            getProportionateScreenHeight(15),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                    });
              },
              child: Text(
                "Import NFT",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
          backgroundColor: kContBgColor,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        // border: Border.all(
                        //   color: Colors.blueAccent.withOpacity(0.3),
                        //   width: 0.5,
                        // ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Text NFT",
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(13),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Obx(
                              () => TextFormField(
                                minLines: 3,
                                maxLines: 6,
                                maxLength: 320,
                                enabled: !controller.imageSelected.value,
                                controller: controller.boomText,
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(9)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kPrimaryColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kPrimaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kPrimaryColor),
                                  ),
                                  // filled: true,
                                  // fillColor: Colors.grey.shade300,
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Center(
                              child: Column(children: [
                                Text(
                                  "OR",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(7),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(
                                                          25.0)),
                                            ),
                                            builder: (context) {
                                              return Container(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.2,
                                                decoration: const BoxDecoration(
                                                  color: kContBgColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Add File From",
                                                        style: TextStyle(
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    16),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            getProportionateScreenHeight(
                                                                20),
                                                      ),
                                                      Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.back();
                                                              controller
                                                                  .handlePickingImage();
                                                            },
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          10),
                                                              width: SizeConfig
                                                                      .screenWidth *
                                                                  0.8,
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      30),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[200],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "Pick Image",
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
                                                                  .handleTakingPhoto();
                                                            },
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          10),
                                                              width: SizeConfig
                                                                      .screenWidth *
                                                                  0.8,
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      30),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[200],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "Take Photo",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        getProportionateScreenHeight(
                                                                            16)),
                                                              ),
                                                            ),
                                                          ),
                                                          // GestureDetector(
                                                          //   onTap: () {
                                                          //     Get.back();
                                                          //     controller
                                                          //         .handlePickingVideo();
                                                          //   },
                                                          //   child: Container(
                                                          //     margin:
                                                          //         const EdgeInsets
                                                          //                 .only(
                                                          //             bottom: 10),
                                                          //     width: SizeConfig
                                                          //             .screenWidth *
                                                          //         0.8,
                                                          //     height:
                                                          //         getProportionateScreenHeight(
                                                          //             30),
                                                          //     decoration:
                                                          //         BoxDecoration(
                                                          //       color: Colors
                                                          //           .grey[200],
                                                          //       borderRadius:
                                                          //           BorderRadius
                                                          //               .circular(
                                                          //                   10),
                                                          //     ),
                                                          //     alignment:
                                                          //         Alignment.center,
                                                          //     child: Text(
                                                          //       "Pick Video",
                                                          //       style: TextStyle(
                                                          //           fontSize:
                                                          //               getProportionateScreenHeight(
                                                          //                   16)),
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          // GestureDetector(
                                                          //   onTap: () {
                                                          //     Get.back();
                                                          //     controller
                                                          //         .handleRecordingVideo();
                                                          //   },
                                                          //   child: Container(
                                                          //     margin:
                                                          //         const EdgeInsets
                                                          //                 .only(
                                                          //             bottom: 10),
                                                          //     width: SizeConfig
                                                          //             .screenWidth *
                                                          //         0.8,
                                                          //     height:
                                                          //         getProportionateScreenHeight(
                                                          //             30),
                                                          //     decoration:
                                                          //         BoxDecoration(
                                                          //       color: Colors
                                                          //           .grey[200],
                                                          //       borderRadius:
                                                          //           BorderRadius
                                                          //               .circular(
                                                          //                   10),
                                                          //     ),
                                                          //     alignment:
                                                          //         Alignment.center,
                                                          //     child: Text(
                                                          //       "Take Video",
                                                          //       style: TextStyle(
                                                          //           fontSize:
                                                          //               getProportionateScreenHeight(
                                                          //                   16)),
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });

                                        // await controller.handlePickingImage();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: kBlueColor.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 4, 8, 4),
                                          child: Row(
                                            children: [
                                              Icon(
                                                MdiIcons.plus,
                                                color: Colors.white,
                                                size: 13,
                                              ),
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        5),
                                              ),
                                              Text(
                                                "Add File",
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          12),
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(15),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        Get.toNamed(RouteHelper.instagramWeb);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 4, 8, 4),
                                          child: Row(
                                            children: [
                                              Icon(
                                                MdiIcons.plus,
                                                color: Colors.blueAccent,
                                                size: 13,
                                              ),
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        3),
                                              ),
                                              Text(
                                                "Instagram Import",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            12),
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    (controller.pickedImage != null)
                                        ? GestureDetector(
                                            onTap: () => showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  PreviewDialog(
                                                image: controller.pickedImage!,
                                              ),
                                            ),
                                            child: SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      50),
                                              width:
                                                  getProportionateScreenWidth(
                                                      50),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  controller.pickedImage!,
                                                  height:
                                                      getProportionateScreenHeight(
                                                          50),
                                                  width:
                                                      getProportionateScreenWidth(
                                                          50),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : controller.pickedVideo != null
                                            ? GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .selectedVideoController
                                                      .play();
                                                  showCupertinoDialog(
                                                    context: context,
                                                    builder: ((context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Video Preview"),
                                                        content: SizedBox(
                                                          height:
                                                              getProportionateScreenHeight(
                                                                  300),
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  300),
                                                          child: VideoPlayer(
                                                              controller
                                                                  .selectedVideoController),
                                                        ),
                                                        actions: [
                                                          CupertinoDialogAction(
                                                            child: const Text(
                                                                "Close"),
                                                            onPressed: () {
                                                              Get.back();
                                                              controller
                                                                  .selectedVideoController
                                                                  .pause();
                                                              controller
                                                                  .selectedVideoController
                                                                  .seekTo(
                                                                const Duration(
                                                                    seconds: 0),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                  );
                                                },
                                                child: Container(
                                                    width:
                                                        getProportionateScreenWidth(
                                                            70),
                                                    height:
                                                        getProportionateScreenHeight(
                                                            40),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: kPrimaryColor,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.play_arrow,
                                                          size: 30,
                                                          color: kBlueColor,
                                                        ),
                                                        Text(
                                                          "Preview Video",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  getProportionateScreenHeight(
                                                                      9),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        )
                                                      ],
                                                    )),
                                              )
                                            : Container(),
                                  ],
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(3),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Max upload size 30MB",
                                style: TextStyle(
                                    fontSize: getProportionateScreenHeight(10),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Text(
                      "Number of versions",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: getProportionateScreenHeight(14),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    TextFormField(
                      controller: controller.quantity,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter number of versions";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(4),
                        hintText: "Enter number of copies you want to create",
                        hintStyle: TextStyle(
                            fontSize: getProportionateScreenHeight(12)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: getProportionateScreenHeight(15),
                    // ),
                    // SizedBox(
                    //   width: SizeConfig.screenWidth * 0.5,
                    //   child: TextFormField(
                    //     controller: controller.fixedPrice,
                    //     decoration: InputDecoration(
                    //       contentPadding: const EdgeInsets.all(4),
                    //       hintText: "\$ Fixed Price",
                    //       hintStyle: TextStyle(
                    //         fontSize: getProportionateScreenHeight(12),
                    //       ),
                    //       filled: true,
                    //       fillColor: Colors.white,
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(8.0),
                    //         borderSide: BorderSide.none,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Text(
                      "Price",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: getProportionateScreenHeight(15)),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth,
                      child: TextFormField(
                        controller: controller.price,
                        onChanged: (value) {
                          controller.getCryptoAmount(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter price";
                          } else if (double.parse(value) < 5) {
                            return "Price must be greater than \$5";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(4),
                          hintText: "Price (min. listing price is \$5)",
                          hintStyle: TextStyle(
                            fontSize: getProportionateScreenHeight(12),
                          ),
                          prefix: Text(
                            "\$",
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(12),
                              color: Colors.black,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffix: const SizedBox(),
                          suffixIcon: FittedBox(
                            // width: SizeConfig.screenWidth * 0.35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CachedNetworkImage(
                                  height: getProportionateScreenHeight(16),
                                  imageUrl: controller
                                      .selectedNetworkModel!.imageUrl!,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/icons/${controller.networks.where((element) => element.symbol == controller.selectedNetwork).toString().toLowerCase()}.png',
                                    height: getProportionateScreenHeight(20),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(4),
                                ),
                                Obx(
                                  () => Text(
                                    "${controller.cryptoAmount} ${controller.selectedNetwork}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize:
                                          getProportionateScreenHeight(12),
                                    ),
                                  ),
                                ),
                                DropdownButton(
                                    icon: const Icon(
                                      Icons.arrow_drop_down_circle_outlined,
                                      color: Colors.grey,
                                      size: 24,
                                    ),
                                    underline: const SizedBox(),
                                    style: const TextStyle(color: Colors.black),
                                    items: controller.networks.map((e) {
                                      return DropdownMenuItem(
                                          value: e,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CachedNetworkImage(
                                                height:
                                                    getProportionateScreenHeight(
                                                        16),
                                                imageUrl: e.imageUrl!,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        4),
                                              ),
                                              Text(
                                                e.symbol!,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          12),
                                                ),
                                              )
                                            ],
                                          ));
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.changeChain(value!.symbol!);
                                    }),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Service Fee ',
                        children: const [
                          TextSpan(
                            text: ' 4%',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        ],
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: getProportionateScreenHeight(12),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NFT Details",
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(15),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Text(
                              "Complete the following details before your post is listed on the marketplace",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: getProportionateScreenHeight(11),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            Text(
                              "Apply title, category, description, hashtags to all posts",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: getProportionateScreenHeight(11),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Text(
                              "Title",
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(13),
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            TextFormField(
                              controller: controller.title,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter title";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(4),
                                hintText: "Enter title about your art",
                                hintStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(12),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade100,
                                    width: 0.1,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Text(
                              "Caption (Optional)",
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(13),
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            TextFormField(
                              maxLines: 5,
                              controller: controller.description,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(4),
                                hintText:
                                    "Enter some description about your post",
                                hintStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(12),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade100,
                                    width: 0.1,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Text(
                              "Location",
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(13),
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            TextFormField(
                              controller: controller.location,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter location";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(4),
                                // hintText: "Enter title about your art",
                                hintStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(12),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade100,
                                    width: 0.1,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Text(
                              "Add At-Tags",
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(13),
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            TextFormField(
                              controller: controller.tags,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter tags";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(4),
                                // hintText: "Enter title about your art",
                                hintStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(12),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade100,
                                    width: 0.1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    // Center(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       showModalBottomSheet(
                    //         context: context,
                    //         isScrollControlled: true,
                    //         shape: const RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.only(
                    //             topLeft: Radius.circular(20),
                    //             topRight: Radius.circular(20),
                    //           ),
                    //         ),
                    //         builder: (context) {
                    //           return Container(
                    //             height: SizeConfig.screenHeight * 0.2,
                    //             width: SizeConfig.screenWidth,
                    //             margin: EdgeInsets.only(
                    //               bottom:
                    //                   MediaQuery.of(context).viewInsets.bottom,
                    //             ),
                    //             decoration: const BoxDecoration(
                    //               color: Colors.white,
                    //               borderRadius: BorderRadius.only(
                    //                 topLeft: Radius.circular(20),
                    //                 topRight: Radius.circular(20),
                    //               ),
                    //             ),
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: Column(
                    //                 children: [
                    //                   Text(
                    //                     "Mint Your NFT Via: ",
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.w800,
                    //                       fontSize:
                    //                           getProportionateScreenHeight(15),
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     height:
                    //                         getProportionateScreenHeight(20),
                    //                   ),
                    //                   GestureDetector(
                    //                     onTap: () {
                    //                       Get.back();
                    //                       controller.uploadNewBoom(false);
                    //                     },
                    //                     child: Container(
                    //                       margin:
                    //                           const EdgeInsets.only(bottom: 20),
                    //                       width: SizeConfig.screenWidth * 0.8,
                    //                       height:
                    //                           getProportionateScreenHeight(35),
                    //                       decoration: BoxDecoration(
                    //                         color: Colors.grey[200],
                    //                         borderRadius:
                    //                             BorderRadius.circular(10),
                    //                       ),
                    //                       alignment: Alignment.center,
                    //                       child: Text(
                    //                         "Off-Chain Minting",
                    //                         style: TextStyle(
                    //                             fontSize:
                    //                                 getProportionateScreenHeight(
                    //                                     16)),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   GestureDetector(
                    //                     onTap: () async {
                    //                       Get.back();
                    //                       Future.delayed(
                    //                           const Duration(seconds: 0), () {
                    //                         showDialog(
                    //                           context: context,
                    //                           builder: (BuildContext context) {
                    //                             return AlertDialog(
                    //                               title: const Text(
                    //                                   "Connect Wallet"),
                    //                               content: const Text(
                    //                                   "Please make sure you have selected the correct network in your wallet provider. "),
                    //                               actions: [
                    //                                 TextButton(
                    //                                   onPressed: () {
                    //                                     Navigator.pop(context);
                    //                                   },
                    //                                   child:
                    //                                       const Text("Cancel"),
                    //                                 ),
                    //                                 TextButton(
                    //                                   onPressed: () async {
                    //                                     Get.back();
                    //                                     await controller
                    //                                         .uploadNewBoom(
                    //                                             true);
                    //                                   },
                    //                                   child:
                    //                                       const Text("Proceed"),
                    //                                 ),
                    //                               ],
                    //                             );
                    //                           },
                    //                         );
                    //                       });
                    //                     },
                    //                     child: Container(
                    //                       margin:
                    //                           const EdgeInsets.only(bottom: 10),
                    //                       width: SizeConfig.screenWidth * 0.8,
                    //                       height:
                    //                           getProportionateScreenHeight(35),
                    //                       decoration: BoxDecoration(
                    //                         color: Colors.grey[200],
                    //                         borderRadius:
                    //                             BorderRadius.circular(10),
                    //                       ),
                    //                       alignment: Alignment.center,
                    //                       child: Text(
                    //                         "On-Chain Minting",
                    //                         style: TextStyle(
                    //                             fontSize:
                    //                                 getProportionateScreenHeight(
                    //                                     16)),
                    //                       ),
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //       );
                    //     },
                    //     child: Container(
                    //       height: getProportionateScreenHeight(40),
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(16),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.grey.withOpacity(0.2),
                    //             spreadRadius: 1,
                    //             blurRadius: 2,
                    //             offset: const Offset(4, 8),
                    //           ),
                    //         ],
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    //         child: Text(
                    //           "Create Post",
                    //           style: TextStyle(
                    //             fontSize: getProportionateScreenHeight(16),
                    //             fontWeight: FontWeight.w800,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: getProportionateScreenHeight(20),
                    // ),
                    Center(
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.85,
                        child: SlideAction(
                          snapAnimationDuration:
                              const Duration(milliseconds: 100),
                          actionSnapThreshold: 0.35,
                          trackBuilder: (context, state) {
                            return Container(
                              height: getProportionateScreenHeight(40),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(4, 8),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Text(
                                  "Slide to Create Post",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            );
                          },
                          thumbBuilder: (context, state) {
                            return Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          action: () async {
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
                                  height: SizeConfig.screenHeight * 0.2,
                                  width: SizeConfig.screenWidth,
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Mint Your NFT Via: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    15),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(20),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                            controller.uploadNewBoom(false,
                                                context: context);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            width: SizeConfig.screenWidth * 0.8,
                                            height:
                                                getProportionateScreenHeight(
                                                    35),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Off-Chain Minting",
                                              style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          16)),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            Get.back();
                                            // await controller
                                            //     .createWalletConnectSession(
                                            //   context: context,
                                            //   androidUseOsPicker: false,
                                            // );

                                            // Get.snackbar(
                                            //   "Coming Soon",
                                            //   "Hang in there, this feature will be available soon",
                                            //   backgroundColor: kPrimaryColor,
                                            //   colorText: Colors.black,
                                            // );

                                            Future.delayed(
                                                const Duration(seconds: 0), () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Connect Wallet"),
                                                    content: const Text(
                                                        "Please make sure you have selected the correct network in your wallet provider. "),
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
                                                              .uploadNewBoom(
                                                            true,
                                                            context: context,
                                                          );

                                                          // await controller
                                                          //     .bindToPlatform();
                                                          // log("Battery Level${controller.batteryLevel}");
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
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            width: SizeConfig.screenWidth * 0.8,
                                            height:
                                                getProportionateScreenHeight(
                                                    35),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "On-Chain Minting",
                                              style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          16)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(40),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class PreviewDialog extends StatelessWidget {
  final File image;
  const PreviewDialog({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                  minHeight: 100,
                  maxHeight: MediaQuery.of(context).size.height * 0.5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Image.file(
                image,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.3),
                  shape: BoxShape.circle),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  splashColor: Colors.grey,
                  onTap: () =>
                      Navigator.canPop(context) ? Navigator.pop(context) : null,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close, size: 28, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dialogContent(BuildContext context, int index, VoidCallback fct) {
    return FittedBox(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: fct,
          splashColor: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: const ClipOval(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
