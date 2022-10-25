import 'package:boom_mobile/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class InstagramWeb extends StatelessWidget {
  const InstagramWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WebviewScaffold(
      url: url,
    );
  }
}
