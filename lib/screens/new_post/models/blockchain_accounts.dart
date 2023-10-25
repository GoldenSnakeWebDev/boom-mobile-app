import 'dart:developer';

import 'package:boom_mobile/screens/new_post/models/blockchain.dart';
import 'package:flutter/foundation.dart';
import 'package:web3dart/web3dart.dart';

class BlockchainAccount {
  late final String accountAdress;
  late final Blockchain blockchain;

  List<String> aliases = [];

  BlockchainAccount({required this.accountAdress, required this.blockchain}) {
    verifyCAIP10Format();
  }

  BlockchainAccount.fromAccountID({required String accountId}) {
    List<String> accountComponents = accountId.split(':');

    if (accountComponents.length != 3) {
      throw 'Malformed accountId: $accountId - must have 3 components or missing : separator?';
    } else {
      Blockchain? blockchainMatch = Blockchain.fromChainId(
          '${accountComponents[0]}:${accountComponents[1]}');

      if (blockchainMatch != null) {
        blockchain = blockchainMatch;
        accountAdress = accountComponents[2];
      } else {
        throw 'Invalid Blockchain chainId ${accountComponents[0]}:${accountComponents[1]}';
      }
    }
    verifyCAIP10Format();
  }

  @override
  bool operator ==(Object other) {
    if (other is BlockchainAccount) {
      return other.blockchain == blockchain &&
          other.accountAdress.toLowerCase() == accountAdress.toLowerCase();
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(blockchain, accountAdress.toLowerCase());

  get accountId => ('${blockchain.chainId}:$accountAdress');

  get chainId => blockchain.chainId;
  get eip155chainId => blockchain.eip155ChainId;

  get namespace => blockchain.namespace;

  get reference => blockchain.reference;

  get accountAddressShort {
    if ((namespace == 'eip155') && accountAdress.length > 16) {
      return '${accountAdress.substring(0, 6)}...${accountAdress.substring(accountAdress.length - 4)}';
    } else {
      return accountAdress;
    }
  }

  bool verifyCAIP10Format() {
    bool isChainIdGood = Blockchain.isValidChainId(chainId);
    bool isAccountAddressGood = Blockchain.isValidAccountAddress(accountAdress);

    if (isChainIdGood && isAccountAddressGood) {
      return true;
    }
    throw ';Malformed accountId: $accountId ${(isChainIdGood) ? '' : '- chainId has bad format '} ${(isAccountAddressGood) ? '' : '- account address had bad format.'}';
  }

  @override
  String toString() {
    String blockchainName = Blockchain.fromChainId(chainId)?.name ?? 'Unknown';
    return '$blockchainName $accountAddressShort';
  }

  String toFullString() => accountId;

  void addAlias(String alias) {
    if (aliases.contains(alias)) {
      if (kDebugMode) {
        log("BlockchainAccount addAlias: duplicate alias $alias ignored. Redundant lookup?");
        return;
      }
    }
    aliases.add(alias);
  }
}

extension Web3Dart on BlockchainAccount {
  EthereumAddress get toEthereumAddress =>
      EthereumAddress.fromHex(accountAdress);
}
