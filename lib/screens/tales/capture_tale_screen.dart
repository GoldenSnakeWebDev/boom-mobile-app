import 'package:boom_mobile/screens/tales/controllers/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaptureTaleScreen extends GetView<TalesController> {
  const CaptureTaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: TalesController(),
        builder: (value) {
          return Stack(
            children: [
              value.cameraController?.buildPreview() ?? Container(),
            ],
          );
        });
  }
}
