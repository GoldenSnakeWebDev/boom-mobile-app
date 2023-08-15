// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/new_post/models/insta_media.dart';
import 'package:boom_mobile/secrets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InstagramService {
  /// [clientID], [appSecret], [redirectUri] from your facebook developer basic display panel.
  /// [scope] choose what kind of data you're wishing to get.
  /// [responseType] I recommend only 'code', I try on DEV MODE with token, it wasn't working.
  /// [url] simply the url used to communicate with Instagram API at the beginning.

  late String authorizationCode;
  late String accessToken;
  late String userID;

  String getAuthorizationCode(String url) {
    authorizationCode =
        url.replaceAll('$redirectUri?code=', '').replaceAll('#_', '');

    return authorizationCode;
  }

  Future<bool> getTokenAndUserID(String authCode) async {
    log("Auth Code $authCode");
    final response = await http.post(
      Uri.parse('https://api.instagram.com/oauth/access_token'),
      body: {
        'client_id': clientID,
        'client_secret': appSecret,
        'grant_type': 'authorization_code',
        'redirect_uri': redirectUri,
        'code': authCode,
      },
    );
    if (response.statusCode == 200) {
      log("IG API Response ${response.body}");
      accessToken = jsonDecode(response.body)['access_token'];
      userID = jsonDecode(response.body)['user_id'].toString();
      return (accessToken.isNotEmpty && userID.isNotEmpty) ? true : false;
    } else {
      log("IG API Error Response ${response.body}");
      return false;
    }
  }

  Future<List<InstaMedia>> getAllMedias() async {
    final String fields = mediaFields.join(',');

    final bodySent = {"fields": fields, "access_token": accessToken};

    log("The Body Sent $bodySent");

    final uri = Uri.parse(
        "https://graph.instagram.com/me/media?fields=$fields&access_token=$accessToken");

    final responseMedia = await http.get(uri);

    log("Response from Instagram ${responseMedia.body}");

    if (responseMedia.statusCode != 200) {
      Get.snackbar("Ig Error", "Could not fetch your IG posts");
      Get.back();
      return [];
    }

    Map<String, dynamic> mediaList = jsonDecode(responseMedia.body);

    final List<InstaMedia> medias = [];

    await mediaList["data"].forEach((media) async {
      Map<String, dynamic> m = await getMediaDetails(media["id"]);

      InstaMedia instaMedia = InstaMedia.fromJson(m);
      medias.add(instaMedia);
    });

    await Future.delayed(const Duration(seconds: 3));

    return medias;
  }

  Future<Map<String, dynamic>> getMediaDetails(String mediaID) async {
    final String fields = mediaFields.join(',');

    final uri = Uri.parse(
        "https://graph.instagram.com/$mediaID?fields=$fields&access_token=$accessToken");

    final responseMedia = await http.get(uri);

    Map<String, dynamic> media = jsonDecode(responseMedia.body);

    return media;
  }
}
