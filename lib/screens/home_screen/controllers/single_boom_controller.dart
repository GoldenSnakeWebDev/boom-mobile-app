import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/screens/home_screen/models/single_boom_model.dart';
import 'package:boom_mobile/screens/home_screen/services/home_service.dart';
import 'package:boom_mobile/screens/home_screen/services/single_boom_service.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/screens/new_post/controllers/new_post_controller.dart';
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

  int chainId = 56;

  List<int> chainIds = [56, 137];

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

  exportBoom(String selNetwork) async {
    switch (selNetwork) {
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

      case "OKT":
        chainId = chainIds[2];
        client = Web3Client(
          'https://exchaintestrpc.okex.org',
          http.Client(),
        );
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

      await mintNFT(credentials.provider.connector.session.accounts.first);

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
            await mintNFT(session.accounts.first);
            return credentials.provider.connector.session.accounts.first;
          });
        },
      );
    }
  }

  mintNFT(String addy) async {}

  obtainBoom() async {}

  viewBoomContract() async {}

  reportBoom() async {}
}
