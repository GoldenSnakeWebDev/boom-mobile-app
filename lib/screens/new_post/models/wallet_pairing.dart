import 'package:boom_mobile/screens/new_post/models/explorer_registry_listing.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_pairing.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class WalletPairingInfo {
  WalletPairingInfo(
      {required this.pairingTopic, this.wcUri, this.registryListing});

  String pairingTopic;
  String? currentSessionTopic;
  Uri? wcUri;
  ExplorerRegistryListing? registryListing;
  int sessionCount = 0;
  Map<String, int> errorMessageCount = {};
  List<String> signTransactionHashes = [];
  int signTransactionCount = 0;

  factory WalletPairingInfo.fromJson(Map<String, dynamic> json) =>
      _$WalletPairingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WalletPairingInfoToJson(this);
}

class WalletState {}
