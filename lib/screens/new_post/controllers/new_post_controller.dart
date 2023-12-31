import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/helpers/file_uploader.dart';
import 'package:boom_mobile/models/network_model.dart';
import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/home_screen/home_screen.dart';
import 'package:boom_mobile/screens/new_post/models/blockchain.dart';
import 'package:boom_mobile/screens/new_post/models/blockchain_accounts.dart';
import 'package:boom_mobile/screens/new_post/models/eip155_wallet_credentials.dart';
import 'package:boom_mobile/screens/new_post/models/explorer_registry_listing.dart';
import 'package:boom_mobile/screens/new_post/models/new_post_model.dart';
import 'package:boom_mobile/screens/new_post/models/wallet_connect_extensions.dart';
import 'package:boom_mobile/screens/new_post/models/wallet_nft.dart';
import 'package:boom_mobile/screens/new_post/models/wallet_pairing.dart';
import 'package:boom_mobile/screens/new_post/services/explorer_registry_service.dart';
import 'package:boom_mobile/screens/new_post/services/upload_boom.dart';
import 'package:boom_mobile/screens/new_post/services/wc_service.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/edit_profile_controller.dart';
import 'package:boom_mobile/secrets.dart';
import 'package:boom_mobile/utils/boomERC721.dart';
import 'package:boom_mobile/utils/boomMarketPlace.dart';
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
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/web3dart.dart';

enum POST_TYPE { image, video, text }

