import 'package:boom_mobile/screens/back_pack_screen/controllers/backpack_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BackPackScreen extends StatefulWidget {
  const BackPackScreen({Key? key}) : super(key: key);

  @override
  State<BackPackScreen> createState() => _BackPackScreenState();
}

class _BackPackScreenState extends State<BackPackScreen> {
  @override
  void initState() {
    Get.put(BackPackController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<BackPackController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BackPackController>(
      builder: (controller) {
        return controller.isLoading
            ? SizedBox(
                width: SizeConfig.screenWidth,
                height: getProportionateScreenHeight(250),
                child: const SizedBox(),
              )
            : controller.myBooms!.booms!.isEmpty
                ? const Center(
                    child: Text("You have no booms"),
                  )
                : Container(
                    width: SizeConfig.screenWidth * 0.8,
                    height: SizeConfig.screenHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Navigator.of(context).pop();
                                  controller.onClose();
                                  Get.back();
                                },
                                icon: const Icon(MdiIcons.close),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await Clipboard.setData(
                                    const ClipboardData(
                                      text:
                                          "controller.user!.backPack!.backPackId",
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4),
                                    gradient: const LinearGradient(
                                      colors: [
                                        kPrimaryColor,
                                        kSecondaryColor,
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          MdiIcons.contentCopy,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: getProportionateScreenWidth(5),
                                        ),
                                        Text(
                                          "Copy",
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    11),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          RichText(
                            text: const TextSpan(
                              text: "Backpack ID: ",
                              style: TextStyle(color: Colors.grey),
                              children: [
                                TextSpan(
                                    text: "KA265890OQ",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w800,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          Container(
                            width: SizeConfig.screenWidth,
                            height: getProportionateScreenHeight(40),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(4),
                              gradient: const LinearGradient(
                                colors: [
                                  kSecondaryColor,
                                  kPrimaryColor,
                                  kPrimaryColor,
                                  kPrimaryColor,
                                  kPrimaryColor,
                                  kSecondaryColor,
                                ],
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: SizeConfig.screenWidth * 0.3,
                                  child: Text(
                                    "Syn. NFT",
                                    style: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(16),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                      child: Text(
                                        controller.myBooms?.booms!.length
                                                .toString() ??
                                            "0",
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(12),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.myBooms!.booms!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    color: kContBgColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: SizeConfig.screenWidth * 0.4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text: "Syn. NFT ID: ",
                                                  style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            11),
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${controller.myBooms!.booms![index].id}",
                                                      style: TextStyle(
                                                        fontSize:
                                                            getProportionateScreenHeight(
                                                                9),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Divider(
                                                color: Colors.black,
                                                height: 20,
                                              ),
                                              Text(
                                                "${controller.myBooms!.booms![index].description!.isEmpty ? "No Description" : controller.myBooms!.booms![index].description}",
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          11),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                      gradient:
                                                          const LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: [
                                                          kSecondaryColor,
                                                          kPrimaryColor,
                                                          kPrimaryColor,
                                                          kSecondaryColor
                                                        ],
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8.0, 4, 8, 4),
                                                      child: Text(
                                                        "Export",
                                                        style: TextStyle(
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    12)),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      //showListOfUsers();

                                                      showModalBottomSheet(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .vertical(
                                                            top:
                                                                Radius.circular(
                                                              getProportionateScreenHeight(
                                                                  15),
                                                            ),
                                                          ),
                                                        ),
                                                        context: context,
                                                        builder: (context) =>
                                                            Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                getProportionateScreenWidth(
                                                                    15),
                                                            vertical:
                                                                getProportionateScreenHeight(
                                                                    20),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .vertical(
                                                              top: Radius
                                                                  .circular(
                                                                getProportionateScreenHeight(
                                                                    15),
                                                              ),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
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
                                                                "Send Boom",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      getProportionateScreenHeight(
                                                                          16),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    getProportionateScreenHeight(
                                                                        15),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    _buildUsersList(
                                                                  controller,
                                                                  index,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );

                                                      //onTapUserShowDialog to send Boom
                                                      //onTapYesSendBoom(index);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.black,
                                                            width: 0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                        gradient:
                                                            const LinearGradient(
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors: [
                                                            kSecondaryColor,
                                                            kPrimaryColor,
                                                            kPrimaryColor,
                                                            kSecondaryColor
                                                          ],
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8.0, 4, 8, 4),
                                                        child: Text(
                                                          "Send To",
                                                          style: TextStyle(
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    12),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        controller.myBooms!.booms![index]
                                                    .boomType ==
                                                "image"
                                            ? SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        100),
                                                height:
                                                    getProportionateScreenHeight(
                                                        95),
                                                // decoration: BoxDecoration(
                                                //   borderRadius: BorderRadius.circular(10),
                                                //   image: const DecorationImage(
                                                //     image: NetworkImage(
                                                //       "https://bafybeiecd2ncp25fnbrcol3x6eowmfrt7sjwpdn244krddyof5rnri4dwy.ipfs.nftstorage.link/bored_ape.png",
                                                //     ),
                                                //   ),
                                                // ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl: controller
                                                        .myBooms!
                                                        .booms![index]
                                                        .imageUrl!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
      },
    );
  }

  _buildUsersList(BackPackController controller, int boomIndex) {
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
            MdiIcons.send,
            color: Colors.black,
          ),
          onTap: () {
            //onTapUserShowDialog to send Boom
            // onTapYesSendBoom(index);
            Get.dialog(
              AlertDialog(
                title: const Text("Send Boom"),
                content: const Text("Are you sure you want to send this Boom?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () async {
                      final res =
                          await controller.onTapYesSendBoom(boomIndex, index);
                      if (res) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Yes"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
