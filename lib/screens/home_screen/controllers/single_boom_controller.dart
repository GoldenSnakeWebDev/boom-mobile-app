import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/helpers/file_uploader.dart';
import 'package:boom_mobile/screens/home_screen/models/single_boom_model.dart';
import 'package:boom_mobile/screens/home_screen/services/home_service.dart';
import 'package:boom_mobile/screens/home_screen/services/single_boom_service.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/screens/new_post/controllers/new_post_controller.dart';
import 'package:boom_mobile/utils/boomERC721.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';

class SingleBoomController extends GetxController {
  final box = GetStorage();
  HomeService homeService = HomeService();
  SingleBoomService singleBoomService = SingleBoomService();
  var isLikes = false.obs;
  var isLoves = false.obs;
  var isSmiles = false.obs;
  var isRebooms = false.obs;
  var isReports = false.obs;
  bool commentLoading = false;
  int likesCount = 0;
  int lovesCount = 0;
  int smilesCount = 0;
  int reboomsCount = 0;
  int reportsCount = 0;

  TextEditingController commentController = TextEditingController();
  FocusNode commentFocusNode = FocusNode();

  late String walletAddress, privateKey;
  bool isWalletConnected = false;
  EthereumWalletConnectProvider? provider;
  late Web3Client client;

  int chainId = 97;

  List<int> chainIds = [97, 80001, 65];

  syntheticallyMintBoom(String boomId) async {
    EasyLoading.show(status: "Minting...");
    final format = DateFormat("MM/dd/yyyy, hh:mm:ss a");
    var timeStamp = format.format(DateTime.now());

    final res = await http.post(
      Uri.parse("${baseURL}by-booms-with-sync-coins"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": box.read("token"),
      },
      body: jsonEncode({
        "boom": boomId,
        "timestamp": timeStamp,
      }),
    );
    if (res.statusCode == 200) {
      EasyLoading.dismiss();
      Get.snackbar("Minting", "Boom successfully minted",
          backgroundColor: kPrimaryColor);
      Get.off(() => const MainScreen(), binding: AppBindings());
    } else {
      log(res.body);
      log(boomId);
      log(res.statusCode.toString());

      EasyLoading.dismiss();
      Get.snackbar("Minting", "Boom minting failed",
          backgroundColor: kwarningColor1);
    }
  }

