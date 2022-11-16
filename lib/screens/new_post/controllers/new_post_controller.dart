import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/models/network_model.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/screens/new_post/controllers/instagram_web_controller.dart';
import 'package:boom_mobile/screens/new_post/models/new_post_model.dart';
import 'package:boom_mobile/screens/new_post/services/upload_boom.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/edit_profile_controler.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_request.dart';
import 'package:wallet_connect/wallet_connect.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

enum POST_TYPE { image, video, text }

class NewPostController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  File? pickedImage;
  UploadService uploadService = UploadService();

  TextEditingController title = TextEditingController();
  TextEditingController boomText = TextEditingController();
  TextEditingController tags = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController fixedPrice = TextEditingController();
  TextEditingController price = TextEditingController();
  NetworkModel? networkModel = Get.find<MainScreenController>().networkModel;
  String? selectedNetwork;
  Network? selectedNetworkModel;
  List<Network> networks = [];
  final igController = Get.find<InstagramWebController>();
  late WCClient wcClient;
  late InAppWebViewController webViewController;
  late String walletAddress, privateKey;
  bool isWalletConnected = false;
  WCSessionStore? sessionStore;

  String rpc =
      'wc:00e46b69-d0cc-4b3e-b6a2-cee442f97188@1?bridge=https%3A%2F%2Fbridge.walletconnect.org&key=91303dedf64285cbbaf9120f6e9d160a5c8aa3deb67017a3874cd272323f48ae';
  final web3Client = Web3Client(
      "wc:00e46b69-d0cc-4b3e-b6a2-cee442f97188@1?bridge=https%3A%2F%2Fbridge.walletconnect.org&key=91303dedf64285cbbaf9120f6e9d160a5c8aa3deb67017a3874cd272323f48ae",
      http.Client());
  @override
  void onInit() {
    super.onInit();
    selectedNetwork = networkModel!.networks[0].symbol;
    selectedNetworkModel = networkModel!.networks[0];
    networks.clear();
    for (var element in networkModel!.networks) {
      networks.add(element);
    }
    // image = null;
    // pickedImage = null;

    log("Ig Post ${igController.selectedIgMedia?.id}");
  }

  connectWallet() {
    wcClient = WCClient(
      onSessionRequest: (number, peerData) {
        log("Session Request");
      },
      onFailure: (message) {
        log("Failure");
      },
      onDisconnect: (code, reason) {
        log("Disconnect");
      },
      onEthSign: (id, message) {
        log("Eth Sign");
      },
      onEthSignTransaction: (id, transaction) {
        log("Eth Sign Transaction");
      },
      onConnect: () {
        log("Connected");
        isWalletConnected = true;
        update();
      },
      onCustomRequest: (number, peerData) {
        log("Session Update");
      },
      onWalletSwitchNetwork: (id, chainId) {
        log("Wallet Switch Network");
      },
    );
    final rpcReq = JsonRpcRequest.fromJson({
      "jsonrpc": "2.0",
      "id": 1666695490479571,
      "method": "eth_accounts",
      "params": [
        {"chainId": "0x1"}
      ],
    });

    log(rpcReq.toJson().toString());
  }

  changeChain(String value) {
    selectedNetwork = value;
    for (var element in networkModel!.networks) {
      if (element.symbol == value) {
        selectedNetworkModel = element;
      }
    }
    update();
  }

  fetchImageFromIG(File image) {
    pickedImage = image;

    update();
  }

  handlePickingImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image!.path);
    }
    update();
  }

  handleTakingPhoto() async {
    image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedImage = File(image!.path);
    }
    update();
  }

  uploadNewBoom() async {
    EasyLoading.show(status: "Uploading");
    String postType = '';
    String imgURL = '';
    pickedImage == null && boomText.text.trim().isNotEmpty
        ? postType = 'text'
        : postType = 'image';
    if (postType != 'text') {
      imgURL = await EditProfileController()
          .uploadPhoto(pickedImage!, "Boom Uploaded");
    } else {
      imgURL = boomText.text.trim();
    }

    log("Boom Type $postType");
    NewPostModel newPostModel = NewPostModel(
        boomType: postType,
        network: selectedNetworkModel!.id,
        description: description.text.trim(),
        title: title.text.trim(),
        imageUrl: imgURL,
        quantity: quantity.text.trim(),
        tags: tags.text.trim(),
        fixedPrice: price.text.trim(),
        price: price.text.trim());
    final res = await uploadService.uploadPost(newPostModel);

    if (res.statusCode == 201) {
      CustomSnackBar.showCustomSnackBar(
          errorList: [""], msg: [""], isError: false);
      Get.offAll(() => const MainScreen(), binding: AppBindings());
    } else {
      log(res.body);
      CustomSnackBar.showCustomSnackBar(
          errorList: [""], msg: [""], isError: true);
    }
    EasyLoading.dismiss();
  }
}
