import 'dart:async';
import 'dart:developer';

import 'package:boom_mobile/screens/new_post/services/instagram_api_service.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';

class NewPostController extends GetxController {
  bool isLoggedIn = false;
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  late StreamSubscription<String> onUrlChanged;
  late InstagramService instragram;

  @override
  void onInit() async {
    super.onInit();
    await urlChanged();
  }

  urlChanged() async {
    onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) async {
      log("New Url $url");
      if (url.startsWith("https://rennylangat.github.io/")) {
        instragram.getAuthorizationCode(url);
        bool isTokeFetched = await instragram.getTokenAndUserID();

        if (isTokeFetched) {}
      }
    });
  }

  openInstagramAuth() async {}
}
