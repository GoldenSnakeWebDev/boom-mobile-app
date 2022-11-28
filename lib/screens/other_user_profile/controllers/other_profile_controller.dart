import 'dart:developer';

import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/network_model.dart';
import '../../home_screen/models/all_booms.dart';
import '../../main_screen/controllers/main_screen_controller.dart';

class OtherUserProfileController extends GetxController {
  String? userId;
  bool isNewUser = false;
  bool isVerified = false;
  int numOfFans = 0;
  int numOfFrens = 0;
  int numOfBooms = 0;
  bool isLoves = false;
  bool isSmiles = false;
  bool isRebooms = false;
  bool isLiked = false;
  NetworkModel? networkModel = Get.find<MainScreenController>().networkModel;
  String? selectedNetwork;
  Network? selectedNetworkModel;
  List<Network> networks = [];
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    userId = Get.arguments;
    selectedNetwork = networkModel!.networks![0].symbol;
    log("Selected network Controller: $selectedNetwork");
    selectedNetworkModel = networkModel!.networks![0];
    networks.clear();
    for (var element in networkModel!.networks!) {
      networks.add(element);
    }
  }

  fetchReactionStatus(Boom boom) {
    String userId = box.read("userId");
    for (var item in boom.reactions!.likes!) {
      if (item.id == userId) {
        isLiked = true;
      } else {
        isLiked = false;
      }
    }
    for (var item in boom.reactions!.loves!) {
      if (item.id == userId) {
        isLoves = true;
      }
    }
    for (var item in boom.reactions!.smiles!) {
      if (item.id == userId) {
        isSmiles = true;
      }
    }
    for (var item in boom.reactions!.rebooms!) {
      if (item.id == userId) {
        isRebooms = true;
      }
    }
  }

  SingleBoomPost getSingleBoomDetails(Boom boom, int index) {
    fetchReactionStatus(boom);
    return SingleBoomPost(
      index: index,
      boomType: "${boom.boomType}",
      location: "${boom.location}",
      chain: "${boom.network!.symbol}",
      imgUrl: "${boom.imageUrl}",
      desc: "${boom.description}",
      title: "${boom.title}",
      network: boom.network!,
      isLiked: isLiked,
      isLoves: isLoves,
      isRebooms: isRebooms,
      isSmiles: isSmiles,
      likes: boom.reactions!.likes!.length,
      loves: boom.reactions!.loves!.length,
      smiles: boom.reactions!.smiles!.length,
      rebooms: boom.reactions!.rebooms!.length,
      reported: boom.reactions!.reports!.length,
      comments: boom.comments!.length,
    );
  }

  changeChain(String value) {
    selectedNetwork = value;
    for (var element in networkModel!.networks!) {
      if (element.symbol == value) {
        selectedNetworkModel = element;
      }
    }
    update();
  }
}
