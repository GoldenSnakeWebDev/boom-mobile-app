// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/main.dart';
import 'package:boom_mobile/screens/authentication/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() async {
  //Device ID 99005732f72ce80f
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
    configureLoader();
  });

  testWidgets('Boom Social Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(
      GetMaterialApp(
        initialBinding: AppBindings(),
        home: const LoginScreen(),
      ),
    );

    // Verify that our logo appears on SplashScreen.

    // expect(
    //     find.byKey(const Key("BoomLogo"), skipOffstage: false), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    Finder emailField = find.byKey(const Key("uname"), skipOffstage: false);

    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, "!renny");

    Finder passField = find.byKey(const Key("pass"), skipOffstage: false);
    expect(passField, findsOneWidget);
    await tester.enterText(passField, "Tictac2040#");

    Finder loginBtn = find.byKey(const Key("loginBtn"), skipOffstage: false);
    expect(loginBtn, findsOneWidget);
    await tester.tap(loginBtn);

    await tester.pump();

    // Verify that our counter has incremented.
  });
}
