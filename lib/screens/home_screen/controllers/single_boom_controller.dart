import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SingleBoomController extends GetxController {
  final box = GetStorage();

  Stream<Boom> getSingleBoom() {
    return box.read("singleBoom").obs;
  }
}
