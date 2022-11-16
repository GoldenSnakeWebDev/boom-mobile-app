import 'package:boom_mobile/repo/get_user/get_curr_user.dart';
import 'package:boom_mobile/screens/authentication/login/controllers/login_controller.dart';
import 'package:boom_mobile/screens/authentication/registration/controllers/signup_controller.dart';
import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/screens/new_post/controllers/instagram_web_controller.dart';
import 'package:boom_mobile/screens/new_post/controllers/new_post_controller.dart';
import 'package:boom_mobile/screens/other_user_profile/controllers/other_profile_controller.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/edit_profile_controler.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/profile_controller.dart';
import 'package:boom_mobile/screens/splash_screen/controllers/splash_controller.dart';
import 'package:boom_mobile/screens/tales/controllers/camera_controller.dart';
import 'package:boom_mobile/screens/tales/controllers/tales_epics_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TalesController>(() => TalesController());
    Get.lazyPut<NewPostController>(() => NewPostController());
    Get.lazyPut<InstagramWebController>(() => InstagramWebController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MainScreenController>(
        () => MainScreenController(repo: Get.find()));
    Get.lazyPut<FetchCurrUserRepo>(() => FetchCurrUserRepo());
    Get.lazyPut<TalesEpicsController>(() => TalesEpicsController());
    Get.lazyPut<OtherUserProfileController>(() => OtherUserProfileController());
  }
}
