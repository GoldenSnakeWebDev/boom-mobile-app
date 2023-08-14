
import 'package:boom_mobile/screens/new_post/controllers/instagram_web_controller.dart';
import 'package:boom_mobile/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin_ios_android/flutter_webview_plugin_ios_android.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InstagramWeb extends StatelessWidget {
  InstagramWeb({Key? key}) : super(key: key);
  final _myController = Get.put(
    InstagramWebController(),
  );
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            _myController.flutterWebViewPlugin.close();
          },
          icon: const Icon(
            MdiIcons.close,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              _myController.flutterWebViewPlugin.reload();
            },
            icon: const Icon(
              MdiIcons.reload,
              color: Colors.black,
            ),
          )
        ],
      ),
      withLocalStorage: true,
      onBackPress: () {
        _myController.flutterWebViewPlugin.goBack();
      },
      initialChild: Container(
        color: Colors.greenAccent.shade100,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
            value: _myController.loadingProgress,
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
