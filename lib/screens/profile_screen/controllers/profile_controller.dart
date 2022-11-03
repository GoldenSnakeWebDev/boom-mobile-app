import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/authentication/login/login_screen.dart';
import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  bool isNewUser = true;
  int selectedTab = 0;
  int numberOfBooms = 0;
  int numberOfFans = 0;
  int numberOfFrens = 0;
  bool isVerified = false;
  final User? user = Get.find<MainScreenController>().user;

  final box = GetStorage();
  List<SingleBoomPost> booms = [];

  changeSelectedIndex(int index) {
    selectedTab = index;
    update();
  }

  signOut() async {
    await box.erase();
    Get.offAll(() => const LoginScreen());
    CustomSnackBar.showCustomSnackBar(
        errorList: ["Signed out"], msg: ["Sign out"], isError: false);
  }
}
