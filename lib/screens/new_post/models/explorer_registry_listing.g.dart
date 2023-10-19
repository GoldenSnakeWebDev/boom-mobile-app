// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explorer_registry_listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegistryImageUrlImpl _$$RegistryImageUrlImplFromJson(
        Map<String, dynamic> json) =>
    _$RegistryImageUrlImpl(
      sm: json['sm'] as String?,
      md: json['md'] as String?,
      lg: json['lg'] as String?,
    );

Map<String, dynamic> _$$RegistryImageUrlImplToJson(
    _$RegistryImageUrlImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sm', instance.sm);
  writeNotNull('md', instance.md);
  writeNotNull('lg', instance.lg);
  return val;
}

_$RegistryAppImpl _$$RegistryAppImplFromJson(Map<String, dynamic> json) =>
    _$RegistryAppImpl(
      browser: json['browser'] as String?,
      ios: json['ios'] as String?,
      android: json['android'] as String?,
      mac: json['mac'] as String?,
      windows: json['windows'] as String?,
      linux: json['linux'] as String?,
      chrome: json['chrome'] as String?,
      firefox: json['firefox'] as String?,
      safari: json['safari'] as String?,
      edge: json['edge'] as String?,
      opera: json['opera'] as String?,
    );

Map<String, dynamic> _$$RegistryAppImplToJson(_$RegistryAppImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('browser', instance.browser);
  writeNotNull('ios', instance.ios);
  writeNotNull('android', instance.android);
  writeNotNull('mac', instance.mac);
  writeNotNull('windows', instance.windows);
  writeNotNull('linux', instance.linux);
  writeNotNull('chrome', instance.chrome);
  writeNotNull('firefox', instance.firefox);
  writeNotNull('safari', instance.safari);
  writeNotNull('edge', instance.edge);
  writeNotNull('opera', instance.opera);
  return val;
}

_$InjectedImpl _$$InjectedImplFromJson(Map<String, dynamic> json) =>
    _$InjectedImpl(
      injectedId: json['injected_id'] as String?,
      namespace: json['namespace'] as String?,
    );

Map<String, dynamic> _$$InjectedImplToJson(_$InjectedImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('injected_id', instance.injectedId);
  writeNotNull('namespace', instance.namespace);
  return val;
}

_$RegistryDesktopImpl _$$RegistryDesktopImplFromJson(
        Map<String, dynamic> json) =>
    _$RegistryDesktopImpl(
      native: json['native'] as String?,
      universal: json['universal'] as String?,
    );

Map<String, dynamic> _$$RegistryDesktopImplToJson(
    _$RegistryDesktopImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('native', instance.native);
  writeNotNull('universal', instance.universal);
  return val;
}

_$RegistryMobileImpl _$$RegistryMobileImplFromJson(Map<String, dynamic> json) =>
    _$RegistryMobileImpl(
      native: json['native'] as String?,
      universal: json['universal'] as String?,
    );

Map<String, dynamic> _$$RegistryMobileImplToJson(
    _$RegistryMobileImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('native', instance.native);
  writeNotNull('universal', instance.universal);
  return val;
}

_$RegistryMetadataImpl _$$RegistryMetadataImplFromJson(
        Map<String, dynamic> json) =>
    _$RegistryMetadataImpl(
      shortName: json['shortName'] as String?,
      colors: (json['colors'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      ),
    );

Map<String, dynamic> _$$RegistryMetadataImplToJson(
    _$RegistryMetadataImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('shortName', instance.shortName);
  writeNotNull('colors', instance.colors);
  return val;
}

_$RegistryStandardImpl _$$RegistryStandardImplFromJson(
        Map<String, dynamic> json) =>
    _$RegistryStandardImpl(
      id: json['id'] as String?,
      url: json['url'] as String?,
      title: json['title'] as String?,
      standardId: json['standard_id'] as int?,
      standardPrefix: json['standard_prefix'] as String?,
    );

Map<String, dynamic> _$$RegistryStandardImplToJson(
    _$RegistryStandardImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('url', instance.url);
  writeNotNull('title', instance.title);
  writeNotNull('standard_id', instance.standardId);
  writeNotNull('standard_prefix', instance.standardPrefix);
  return val;
}

_$ExplorerRegistryListingImpl _$$ExplorerRegistryListingImplFromJson(
        Map<String, dynamic> json) =>
    _$ExplorerRegistryListingImpl(
      id: json['id'] as String? ?? 'Unknown ID',
      name: json['name'] as String? ?? 'Unknown Name',
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      homepage: json['homepage'] as String?,
      chains:
          (json['chains'] as List<dynamic>?)?.map((e) => e as String).toList(),
      versions: (json['versions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sdks: (json['sdks'] as List<dynamic>?)?.map((e) => e as String).toList(),
      appType: json['app_type'] as String?,
      imageId: json['image_id'] as String?,
      image_url: json['image_url'] == null
          ? null
          : RegistryImageUrl.fromJson(
              json['image_url'] as Map<String, dynamic>),
      app: json['app'] == null
          ? null
          : RegistryApp.fromJson(json['app'] as Map<String, dynamic>),
      injected: (json['injected'] as List<dynamic>?)
          ?.map((e) => Injected.fromJson(e as Map<String, dynamic>))
          .toList(),
      mobile: json['mobile'] == null
          ? null
          : RegistryMobile.fromJson(json['mobile'] as Map<String, dynamic>),
      desktop: json['desktop'] == null
          ? null
          : RegistryDesktop.fromJson(json['desktop'] as Map<String, dynamic>),
      supportedStandards: (json['supported_standards'] as List<dynamic>?)
          ?.map((e) => RegistryStandard.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] == null
          ? null
          : RegistryMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ExplorerRegistryListingImplToJson(
    _$ExplorerRegistryListingImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('slug', instance.slug);
  writeNotNull('description', instance.description);
  writeNotNull('homepage', instance.homepage);
  writeNotNull('chains', instance.chains);
  writeNotNull('versions', instance.versions);
  writeNotNull('sdks', instance.sdks);
  writeNotNull('app_type', instance.appType);
  writeNotNull('image_id', instance.imageId);
  writeNotNull('image_url', instance.image_url);
  writeNotNull('app', instance.app);
  writeNotNull('injected', instance.injected);
  writeNotNull('mobile', instance.mobile);
  writeNotNull('desktop', instance.desktop);
  writeNotNull('supported_standards', instance.supportedStandards);
  writeNotNull('metadata', instance.metadata);
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  return val;
}
