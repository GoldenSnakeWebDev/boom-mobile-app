import 'dart:developer';

import 'package:boom_mobile/screens/new_post/models/blockchain_accounts.dart';
import 'package:flutter/foundation.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

extension PrintRelay on Relay {
  String get prettyPrint {
    if (data == null) {
      return protocol;
    }
    return '$protocol ($data)';
  }
}

List<BlockchainAccount> nameSpacesToBlockchainAccounts(
    Map<String, Namespace> namespaces) {
  List<BlockchainAccount> blockchainAccounts = [];
  for (String namespace in namespaces.keys) {
    List<String>? accounts = [];
    accounts = namespaces[namespace]?.accounts ?? accounts;
    for (String accountId in accounts) {
      if (accountId.toLowerCase().contains('nan')) {
        if (kDebugMode) {
          log('namespacesToBlockchainAccounts - malformed accountId: $accountId, in namespace: $namespace, namespaces: $namespaces');
        }
        continue;
      }
      blockchainAccounts
          .add(BlockchainAccount.fromAccountID(accountId: accountId));
    }
  }
  return blockchainAccounts;
}
