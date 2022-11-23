import 'package:boom_mobile/screens/profile_screen/controllers/edit_profile_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      ),
      body: SafeArea(
        child: GetBuilder<EditProfileController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: controller.boomsURL.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(controller.boomsURL[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: controller.boomsURL[index],
                        ),
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
