import 'dart:async';
import 'dart:developer';

import 'package:boom_mobile/screens/new_post/models/insta_media.dart';
import 'package:boom_mobile/screens/new_post/services/instagram_api_service.dart';
import 'package:boom_mobile/screens/new_post/ui/instagram_posts.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';

class InstagramWebController extends GetxController {
  bool isLoggedIn = false;
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  late StreamSubscription<String> onUrlChanged;
  InstagramService instragram = InstagramService();
  List<InstaMedia> medias = [];

  @override
  void onInit() async {
    super.onInit();
    await urlChanged();
  }

  urlChanged() async {
    onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) async {
      log("New Url $url");
      if (url.startsWith("https://rennylangat.github.io/")) {
        String authorizationCode = instragram.getAuthorizationCode(url);

        bool isTokenFetched =
            await instragram.getTokenAndUserID(authorizationCode);
        log("We are here $isTokenFetched");
        if (isTokenFetched) {
          log("Found token and user id");
          medias = await instragram.getAllMedias();
          // update();

          log("Fetched Posts of this number${medias.length}");

          update();

          flutterWebViewPlugin.close();

          Get.to(() => const InstagramPosts());
        }
      } else {
        log("URL $url");
        log("Not found token and user id");
      }
    });
  }
}
