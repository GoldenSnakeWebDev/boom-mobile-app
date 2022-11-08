import 'package:boom_mobile/screens/new_post/controllers/instagram_web_controller.dart';
import 'package:boom_mobile/screens/new_post/ui/create_new_post.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstagramPosts extends StatelessWidget {
  const InstagramPosts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstagramWebController>(
      init: InstagramWebController(),
      builder: (controller) {
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
            centerTitle: true,
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
          body: GridView.builder(
            itemCount: controller.medias.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.9,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return controller.medias[index].media_type == "VIDEO"
                  ? const SizedBox.shrink()
                  : CachedNetworkImage(
                      height: 400,
                      width: MediaQuery.of(context).size.width * 0.8,
                      imageUrl: controller.medias[index].media_url,
                      fit: BoxFit.cover,
                    );
            },
          ),
        );
      },
    );
  }
}
