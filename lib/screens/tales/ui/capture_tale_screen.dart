import 'dart:io';

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/screens/tales/controllers/camera_controller.dart';
import 'package:boom_mobile/screens/tales/ui/edit_tale_image.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CaptureTaleScreen extends StatefulWidget {
  const CaptureTaleScreen({Key? key}) : super(key: key);

  @override
  State<CaptureTaleScreen> createState() => _CaptureTaleScreenState();
}

class _CaptureTaleScreenState extends State<CaptureTaleScreen> {
  @override
  void initState() {
    super.initState();
    if (!mounted) {
      Get.put(TalesController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TalesController(),
      builder: (value) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                value.cameraController?.buildPreview() ?? Container(),
                Positioned(
                  top: 5,
                  left: SizeConfig.screenWidth * 0.4,
                  child: GestureDetector(
                    onTap: () {
                      value.cameraController?.setFlashMode(FlashMode.off);
                    },
                    child: const Icon(
                      MdiIcons.flashOff,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      MdiIcons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 25,
                  right: 10,
                  child: Icon(
                    MdiIcons.cameraFlip,
                    color: Colors.white,
                  ),
                ),
                const Positioned(
                  bottom: 25,
                  left: 10,
                  child: Icon(
                    MdiIcons.imageAreaClose,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 60,
                  left: SizeConfig.screenWidth * 0.4,
                  child: GestureDetector(
                    onTap: () async {
                      XFile? capturedImage =
                          await value.cameraController?.takePicture();
                      File file = File(capturedImage!.path);
                      Get.to(
                        () => EditTaleImage(imageFile: file),
                        binding: AppBindings(),
                      );
                    },
                    child: Container(
                      width: getProportionateScreenWidth(55),
                      height: getProportionateScreenHeight(55),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: getProportionateScreenWidth(45),
                          height: getProportionateScreenHeight(45),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
