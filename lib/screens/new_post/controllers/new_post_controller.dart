import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/models/network_model.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/screens/new_post/controllers/instagram_web_controller.dart';
import 'package:boom_mobile/screens/new_post/models/new_post_model.dart';
import 'package:boom_mobile/screens/new_post/models/wallet_nft.dart';
import 'package:boom_mobile/screens/new_post/services/upload_boom.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/edit_profile_controller.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/erc721.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
  File? importedNFT;
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
  late Web3Client client;

  var imageSelected = false.obs;
  // WCSessionStore? sessionStore;

  // String rpc = 'https://matic-testnet-archive-rpc.bwarelabs.com';

  int chainId = 56;

  List<int> chainIds = [56, 137];
  // final web3Client = Web3Client(
  //   "https://link.trustwallet.com/wc?uri=wc%3Aca1fccc0-f4d1-46c2-90b7-c07fce1c0cae%401%3Fbridge%3Dhttps%253A%252F%252Fbridge.walletconnect.org%26key%3Da413d90751839c7628873557c718fd73fcedc5e8e8c07cfecaefc0d3a178b1d8",
  //   http.Client(),
  // );

  // final File abiFile = File('assets/files/erc721.json');

  @override
  void onInit() {
    super.onInit();
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    analytics.setCurrentScreen(screenName: "New Post Screen");
    selectedNetwork = networkModel!.networks![0].symbol;
    selectedNetworkModel = networkModel!.networks![0];
    client = Web3Client(
      'https://bsc-dataseed1.binance.org/',
      http.Client(),
    );
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
        switch (value) {
          case "MATIC":
            chainId = chainIds[1];
            client = Web3Client(
              'https://polygon-mainnet.infura.io/v3/3f83d628804547b89b1f7a84ea02cea9',
              http.Client(),
            );
            break;
          case "BNB":
            chainId = chainIds[0];
            client = Web3Client(
              'https://bsc-dataseed1.binance.org/',
              http.Client(),
            );
            break;
          default:
            chainId = chainIds[1];
        }
      }
    }
    getCryptoPrice(selectedNetworkModel!.symbol!);
    // getCryptoPrice(selectedNetworkModel!.symbol!);

    log("Selected chain ${client.getChainId()}");

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

    imageSelected.value = true;
    update();
  }

  handlePickingImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image!.path);
      imageSelected.value = true;
    }
    update();
  }

  handleTakingPhoto() async {
    image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedImage = File(image!.path);
      imageSelected.value = true;
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

  fetchNFT(String addy) async {
    log("Starting on connection");

    // Web3Client client = Web3Client(
    //   "https://matic-testnet-archive-rpc.bwarelabs.com",
    //   http.Client(),
    // );
    log("Account $addy");
    EthereumAddress account = EthereumAddress.fromHex(addy);

    // var addy = await connectWallet();
    // walletAddress = addy.toString();

    // log("Wallet Address $walletAddress");
    // // final abiCode = await abiFile.readAsString();
    EasyLoading.show(status: 'loading...');
    var contract = DeployedContract(
      ContractAbi.fromJson(polygonSmartContract, 'MFNFT'),
      EthereumAddress.fromHex(nftContractAddress.text),
    );
    List<dynamic> balance = [];
    try {
      balance = await client.call(
        contract: contract,
        function: contract.function('balanceOf'),
        params: [account],
      );
    } catch (e) {
      log("Error ${e.toString()}");
      EasyLoading.dismiss();
      Get.snackbar("Error", e.toString());
    }

    // log("Wallet Balance ${BigInt.from(balance[0])}");
    int bigValue = balance[0].toInt();
    // log("Valid Int ${bigValue.runtimeType}");
    try {
      if (bigValue > 0) {
        var tokenURI = await client.call(
          contract: contract,
          function: contract.function('tokenURI'),
          params: [
            BigInt.from(
              double.parse(
                nftId.text.trim(),
              ),
            ),
          ],
        );
        String token = tokenURI[0].toString();

        if (tokenURI[0].toString().startsWith("ipfs://")) {
          tokenURI[0] =
              "https://ipfs.io/ipfs/${tokenURI[0].toString().replaceAll("ipfs://", "")}";
          final res = await http.get(Uri.parse(tokenURI[0]));

          if (res.statusCode == 200) {
            var result = jsonDecode(res.body)["image"];
            token = "https://ipfs.io/ipfs/${result.toString().split("/").last}";
          }
        }

        final res = await http.get(Uri.parse(token));

        if (res.statusCode == 200) {
          WalletNft data = WalletNft.fromJson(jsonDecode(res.body));
          HttpClient client = HttpClient();
          try {
            EasyLoading.show(status: "Downloading Image");
            var request = await client.getUrl(Uri.parse(data.image));
            var response = await request.close();
            if (response.statusCode == 200) {
              var bytes = await consolidateHttpClientResponseBytes(response);
              Directory dir = await getApplicationDocumentsDirectory();
              String filePath = '';
              filePath = '${dir.path}/${data.name}.jpg';

              importedNFT = File(filePath);
              await importedNFT!.writeAsBytes(bytes);

              EasyLoading.dismiss();
              pickedImage = importedNFT;

              title.text = data.name;
              description.text = data.description;
              imageSelected.value = true;
              update();
              Get.back();
            } else {
              CustomSnackBar.showCustomSnackBar(
                  errorList: ["Error Downloading Image"],
                  msg: ["Error"],
                  isError: true);
            }
          } catch (e) {
            CustomSnackBar.showCustomSnackBar(
                errorList: ["Error downloading image $e"],
                msg: ["Download Error"],
                isError: true);
          }
        }
        log("Token URI ${tokenURI[0]}");
      }
      EasyLoading.dismiss();
    } catch (e) {
      log(e.toString());
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Error fetching NFT. $e"],
          msg: ["Download Error"],
          isError: true);
      EasyLoading.dismiss();
    }
  }

  connectWallet() async {
    log("Chain ID $chainId");
    late WalletConnectEthereumCredentials credentials;
    final connector = WalletConnect(
      bridge: "https://bridge.walletconnect.org",
      // uri: rpc,
      clientMeta: const PeerMeta(
        name: "Boom",
        description: "Boom",
        icons: [boomIconUrl],
        url: "https://boomapp.io",
      ),
    );
    connector.connect(chainId: chainId);

    if (connector.connected) {
      for (var element in connector.session.accounts) {
        log("Wallet Address $element");
      }
      log("Wallet is already connected ${connector.session.accounts.first}");

      connector.on('connect', (SessionStatus session) {
        provider = EthereumWalletConnectProvider(connector, chainId: chainId);
        final sender = EthereumAddress.fromHex(session.accounts.first);

        credentials = WalletConnectEthereumCredentials(provider: provider!);
        log("Sender connected $sender");
      });

      await fetchNFT(credentials.provider.connector.session.accounts.first);

      return credentials.provider.connector.session.accounts.first;
    } else {
      log("Wallet connection Not done yet");
      final session = await connector.createSession(
        chainId: chainId,
        onDisplayUri: (uri) async {
          final launchUri = 'metamask://wc?uri=$uri';
          await launchUrlString(launchUri);
          log("Metamask URI::: $launchUri");
          // await connector.connect(chainId: chainId);

          connector.on('connect', (SessionStatus session) async {
            provider =
                EthereumWalletConnectProvider(connector, chainId: chainId);
            final sender = EthereumAddress.fromHex(session.accounts.first);
            final credentials =
                WalletConnectEthereumCredentials(provider: provider!);
            log("Sender $sender");
            await fetchNFT(session.accounts.first);
            return credentials.provider.connector.session.accounts.first;
          });
        },
      );
      // await connector.connect(
      //   onDisplayUri: ((uri) async {
      //     await launchUrlString(uri);
      //     connector.on('connect', (SessionStatus session) {
      //       provider =
      //           EthereumWalletConnectProvider(connector, chainId: chainId);
      //       final sender = EthereumAddress.fromHex(session.accounts.first);
      //       final credentials =
      //           WalletConnectEthereumCredentials(provider: provider!);
      //       log("Sender $sender");
      //       return credentials.provider.connector.session.accounts.first;
      //     });
      //   }),
      // );
      // log("Attempting to connect");
      // connector.on('connect', (SessionStatus session) {
      //   provider = EthereumWalletConnectProvider(connector, chainId: chainId);
      //   final sender = EthereumAddress.fromHex(session.accounts.first);
      //   final credentials =
      //       WalletConnectEthereumCredentials(provider: provider!);
      //   log("Sender $sender");
      //   return credentials.provider.connector.session.accounts.first;
      // });
      // log("App jumped to this place");
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

      String longTag = tags.text.trim().replaceAll(" ", "@");
      List<String> tagList = longTag.split("@").toList();
      String tagString = tagList.join(",");

      NewPostModel newPostModel = NewPostModel(
        boomType: postType,
        network: selectedNetworkModel!.id!,
        description: description.text.trim(),
        title: title.text.trim(),
        imageUrl: imgURL,
        quantity: quantity.text.trim(),
        tags: tagString,
        location: location.text.trim(),
        fixedPrice: price.text.trim(),
        price: cryptoAmount.value.toString(),
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
    var signature = MsgSignature(BigInt.one, BigInt.two, chainId!);
    return signature;
  }

  @override
  EthereumAddress get address =>
      EthereumAddress.fromHex(provider.connector.session.accounts.first);

  @override
  MsgSignature signToEcSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToEcSignature
    throw UnimplementedError();
  }
}
