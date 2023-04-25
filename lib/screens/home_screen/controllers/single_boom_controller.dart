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
  bool isLikes = false;
  bool isLoves = false;
  bool isSmiles = false;
  bool isRebooms = false;
  bool isReports = false;
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

    final res = await http.post(
      Uri.parse("${baseURL}by-booms-with-sync-coins"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": box.read("token"),
      },
      body: jsonEncode({
        "boom": boomId,
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

  Future<bool> reactToBoom(String reactType, String boomId) async {
    final res = await homeService.reactToBoom(reactType, boomId);

    if (res.statusCode == 200) {
      log("Boom Reacted To : $reactType");
      log("message: ${res.body}");
      update();
      return true;
    } else {
      log("Reaction Body ${res.body}");
      log("Reaction Code ${res.statusCode}");
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
        isLikes = true;
      } else {
        isLikes = false;
      }
    }
    for (var item in boom.boom.reactions!.loves) {
      if (item.id == userId) {
        isLoves = true;
      } else {
        isLoves = false;
      }
    }
    for (var item in boom.boom.reactions!.smiles) {
      if (item.id == userId) {
        isSmiles = true;
      } else {
        isSmiles = false;
      }
    }
    for (var item in boom.boom.reactions!.reports) {
      if (item.id == userId) {
        isReports = true;
      } else {
        isReports = false;
      }
    }
    for (var item in boom.boom.reactions!.rebooms) {
      if (item.id == userId) {
        isRebooms = true;
      } else {
        isRebooms = false;
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

  exportBoom(String selNetwork, String imgURL, String name, String desc,
      String boomId) async {
    log("Selected Network $selNetwork");
    switch (selNetwork) {
      case "MATIC":
        chainId = chainIds[1];
        client = Web3Client(
          'https://matic-mumbai.chainstacklabs.com',
          http.Client(),
        );
        update();
        break;
      case "BNB":
        chainId = chainIds[0];
        client = Web3Client(
          'https://data-seed-prebsc-2-s1.binance.org:8545',
          http.Client(),
        );
        update();
        break;

      case "OKT":
        chainId = chainIds[2];
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
        url: "https://boomapp.io",
      ),
    );
    connector.connect(chainId: chainId);

    if (connector.connected) {
      connector.on('connect', (SessionStatus session) {
        provider = EthereumWalletConnectProvider(connector, chainId: chainId);
        final sender = EthereumAddress.fromHex(session.accounts.first);

        credentials = WalletConnectEthereumCredentials(provider: provider!);
      });

      await mintNFT(credentials.provider.connector.session.accounts.first,
          imgURL, name, desc, boomId, client, credentials);

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
            await mintNFT(session.accounts.first, imgURL, name, desc, boomId,
                client, credentials);
            // return credentials.provider.connector.session.accounts.first;
          });
        },
      );
    }
  }

  mintNFT(
      String addy,
      String imgURL,
      String name,
      String desc,
      String boomId,
      Web3Client web3Client,
      WalletConnectEthereumCredentials credentials) async {
    late File nftImg;
    // late WalletConnectEthereumCredentials credentials;
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

      log("Token URI $tokenURI");

      //Call Boom ERC721 contract

      EthereumAddress account = EthereumAddress.fromHex(addy);

      EthereumAddress contractAddress =
          EthereumAddress.fromHex("0x61ceeb2f2a5915e997d0969c1d790af1a938ffd6");

      EasyLoading.show(status: 'Exporting... Please check your wallet app');

      var contract = DeployedContract(
        ContractAbi.fromJson(boomSmartContract, 'BoomERC721'),
        contractAddress,
      );
      // List<dynamic> result = [];

      String hashResult = '';

      // final mintToEvent = contract.event('mintTo');

      // final subscription = client
      //     .events(FilterOptions.events(contract: contract, event: mintToEvent))
      //     .take(1)
      //     .listen((event) {
      //   final decoded = mintToEvent.decodeResults(event.topics!, event.data!);

      //   final from = decoded[0] as EthereumAddress;
      //   final to = decoded[1] as EthereumAddress;
      //   final value = decoded[2] as BigInt;

      //   log("message from $from to $to: $value");
      // });

      try {
        Transaction tx = Transaction(
          from: account,
          to: contractAddress,
          data: contract.function('mintTo').encodeCall(
            [account, tokenURI],
          ),
        );

        // credentials = WalletConnectEthereumCredentials(provider: provider!);

        // await web3Client.signTransaction(credentials, tx);

        hashResult = await web3Client.sendTransaction(
          credentials,
          tx,
          chainId: chainId,
        );

        // await subscription.asFuture();

        // result = await web3Client.call(
        //   sender: account,
        //   contract: contract,
        //   function: contract.function('mintTo'),
        //   params: [account, tokenURI],
        // );

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
