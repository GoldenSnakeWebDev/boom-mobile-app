import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/screens/new_post/controllers/new_post_controller.dart';
import 'package:boom_mobile/screens/new_post/models/insta_media.dart';
import 'package:boom_mobile/screens/new_post/services/instagram_api_service.dart';
import 'package:boom_mobile/screens/new_post/ui/create_new_post.dart';
import 'package:boom_mobile/screens/new_post/ui/instagram_posts.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class InstagramWebController extends GetxController {
  bool isLoggedIn = false;
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  late StreamSubscription<String> onUrlChanged;
  InstagramService instragram = InstagramService();
  List<InstaMedia> medias = [];
  List<Map<String, VideoPlayerController>> videoControllers = [];
  File? selectedIgImage;
  InstaMedia? selectedIgMedia;
  String filePath = '';

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
          await initializeVideoControllers();

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

  initializeVideoControllers() async {
    for (var element in medias) {
      if (element.media_type == "VIDEO") {
        final Map<String, VideoPlayerController> myMap = {
          element.id: VideoPlayerController.network(element.media_url),
        };
        videoControllers.add(myMap);
      }
    }
    log("message ${videoControllers.length}");

    for (var element in medias) {
      for (var video in videoControllers) {
        if (video.containsKey(element.id)) {
          log("Video ${video[element.id]!.dataSource}");
          await video[element.id]!.initialize();
        }
      }
    }

    update();
  }

  selectImage(InstaMedia img) {
    selectedIgMedia = img;

    log("Changed image to ${selectedIgMedia!.id}");
    update();
  }

  proceedWithUpload(InstaMedia? media) async {
    // await instragram.downloadMedia(media);
    log("Selected Image URL:: ${media!.media_url}");
    if (media == null) {
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Please Select an Image"], msg: ["Error"], isError: true);
    } else {
      HttpClient client = HttpClient();
      try {
        EasyLoading.show(status: "Downloading Image");
        var request = await client.getUrl(Uri.parse(media.media_url));
        var response = await request.close();
        if (response.statusCode == 200) {
          var bytes = await consolidateHttpClientResponseBytes(response);
          Directory dir = await getApplicationDocumentsDirectory();

          filePath = '${dir.path}/${media.id}.jpg';

          selectedIgImage = File(filePath);
          await selectedIgImage!.writeAsBytes(bytes);
          log(selectedIgImage!.exists().toString());
          EasyLoading.dismiss();
          Get.find<NewPostController>().fetchImageFromIG(selectedIgImage!);
          Get.to(() => const CreateNewPost(), binding: AppBindings());
          update();
        } else {
          CustomSnackBar.showCustomSnackBar(
              errorList: ["Error Downloading Image"],
              msg: ["Error"],
              isError: true);
        }
      } catch (e) {
        CustomSnackBar.showCustomSnackBar(
            errorList: ["Error downloading image $e"],
            msg: ["Download Error"],
            isError: true);
      }
    }
  }

  @override
  void onClose() {
    onUrlChanged.cancel();
    super.onClose();
  }
}
