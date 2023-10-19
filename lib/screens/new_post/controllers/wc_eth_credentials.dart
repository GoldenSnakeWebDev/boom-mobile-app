import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

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
