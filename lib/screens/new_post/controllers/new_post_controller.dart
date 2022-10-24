import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';

class NewPostController extends GetxController {
  bool isLoggedIn = false;
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  openInstagramAuth() async {
    flutterWebViewPlugin.onUrlChanged.listen((url) {});
    return WebviewScaffold(
      url: "https://www.instagram.com/accounts/login/",
      appBar: AppBar(
        title: const Text("Instagram Login"),
      ),
    );
  }
}
