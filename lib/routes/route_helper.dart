//This class helps us manage named routes to screens within the app
import 'package:boom_mobile/screens/authentication/login/login_screen.dart';
import 'package:boom_mobile/screens/authentication/registration/registration_screen.dart';
import 'package:boom_mobile/screens/explore/explore_screen.dart';
import 'package:boom_mobile/screens/home_screen/home_screen.dart';
import 'package:boom_mobile/screens/notifications/notifications_screen.dart';
import 'package:boom_mobile/screens/profile_screen/ui/profile_screen.dart';
import 'package:boom_mobile/screens/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String homeScreen = '/home';
  static const String loginScreen = '/login';
  static const String exploreScreen = '/explore';
  static const String notificationScreen = '/notification';
  static const String profileScreen = '/profile';
  static const String splashScreen = '/splash';
  static const String registerScreen = '/register';

  static List<GetPage> routes = [
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: exploreScreen, page: () => const ExploreScreen()),
    GetPage(name: notificationScreen, page: () => const NotificationScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: registerScreen, page: () => const RegistrationScreen()),
  ];
}
