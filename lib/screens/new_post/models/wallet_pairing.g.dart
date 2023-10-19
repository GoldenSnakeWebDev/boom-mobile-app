// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_pairing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletPairingInfo _$WalletPairingInfoFromJson(Map<String, dynamic> json) =>
    WalletPairingInfo(
      pairingTopic: json['pairingTopic'] as String,
      wcUri: json['wcUri'] == null ? null : Uri.parse(json['wcUri'] as String),
      registryListing: json['registryListing'] == null
          ? null
          : ExplorerRegistryListing.fromJson(
              json['registryListing'] as Map<String, dynamic>),
    )
      ..currentSessionTopic = json['currentSessionTopic'] as String?
      ..sessionCount = json['sessionCount'] as int
      ..errorMessageCount =
          Map<String, int>.from(json['errorMessageCount'] as Map)
      ..signTransactionHashes = (json['signTransactionHashes'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..signTransactionCount = json['signTransactionCount'] as int;

Map<String, dynamic> _$WalletPairingInfoToJson(WalletPairingInfo instance) {
  final val = <String, dynamic>{
    'pairingTopic': instance.pairingTopic,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('currentSessionTopic', instance.currentSessionTopic);
  writeNotNull('wcUri', instance.wcUri?.toString());
  writeNotNull('registryListing', instance.registryListing?.toJson());
  val['sessionCount'] = instance.sessionCount;
  val['errorMessageCount'] = instance.errorMessageCount;
  val['signTransactionHashes'] = instance.signTransactionHashes;
  val['signTransactionCount'] = instance.signTransactionCount;
  return val;
}