  Future<bool> reactToBoom(
      String reactType, String boomId, SingleBoom boom) async {
    final res = await homeService.reactToBoom(reactType, boomId);

    switch (reactType) {
      case "likes":
        isLikes.value = !isLikes.value;
        break;
      case "loves":
        isLoves.value = !isLoves.value;
        break;
      case "smiles":
        isSmiles.value = !isSmiles.value;
        break;
      case "rebooms":
        isRebooms.value = !isRebooms.value;
        break;
    }
    update();

    if (res.statusCode == 200) {
      await fetchReactionStatus(boom);
      return true;
    } else {
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Could not react to Boom"],
          msg: ["Error"],
          isError: true);
      return false;
    }
  }

  fetchReactionStatus(SingleBoom boom) {
    likesCount = boom.boom.reactions!.likes.length;
    lovesCount = boom.boom.reactions!.loves.length;
    smilesCount = boom.boom.reactions!.smiles.length;
    reboomsCount = boom.boom.reactions!.rebooms.length;
    reportsCount = boom.boom.reactions!.reports.length;

    String userId = box.read("userId");

    for (var item in boom.boom.reactions!.likes) {
      if (item.id == userId) {
        isLikes.value = true;
      } else {
        isLikes.value = false;
      }
    }
    for (var item in boom.boom.reactions!.loves) {
      if (item.id == userId) {
        isLoves.value = true;
      } else {
        isLoves.value = false;
      }
    }
    for (var item in boom.boom.reactions!.smiles) {
      if (item.id == userId) {
        isSmiles.value = true;
      } else {
        isSmiles.value = false;
      }
    }
    for (var item in boom.boom.reactions!.reports) {
      if (item.id == userId) {
        isReports.value = true;
      } else {
        isReports.value = false;
      }
    }
    for (var item in boom.boom.reactions!.rebooms) {
      if (item.id == userId) {
        isRebooms.value = true;
      } else {
        isRebooms.value = false;
      }
    }

    update();
  }

  commentOnPost(String text, String boomId) async {
    commentLoading = true;

    String token = box.read("token");

    var d12 = DateFormat('MM-dd-yyyy, hh:mm a').format(DateTime.now());
    Map<String, dynamic> body = {
      "message": text,
      "timestamp": d12,
    };
    var res = await http.post(Uri.parse("${baseURL}booms/$boomId/comments"),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(body));
    if (res.statusCode == 201) {
      commentLoading = false;

      commentController.clear();
    } else {
      commentLoading = false;
      log(res.body);
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Could not comment on Boom"],
          msg: ["Error"],
          isError: true);
    }
  }

  refreshPage() {
    singleBoomService.getSingleBoom();
    update();
  }

  /// Polygon Metamask URI- wc:35fd85572c6887ced1c5fa89bfaa99ba8aab40346dbe3d3b1494fce1c7309fc0@2?relay-protocol=irn&symKey=d41ade7149b82d8fa2f9bb26a2e1cb5cd29ca72d3bdb80ae576805f1d1f3bcb6
  /// BSC URI wc:8ea7eb7ac1a11841c3693de94f0e10366af92d0d125622b5c93c49f4917771b7@2?relay-protocol=irn&symKey=00344de55036afcca4a149d9dc001369c8a5dd4f1e3864b2b974512fafa50baa
  ///

  exportBoom(String selNetwork, String imgURL, String name, String desc,
      String boomId) async {
    String contractAddy = '';
    switch (selNetwork) {
      case "MATIC":
        chainId = chainIds[1];
        contractAddy = "0xa4F716c2812652b4d49F7CF3220A211FE89587eE";
        client = Web3Client(
          'https://matic-mumbai.chainstacklabs.com',
          http.Client(),
        );
        update();
        break;
      case "BNB":
        chainId = chainIds[0];
        contractAddy = "0x61ceeb2f2a5915e997d0969c1d790af1a938ffd6";
        client = Web3Client(
          'https://data-seed-prebsc-2-s1.binance.org:8545',
          http.Client(),
        );
        update();
        break;

      case "OKT":
        chainId = chainIds[2];
        contractAddy = "0xfbC908Cf9E63c63F8Ca9Bc102713aCe8F8Eba4F7";
        client = Web3Client(
          'https://exchaintestrpc.okex.org',
          http.Client(),
        );
        update();
        break;
      default:
        chainId = chainIds[1];
    }

    late WalletConnectEthereumCredentials credentials;
    final connector = WalletConnect(
      bridge: "https://bridge.walletconnect.org",
      // uri: rpc,
      clientMeta: const PeerMeta(
        name: "Boom",
        description: "Boom",
        icons: [boomIconUrl],
        url: "https://www.boooooooooom.com/",
      ),
    );

    // connector.connect(chainId: chainId);

    log("Chain ID Selected: $chainId");

    if (connector.connected) {
      log("Wallet connection already done");
      connector.on('connect', (SessionStatus session) {
        provider = EthereumWalletConnectProvider(connector, chainId: chainId);
        // final sender = EthereumAddress.fromHex(session.accounts.first);

        credentials = WalletConnectEthereumCredentials(provider: provider!);
      });

      await mintNFT(credentials.provider.connector.session.accounts.first,
          contractAddy, imgURL, name, desc, boomId, client, credentials);

      return credentials.provider.connector.session.accounts.first;
    } else {
      log("Wallet connection Not done yet");
      await connector.createSession(
        chainId: chainId,
        onDisplayUri: (uri) async {
          final launchUri = 'metamask://wc?uri=$uri';
          await launchUrlString(launchUri);
          log("Metamask URI::: $launchUri");

          connector.on('connect', (SessionStatus session) async {
            log("Chain ID Selected: ${session.chainId}");
            if (session.chainId != chainId) {
              await connector.connect(chainId: chainId);
            }
            provider =
                EthereumWalletConnectProvider(connector, chainId: chainId);
            final sender = EthereumAddress.fromHex(session.accounts.first);
            final credentials =
                WalletConnectEthereumCredentials(provider: provider!);
            log("Sender $sender");
            await mintNFT(session.accounts.first, contractAddy, imgURL, name,
                desc, boomId, client, credentials);
            // return credentials.provider.connector.session.accounts.first;
          });
        },
      );
    }
  }

  mintNFT(
      String addy,
      String contractAddy,
      String imgURL,
      String name,
      String desc,
      String boomId,
      Web3Client web3Client,
      WalletConnectEthereumCredentials credentials) async {
    late File nftImg;

    try {
      final nftDetails = {
        "name": name,
        "description": desc,
        "image": imgURL,
      };

      Directory dir = await getApplicationDocumentsDirectory();
      String filePath = '';
      filePath = '${dir.path}/$boomId.json';

      nftImg = File(filePath);
      nftImg.writeAsStringSync(json.encode(nftDetails));

      String tokenURI = await FileUploader().uploadPhoto(nftImg, "");

      //Call Boom ERC721 contract

      // BSC-Addy- 0x61ceeb2f2a5915e997d0969c1d790af1a938ffd6
      // Matic-Addy- 0xa4F716c2812652b4d49F7CF3220A211FE89587eE
      // OKT-Addy- 0xfbC908Cf9E63c63F8Ca9Bc102713aCe8F8Eba4F7

      EthereumAddress account = EthereumAddress.fromHex(addy);

      EthereumAddress contractAddress = EthereumAddress.fromHex(contractAddy);

      EasyLoading.show(status: 'Exporting... Please check your wallet app');

      var contract = DeployedContract(
        ContractAbi.fromJson(boomSmartContract, 'BoomERC721'),
        contractAddress,
      );

      String hashResult = '';

      try {
        Transaction tx = Transaction(
          from: account,
          to: contractAddress,
          data: contract.function('mintTo').encodeCall(
            [account, tokenURI],
          ),
        );

        hashResult = await web3Client.sendTransaction(
          credentials,
          tx,
          chainId: chainId,
        );

        int txCount = await web3Client.getTransactionCount(account);
        EasyLoading.dismiss();
        log("Result ${hashResult.isEmpty ? "No Result" : "$hashResult\n ${hashResult.length}"}");
        log("TX Count $txCount");
        // await subscription.cancel();
        await client.dispose();
      } catch (e) {
        log("Error ${e.toString()}");
        EasyLoading.dismiss();
        Get.snackbar("Error", e.toString());
      }
    } catch (e) {
      log("Error ${e.toString()}");
      EasyLoading.dismiss();
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Error exporting Boom as NFT"],
          msg: ["Export Error"],
          isError: true);
    }
  }

  obtainBoom() async {}

  viewBoomContract() async {}

  reportBoom() async {}
}
