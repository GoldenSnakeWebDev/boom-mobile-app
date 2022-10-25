// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:boom_mobile/secrets.dart';
import 'package:http/http.dart' as http;

class InstagramService {
  /// [clientID], [appSecret], [redirectUri] from your facebook developer basic display panel.
  /// [scope] choose what kind of data you're wishing to get.
  /// [responseType] I recommend only 'code', I try on DEV MODE with token, it wasn't working.
  /// [url] simply the url used to communicate with Instagram API at the beginning.

  String authorizationCode = '';
  String accessToken = '';
  String userID = '';

  void getAuthorizationCode(String url) {
    authorizationCode =
        url.replaceAll('$redirectUri?code=', '').replaceAll('#', '');
  }

  Future<bool> getTokenAndUserID() async {
    final response = await http.post(
      Uri.parse('https://api.instagram.com/oauth/access_token'),
      body: {
        'client_id': clientID,
        'client_secret': appSecret,
        'grant_type': 'authorization_code',
        'redirect_uri': redirectUri,
        'code': authorizationCode,
      },
    );
    if (response.statusCode == 200) {
      accessToken = jsonDecode(response.body)['access_token'];
      userID = jsonDecode(response.body)['user_id'].toString();
      return (accessToken.isNotEmpty && userID.isNotEmpty) ? true : false;
    } else {
      return false;
    }
  }

  Future<bool> getUserProfile() async {
    final String fields = userFields.join(',');
    final response = await http.get(
      Uri.parse(
          'https://graph.instagram.com/$userID?fields=$fields&access_token=$accessToken'),
    );
    var instaProfile = {
      "id": jsonDecode(response.body)['id'],
      "username": jsonDecode(response.body)['username'],
    };
    return (instaProfile.isNotEmpty) ? true : false;
  }
}
