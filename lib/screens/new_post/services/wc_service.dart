import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/new_post/models/blockchain.dart';
import 'package:boom_mobile/screens/new_post/models/blockchain_accounts.dart';
import 'package:boom_mobile/screens/new_post/models/eip155_wallet_credentials.dart';
import 'package:boom_mobile/screens/new_post/models/explorer_registry_listing.dart';
import 'package:boom_mobile/screens/new_post/models/wallet_connect_extensions.dart';
import 'package:boom_mobile/screens/new_post/models/wallet_connect_stats.dart';
import 'package:flutter/foundation.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class WalletConnectService {
  WalletConnectServiceStats serviceStats = WalletConnectServiceStats();
  int lastSessionUpdateId = 0;

  String sessionTopic = '';

//TODO: Initialise the WC Service to be used in Import and Export
  Future<void> init(
      {required TargetPlatform platform,
      required Web3App web3app,
      ICore? core}) async {
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();

    serviceStats.clearCounters();
    registerListeners(core: core!);
  }

  WalletConnectEip155Credentials? getgetEip155Credentials(
      {required String sessionTopic,
      required Web3App web3app,
      required BlockchainAccount blockchainAccount}) {
    WalletConnectEip155Credentials credentials = WalletConnectEip155Credentials(
        signEngine: web3app.signEngine,
        sessionTopic: sessionTopic,
        blockchain: blockchainAccount.blockchain,
        credentialAddress: blockchainAccount.toEthereumAddress);
    return credentials;
  }

  relayClientConnect(
      {ICore? core, String? relayUrl, required Web3App web3app}) async {
    core = web3app.signEngine.core;
    relayUrl = relayUrl ?? core.relayUrl;
    core.relayClient.connect(relayUrl: relayUrl);
    return;
  }

  relayDisconnect({ICore? core, required Web3App web3app}) async {
    core = web3app.signEngine.core;
    await core.relayClient.disconnect();
    return;
  }

  Future<bool> registerListeners({required ICore core}) async {
    Stopwatch stopwatch = Stopwatch();

    stopwatch.start();

    // RELAY CONNECT
    core.relayClient.onRelayClientConnect.subscribe((args) {
      serviceStats.relayClientConnectTime = DateTime.now();
      if (args != null) {
        log('Core.onRelayClientConnect  - Unexpected event arguments. isRelayUp:  eventArgs: $args, ');
        return;
      }
    });
    // RELAY DISCONNECT
    core.relayClient.onRelayClientDisconnect.subscribe((args) {
      serviceStats.relayClientConnectTime = null;

      if (args != null) {
        log('Core.onRelayClientConnect  - Unexpected event arguments. isRelayUp:  eventArgs: $args, ');
        return;
      }
    });

    // RELAY ERROR
    core.relayClient.onRelayClientError.subscribe((errorEvent) {
      serviceStats.relayClientTxErrorCount++;
      if (errorEvent != null) {
        log('Core.onRelayClientError  - Unexpected event arguments. isRelayUp:  eventArgs: $errorEvent, ');
        //Bad State: Client is closed

        if (errorEvent.error
            .toString()
            .contains('Bad state: Client is closed')) {
          log("Core.onRelayClientError",
              error:
                  "Core.onRelayClientError  - Relay is down, but we thought it was up!  Missing logic path!");
        }
        return;
      }
    });

    // RELAY MESSAGE

    core.relayClient.onRelayClientMessage.subscribe((args) {
      if (args != null) {
        String decodedMessage = utf8.decode(base64Decode(args.message));

        log('Core.onRelayClientMessage  - topic: ${args.topic} message: $decodedMessage [${args.message.length} bytes] ');

        serviceStats.relayClientMessageTxCount++;
        serviceStats.relayClientMessageTxBytes += args.message.length;

        if (args.topic == decodedMessage) {
          log("Ping success for topic ${args.topic}}");
          serviceStats.relayPairingPingRxCount++;
        }
        return;
      }
    });

    //RELAY SUBSCRIPTION CREATED

    core.relayClient.onSubscriptionCreated.subscribe((args) {
      if (args != null) {
        log('Core.onSubscriptionCreated  - Unexpected event arguments. isRelayUp:  eventArgs: $args, ');
        return;
      }
      log("Core.onSubscriptionCreated - null data passed");
    });

    //RELAY SUBSCRIPTION DELETED

    core.relayClient.onSubscriptionDeleted.subscribe((args) {
      if (args != null) {
        log('Core.onSubscriptionDeleted  - Unexpected event arguments. isRelayUp:  eventArgs: $args, ');
        return;
      }
      log("Core.onSubscriptionDeleted - null data passed");
    });

    //RELAY SUBSCRIPTION RESUBSCRIBED

    core.relayClient.onSubscriptionResubscribed.subscribe((args) {
      if (args != null) {
        log('Core.onSubscriptionResubscribed  - Unexpected event arguments. isRelayUp:  eventArgs: $args, ');
        return;
      }
      log("Core.onSubscriptionResubscribed - null data passed");
    });

    //RELAY SUBSCRIPTION SYNC

    core.relayClient.onSubscriptionSync.subscribe((args) {
      if (args != null) {
        log('Core.onSubscriptionSync  - Unexpected event arguments. isRelayUp:  eventArgs: $args, ');
        return;
      }
      log("Core.onSubscriptionSync - null data passed");
    });

    //PAIRING EVENTS
    core.pairing.onPairingPing.subscribe((args) {
      serviceStats.relayPairingPingTxCount++;
      if (args != null) {
        log('pairing.onPairingPing  - id: ${args.id} pairing topic: ${args.topic}, error ${args.error?.message ?? 'N/A'}');
        return;
      }
      log("pairing.onPairingPing - null data passed");
    });

    log('registerRelate Listeners - completed in ${stopwatch.elapsedMilliseconds} ms');

    return true;
  }

  //Show Relay Information
  void showRelayInfo({ICore? core, required Web3App web3app}) {
    core = core ?? web3app.signEngine.core;

    log("=Core Services ${core.protocol}: v${core.version}, relayUrl: ${core.relayUrl}, pushUrl: ${core.pushUrl}");

    List<PairingInfo> pairings = core.pairing.getPairings();

    log("==Pairiings (${pairings.length})");

    if (pairings.isEmpty) {
      log("No Pairings");
    } else {
      for (PairingInfo pairingInfo in pairings) {
        log("topic: ${pairingInfo.topic}, relay: ${pairingInfo.relay.prettyPrint}, active: ${pairingInfo.active}, peer: ${pairingInfo.peerMetadata?.name ?? 'null'}, redirect native: ${pairingInfo.peerMetadata?.redirect?.native ?? 'null'}, redirect universal: ${pairingInfo.peerMetadata?.redirect?.universal ?? 'null'}");
      }
    }
  }

  //Get Session Topic from Blockchain Account

  String? getSessionTopicFromAccount(BlockchainAccount account,
      {required Web3App web3app}) {
    String? sessionTopic;
    ISignEngine signEngine = web3app.signEngine;

    for (SessionData? sessionData in signEngine.sessions.getAll()) {
      if (sessionData == null) {
        //Fail First and Exit
        log("getSessionTopicFromAccount - No active sessions.  Returning null.");
        return null;
      }

      List<BlockchainAccount>? blockChainAccounts =
          nameSpacesToBlockchainAccounts(sessionData.namespaces);

      if (blockChainAccounts.contains(account)) {
        if (WalletConnectUtils.isExpired(sessionData.expiry)) {
          log('getSessionTopicFromAccount - Found expired match: ${sessionData.topic}.  Ignoring');
          //TODO: Handle an expired session
        } else {
          sessionTopic = sessionData.topic;
          return sessionData.topic;
        }
      }
    }
    return sessionTopic;
  }

  bool isValidSessionTopic(String sessionTopic, {required Web3App web3app}) {
    return web3app.signEngine.getActiveSessions().keys.contains(sessionTopic);
  }

