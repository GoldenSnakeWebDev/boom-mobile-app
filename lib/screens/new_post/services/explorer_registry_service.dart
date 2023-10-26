import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/new_post/models/explorer_registry_listing.dart';
import 'package:boom_mobile/secrets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class ExplorerRegistryService {
  static const String _walletConnectProjectId = WALLET_CONNECT_ID;
  static final ExplorerRegistryService _singleton =
      ExplorerRegistryService._internal();

  factory ExplorerRegistryService() {
    return _singleton;
  }
  ExplorerRegistryService._internal();

  String listToCommaSeparatedString(List<String> listOfStrings) {
    String commaSeparatedString = "";
    for (String value in listOfStrings) {
      commaSeparatedString = (commaSeparatedString == '' ? '' : ",") + value;
    }
    return commaSeparatedString;
  }

  //Querying WalletConnect Explorer Registry for compatible wallets

  Future<List<ExplorerRegistryListing>> readWalletRegistry({
    int limit = 30,
    String supportedCAIP2Chains = 'eip155:80001,eip155:137,eip155:56,eip155:97',
    String walletConnectProjectId = _walletConnectProjectId,
    required TargetPlatform targetPlatform,
    List<String> alwaysIncludedWallets = const [],
    List<String> alwaysExcludedWallets = const [],
  }) async {
    List<ExplorerRegistryListing> listings = [];

    int numResponseListings = 0;

    if (walletConnectProjectId.isEmpty) {
      return listings;
    }
    var client = http.Client();
    String platform;

    switch (targetPlatform) {
      case TargetPlatform.iOS:
        platform = 'ios';
        break;
      case TargetPlatform.android:
        platform = 'android';
        break;
      case TargetPlatform.fuchsia:
        platform = 'browser';
      case TargetPlatform.windows:
        platform = 'windows';
        break;
      case TargetPlatform.macOS:
        platform = 'mac';
        break;
      case TargetPlatform.linux:
        platform = 'linux';
        break;
      default:
        platform = '';
    }

    Map<String, dynamic> queryParameters = {};

    if (alwaysExcludedWallets.isNotEmpty) {
      queryParameters = {
        'entries': '${alwaysExcludedWallets.length}',
        'page': '1',
        'projectId': walletConnectProjectId,
        'ids': alwaysExcludedWallets.join(','),
        'platforms': (kIsWeb) ? 'browser' : platform,
      };
    } else {
      queryParameters = {
        'entries': '$limit',
        'page': '1',
        'projectId': walletConnectProjectId,
        'sdks': 'sign_v2',
        'chains': supportedCAIP2Chains,
        'platforms': (kIsWeb) ? 'browser' : platform,
      };
    }

    http.Response? response;

    try {
      response = await client.get(
          Uri.https(
            'explorer-api.walletconnect.com', // Formerly registry.walletconnect.com
            'v3/wallets', //formerly 'api/v1/wallets'
            queryParameters,
          ),
          headers: {
            'Content-Type': 'application/json',
          }).timeout(
        const Duration(seconds: 10),
      );
    } on http.ClientException catch (e) {
      if (e.message.contains("XMLHttpRequest error.")) {
        log("WalletConnect Registry server is not properly configured. Please contact the WalletConnect team.");
      } else {
        log("WalletConnect Registry server is not reachable. Please check your internet connection.");
      }
      return listings;
    } catch (e) {
      log("readWalletRegistry - Unexpected protocol error: $e");
      return listings;
    }

    if (response.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      if (decodedResponse["listings"] != null) {
        for (Map<String, dynamic> entry in decodedResponse["listings"].values) {
          ExplorerRegistryListing listing = const ExplorerRegistryListing();
          try {
            listing = ExplorerRegistryListing.fromJson(entry);
          } catch (e) {
            log("Error parsing ExplorerRegistryListing: ${jsonEncode(entry)}");
            continue;
          }
          numResponseListings++;
          bool acceptListing = true;

          if (alwaysIncludedWallets.contains(listing.id)) {
            listings.add(listing);
            continue;
          }
          if (alwaysExcludedWallets.contains(listing.id)) {
            acceptListing = false;
          }

          if (!(listing.appType == 'wallet' || listing.appType == 'hybrid')) {
            acceptListing = false;
          }

          if (listing.chains?.isEmpty ?? true) {
            acceptListing = false;
          } else {
            List<String> requestedChains = supportedCAIP2Chains.split(',');
            for (String chain in requestedChains) {
              if (!listing.chains.toString().contains(chain)) {
                acceptListing = false;
              }
            }
          }

          if (acceptListing) {
            listings.add(listing);
          }
          //  else {
          //   // log("readWalletRegistry - Skipping ${listing.appType} id: ${listing.id} name: ${listing.name} supported chains:${listing.chains} - issues: $issues");
          // }
        }
      }
      log("readWalletRegistry - Found ${listings.length} compatible listings out of $numResponseListings returned.");
      return listings;
    } else {
      log("readWalletRegistry - Unexpected server error: ${response.statusCode}: ${response.reasonPhrase}.");
      client.close();
    }
    return listings;
  }

  /// Direct the user to the appropriate app store listing for the wallet they have chosen.
  ///
  /// Used as a last resort, if the wallet is not installed on the device.
  ///

  Future<bool> launcAppStoreListing(
      {required TargetPlatform platform,
      required ExplorerRegistryListing registryListing}) async {
    return true;
  }

  Future<bool> launcAppWithPairingUri({
    required TargetPlatform platform,
    required ExplorerRegistryListing listing,
    required Uri pairingUri,
    androidOsPicker = true,
  }) async {
    bool result = false;
    Uri originalUri = pairingUri;

    String encodedWcUrl = Uri.encodeComponent(pairingUri.toString());
    String urlSource = 'unknown';
    switch (platform) {
      case TargetPlatform.iOS:
        String uriBase = listing.mobile?.universal ?? '';
        if (uriBase.isNotEmpty) {
          pairingUri = Uri.parse('$uriBase/wc?uri=$encodedWcUrl');
          urlSource = 'mobile universal';
          break;
        }
        log("launchApp - universal link failed - empty/null value in listing.  Consider hiding such entries on IOS?");
        uriBase = listing.mobile?.native ?? '';
        if (uriBase.isNotEmpty) {
          String trailingCharater = uriBase.substring(uriBase.length - 1);
          if (!(trailingCharater == '/')) {
            log("launchApp - native link does not end with  / *** compatibility ***  adding //");
            pairingUri = Uri.parse('$uriBase//wc?uri=$encodedWcUrl');
          } else {
            pairingUri = Uri.parse('$uriBase/wc?uri=$encodedWcUrl');
          }
          urlSource = 'mobile native';
          break;
        }

        break;
      case TargetPlatform.android:
        String uriBase;
        if (androidOsPicker) {
          pairingUri = originalUri;
          urlSource = 'originalUri';
          break;
        } else {
          uriBase = listing.mobile?.native ?? '';
          if (uriBase.isNotEmpty) {
            String trailingCharacter = uriBase.substring(uriBase.length - 1);
            if (!(trailingCharacter == '/')) {
              log("launchApp - native link does not end with  / *** compatibility ***  adding //");
              pairingUri = Uri.parse('$uriBase//wc?uri=$encodedWcUrl');
            } else {
              pairingUri = Uri.parse('$uriBase/wc?uri=$encodedWcUrl');
            }
            urlSource = 'mobile native';
            break;
          }
          log("launchApp - native link failed - empty/null value in listing");

          uriBase = listing.mobile?.universal ?? '';
          if (uriBase.isNotEmpty) {
            pairingUri = Uri.parse('$uriBase/wc?uri=$encodedWcUrl');
            urlSource = 'mobile universal';
            break;
          }
          log("launchApp - universal link failed - empty/null value in listing.");
          urlSource = 'walletConnect URI';
          pairingUri = originalUri;
          break;
        }
      case TargetPlatform.fuchsia:
        String uriBase = listing.mobile?.universal ?? '';
        if (uriBase.isNotEmpty) {
          pairingUri = Uri.parse('$uriBase/wc?uri=$encodedWcUrl');
          urlSource = 'mobile universal';
          break;
        }
        log('launchApp - universal link failed - empty/null value in listing');
        break;
      default:
        log('launchApp - platform not supported');
    }
    try {
      result =
          await launchUrl(pairingUri, mode: LaunchMode.externalApplication);
    } on PlatformException catch (e) {
      if (e.code == "ACTIVITY_NOT_FOUND") {
        log("launchApp - 1. $urlSource failed - Android Intent returned ACTIVITY_NOT_FOUND (app missing support it or app not installed.)");
      } else {
        log("launchApp - 1. $urlSource failed - Unexpected PlatformException error opening ${listing.name}: ${e.message}, code: ${e.code}, details: ${e.details}");
      }
    } on Exception catch (e) {
      log('launchApp - 1. $urlSource failed - unexpected error e: $e');
    }

    if (result == false && platform == TargetPlatform.android) {
      String uriBase = listing.mobile?.universal ?? '';
      if (uriBase.isEmpty) {
        log("launchApp - 1.a mobile universal failed - empty/null value in listing.");
      } else {
        pairingUri = Uri.parse('$uriBase/wc?uri=$encodedWcUrl');
        urlSource = 'mobile universal';

        try {
          log('launchApp - 1.a $urlSource using LaunchMode.externalApplication with mobile universal \n${Uri.decodeFull(pairingUri.toString())}');
          result =
              await launchUrl(pairingUri, mode: LaunchMode.externalApplication);
        } on PlatformException catch (e) {
          log('launchApp - 1.a $urlSource failed - PlatformException error opening ${listing.name}: $e');
        } on Exception catch (e) {
          log('launchApp - 1.a $urlSource failed - Unexpected error e: $e');
        }
      }
    }

    if (result == false && await canLaunchUrl(originalUri)) {
      urlSource = 'WalletConnect URI';
      log('launchApp - 2. OS confirms we have apps that can launch the wc URI, but app selection is controlled by the OS.');
      log("launchApp - 2. $urlSource using LaunchMode.externalApplication with mobile universal \n${Uri.decodeFull(originalUri.toString())}");
      try {
        result =
            await launchUrl(originalUri, mode: LaunchMode.externalApplication);
      } catch (e) {
        result = false;
        log('launchApp - 2. $urlSource failed - Unexpected error e: $e');
      }
    }
    if (result == false) {
      result = await launcAppStoreListing(
          platform: platform, registryListing: listing);
    }

    return result;
  }

  // Assumptions:
  // * The wallet has already been used on this device (i.e. installed so no app store fallback)
  // * The wallet will be called via the platform preferred method, no fallbacks
  // * pairingInfo has redirect info --- SPOILER --- they don't --- So we may have "fixed it"

  Future<bool> launchAppWithPairingMetadata({
    required TargetPlatform platform,
    PairingMetadata? pairingMetadata,
    String? additionalUriString,
  }) async {
    if (pairingMetadata == null) {
      return false;
    }

    String appLaunchUrl = '';
    switch (platform) {
      case TargetPlatform.iOS:
        appLaunchUrl = pairingMetadata.redirect?.universal ?? '';
        break;
      case TargetPlatform.android:
        appLaunchUrl = pairingMetadata.redirect?.native ?? '';
        break;
      default:
        log('launcAppWithPairingMetadata - $platform not supported');
        appLaunchUrl = pairingMetadata.redirect?.universal ?? '';
        break;
    }
    if (appLaunchUrl == '') {
      log('PairingData does not have required redirect urls.  redirect: ${pairingMetadata.redirect}  universal:${pairingMetadata.redirect?.universal ?? 'NULL'} native: ${pairingMetadata.redirect?.native ?? 'NULL'}');
      return false;
    }

    log('launchAppWithPairingMetadata using url: $appLaunchUrl');
    return true;
  }
}
