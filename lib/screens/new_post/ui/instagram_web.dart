import 'package:boom_mobile/screens/new_post/controllers/instagram_web_controller.dart';
import 'package:boom_mobile/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';

class InstagramWeb extends StatelessWidget {
  InstagramWeb({Key? key}) : super(key: key);

  final _myController = Get.put(
    InstagramWebController(),
    permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    return const WebviewScaffold(
      url: url,
    );
  }
}
