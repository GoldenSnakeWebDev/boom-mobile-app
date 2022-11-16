import 'dart:io';

import 'package:boom_mobile/screens/new_post/controllers/new_post_controller.dart';
import 'package:boom_mobile/screens/new_post/ui/instagram_web.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateNewPost extends GetView<NewPostController> {
  const CreateNewPost({Key? key}) : super(key: key);

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
                controller.connectWallet();
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
                          TextFormField(
                            minLines: 3,
                            maxLines: 6,
                            maxLength: 320,
                            controller: controller.boomText,
                            decoration: InputDecoration(
                              counterStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(9)),
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
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: kPrimaryColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          Text(
                            "OR",
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(12),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(5),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await controller.handlePickingImage();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kBlueColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          MdiIcons.plus,
                                          color: Colors.white,
                                          size: 13,
                                        ),
                                        SizedBox(
                                          width: getProportionateScreenWidth(5),
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
                                  Get.off(() => InstagramWeb());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          MdiIcons.plus,
                                          color: Colors.blueAccent,
                                          size: 13,
                                        ),
                                        SizedBox(
                                          width: getProportionateScreenWidth(3),
                                        ),
                                        Text(
                                          "Instagram Import",
                                          style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      12),
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w600),
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
                                            getProportionateScreenHeight(50),
                                        width: getProportionateScreenWidth(50),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            controller.pickedImage!,
                                            height:
                                                getProportionateScreenHeight(
                                                    50),
                                            width:
                                                getProportionateScreenWidth(50),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
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
                      hintStyle:
                          TextStyle(fontSize: getProportionateScreenHeight(12)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
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
                  TextFormField(
                    controller: controller.price,
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
                      suffixIcon: SizedBox(
                        width: SizeConfig.screenWidth * 0.45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              height: getProportionateScreenHeight(16),
                              imageUrl:
                                  controller.selectedNetworkModel?.imageUrl ??
                                      "",
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(4),
                            ),
                            Text(
                              "0.00 ${controller.selectedNetwork}",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: getProportionateScreenHeight(12),
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
                                            imageUrl: e.imageUrl,
                                          ),
                                          SizedBox(
                                            width:
                                                getProportionateScreenWidth(4),
                                          ),
                                          Text(
                                            e.symbol,
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
                                  controller.changeChain(value!.symbol);
                                }),
                          ],
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
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
                            controller: controller.tags,
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
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        controller.uploadNewBoom();
                      },
                      child: Container(
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
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(
                            "Create Post",
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(16),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
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
                    color: Theme.of(context).backgroundColor,
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
