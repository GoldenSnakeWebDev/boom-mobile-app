import 'package:boom_mobile/helpers/string_format_helper.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomSnackBar {
  static showCustomSnackBar(
      {required List<String> errorList,
      required List<String> msg,
      required bool isError,
      int duration = 3}) {
    String message = '';
    if (isError) {
      if (errorList.isEmpty) {
        message = "uknown  error";
      } else {
        for (var element in errorList) {
          message = message.isEmpty ? '$message$element' : '$message\n$element';
        }
      }
      message =
          CustomValueConverter.removeQuotationAndSpecialCharacterFromString(
              message);
    } else {
      if (msg.isEmpty) {
        message = "Success";
      } else {
        for (var element in msg) {
          message = message.isEmpty ? '$message$element' : '$message\n$element';
        }
      }
      message =
          CustomValueConverter.removeQuotationAndSpecialCharacterFromString(
              message);
    }

    Get.rawSnackbar(
      progressIndicatorBackgroundColor:
          isError ? kredCancelLightColor : kgreenSuccessColor,
      progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(
          isError ? kredCancelTextColor : kgreenSuccessColor),
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          Text(
            message,
            style: TextStyle(
                fontSize: getProportionateScreenHeight(13),
                color: Colors.black),
          )
        ],
      ),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.TOP,
      titleText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isError ? "Error" : "Success",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: getProportionateScreenHeight(15),
            ),
          ),
          isError
              ? SvgPicture.asset("assets/images/Error.svg",
                  height: 25, width: 25, color: kredCancelTextColor)
              : const Icon(MdiIcons.check, color: kgreenSuccessColor)
        ],
      ),
      backgroundColor: Colors.white,
      borderRadius: 4,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      duration: Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeIn,
      showProgressIndicator: true,
      leftBarIndicatorColor: Colors.white,
      animationDuration: const Duration(seconds: 1),
      borderColor: Colors.white,
      reverseAnimationCurve: Curves.easeOut,
      borderWidth: 2,
    );
  }

  void networkErrorSnack(void Function()? btnAction) {
    Get.snackbar(
      "Network Error",
      "Could not load booms check your connection",
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 6),
      mainButton: TextButton(
        onPressed: () async {
          btnAction;
        },
        child: const Text(
          "Retry",
          style: TextStyle(color: Colors.white),
        ),
      ),
      icon: const Icon(
        MdiIcons.accessPointNetworkOff,
      ),
    );
  }
}
