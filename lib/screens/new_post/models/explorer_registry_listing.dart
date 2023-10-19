// ignore_for_file: non_constant_identifier_names, prefer_adjacent_string_concatenation

import 'package:freezed_annotation/freezed_annotation.dart';

part 'explorer_registry_listing.freezed.dart';
part 'explorer_registry_listing.g.dart';

/// Cloud Explorer API? https://docs.walletconnect.com/2.0/cloud/explorer#cloud-explorer-api
///
/// To rebuild JSON annotation run
/// flutter pub run build_runner build --delete-conflicting-outputs
///
/// NOTE: Most everything is nullable because the registry listings are still in a bit of flux
///

@freezed
class RegistryImageUrl with _$RegistryImageUrl {
  @JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
  const factory RegistryImageUrl({
    String? sm,
    String? md,
    String? lg,
  }) = _RegistryImageUrl;

  factory RegistryImageUrl.fromJson(Map<String, dynamic> json) =>
      _$RegistryImageUrlFromJson(json);
}

@freezed
class RegistryApp with _$RegistryApp {
  @JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
  const factory RegistryApp({
    String? browser,
    String? ios,
    String? android,
    String? mac,
    String? windows,
    String? linux,
    String? chrome,
    String? firefox,
    String? safari,
    String? edge,
    String? opera,
  }) = _RegistryApp;

  factory RegistryApp.fromJson(Map<String, dynamic> json) =>
      _$RegistryAppFromJson(json);
}

@freezed
class Injected with _$Injected {
  @JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
  const factory Injected({
    String? injectedId,
    String? namespace,
  }) = _Injected;

  factory Injected.fromJson(Map<String, dynamic> json) =>
      _$InjectedFromJson(json);
}

@freezed
class RegistryDesktop with _$RegistryDesktop {
  @JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
  const factory RegistryDesktop({
    String? native,
    String? universal,
  }) = _RegistryDesktop;

  factory RegistryDesktop.fromJson(Map<String, dynamic> json) =>
      _$RegistryDesktopFromJson(json);
}

@freezed
class RegistryMobile with _$RegistryMobile {
  @JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
  const factory RegistryMobile({
    String? native,
    String? universal,
  }) = _RegistryMobile;

  factory RegistryMobile.fromJson(Map<String, dynamic> json) =>
      _$RegistryMobileFromJson(json);
}

@freezed
class RegistryMetadata with _$RegistryMetadata {
  @JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
  const factory RegistryMetadata({
    /// Yes this is inconsistent with the other metadata field naming
    @JsonKey(name: 'shortName') String? shortName,
    Map<String, String?>? colors,
  }) = _RegistryMetadata;

  factory RegistryMetadata.fromJson(Map<String, dynamic> json) =>
      _$RegistryMetadataFromJson(json);
}

@freezed
class RegistryStandard with _$RegistryStandard {
  const RegistryStandard._();

  @JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
  const factory RegistryStandard({
    String? id,
    String? url,
    String? title,
    int? standardId,
    String? standardPrefix,
  }) = _RegistryStandard;

  factory RegistryStandard.fromJson(Map<String, dynamic> json) =>
      _$RegistryStandardFromJson(json);

  String get standard => '${standardPrefix ?? 'null'}-${standardId ?? 'null'}';
}

/// WalletConnect Cloud Explorer API V2 Registry Listing
///
/// https://docs.walletconnect.com/2.0/cloud/explorer
@freezed
class ExplorerRegistryListing with _$ExplorerRegistryListing {
  const ExplorerRegistryListing._();

  @JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
  const factory ExplorerRegistryListing({
    @Default('Unknown ID') String id,
    @Default('Unknown Name') String name,
    String? slug,
    String? description,
    String? homepage,
    List<String>? chains, //  CAIP-2 formatted Blockchain ID  [ "eip155:1" ]
    List<String>? versions,
    List<String>? sdks,
    String? appType,
    String? imageId,
    RegistryImageUrl? image_url,
    RegistryApp? app,
    List<Injected>? injected,
    RegistryMobile? mobile,
    RegistryDesktop? desktop,
    List<RegistryStandard>? supportedStandards,
    RegistryMetadata? metadata,

    /// Date the registry listing was last updated so we can cache results
    DateTime? updatedAt,
  }) = _ExplorerRegistryListing;

  factory ExplorerRegistryListing.fromJson(Map<String, dynamic> json) =>
      _$ExplorerRegistryListingFromJson(json);

  List<String> get standardsList {
    List<String> standards = [];
    if (supportedStandards != null) {
      for (RegistryStandard registryStandard in supportedStandards!) {
        // logger.i('${registryStandard.standard} : $registryStandard');
        if (!standards.contains(registryStandard.standard)) {
          standards.add(registryStandard.standard);
        }
      }
    }
    return standards;
  }
}

// curl --location --request GET 'https://explorer-api.walletconnect.com/v3/wallets?projectId=$WALLETCONNECT_PROJECT_ID&entries=1&page=4&chains=eip155:1,eip155:137&platforms=android,ios&sdks=sign_v2'
// {
//     "listings": {
//         "afbd95522f4041c71dd4f1a065f971fd32372865b416f95a0b1db759ae33f2a7": {
//             "id": "afbd95522f4041c71dd4f1a065f971fd32372865b416f95a0b1db759ae33f2a7",
//             "name": "Omni",
//             "description": "Multi chain, self custodial DeFi wallet",
//             "homepage": "https://omni.app",
//             "chains": [
//                 "solana:4sGjMW1sUnHzSxGspuhpqLDx6wiyjNtZ"
//             ],
//             "versions": [
//                 "1",
//                 "2"
//             ],
//             "sdks": [
//                 "sign_v1",
//                 "sign_v2"
//             ],
//             "app_type": "wallet",
//             "image_id": "2cd67b4c-282b-4809-e7c0-a88cd5116f00",
//             "image_url": {
//                 "sm": "https://explorer-api.walletconnect.com/v3/logo/sm/2cd67b4c-282b-4809-e7c0-a88cd5116f00?projectId=0501367d3019f4397d744c91a88ae643",
//                 "md": "https://explorer-api.walletconnect.com/v3/logo/md/2cd67b4c-282b-4809-e7c0-a88cd5116f00?projectId=0501367d3019f4397d744c91a88ae643",
//                 "lg": "https://explorer-api.walletconnect.com/v3/logo/lg/2cd67b4c-282b-4809-e7c0-a88cd5116f00?projectId=0501367d3019f4397d744c91a88ae643"
//             },
//             "app": {
//                 "browser": "",
//                 "ios": "https://apps.apple.com/de/app/steakwallet/id1569375204?l=en",
//                 "android": "https://play.google.com/store/apps/details?id=fi.steakwallet.app",
//                 "mac": null,
//                 "windows": null,
//                 "linux": null,
//                 "chrome": null,
//                 "firefox": null,
//                 "safari": null,
//                 "edge": null,
//                 "opera": null
//             },
//             "injected": null,
//             "mobile": {
//                 "native": "omni",
//                 "universal": "https://links.omni.app"
//             },
//             "desktop": {
//                 "native": null,
//                 "universal": null
//             },
//             "supported_standards": [],
//             "metadata": {
//                 "shortName": "Omni",
//                 "colors": {
//                     "primary": "#FFFFFF",
//                     "secondary": "#000000"
//                 }
//             }
//         }
//     },
//     "count": 1,
//     "total": 21
// }