class NewPostController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  File? pickedImage;
  XFile? video;
  File? pickedVideo;
  File? importedNFT;
  UploadService uploadService = UploadService();
  final ExplorerRegistryService explorerRegistryService =
      ExplorerRegistryService();

  WalletConnectService wcService = WalletConnectService();

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
  TextEditingController nftURI = TextEditingController();

  NetworkModel? networkModel = Get.find<HomeController>().networkModel;
  late VideoPlayerController selectedVideoController;

  String? selectedNetwork;
  double priceValue = 0.0;
  var cryptoAmount = '0.00'.obs;
  Network? selectedNetworkModel;
  List<Network> networks = [];
  late InAppWebViewController webViewController;
  late String walletAddress, privateKey;
  bool isWalletConnected = false;
  EthereumWalletConnectProvider? provider;
  late TargetPlatform targetPlatform;
  late Web3Client client;
  late Web3App _web3app;
  late RequiredNamespace eip155RequiredNamespace;
  late RequiredNamespace eip155OptionalNamespace;
  List<Blockchain> reqiredBlockchains = [Blockchain.bnb];
  List<Blockchain> optionalBlockchains = [Blockchain.bnb, Blockchain.polygon];

  Map<String, WalletPairingInfo> walletPairingInfoMap = {};
  ExplorerRegistryListing selectedRegistryListing =
      const ExplorerRegistryListing();

  List<ExplorerRegistryListing> explorerRegistryListings = [];

  var imageSelected = false.obs;

  int chainId = 97;
  // String smartContractAddress = bnbTestNetToken;
  // String marketPlaceAddress = bnbTestNetMarket;

  String smartContractAddress = bnbTokenAddress;
  String marketPlaceAddress = bnbMarketAddress;

  List<int> chainIds = [56, 137, 65];

  // List<int> chainIds = [97, 80001, 65];

  String txHash = "";

  @override
  void onInit() {
    super.onInit();
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    analytics.setCurrentScreen(screenName: "New Post Screen");
    selectedNetwork = networkModel!.networks![0].symbol;
    selectedNetworkModel = networkModel!.networks![0];
    networks.clear();
    for (var element in networkModel!.networks!) {
      networks.add(element);
    }
    getCryptoPrice(selectedNetworkModel!.symbol!);

    init(
        targetPlatform:
            Platform.isAndroid ? TargetPlatform.android : TargetPlatform.iOS);

    // image = null;
    // pickedImage = null;
  }

  @override
  void onClose() {
    super.onClose();
    pickedImage = null;
    pickedVideo = null;
    // selectedVideoController.dispose();
    wcService.disconnectAllPairings(web3app: _web3app);
    // pickedImage = null;
    // pickedVideo = null;
    // selectedVideoController.dispose();
  }

  Future<void> init({required TargetPlatform targetPlatform}) async {
    this.targetPlatform = targetPlatform;

    _web3app = await Web3App.createInstance(
      projectId: WALLET_CONNECT_ID,
      metadata: const PairingMetadata(
        name: "Boom",
        description: "Boom",
        icons: [boomIconUrl],
        url: redirectUri,
      ),
      memoryStore: false,
      relayUrl: WalletConnectConstants.DEFAULT_RELAY_URL,
      logLevel: LogLevel.nothing, // Level.verbose,
    );

    //TODO: Change the RPC selection
    client = Web3Client(
      bnbMainnetRPC,
      http.Client(),
    );

    eip155RequiredNamespace = RequiredNamespace(
        chains: supportedBlockchainsToCAIP2List(
            namespace: Blockchain.bnb.namespace),
        methods: kAppRequiredEIP155Methods,
        events: kAppOptionalEIP155Events);

    eip155OptionalNamespace = RequiredNamespace(
      chains: supportedBlockchainsToCAIP2List(
          namespace: Blockchain.polygon.namespace),
      methods: kAppOptionalEIP155Methods,
      events: kAppOptionalEIP155Events,
    );

    wcService.init(
      platform: targetPlatform,
      web3app: _web3app,
      core: _web3app.signEngine.core,
    );

    update();
  }

  // Handle changing of selected network/crypto

  changeChain(String value) async {
    selectedNetwork = value;
    for (var element in networkModel!.networks!) {
      if (element.symbol == value) {
        selectedNetworkModel = element;
        switch (value) {
          case "MATIC":
            chainId = chainIds[1];
            smartContractAddress = maticTokenAddress;
            marketPlaceAddress = maticMarketAddress;
            client = Web3Client(
              maticMainnetRPC,
              http.Client(),
            );
            break;
          case "BNB":
            chainId = chainIds[0];
            smartContractAddress = bnbTokenAddress;
            marketPlaceAddress = bnbMarketAddress;
            client = Web3Client(
              bnbMainnetRPC,
              http.Client(),
            );
            break;

          case "OKT":
          // chainId = chainIds[2];
          // smartContractAddress = "0xfbC908Cf9E63c63F8Ca9Bc102713aCe8F8Eba4F7";
          // client = Web3Client(
          //   'https://exchaintestrpc.okex.org',
          //   http.Client(),
          // );
          // break;
          default:
            chainId = chainIds[1];
        }
        update();
      }
    }
    getCryptoPrice(selectedNetworkModel!.symbol!);
    // getCryptoPrice(selectedNetworkModel!.symbol!);

    update();
  }

  //Function to get current price of selected crypto

  getCryptoPrice(String cryptoName) async {
    final res = await http.get(
        Uri.parse("${baseURL}networks-pricing?symbol=$cryptoName&amount=1"));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      priceValue = double.parse(data['currentUSDPrice'].toString());
      getCryptoAmount(price.text.trim());
      update();
    }
  }

  //Function to convert Fiat to Crypto

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

  //Function to handle selecting image from list
  fetchImageFromIG(File image) {
    pickedImage = image;

    imageSelected.value = true;
    update();
  }

  // Function to handle picking image from phone

  handlePickingImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image!.path);
      imageSelected.value = true;
    }
    update();
  }

  // Function to handle taking photo
  handleTakingPhoto() async {
    image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedImage = File(image!.path);
      imageSelected.value = true;
    }
    update();
  }

  // Function to handle picking video from phone
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

  // Function to record video
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

  // Importing NFT from an EOA Wallet.

  fetchNFT(String addy) async {
    EthereumAddress account = EthereumAddress.fromHex(addy);

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
        // String token = tokenURI[0].toString();

        // if (tokenURI[0].toString().startsWith("ipfs://")) {
        //   tokenURI[0] =
        //       "https://ipfs.io/ipfs/${tokenURI[0].toString().replaceAll("ipfs://", "")}";
        //   final res = await http.get(Uri.parse(tokenURI[0]));

        //   if (res.statusCode == 200) {
        //     var result = jsonDecode(res.body)["image"];
        //     token = "https://ipfs.io/ipfs/${result.toString().split("/").last}";
        //   }
        // }

        final res = await http.get(Uri.parse(nftURI.text.trim()));

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

  // Establish wallet connection and return Ethereum Wallet Address credentials

  //Function to handle uploading of Boom Post to Boom Backend

  uploadNewBoom(bool isOnchain, {required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: "Uploading");
      String postType = '';
      String imgURL = '';
      String boomState = '';
      var d12 = DateFormat('MM-dd-yyyy, hh:mm a').format(DateTime.now());
      String longTag = tags.text.trim().replaceAll(" ", "@");
      List<String> tagList = longTag.split("@").toList();
      String tagString = tagList.join(",");

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

      if (isOnchain) {
        String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
        boomState = 'realnft';

        // log("txHash $txHash");
        // if (txHash.contains("0x")) {
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
          boomState: boomState,
        );

        Future.delayed(Duration.zero).then(
          (_) async {
            await createWalletConnectSession(
              false,
              context: context,
              newPostModel: newPostModel,
              imgURL: imgURL,
              timeStamp: timeStamp,
            );
          },
        );

        // final res = await uploadService.uploadPost(newPostModel);

        // if (res.statusCode == 201) {
        //   CustomSnackBar.showCustomSnackBar(
        //       errorList: [""], msg: [""], isError: false);

        // } else {
        //   List<String> errors = [];
        //   for (var item in jsonDecode(res.body)["errors"]) {
        //     errors.add(item["message"]);
        //   }
        //   CustomSnackBar.showCustomSnackBar(
        //       errorList: errors, msg: [""], isError: true);
        // }
        // }
      } else {
        boomState = 'synthetic';
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
          boomState: boomState,
        );

        await postBoomNFT(newPostModel);

        // if (res.statusCode == 201) {
        //   CustomSnackBar.showCustomSnackBar(
        //       errorList: [""], msg: [""], isError: false);

        // } else {
        //   List<String> errors = [];
        //   for (var item in jsonDecode(res.body)["errors"]) {
        //     errors.add(item["message"]);
        //   }
        //   CustomSnackBar.showCustomSnackBar(
        //       errorList: errors, msg: [""], isError: true);
        // }
      }
    }
  }

  postBoomNFT(NewPostModel newPostModel) async {
    final res = await uploadService.uploadPost(newPostModel);

    if (res.statusCode == 201) {
      //TODO: Add function to update the Post with NFTID

      EasyLoading.dismiss();
      CustomSnackBar.showCustomSnackBar(
          errorList: [""], msg: [""], isError: false);
      Get.offAll(() => const HomeScreen());
    } else {
      EasyLoading.dismiss();
      List<String> errors = [];
      for (var item in jsonDecode(res.body)["errors"]) {
        errors.add(item["message"]);
      }
      CustomSnackBar.showCustomSnackBar(
          errorList: errors, msg: [""], isError: true);
    }
  }

  //Function to mint Post to selected network

  onChainMint(
    String imgURL,
    String boomId,
    String addy,
    Web3Client web3Client,
    WalletConnectEip155Credentials credentials,
    NewPostModel newPostModel,
    int chainId,
  ) async {
    late File nftImg;
    String hashResult = '';

    try {
      final nftDetails = {
        "name": title.text.trim(),
        "description": description.text.trim(),
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

      EthereumAddress contractAddress =
          EthereumAddress.fromHex(smartContractAddress);

      EasyLoading.show(status: 'Minting... Please check your wallet app');

      var contract = DeployedContract(
        ContractAbi.fromJson(boomSmartContract, 'BoomERC721'),
        contractAddress,
      );

      try {
        Transaction tx = Transaction(
          from: account,
          to: contractAddress,
          data: contract.function('mintTo').encodeCall(
            [account, tokenURI],
          ),
        );

        log("Selected Chain ID :$chainId");

        hashResult = await web3Client.sendTransaction(
          credentials,
          tx,
          chainId: chainId,
        );

        int txCount = await web3Client.getTransactionCount(account);
        EasyLoading.dismiss();
        log("Result ${hashResult.isEmpty ? "No Result" : "$hashResult\n length: ${hashResult.length}"}");
        log("TX Count $txCount");
        // await subscription.cancel();
        if (hashResult.isNotEmpty) {
          //We get the Logs and decode to get NFT ID

          EasyLoading.show(status: "Awaiting Tranasction Completion");

          await Future.delayed(const Duration(milliseconds: 500));

          var txLogs = await web3Client.getTransactionReceipt(hashResult);
          while (txLogs == null) {
            log("TX Logs ${txLogs?.logs.first.topics ?? txLogs?.logs.length ?? "No Logs"}");
            txLogs = await web3Client.getTransactionReceipt(hashResult);
          }

          log("TX Logs ${txLogs.logs.first.topics}");

          var tempId = txLogs.logs.first.topics?.last ?? "";
          // var tempId;
          EasyLoading.dismiss();

          log("Temp ID $tempId RunTimeType ${tempId.runtimeType}");

          int nftId = int.parse(tempId.toString().split("x")[1], radix: 16);

          EasyLoading.show(
              status: 'Approval... Please check your wallet app for approval');

          EthereumAddress market = EthereumAddress.fromHex(marketPlaceAddress);

          var marketContract = DeployedContract(
            ContractAbi.fromJson(marketPlaceContrat, 'Marketplace'),
            market,
          );

          //Call the createListing Function of the Smart Contract
          log("NFT ID $nftId ${contractAddress.hex} Versions ${quantity.text.trim()} CryptoAmount $cryptoAmount");

          try {
            // log("NFT ID $nftId ${contractAddress.hex} Versions ${quantity.text.trim()} CryptoAmount $cryptoAmount");

            Transaction approvalTx = Transaction(
              from: account,
              to: contractAddress,
              data: contract.function('setApprovalForAll').encodeCall(
                [market, true],
              ),
            );

            final approveResult = await web3Client.sendTransaction(
              credentials,
              approvalTx,
              chainId: chainId,
            );

            if (approveResult.isNotEmpty) {
              try {
                EasyLoading.dismiss();
                EasyLoading.show(
                    status:
                        'Creating Listing... Please check your wallet app for approval');

                // final listingData = [
                //   {
                //     "assetContract": contractAddress.hex,
                //     "tokenId": nftId,
                //     "startTime": 0,
                //     "secondsUntilEndTime": 30 * 24 * 60 * 60,
                //     "quantityToList": int.parse(quantity.text.trim()),
                //     "currencyToAccept":
                //         "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE",
                //     "reservePricePerToken": 0,
                //     "buyoutPricePerToken": cryptoAmount.toString(),
                //     "listingType": "Direct"
                //   }
                // ];
                int timeStamp =
                    (DateTime.now().millisecondsSinceEpoch / 1000).ceil();

                var listingParams = [
                  contractAddress,
                  BigInt.from(nftId),
                  BigInt.from(timeStamp),
                  BigInt.from(30 * 24 * 60 * 60),
                  BigInt.from(int.parse(quantity.text.trim())),
                  EthereumAddress.fromHex(
                      "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE"),
                  BigInt.from(0),
                  BigInt.from(double.parse(cryptoAmount.toString())),
                  BigInt.from(0)
                ];
                // ["0xAf517ACFD09B6AC830f08D2265B105EDaE5B2fb5",2,0,30 * 24 * 60 * 60,1,"0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE",0,0.01,0]
                // ["0xAf517ACFD09B6AC830f08D2265B105EDaE5B2fb5",2,0,2592000,1,"0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE",0,1,0]
                // ["0xAf517ACFD09B6AC830f08D2265B105EDaE5B2fb5",29,1688058789501,2592000,1,"0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE",0,1,0]
                // 1688059352
                Transaction listingTx = Transaction(
                  from: account,
                  to: market,
                  data: marketContract.function('createListing').encodeCall(
                    [listingParams],
                  ),
                );
                String listingResult = '';
                await web3Client
                    .signTransaction(credentials, listingTx)
                    .then((value) async {
                  if (value.isNotEmpty) {
                    listingResult = await web3Client.sendTransaction(
                      credentials,
                      listingTx,
                      chainId: chainId,
                    );
                  }
                });

                if (listingResult.isNotEmpty) {
                  EasyLoading.dismiss();
                  EasyLoading.showSuccess(
                      "Boom has been Listed on Marketplace");
                  await postBoomNFT(newPostModel);
                }
              } catch (e) {
                log("Error creating listing $e");
                EasyLoading.showError("Error occured when listing");
              }
            }
          } catch (e) {
            //Throw Exception and Report issue to user
            log("Error Approving For all $e");
            EasyLoading.showError("Error occured when approving");
          }
          EasyLoading.dismiss();
          return hashResult;
        } else {
          CustomSnackBar.showCustomSnackBar(
            errorList: ["Error minting Boom as NFT"],
            msg: ["Error"],
            isError: true,
          );
        }
        await client.dispose();
        return hashResult;
      } catch (e) {
        log("Error ${e.toString()}");
        EasyLoading.dismiss();
        Get.snackbar("Error", e.toString());
        return "";
      }
    } catch (e) {
      log("Error ${e.toString()}");
      EasyLoading.dismiss();
      CustomSnackBar.showCustomSnackBar(
        errorList: ["Error exporting Boom as NFT"],
        msg: ["Export Error"],
        isError: true,
      );
      return;
    }
  }

  //List Asset on Marketplace
  createListing() async {
    /** 
     * 
     * const listing  = {
        assetContract: "boomERC721 address";
        tokenId: tokenId;
        startTime: 0;
        secondsUntilEndTime: 1 * 24 * 60 * 60; // 1 day
        quantityToList: 1;
        currencyToAccept: "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
        reservePricePerToken: 0;
        buyoutPricePerToken: "0.013;
        listingType: "Direct" ;
        }
     */
  }

  /// New Wallet Connect Integration Test using WalletConnectFlutterV2.
  /// More documentation can be found here: https://github.com/WalletConnect/WalletConnectFlutterV2

  formatNativeUrl(String? deepLink, String wcUri) {
    String safeAppUrl = deepLink ?? "";

    if (deepLink != null && deepLink.isNotEmpty) {
      if (!safeAppUrl.contains('://')) {
        safeAppUrl = deepLink.replaceAll('/', '').replaceAll(':', '');
        safeAppUrl = '$safeAppUrl://';
      }
    }
    String encodeWcUrl = Uri.encodeComponent(wcUri);

    return Uri.parse('$safeAppUrl$encodeWcUrl');
  }

  /// Begin of WalletConnect Implementation.
  ///

  String get supportedBlockchainsToCIAP2String {
    String chainIds = '';

    if (reqiredBlockchains.isNotEmpty) {
      for (Blockchain blockchain in reqiredBlockchains) {
        chainIds = chainIds + (chainIds == '' ? '' : ',') + blockchain.chainId;
      }
    }

    return chainIds;
  }

  List<String> supportedBlockchainsToCAIP2List({required String namespace}) {
    List<String> ciap2Strings = [];
    if (reqiredBlockchains.isNotEmpty) {
      for (Blockchain blockchain in reqiredBlockchains) {
        if (blockchain.namespace == namespace) {
          ciap2Strings.add(blockchain.chainId);
        }
      }
    }

    log("CIAP2 Strings $ciap2Strings");
    return ciap2Strings;
  }

  Future<String?> createWalletConnectSession(bool isImport,
      {required BuildContext context,
      bool androidUseOsPicker = true,
      String? imgURL,
      String? timeStamp,
      NewPostModel? newPostModel}) async {
    Stopwatch stopwatch = Stopwatch();

    stopwatch.start();

    await wcService.relayClientConnect(web3app: _web3app);

    log("createWalletConnectSession - requiredNamespace: $eip155RequiredNamespace");

    ConnectResponse resp = await _web3app.signEngine.connect(
      requiredNamespaces: {
        'eip155': eip155RequiredNamespace,
      },
      optionalNamespaces: {
        'eip155': eip155OptionalNamespace,
      },
    );

    final Uri? pairingUri = resp.uri;

    if (pairingUri == null) {
      log("createWalletConnectSession - No URI returned from connect method");
      return null;
    }

    //Decoding the URI from the EIP-1328 Standard

    final String decodeUriString = Uri.decodeFull(pairingUri.toString());

    log("WalletConnect URI Decoded is $decodeUriString");

    final String pairingTopic = resp.pairingTopic;

    //Keeping Track of connected wallets for ease of reference in the future

    walletPairingInfoMap[pairingTopic] = WalletPairingInfo(
      pairingTopic: pairingTopic,
      wcUri: pairingUri,
    );

    //SavePairingInfo To Secure Storage

    // savePairingInfo();

    // resp.session.future.then((value) {
    //   if (context.mounted) {
    //     if (Navigator.canPop(context)) {
    //       Navigator.pop(context, 'QR Code Scanned');
    //     }
    //   }
    // });

    try {
      explorerRegistryListings = await explorerRegistryService
          .readWalletRegistry(targetPlatform: targetPlatform);

      bool result = await explorerRegistryService.launcAppWithPairingUri(
          platform: targetPlatform,
          listing: selectedRegistryListing,
          pairingUri: pairingUri,
          androidOsPicker: androidUseOsPicker);

      log("Data to be sent in: ${selectedRegistryListing.chains} ");

      log("createWalletConnectSession - launchWithPairingUri result: $result");

      log('Awaiting session completer before returning');

      await resp.session.future;
    } on JsonRpcError catch (e, s) {
      String? errorMessage = e.message;
      if (errorMessage != null) {
        if (errorMessage.contains('Unsupported chains')) {
          log("Error from wallet: ${e.code} - ${e.message} Requested chains: ${eip155RequiredNamespace.chains ?? 'None'}");
        }

        if (errorMessage.contains('Unsupported methods')) {
          log("Error from wallet: ${e.code} - ${e.message} Requested methods: ${eip155RequiredNamespace.methods}");
        }

        if (errorMessage.contains('Rejected by user')) {
          log("Error from wallet: ${e.code} - ${e.message}. Bummer rejecting yourself like that. Blame the wallet.");
        } else {
          log("createWalletConnectSession JsonRpcError Unlisted Error: ${e.code} - ${e.message}\n$s");
        }
      } else {
        log("createWalletConnectSession JsonRpcError No ErrorMsg: ${e.code} - ${e.message}\n$s");
      }
    } catch (e, s) {
      log("createWalletConnectSession Exception: $e\n$s");
    }

    stopwatch.stop();
    log("createWalletConnectSession - Elapsed time: ${stopwatch.elapsedMilliseconds}ms  - Connection with wallet took ${(stopwatch.elapsedMicroseconds / 1000).toStringAsFixed(2)} seconds.");
    ISignEngine signEngine = _web3app.signEngine;
    List<BlockchainAccount> blockchainAccounts = [];
    for (SessionData? sessionData in signEngine.sessions.getAll()) {
      if (sessionData == null) {
        log("getBlockChainAccounts - No active sessions returning null");
        continue;
      }
      log("createSession - ${sessionData.namespaces} + ${sessionData.topic}");

      blockchainAccounts +=
          nameSpacesToBlockchainAccounts(sessionData.namespaces);
    }
    BlockchainAccount selectedAccount = blockchainAccounts.firstWhere(
        (element) => element.blockchain.chainId == "eip155:$chainId");

    int selectedAccountIndex = blockchainAccounts.indexOf(selectedAccount);

    log("Selected Account Index $selectedAccountIndex");

    String? sessionTopic = wcService.getSessionTopicFromAccount(
            blockchainAccounts[selectedAccountIndex],
            web3app: _web3app) ??
        "No session topic found";
    WalletConnectEip155Credentials? connectEip155Credentials =
        wcService.getgetEip155Credentials(
      sessionTopic: sessionTopic,
      web3app: _web3app,
      blockchainAccount: blockchainAccounts[selectedAccountIndex],
    );

    onChainMint(
        imgURL!,
        timeStamp!,
        connectEip155Credentials!.credentialAddress.toString(),
        client,
        connectEip155Credentials,
        newPostModel!,
        chainId);

    return 'Sessions?';
  }

//TODO: Separate WalletConnect Services from the controller to make it more modular
//TODO: Refactor the code to make it more readable and understandable

  //TODO: Add Disconnect Pairing function to disconnect from WalletConnect onClose of the Controller
}
