import 'package:boom_mobile/screens/new_post/controllers/instagram_web_controller.dart';
import 'package:boom_mobile/screens/new_post/ui/create_new_post.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstagramPosts extends StatelessWidget {
  const InstagramPosts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstagramWebController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Get.off(() => const CreateNewPost());
            },
          ),
          leadingWidth: getProportionateScreenWidth(70),
          title: Text(
            '${controller.medias.isNotEmpty ? controller.medias[0].username : ""} Instagram Posts',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: getProportionateScreenHeight(12),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.off(() => const CreateNewPost());
                },
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              height: 400,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(controller.medias[index].media_url),
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8.0);
          },
          itemCount: controller.medias.length,
        ),
      );
    });
  }
}
