import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleMessage extends StatelessWidget {
  final String username;
  final String img;
  const SingleMessage({
    Key? key,
    required this.username,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.snackbar(
                "Hang in there.",
                "Shipping soon..",
                backgroundColor: kPrimaryColor,
                snackPosition: SnackPosition.TOP,
                colorText: Colors.black,
                overlayBlur: 5.0,
                margin: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.05,
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                ),
              );
            },
            icon: const Icon(
              MdiIcons.phone,
              color: kPrimaryColor,
            ),
          ),
        ],
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                img,
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Text(
              username,
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenHeight(15),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
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
                    child: SingleChildScrollView(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 30,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: getProportionateScreenHeight(10),
                              top: getProportionateScreenHeight(10),
                            ),
                            child: Row(
                              mainAxisAlignment: index % 2 == 0
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: index % 2 == 0
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth * 0.7,
                                      decoration: BoxDecoration(
                                        color: index % 2 == 0
                                            ? const Color(0xFFF8F8F8)
                                            : const Color(0XFF4B5259),
                                        borderRadius: index % 2 == 0
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                                bottomLeft: Radius.circular(12),
                                              )
                                            : const BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12),
                                              ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${index % 2 == 0 ? "Sender" : "Recepient"} These are some messages. Let's try to make it long enough to see how it looks like 😂😂😂🥳",
                                          style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      12),
                                              color: index % 2 == 0
                                                  ? const Color(0xFF5F5F5F)
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Seen",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(10),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12.0),
                      fillColor: const Color(0xFFF8F8F8),
                      filled: true,
                      hintText: "Type a message...",
                      prefixIcon: IconButton(
                        icon: const Icon(
                          MdiIcons.cameraOutline,
                          color: Color(0xFF454C4D),
                        ),
                        onPressed: () {},
                      ),
                      suffixIcon: SizedBox(
                        width: getProportionateScreenWidth(100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              MdiIcons.microphoneOutline,
                              color: Color(0xFF454C4D),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(9),
                            ),
                            const Icon(
                              MdiIcons.imageOutline,
                              color: Color(0xFF454C4D),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(9),
                            ),
                            const Icon(
                              MdiIcons.plusCircleOutline,
                              color: Color(0xFF454C4D),
                            ),
                          ],
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
  }
}
