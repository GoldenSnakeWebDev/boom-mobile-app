import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/screens/other_user_profile/other_user_profile.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FansScreen extends StatelessWidget {
  const FansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Fun> fans = Get.arguments[0];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fans",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: fans.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.35)),
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  onTap: () {
                    Get.to(() => const OtherUserProfileScreen(),
                        arguments: fans[index].id);
                  },
                  title: Text(
                    fans[index].username!,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: getProportionateScreenHeight(16)),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      height: getProportionateScreenHeight(35),
                      width: getProportionateScreenWidth(35),
                      imageUrl: fans[index].photo!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