//Evaluate if core is currently online. Timeout is 30 seconds
  Future pingPairing(
      {ICore? core,
      required String pairingTopic,
      required Web3App web3app}) async {
    core = core ?? web3app.signEngine.core;

    if (core.pairing
        .getPairings()
        .where((element) => element.topic == pairingTopic)
        .isEmpty) {
      log("pingpairing - pairingTopic $pairingTopic not found in pairings");
      serviceStats.relayClientTxErrorCount++;
      return;
    }
    log("pingPairing - pairingTopic $pairingTopic found in pairings");
    core.pairing.ping(topic: pairingTopic);
    serviceStats.relayPairingPingTxCount++;
  }

  //Ping a session to check if it is still alive

  Future pingSession(
      {ICore? core,
      required String sessionTopic,
      required Web3App web3app}) async {
    core = core ?? web3app.signEngine.core;
    if (!isValidSessionTopic(sessionTopic, web3app: web3app)) {
      log("pingSesion - sessionTopic $sessionTopic not found in sessions");
      serviceStats.relayClientTxErrorCount++;
      return;
    }

    log("pingSession - sessionTopic $sessionTopic found in sessions");
    SessionData? sessionData = web3app.signEngine.sessions.get(sessionTopic);

    if (sessionData == null) {
      log("pingSession - Null data returned topic $sessionTopic");
      return;
    }
    Duration duration =
        DateTime.fromMillisecondsSinceEpoch(sessionData.expiry * 1000)
            .difference(DateTime.now());
    if (duration.isNegative) {
      log("pingSession - Session expired $sessionTopic");
      return;
    } else {
      serviceStats.incrementPingTXCount(sessionData.topic);
      await web3app.signEngine.ping(topic: sessionData.topic);
    }
  }

  //Disconnect from Pairing Session
  Future disconnectPairing(
      {ICore? core, required Web3App web3app, required String topic}) async {
    log("disconnectPairing - topic $topic");
    core = core ?? web3app.signEngine.core;

    if (core.pairing
        .getPairings()
        .where((element) => element.topic == topic)
        .isEmpty) {
      log("disconnectPairing - topic $topic not found in pairings");
      serviceStats.incrementSessionErrorCount(topic);
      return;
    }
    try {
      await core.pairing.disconnect(topic: topic);
    } on WalletConnectError catch (e) {
      if (e.code == 8) {
        log("disconnectPairing - WalletConnectError ${e.code} : ${e.message},  Expired pairing or Never paired topic?");
      } else {
        log("disconnectPairing - WalletConnectError ${e.code} : ${e.message}");
      }
    } catch (e) {
      log("disconnectPairing - Exception ${e.toString()}");
    }
    return;
  }

  //Disconnect all Pairings

  Future disconnectAllPairings({ICore? core, required Web3App web3app}) async {
    core = core ?? web3app.signEngine.core;
    List<PairingInfo> pairings = core.pairing.getPairings();

    if (pairings.isEmpty) {
      log("No Pairings available");
      return;
    } else {
      for (PairingInfo pairingInfo in pairings) {
        try {
          await core.pairing.disconnect(topic: pairingInfo.topic);
        } on WalletConnectError catch (e, s) {
          if (e.code == 6) {
            log("disconnectAllPairings - WalletConnectError ${e.code} : ${e.message},  Unsuccessful pairing attempt?");
          } else {
            log("disconnectAllPairings - WalletConnectError ${e.code} : ${e.message}\n$s");
          }
        } catch (e, s) {
          log("disconnectAllParings - Unexpected error: $e, topic ${pairingInfo.topic}\n$s");
        }
      }
    }
  }

  //Register Sign Engine Listeners

  Future registerSignEngineListeners(
    List<Blockchain> requiredBlockchains,
    ExplorerRegistryListing selectedRegistryListing,
    RequiredNamespace requiredNamespace,
    RequiredNamespace optinalNamespace, {
    ISignEngine? signEngine,
    required Web3App web3app,
  }) async {
    Stopwatch stopwatch = Stopwatch();

    stopwatch.start();

    signEngine = signEngine ?? web3app.signEngine;

    defaultTopicHandler(String topic, dynamic params) async {
      log("defaultTopicHandler - topic: $topic, params: $params");
    }

    if (requiredBlockchains.isNotEmpty) {
      for (Blockchain blockchain in requiredBlockchains) {
        for (String method
            in (requiredNamespace.methods + optinalNamespace.methods)) {
          signEngine.registerRequestHandler(
            chainId: blockchain.chainId,
            method: method,
            handler: defaultTopicHandler,
          );
        }
      }
    }

    signEngine.onSessionConnect
        .subscribe((SessionConnect? sessionConnect) async {
      sessionTopic = sessionConnect?.session.topic ?? 'none';
      String pairingTopic = sessionConnect?.session.pairingTopic ?? 'none';

      if (sessionConnect != null) {
        serviceStats.setSessionConnected(sessionTopic);
        log('onSessionConnect -'
            '\n****Wallet Responded with New Session ****'
            '\n* ${'name'.padLeft(15)}: ${sessionConnect.session.peer.metadata.name} '
            '- ${sessionConnect.session.peer.metadata.description}'
            '\n* ${'accounts'.padLeft(15)}: ${printNameSpacesAccounts(sessionConnect.session.namespaces)},'
            '\n* ${'methods'.padLeft(15)}: ${printNameSpacesMethods(sessionConnect.session.namespaces)},'
            '\n* ${'events'.padLeft(15)}: ${printNameSpacesEvents(sessionConnect.session.namespaces)},'
            '\n* ${'expires'.padLeft(15)}: ${printDurationFromNow(sessionConnect.session.expiry)}'
            '\n* ${'session topic'.padLeft(15)}: ${sessionConnect.session.topic},'
            '\n* ${'pairing topic'.padLeft(15)}: ${sessionConnect.session.pairingTopic},'
            '\n* ${'our redirect'.padLeft(15)}: ${sessionConnect.session.self.metadata.redirect?.native},'
            '\n* ${'properties'.padLeft(15)}: ${sessionConnect.session.sessionProperties},'
            '\n* ${'icons'.padLeft(15)}: ${sessionConnect.session.peer.metadata.icons},');

        PairingMetadata? originalPairingMetadata =
            web3app.signEngine.sessions.get(sessionTopic)?.peer.metadata;

        PairingMetadata? updatedPairingMetadata = originalPairingMetadata;

        if (sessionConnect.session.peer.metadata.icons.isEmpty &&
            selectedRegistryListing.image_url?.md != null) {
          updatedPairingMetadata = updatedPairingMetadata?.copyWith(
            icons: [selectedRegistryListing.image_url?.md ?? ''],
          );
        }
        if (sessionConnect.session.peer.metadata.redirect?.native == null) {
          log("onSessionConnect - No redirect.native found in session.  Adding from registry");
          updatedPairingMetadata = updatedPairingMetadata?.copyWith(
            redirect: Redirect(
              native: selectedRegistryListing.mobile?.native,
              universal: selectedRegistryListing.mobile?.universal,
            ),
          );
        }

        if (originalPairingMetadata != updatedPairingMetadata &&
            updatedPairingMetadata != null) {
          log('onSessionConnect - Updating pairing metadata with: $updatedPairingMetadata');
          await web3app.core.pairing.updateMetadata(
              topic: pairingTopic, metadata: updatedPairingMetadata);
        }

        //TODO: Initialise Blockchain Accounts Function

        //initialise Blockchain Accounts
        return;
      }
    });

    signEngine.onSessionEvent.subscribe((SessionEvent? sessionEvent) {
      log("signEnngine.onSessionEvent - sessionEvent: $sessionEvent");
      return;
    });

    signEngine.onSessionUpdate.subscribe((SessionUpdate? sessionUpdate) {
      log("signEnngine.onSessionUpdate - sessionUpdate: $sessionUpdate");

      //Initialize Blockchain Accounts
      lastSessionUpdateId = sessionUpdate?.id ?? 0;
      return;
    });

    signEngine.onSessionExpire.subscribe((SessionExpire? sessionExpire) {
      log("signEnngine.onSessionExpire - sessionExpire: $sessionExpire");
      //Initialize Blockchain Accounts
      return;
    });

    signEngine.onSessionExtend.subscribe((SessionExtend? sessionExtend) {
      log("signEnngine.onSessionExtend - sessionExtend: $sessionExtend");

      return;
    });

    signEngine.onSessionDelete.subscribe((SessionDelete? sessionDelete) {
      log("signEnngine.onSessionDelete - sessionDelete: $sessionDelete");

      if (sessionDelete?.topic != null) {
        serviceStats.setSessionDeleted(sessionDelete!.topic);
      }
      // Initialize blockchain accounts

      return;
    });

    log("registerSignEngineListeners - completed in ${stopwatch.elapsedMilliseconds} ms");
  }

  //Delete all sign sessions

  //Wallet Switch Ethereum Blockchain

  initBlockchainAccounts(
      {required List<BlockchainAccount> blockchainAccounts,
      required Web3App web3app}) {
    ISignEngine signEngine = web3app.signEngine;
    blockchainAccounts = [];
    for (SessionData? sessionData in signEngine.sessions.getAll()) {
      if (sessionData == null) {
        log("initBlockchainAccounts - No active sessions");
        continue;
      }

      blockchainAccounts +=
          nameSpacesToBlockchainAccounts(sessionData.namespaces);
    }
  }

  String printNameSpacesAccounts(Map<String, Namespace> nameSpaces) {
    return '';
  }

  String printNameSpacesMethods(Map<String, Namespace> nameSpaces) {
    return '';
  }

  String printNameSpacesEvents(Map<String, Namespace> nameSpaces) {
    return '';
  }

  String printDurationFromNow(int expiry) {
    return '';
  }
}
