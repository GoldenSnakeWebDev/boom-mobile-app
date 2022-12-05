import 'package:boom_mobile/screens/new_post/controllers/instagram_web_controller.dart';
import 'package:boom_mobile/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InstagramWeb extends StatelessWidget {
  InstagramWeb({Key? key}) : super(key: key);
  final _myController = Get.put(
    InstagramWebController(),
    permanent: true,
  );
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _myController.flutterWebViewPlugin.close();
            Get.back();
          },
          icon: const Icon(
            MdiIcons.close,
            color: Colors.black,
          ),
        ),
      ),
      clearCache: true,
      clearCookies: true,
      withJavascript: true,
      url: url,
    );
  }
}
