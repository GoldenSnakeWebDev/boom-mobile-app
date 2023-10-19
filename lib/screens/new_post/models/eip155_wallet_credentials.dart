import 'dart:developer';

import 'package:boom_mobile/screens/new_post/models/blockchain.dart';
import 'package:flutter/foundation.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class WalletConnectEip155Credentials extends CustomTransactionSender {
  final ISignEngine signEngine;
  final String sessionTopic;
  final Blockchain blockchain;
  final EthereumAddress credentialAddress;

  WalletConnectEip155Credentials({
    required this.signEngine,
    required this.sessionTopic,
    required this.blockchain,
    required this.credentialAddress,
  });

  get chainId => blockchain.chainId;

  @override
  EthereumAddress get address => throw UnimplementedError();

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    if (kDebugMode) {
      log("WalletConnectEip155Credentials: sendTransaction - transaction: $transaction");
    }
    if (!signEngine.getActiveSessions().keys.contains(sessionTopic)) {
      if (kDebugMode) {
        log("sendTransaction - called with invalid session.Topic: $sessionTopic");
      }
      return 'Internal Error - sendTransaction - called with invalid sessionTopic';
    }
    SessionRequestParams sessionRequestParams =
        SessionRequestParams(method: 'eth_sendTransaction', params: [
      {
        'from': transaction.from?.hex ?? credentialAddress.hex,
        'to': transaction.to?.hex,
        'data':
            (transaction.data != null) ? bytesToHex(transaction.data!) : null,
        if (transaction.value != null)
          'value': '0x${transaction.value?.getInWei.toRadixString(16)}',
        if (transaction.maxGas != null)
          'gas': '0x${transaction.maxGas?.toInt().toRadixString(16)}',
        if (transaction.gasPrice != null)
          'gasPrice': '0x${transaction.gasPrice?.getInWei.toRadixString(16)}',
        if (transaction.nonce != null) 'none': transaction.nonce
      }
    ]);

    if (kDebugMode) {
      log("WalletConnectEip155Credentials: sendTransaction - blockchain $blockchain, sessionRequestParams: ${sessionRequestParams.toJson()}");
    }

    final hash = await signEngine.request(
        topic: sessionTopic, chainId: chainId, request: sessionRequestParams);

    return hash;
  }

  @override
  Future<EthereumAddress> extractAddress() {
    // TODO: implement extractAddress
    throw UnimplementedError();
  }

  @override
  MsgSignature signToEcSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToEcSignature
    throw UnimplementedError();
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }
}
