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
      backgroundColor: kContBgColor,
      appBar: AppBar(
        backgroundColor: kContBgColor,
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
            onPressed: () {},
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
                    child: ListView.builder(
                      itemCount: 100,
                      itemBuilder: (context, index) {
                        return const Text("These are some messages");
                      },
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
