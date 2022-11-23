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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/crypto.dart';

import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

enum POST_TYPE { image, video, text }

class WalletConnectEthereumCredentials extends CustomTransactionSender {
  final EthereumWalletConnectProvider provider;
  WalletConnectEthereumCredentials({required this.provider});

  @override
  Future<EthereumAddress> extractAddress() {
    // TODO: implement extractAddress
    throw UnimplementedError();
  }

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    log("Attempting to send TX");
    final hash = await provider.sendTransaction(
      from: transaction.from!.hex,
      to: transaction.to?.hex,
      data: transaction.data,
      gas: transaction.maxGas,
      gasPrice: transaction.gasPrice?.getInWei,
      value: transaction.value?.getInWei,
      nonce: transaction.nonce,
    );

    return hash;
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }
}

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
  TextEditingController location = TextEditingController();
  NetworkModel? networkModel = Get.find<MainScreenController>().networkModel;
  String? selectedNetwork;
  Network? selectedNetworkModel;
  List<Network> networks = [];
  final igController = Get.find<InstagramWebController>();
  // late WCClient wcClient;
  late InAppWebViewController webViewController;
  late String walletAddress, privateKey;
  bool isWalletConnected = false;
  EthereumWalletConnectProvider? provider;
  Web3Client client = Web3Client(
      'https://goerli.infura.io/v3/3f83d628804547b89b1f7a84ea02cea9',
      http.Client());
  // WCSessionStore? sessionStore;

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

  connectWallet() async {
    final connector = WalletConnect(
      bridge: "https://bridge.walletconnect.org",
      clientMeta: const PeerMeta(
        name: "Boom",
        description: "Boom",
        icons: ["https://boomapp.io/assets/images/logo.png"],
        url: "https://boomapp.io",
      ),
    );
    connector.on('connect', (session) {
      log("Connect $session");
    });

    if (!connector.connected) {
      final session = await connector.createSession(
        chainId: 5,
        onDisplayUri: (uri) async {
          log(uri.toString());
          await launchUrl(Uri.parse(uri));
        },
      );
      connector.connect();
      provider = EthereumWalletConnectProvider(connector, chainId: 5);
      final sender = EthereumAddress.fromHex(session.accounts.first);

      final transaction = Transaction(
        to: EthereumAddress.fromHex(
            "0x6582436697029990185E7073f386769979aDbc14"),
        from: sender,
        gasPrice: EtherAmount.inWei(BigInt.one),
        maxGas: 100000,
        value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 1),
      );
      final credentials = WalletConnectEthereumCredentials(provider: provider!);
      log("Client is sending TX");
      final txBytes = await client.sendTransaction(credentials, transaction);
      log("Here we are");
      connector.connect();
      log(txBytes);

      return txBytes;
    }
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
