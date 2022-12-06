import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/models/network_model.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/screens/new_post/controllers/instagram_web_controller.dart';
import 'package:boom_mobile/screens/new_post/models/new_post_model.dart';
import 'package:boom_mobile/screens/new_post/services/upload_boom.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/edit_profile_controller.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/erc721.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/crypto.dart';

import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

enum POST_TYPE { image, video, text }

class NewPostController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  File? pickedImage;
  XFile? video;
  File? pickedVideo;
  UploadService uploadService = UploadService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController boomText = TextEditingController();
  TextEditingController tags = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController fixedPrice = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController nftContractAddress = TextEditingController();
  TextEditingController nftId = TextEditingController();

  NetworkModel? networkModel = Get.find<MainScreenController>().networkModel;
  late VideoPlayerController selectedVideoController;

  String? selectedNetwork;
  double priceValue = 0.0;
  var cryptoAmount = '0.00'.obs;
  Network? selectedNetworkModel;
  List<Network> networks = [];
  final igController = Get.find<InstagramWebController>();
  // late WCClient wcClient;
  late InAppWebViewController webViewController;
  late String walletAddress, privateKey;
  bool isWalletConnected = false;
  EthereumWalletConnectProvider? provider;
  Web3Client client = Web3Client(
    'https://polygon-mumbai.infura.io/v3/3f83d628804547b89b1f7a84ea02cea9',
    http.Client(),
  );
  // WCSessionStore? sessionStore;

  String rpc =
      'https://link.trustwallet.com/wc?uri=wc%3Aca1fccc0-f4d1-46c2-90b7-c07fce1c0cae%401%3Fbridge%3Dhttps%253A%252F%252Fbridge.walletconnect.org%26key%3Da413d90751839c7628873557c718fd73fcedc5e8e8c07cfecaefc0d3a178b1d8';
  final web3Client = Web3Client(
      "https://link.trustwallet.com/wc?uri=wc%3Aca1fccc0-f4d1-46c2-90b7-c07fce1c0cae%401%3Fbridge%3Dhttps%253A%252F%252Fbridge.walletconnect.org%26key%3Da413d90751839c7628873557c718fd73fcedc5e8e8c07cfecaefc0d3a178b1d8",
      http.Client());

  // final File abiFile = File('assets/files/erc721.json');

  @override
  void onInit() {
    super.onInit();
    selectedNetwork = networkModel!.networks![0].symbol;
    selectedNetworkModel = networkModel!.networks![0];
    networks.clear();
    for (var element in networkModel!.networks!) {
      networks.add(element);
    }
    getCryptoPrice(selectedNetworkModel!.symbol!);
    // image = null;
    // pickedImage = null;

    log("Ig Post ${igController.selectedIgMedia?.id}");
  }

  changeChain(String value) {
    selectedNetwork = value;
    for (var element in networkModel!.networks!) {
      if (element.symbol == value) {
        selectedNetworkModel = element;
      }
    }
    getCryptoPrice(selectedNetworkModel!.symbol!);
    // getCryptoPrice(selectedNetworkModel!.symbol!);

    update();
  }

  getCryptoPrice(String cryptoName) async {
    final res = await http.get(
        Uri.parse("${baseURL}networks-pricing?symbol=$cryptoName&amount=1"));

    log("Crypto Res ${res.body}");

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      priceValue = double.parse(data['currentUSDPrice'].toString());
      getCryptoAmount(price.text.trim());
      update();
    }
  }

  getCryptoAmount(String fiatAmount) {
    if (fiatAmount.isNotEmpty) {
      log("Fiat Amount $priceValue");
      cryptoAmount.value = (double.parse(fiatAmount.toString()) /
              double.parse(priceValue.toString()))
          .toStringAsFixed(2);
      update();
    }
    return cryptoAmount;
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

  handlePickingVideo() async {
    video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      pickedVideo = File(video!.path);
      selectedVideoController = VideoPlayerController.file(pickedVideo!)
        ..initialize().then((_) {
          update();
        });
    }
    update();
  }

  handleRecordingVideo() async {
    video = await _picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      pickedVideo = File(video!.path);
      selectedVideoController = VideoPlayerController.file(pickedVideo!)
        ..initialize().then((_) {
          update();
        });
    }
    update();
  }

  fetchNFT() async {
    EasyLoading.show(status: 'loading...');
    Web3Client client = Web3Client(
        "https://polygon-mumbai.infura.io/v3/3f83d628804547b89b1f7a84ea02cea9",
        http.Client());

    EthereumAddress account =
        EthereumAddress.fromHex("0xE777148e471B5ffc5cbB61c0D00843Ce919eb997");

    // var addy = await connectWallet();
    // walletAddress = addy.toString();

    // log("Wallet Address $walletAddress");
    // // final abiCode = await abiFile.readAsString();
    var contract = DeployedContract(
        ContractAbi.fromJson(polygonSmartContract, 'MFNT'),
        EthereumAddress.fromHex(nftContractAddress.text));
    var balance = await client.call(
        contract: contract,
        function: contract.function('balanceOf'),
        params: [
          EthereumAddress.fromHex("0xE777148e471B5ffc5cbB61c0D00843Ce919eb997")
        ]);

    log("Wallet Balance ${BigInt.from(balance[0])}");

    if ("${balance[0]}" != "0") {
      var tokenURI = await client.call(
          contract: contract,
          function: contract.function('tokenURI'),
          params: [nftId.text.trim()]);
      log("Token URI $tokenURI");
    }

    EasyLoading.dismiss();
  }

  connectWallet() async {
    late WalletConnectEthereumCredentials credentials;
    final connector = WalletConnect(
      bridge: "https://bridge.walletconnect.org",
      clientMeta: const PeerMeta(
        name: "Boom",
        description: "Boom",
        icons: [boomIconUrl],
        url: "https://boomapp.io",
      ),
    );
    connector.connect();

    if (connector.connected) {
      for (var element in connector.session.accounts) {
        log("Wallet Address $element");
      }
      log("Wallet is already connected ${connector.session.accounts.first}");

      connector.on('connect', (SessionStatus session) {
        provider = EthereumWalletConnectProvider(connector, chainId: 80001);
        final sender = EthereumAddress.fromHex(session.accounts.first);

        credentials = WalletConnectEthereumCredentials(provider: provider!);
        log("Sender $sender");
      });

      // final transaction = Transaction(
      //   to: EthereumAddress.fromHex(
      //       "0x6582436697029990185E7073f386769979aDbc14"),
      //   from: sender,
      //   gasPrice: EtherAmount.inWei(BigInt.one),
      //   maxGas: 100000,
      //   value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 1),
      // );

      // log("Client is sending TX");
      // final txBytes = await client.sendTransaction(credentials, transaction);
      // log("Here we are");
      // connector.connect();
      // log(txBytes);

      return credentials.provider.connector.session.accounts.first;
    } else {
      log("Wallet connection Not done yet");
      final session = await connector.createSession(
        chainId: 80001,
        onDisplayUri: (uri) async {
          log(uri.toString());
          await launchUrl(Uri.parse(uri));
          await connector.connect(chainId: 80001);
        },
      );
      await connector.connect(chainId: 80001);
      log("Attempting to connect");
      connector.on('connect', (SessionStatus session) {
        provider = EthereumWalletConnectProvider(connector, chainId: 80001);
        final sender = EthereumAddress.fromHex(session.accounts.first);
        final credentials =
            WalletConnectEthereumCredentials(provider: provider!);
        log("Sender $sender");
        return credentials.provider.connector.session.accounts.first;
      });
      log("App jumped to this place");
    }
  }

  uploadNewBoom() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: "Uploading");
      String postType = '';
      String imgURL = '';
      if (pickedImage == null && pickedVideo == null) {
        postType = 'text';
      } else if (pickedImage != null && pickedVideo == null) {
        postType = 'image';
      } else {
        postType = 'video';
      }
      // pickedImage == null && boomText.text.trim().isNotEmpty
      //     ? postType = 'text'
      //     : postType = 'image';
      if (postType == 'image') {
        imgURL = await EditProfileController().uploadPhoto(pickedImage!, "");
      } else if (postType == "video") {
        imgURL = await EditProfileController().uploadVideo(pickedVideo!, "");
      } else {
        imgURL = boomText.text.trim();
      }

      log("Boom Type $postType");
      var d12 = DateFormat('MM-dd-yyyy, hh:mm a').format(DateTime.now());
      NewPostModel newPostModel = NewPostModel(
        boomType: postType,
        network: selectedNetworkModel!.id!,
        description: description.text.trim(),
        title: title.text.trim(),
        imageUrl: imgURL,
        quantity: quantity.text.trim(),
        tags: tags.text.trim(),
        location: location.text.trim(),
        fixedPrice: price.text.trim(),
        price: price.text.trim(),
        timestamp: d12,
      );

      final res = await uploadService.uploadPost(newPostModel);

      if (res.statusCode == 201) {
        CustomSnackBar.showCustomSnackBar(
            errorList: [""], msg: [""], isError: false);
        Get.offAll(() => const MainScreen(), binding: AppBindings());
      } else {
        log(res.body);
        List<String> errors = [];
        for (var item in jsonDecode(res.body)["errors"]) {
          errors.add(item["message"]);
        }
        CustomSnackBar.showCustomSnackBar(
            errorList: errors, msg: [""], isError: true);
      }
      EasyLoading.dismiss();
    }
  }
}

class WalletConnectEthereumCredentials extends CustomTransactionSender {
  final EthereumWalletConnectProvider provider;
  WalletConnectEthereumCredentials({required this.provider});

  @override
  Future<EthereumAddress> extractAddress() async {
    // TODO: implement extractAddress
    return EthereumAddress.fromHex(provider.connector.session.accounts.first);
    // throw UnimplementedError();
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
      {int? chainId, bool isEIP1559 = false}) async {
    // TODO: implement signToSignature

    var signature = MsgSignature(BigInt.one, BigInt.two, chainId!);
    return signature;
  }
}
