import 'package:boom_mobile/screens/splash_screen/controllers/splash_controller.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<SplashController>(
      autoRemove: false,
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: SizedBox(
              child: CachedNetworkImage(
                key: const Key("BoomLogo"),
                imageUrl: boomIconUrl,
                fit: BoxFit.contain,
                width: 180,
                height: 180,
              ),
            ),
          ),
        );
      },
    );
  }
}
