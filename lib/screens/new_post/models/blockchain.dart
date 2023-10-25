import 'dart:developer';

import 'package:flutter/foundation.dart';

class NativeCurrency {
  final String currencyName;
  final String currencySymbol;
  final int currencyDecimals;

  const NativeCurrency({
    required this.currencyName,
    required this.currencySymbol,
    required this.currencyDecimals,
  });
}

enum Blockchain {
  ethereum(
      name: 'Ethereum',
      namespace: 'eip155',
      reference: '1',
      nativeCurrency: NativeCurrency(
          currencyName: 'ETH', currencySymbol: 'ETH', currencyDecimals: 18)),

  polygon(
      name: 'Polygon',
      namespace: 'eip155',
      reference: '137',
      nativeCurrency: NativeCurrency(
          currencyName: 'MATIC',
          currencySymbol: 'MATIC',
          currencyDecimals: 18)),
  mumbai(
      name: 'Mumbai',
      namespace: 'eip155',
      reference: '80001',
      nativeCurrency: NativeCurrency(
          currencyName: 'TMATIC',
          currencySymbol: 'TMATIC',
          currencyDecimals: 18)),
  // tbnb(
  //     name: 'Binance Smart Chain TestNet',
  //     namespace: 'eip155',
  //     reference: '97',
  //     nativeCurrency: NativeCurrency(
  //       currencyName: 'tBNB',
  //       currencySymbol: 'tBNB',
  //       currencyDecimals: 18,
  //     )),
  bnb(
      name: 'Binance Smart Chain',
      namespace: 'eip155',
      reference: '56',
      nativeCurrency: NativeCurrency(
        currencyName: 'BNB',
        currencySymbol: 'BNB',
        currencyDecimals: 18,
      ));

  const Blockchain({
    required this.name,
    required this.namespace,
    required this.reference,
    this.nativeCurrency,
  });
  final String name;
  final String namespace;
  final String reference;
  final NativeCurrency? nativeCurrency;

  //Getters

  String get chainId {
    return '$namespace:$reference';
  }

  //Returns integer chainId for EIP155 based Blockchains
  int get eip155ChainId {
    if (namespace == 'eip155') {
      return int.parse(reference);
    }
    throw 'Uninmplemented EIP155 chainId for $name';
  }

  static Set<Blockchain> fromChainIds(List<String>? chainIds) {
    Set<Blockchain> result = {};

    if (chainIds == null) {
      return result;
    }
    for (String chainIdString in chainIds) {
      try {
        Blockchain? blockchain = Blockchain.fromChainId(chainIdString);
        if (blockchain != null) {
          result.add(blockchain);
        }
      } catch (e) {
        if (kDebugMode) {
          log("Unkown chainId $chainIdString - ignoring. Error $e");
        }
      }
    }
    return result;
  }

  static const camelCaseNames = {
    Blockchain.ethereum: 'ethereum',
    Blockchain.polygon: 'polygon',
    Blockchain.mumbai: 'mumbai',
    // Blockchain.tbnb: 'tbnb',
    Blockchain.bnb: 'bnb',
  };

  static const rpcUrls = {
    Blockchain.ethereum:
        'https://mainnet.infura.io/v3/1c7c468f6c5a4b6e9f2b0b5b9b8b9b8b',
    Blockchain.polygon: 'https://polygon-rpc.com',
    Blockchain.mumbai: 'https://rpc-mumbai.maticvigil.com',
    // Blockchain.tbnb: 'https://data-seed-prebsc-1-s1.bnbchain.org:8545',
    Blockchain.bnb: 'https://binance.llamarpc.com',
  };

  // Check if we are in testnet or not
  bool get isTestnet {
    switch (this) {
      case Blockchain.ethereum:
      case Blockchain.polygon:
      case Blockchain.bnb:
        return false;
      case Blockchain.mumbai:
        // case Blockchain.tbnb:
        return true;
      default:
        throw 'Uninmplemented Blockchain $this';
    }
  }

  //Switch and provide the testnet for the current blockchain
  Blockchain get toTestnet {
    switch (this) {
      case Blockchain.polygon:
        return Blockchain.mumbai;
      case Blockchain.bnb:
        // return Blockchain.tbnb;
        return this;

      case Blockchain.ethereum:
      // case Blockchain.tbnb:
      case Blockchain.mumbai:
        return this;
      default:
        throw 'Uninmplemented Blockchain $this';
    }
  }

  //Switch and provide the mainnet for the current blockchain
  Blockchain get toMainnet {
    switch (this) {
      case Blockchain.mumbai:
        return Blockchain.polygon;
      // case Blockchain.tbnb:
      // return Blockchain.bnb;
      case Blockchain.ethereum:
      case Blockchain.polygon:
      case Blockchain.bnb:
        return this;
      default:
        throw 'Uninmplemented Blockchain $this';
    }
  }

  // Returns Blockchain from the given early standard integer [int? chainid]

  static Blockchain? fromEip155ChainId(int? value) {
    if (value == null) {
      return null;
    }
    switch (value) {
      case 1:
        return Blockchain.ethereum;
      case 137:
        return Blockchain.polygon;
      case 80001:
        return Blockchain.mumbai;
      // case 97:
      //   return Blockchain.tbnb;
      case 56:
        return Blockchain.bnb;
      default:
        throw 'Uninmplemented EIP155 chainId $value';
    }
  }

  //Returns Blockchain from the given CAIP-2 chainId Format
  static Blockchain? fromChainId(String? chainIdString) {
    if (chainIdString == null) {
      return null;
    }

    if (isValidChainId(chainIdString)) {
      switch (chainIdString) {
        case 'eip155:1':
          return Blockchain.ethereum;
        case 'eip155:137':
          return Blockchain.polygon;
        case 'eip155:80001':
          return Blockchain.mumbai;
        // case 'eip155:97':
        //   return Blockchain.tbnb;
        case 'eip155:56':
          return Blockchain.bnb;
        default:
          throw 'Uninmplemented EIP155 chainId $chainIdString';
      }
    } else {
      throw 'Invalid chainId $chainIdString';
    }
  }

  String? get cameCaseName => camelCaseNames[this];
  String? get rpcUrl => rpcUrls[this];

  static bool isValidNamespace(String namespace) {
    RegExp namespaceFormat = RegExp(r'[-a-z0-9]{3,8}');
    return namespaceFormat.hasMatch(namespace);
  }

  static bool isValidReference(String reference) {
    RegExp referenceFormat = RegExp(r'[-_a-zA-Z0-9]{1,32}');
    return referenceFormat.hasMatch(reference);
  }

  static bool isValidChainId(String chainId) {
    RegExp chainidFormat = RegExp(r'[-a-z0-9]{3,8}:[-_a-zA-Z0-9]{1,32}');
    return chainidFormat.hasMatch(chainId);
  }

  static bool isValidAccountAddress(String accountAddress) {
    RegExp accountAddressFormat = RegExp(r'[-.%a-zA-Z0-9]{1,128}');
    return accountAddressFormat.hasMatch(accountAddress);
  }

  @override
  String toString() {
    return chainId;
  }

  bool get isMainnet => !isTestnet;
}
