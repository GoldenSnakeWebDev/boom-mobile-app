// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explorer_registry_listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RegistryImageUrl _$RegistryImageUrlFromJson(Map<String, dynamic> json) {
  return _RegistryImageUrl.fromJson(json);
}

/// @nodoc
mixin _$RegistryImageUrl {
  String? get sm => throw _privateConstructorUsedError;
  String? get md => throw _privateConstructorUsedError;
  String? get lg => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegistryImageUrlCopyWith<RegistryImageUrl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistryImageUrlCopyWith<$Res> {
  factory $RegistryImageUrlCopyWith(
          RegistryImageUrl value, $Res Function(RegistryImageUrl) then) =
      _$RegistryImageUrlCopyWithImpl<$Res, RegistryImageUrl>;
  @useResult
  $Res call({String? sm, String? md, String? lg});
}

/// @nodoc
class _$RegistryImageUrlCopyWithImpl<$Res, $Val extends RegistryImageUrl>
    implements $RegistryImageUrlCopyWith<$Res> {
  _$RegistryImageUrlCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sm = freezed,
    Object? md = freezed,
    Object? lg = freezed,
  }) {
    return _then(_value.copyWith(
      sm: freezed == sm
          ? _value.sm
          : sm // ignore: cast_nullable_to_non_nullable
              as String?,
      md: freezed == md
          ? _value.md
          : md // ignore: cast_nullable_to_non_nullable
              as String?,
      lg: freezed == lg
          ? _value.lg
          : lg // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegistryImageUrlImplCopyWith<$Res>
    implements $RegistryImageUrlCopyWith<$Res> {
  factory _$$RegistryImageUrlImplCopyWith(_$RegistryImageUrlImpl value,
          $Res Function(_$RegistryImageUrlImpl) then) =
      __$$RegistryImageUrlImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? sm, String? md, String? lg});
}

/// @nodoc
class __$$RegistryImageUrlImplCopyWithImpl<$Res>
    extends _$RegistryImageUrlCopyWithImpl<$Res, _$RegistryImageUrlImpl>
    implements _$$RegistryImageUrlImplCopyWith<$Res> {
  __$$RegistryImageUrlImplCopyWithImpl(_$RegistryImageUrlImpl _value,
      $Res Function(_$RegistryImageUrlImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sm = freezed,
    Object? md = freezed,
    Object? lg = freezed,
  }) {
    return _then(_$RegistryImageUrlImpl(
      sm: freezed == sm
          ? _value.sm
          : sm // ignore: cast_nullable_to_non_nullable
              as String?,
      md: freezed == md
          ? _value.md
          : md // ignore: cast_nullable_to_non_nullable
              as String?,
      lg: freezed == lg
          ? _value.lg
          : lg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class _$RegistryImageUrlImpl implements _RegistryImageUrl {
  const _$RegistryImageUrlImpl({this.sm, this.md, this.lg});

  factory _$RegistryImageUrlImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegistryImageUrlImplFromJson(json);

  @override
  final String? sm;
  @override
  final String? md;
  @override
  final String? lg;

  @override
  String toString() {
    return 'RegistryImageUrl(sm: $sm, md: $md, lg: $lg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistryImageUrlImpl &&
            (identical(other.sm, sm) || other.sm == sm) &&
            (identical(other.md, md) || other.md == md) &&
            (identical(other.lg, lg) || other.lg == lg));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sm, md, lg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistryImageUrlImplCopyWith<_$RegistryImageUrlImpl> get copyWith =>
      __$$RegistryImageUrlImplCopyWithImpl<_$RegistryImageUrlImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegistryImageUrlImplToJson(
      this,
    );
  }
}

abstract class _RegistryImageUrl implements RegistryImageUrl {
  const factory _RegistryImageUrl(
      {final String? sm,
      final String? md,
      final String? lg}) = _$RegistryImageUrlImpl;

  factory _RegistryImageUrl.fromJson(Map<String, dynamic> json) =
      _$RegistryImageUrlImpl.fromJson;

  @override
  String? get sm;
  @override
  String? get md;
  @override
  String? get lg;
  @override
  @JsonKey(ignore: true)
  _$$RegistryImageUrlImplCopyWith<_$RegistryImageUrlImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegistryApp _$RegistryAppFromJson(Map<String, dynamic> json) {
  return _RegistryApp.fromJson(json);
}

/// @nodoc
mixin _$RegistryApp {
  String? get browser => throw _privateConstructorUsedError;
  String? get ios => throw _privateConstructorUsedError;
  String? get android => throw _privateConstructorUsedError;
  String? get mac => throw _privateConstructorUsedError;
  String? get windows => throw _privateConstructorUsedError;
  String? get linux => throw _privateConstructorUsedError;
  String? get chrome => throw _privateConstructorUsedError;
  String? get firefox => throw _privateConstructorUsedError;
  String? get safari => throw _privateConstructorUsedError;
  String? get edge => throw _privateConstructorUsedError;
  String? get opera => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegistryAppCopyWith<RegistryApp> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistryAppCopyWith<$Res> {
  factory $RegistryAppCopyWith(
          RegistryApp value, $Res Function(RegistryApp) then) =
      _$RegistryAppCopyWithImpl<$Res, RegistryApp>;
  @useResult
  $Res call(
      {String? browser,
      String? ios,
      String? android,
      String? mac,
      String? windows,
      String? linux,
      String? chrome,
      String? firefox,
      String? safari,
      String? edge,
      String? opera});
}

/// @nodoc
class _$RegistryAppCopyWithImpl<$Res, $Val extends RegistryApp>
    implements $RegistryAppCopyWith<$Res> {
  _$RegistryAppCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? browser = freezed,
    Object? ios = freezed,
    Object? android = freezed,
    Object? mac = freezed,
    Object? windows = freezed,
    Object? linux = freezed,
    Object? chrome = freezed,
    Object? firefox = freezed,
    Object? safari = freezed,
    Object? edge = freezed,
    Object? opera = freezed,
  }) {
    return _then(_value.copyWith(
      browser: freezed == browser
          ? _value.browser
          : browser // ignore: cast_nullable_to_non_nullable
              as String?,
      ios: freezed == ios
          ? _value.ios
          : ios // ignore: cast_nullable_to_non_nullable
              as String?,
      android: freezed == android
          ? _value.android
          : android // ignore: cast_nullable_to_non_nullable
              as String?,
      mac: freezed == mac
          ? _value.mac
          : mac // ignore: cast_nullable_to_non_nullable
              as String?,
      windows: freezed == windows
          ? _value.windows
          : windows // ignore: cast_nullable_to_non_nullable
              as String?,
      linux: freezed == linux
          ? _value.linux
          : linux // ignore: cast_nullable_to_non_nullable
              as String?,
      chrome: freezed == chrome
          ? _value.chrome
          : chrome // ignore: cast_nullable_to_non_nullable
              as String?,
      firefox: freezed == firefox
          ? _value.firefox
          : firefox // ignore: cast_nullable_to_non_nullable
              as String?,
      safari: freezed == safari
          ? _value.safari
          : safari // ignore: cast_nullable_to_non_nullable
              as String?,
      edge: freezed == edge
          ? _value.edge
          : edge // ignore: cast_nullable_to_non_nullable
              as String?,
      opera: freezed == opera
          ? _value.opera
          : opera // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegistryAppImplCopyWith<$Res>
    implements $RegistryAppCopyWith<$Res> {
  factory _$$RegistryAppImplCopyWith(
          _$RegistryAppImpl value, $Res Function(_$RegistryAppImpl) then) =
      __$$RegistryAppImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? browser,
      String? ios,
      String? android,
      String? mac,
      String? windows,
      String? linux,
      String? chrome,
      String? firefox,
      String? safari,
      String? edge,
      String? opera});
}

/// @nodoc
class __$$RegistryAppImplCopyWithImpl<$Res>
    extends _$RegistryAppCopyWithImpl<$Res, _$RegistryAppImpl>
    implements _$$RegistryAppImplCopyWith<$Res> {
  __$$RegistryAppImplCopyWithImpl(
      _$RegistryAppImpl _value, $Res Function(_$RegistryAppImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? browser = freezed,
    Object? ios = freezed,
    Object? android = freezed,
    Object? mac = freezed,
    Object? windows = freezed,
    Object? linux = freezed,
    Object? chrome = freezed,
    Object? firefox = freezed,
    Object? safari = freezed,
    Object? edge = freezed,
    Object? opera = freezed,
  }) {
    return _then(_$RegistryAppImpl(
      browser: freezed == browser
          ? _value.browser
          : browser // ignore: cast_nullable_to_non_nullable
              as String?,
      ios: freezed == ios
          ? _value.ios
          : ios // ignore: cast_nullable_to_non_nullable
              as String?,
      android: freezed == android
          ? _value.android
          : android // ignore: cast_nullable_to_non_nullable
              as String?,
      mac: freezed == mac
          ? _value.mac
          : mac // ignore: cast_nullable_to_non_nullable
              as String?,
      windows: freezed == windows
          ? _value.windows
          : windows // ignore: cast_nullable_to_non_nullable
              as String?,
      linux: freezed == linux
          ? _value.linux
          : linux // ignore: cast_nullable_to_non_nullable
              as String?,
      chrome: freezed == chrome
          ? _value.chrome
          : chrome // ignore: cast_nullable_to_non_nullable
              as String?,
      firefox: freezed == firefox
          ? _value.firefox
          : firefox // ignore: cast_nullable_to_non_nullable
              as String?,
      safari: freezed == safari
          ? _value.safari
          : safari // ignore: cast_nullable_to_non_nullable
              as String?,
      edge: freezed == edge
          ? _value.edge
          : edge // ignore: cast_nullable_to_non_nullable
              as String?,
      opera: freezed == opera
          ? _value.opera
          : opera // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class _$RegistryAppImpl implements _RegistryApp {
  const _$RegistryAppImpl(
      {this.browser,
      this.ios,
      this.android,
      this.mac,
      this.windows,
      this.linux,
      this.chrome,
      this.firefox,
      this.safari,
      this.edge,
      this.opera});

  factory _$RegistryAppImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegistryAppImplFromJson(json);

  @override
  final String? browser;
  @override
  final String? ios;
  @override
  final String? android;
  @override
  final String? mac;
  @override
  final String? windows;
  @override
  final String? linux;
  @override
  final String? chrome;
  @override
  final String? firefox;
  @override
  final String? safari;
  @override
  final String? edge;
  @override
  final String? opera;

  @override
  String toString() {
    return 'RegistryApp(browser: $browser, ios: $ios, android: $android, mac: $mac, windows: $windows, linux: $linux, chrome: $chrome, firefox: $firefox, safari: $safari, edge: $edge, opera: $opera)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistryAppImpl &&
            (identical(other.browser, browser) || other.browser == browser) &&
            (identical(other.ios, ios) || other.ios == ios) &&
            (identical(other.android, android) || other.android == android) &&
            (identical(other.mac, mac) || other.mac == mac) &&
            (identical(other.windows, windows) || other.windows == windows) &&
            (identical(other.linux, linux) || other.linux == linux) &&
            (identical(other.chrome, chrome) || other.chrome == chrome) &&
            (identical(other.firefox, firefox) || other.firefox == firefox) &&
            (identical(other.safari, safari) || other.safari == safari) &&
            (identical(other.edge, edge) || other.edge == edge) &&
            (identical(other.opera, opera) || other.opera == opera));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, browser, ios, android, mac,
      windows, linux, chrome, firefox, safari, edge, opera);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistryAppImplCopyWith<_$RegistryAppImpl> get copyWith =>
      __$$RegistryAppImplCopyWithImpl<_$RegistryAppImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegistryAppImplToJson(
      this,
    );
  }
}

abstract class _RegistryApp implements RegistryApp {
  const factory _RegistryApp(
      {final String? browser,
      final String? ios,
      final String? android,
      final String? mac,
      final String? windows,
      final String? linux,
      final String? chrome,
      final String? firefox,
      final String? safari,
      final String? edge,
      final String? opera}) = _$RegistryAppImpl;

  factory _RegistryApp.fromJson(Map<String, dynamic> json) =
      _$RegistryAppImpl.fromJson;

  @override
  String? get browser;
  @override
  String? get ios;
  @override
  String? get android;
  @override
  String? get mac;
  @override
  String? get windows;
  @override
  String? get linux;
  @override
  String? get chrome;
  @override
  String? get firefox;
  @override
  String? get safari;
  @override
  String? get edge;
  @override
  String? get opera;
  @override
  @JsonKey(ignore: true)
  _$$RegistryAppImplCopyWith<_$RegistryAppImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Injected _$InjectedFromJson(Map<String, dynamic> json) {
  return _Injected.fromJson(json);
}

/// @nodoc
mixin _$Injected {
  String? get injectedId => throw _privateConstructorUsedError;
  String? get namespace => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InjectedCopyWith<Injected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InjectedCopyWith<$Res> {
  factory $InjectedCopyWith(Injected value, $Res Function(Injected) then) =
      _$InjectedCopyWithImpl<$Res, Injected>;
  @useResult
  $Res call({String? injectedId, String? namespace});
}

/// @nodoc
class _$InjectedCopyWithImpl<$Res, $Val extends Injected>
    implements $InjectedCopyWith<$Res> {
  _$InjectedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? injectedId = freezed,
    Object? namespace = freezed,
  }) {
    return _then(_value.copyWith(
      injectedId: freezed == injectedId
          ? _value.injectedId
          : injectedId // ignore: cast_nullable_to_non_nullable
              as String?,
      namespace: freezed == namespace
          ? _value.namespace
          : namespace // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InjectedImplCopyWith<$Res>
    implements $InjectedCopyWith<$Res> {
  factory _$$InjectedImplCopyWith(
          _$InjectedImpl value, $Res Function(_$InjectedImpl) then) =
      __$$InjectedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? injectedId, String? namespace});
}

/// @nodoc
class __$$InjectedImplCopyWithImpl<$Res>
    extends _$InjectedCopyWithImpl<$Res, _$InjectedImpl>
    implements _$$InjectedImplCopyWith<$Res> {
  __$$InjectedImplCopyWithImpl(
      _$InjectedImpl _value, $Res Function(_$InjectedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? injectedId = freezed,
    Object? namespace = freezed,
  }) {
    return _then(_$InjectedImpl(
      injectedId: freezed == injectedId
          ? _value.injectedId
          : injectedId // ignore: cast_nullable_to_non_nullable
              as String?,
      namespace: freezed == namespace
          ? _value.namespace
          : namespace // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class _$InjectedImpl implements _Injected {
  const _$InjectedImpl({this.injectedId, this.namespace});

  factory _$InjectedImpl.fromJson(Map<String, dynamic> json) =>
      _$$InjectedImplFromJson(json);

  @override
  final String? injectedId;
  @override
  final String? namespace;

  @override
  String toString() {
    return 'Injected(injectedId: $injectedId, namespace: $namespace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InjectedImpl &&
            (identical(other.injectedId, injectedId) ||
                other.injectedId == injectedId) &&
            (identical(other.namespace, namespace) ||
                other.namespace == namespace));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, injectedId, namespace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InjectedImplCopyWith<_$InjectedImpl> get copyWith =>
      __$$InjectedImplCopyWithImpl<_$InjectedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InjectedImplToJson(
      this,
    );
  }
}

abstract class _Injected implements Injected {
  const factory _Injected({final String? injectedId, final String? namespace}) =
      _$InjectedImpl;

  factory _Injected.fromJson(Map<String, dynamic> json) =
      _$InjectedImpl.fromJson;

  @override
  String? get injectedId;
  @override
  String? get namespace;
  @override
  @JsonKey(ignore: true)
  _$$InjectedImplCopyWith<_$InjectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegistryDesktop _$RegistryDesktopFromJson(Map<String, dynamic> json) {
  return _RegistryDesktop.fromJson(json);
}

/// @nodoc
mixin _$RegistryDesktop {
  String? get native => throw _privateConstructorUsedError;
  String? get universal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegistryDesktopCopyWith<RegistryDesktop> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistryDesktopCopyWith<$Res> {
  factory $RegistryDesktopCopyWith(
          RegistryDesktop value, $Res Function(RegistryDesktop) then) =
      _$RegistryDesktopCopyWithImpl<$Res, RegistryDesktop>;
  @useResult
  $Res call({String? native, String? universal});
}

/// @nodoc
class _$RegistryDesktopCopyWithImpl<$Res, $Val extends RegistryDesktop>
    implements $RegistryDesktopCopyWith<$Res> {
  _$RegistryDesktopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? native = freezed,
    Object? universal = freezed,
  }) {
    return _then(_value.copyWith(
      native: freezed == native
          ? _value.native
          : native // ignore: cast_nullable_to_non_nullable
              as String?,
      universal: freezed == universal
          ? _value.universal
          : universal // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegistryDesktopImplCopyWith<$Res>
    implements $RegistryDesktopCopyWith<$Res> {
  factory _$$RegistryDesktopImplCopyWith(_$RegistryDesktopImpl value,
          $Res Function(_$RegistryDesktopImpl) then) =
      __$$RegistryDesktopImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? native, String? universal});
}

/// @nodoc
class __$$RegistryDesktopImplCopyWithImpl<$Res>
    extends _$RegistryDesktopCopyWithImpl<$Res, _$RegistryDesktopImpl>
    implements _$$RegistryDesktopImplCopyWith<$Res> {
  __$$RegistryDesktopImplCopyWithImpl(
      _$RegistryDesktopImpl _value, $Res Function(_$RegistryDesktopImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? native = freezed,
    Object? universal = freezed,
  }) {
    return _then(_$RegistryDesktopImpl(
      native: freezed == native
          ? _value.native
          : native // ignore: cast_nullable_to_non_nullable
              as String?,
      universal: freezed == universal
          ? _value.universal
          : universal // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class _$RegistryDesktopImpl implements _RegistryDesktop {
  const _$RegistryDesktopImpl({this.native, this.universal});

  factory _$RegistryDesktopImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegistryDesktopImplFromJson(json);

  @override
  final String? native;
  @override
  final String? universal;

  @override
  String toString() {
    return 'RegistryDesktop(native: $native, universal: $universal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistryDesktopImpl &&
            (identical(other.native, native) || other.native == native) &&
            (identical(other.universal, universal) ||
                other.universal == universal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, native, universal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistryDesktopImplCopyWith<_$RegistryDesktopImpl> get copyWith =>
      __$$RegistryDesktopImplCopyWithImpl<_$RegistryDesktopImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegistryDesktopImplToJson(
      this,
    );
  }
}

abstract class _RegistryDesktop implements RegistryDesktop {
  const factory _RegistryDesktop(
      {final String? native, final String? universal}) = _$RegistryDesktopImpl;

  factory _RegistryDesktop.fromJson(Map<String, dynamic> json) =
      _$RegistryDesktopImpl.fromJson;

  @override
  String? get native;
  @override
  String? get universal;
  @override
  @JsonKey(ignore: true)
  _$$RegistryDesktopImplCopyWith<_$RegistryDesktopImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegistryMobile _$RegistryMobileFromJson(Map<String, dynamic> json) {
  return _RegistryMobile.fromJson(json);
}

/// @nodoc
mixin _$RegistryMobile {
  String? get native => throw _privateConstructorUsedError;
  String? get universal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegistryMobileCopyWith<RegistryMobile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistryMobileCopyWith<$Res> {
  factory $RegistryMobileCopyWith(
          RegistryMobile value, $Res Function(RegistryMobile) then) =
      _$RegistryMobileCopyWithImpl<$Res, RegistryMobile>;
  @useResult
  $Res call({String? native, String? universal});
}

/// @nodoc
class _$RegistryMobileCopyWithImpl<$Res, $Val extends RegistryMobile>
    implements $RegistryMobileCopyWith<$Res> {
  _$RegistryMobileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? native = freezed,
    Object? universal = freezed,
  }) {
    return _then(_value.copyWith(
      native: freezed == native
          ? _value.native
          : native // ignore: cast_nullable_to_non_nullable
              as String?,
      universal: freezed == universal
          ? _value.universal
          : universal // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegistryMobileImplCopyWith<$Res>
    implements $RegistryMobileCopyWith<$Res> {
  factory _$$RegistryMobileImplCopyWith(_$RegistryMobileImpl value,
          $Res Function(_$RegistryMobileImpl) then) =
      __$$RegistryMobileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? native, String? universal});
}

/// @nodoc
class __$$RegistryMobileImplCopyWithImpl<$Res>
    extends _$RegistryMobileCopyWithImpl<$Res, _$RegistryMobileImpl>
    implements _$$RegistryMobileImplCopyWith<$Res> {
  __$$RegistryMobileImplCopyWithImpl(
      _$RegistryMobileImpl _value, $Res Function(_$RegistryMobileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? native = freezed,
    Object? universal = freezed,
  }) {
    return _then(_$RegistryMobileImpl(
      native: freezed == native
          ? _value.native
          : native // ignore: cast_nullable_to_non_nullable
              as String?,
      universal: freezed == universal
          ? _value.universal
          : universal // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class _$RegistryMobileImpl implements _RegistryMobile {
  const _$RegistryMobileImpl({this.native, this.universal});

  factory _$RegistryMobileImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegistryMobileImplFromJson(json);

  @override
  final String? native;
  @override
  final String? universal;

  @override
  String toString() {
    return 'RegistryMobile(native: $native, universal: $universal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistryMobileImpl &&
            (identical(other.native, native) || other.native == native) &&
            (identical(other.universal, universal) ||
                other.universal == universal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, native, universal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistryMobileImplCopyWith<_$RegistryMobileImpl> get copyWith =>
      __$$RegistryMobileImplCopyWithImpl<_$RegistryMobileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegistryMobileImplToJson(
      this,
    );
  }
}

abstract class _RegistryMobile implements RegistryMobile {
  const factory _RegistryMobile(
      {final String? native, final String? universal}) = _$RegistryMobileImpl;

  factory _RegistryMobile.fromJson(Map<String, dynamic> json) =
      _$RegistryMobileImpl.fromJson;

  @override
  String? get native;
  @override
  String? get universal;
  @override
  @JsonKey(ignore: true)
  _$$RegistryMobileImplCopyWith<_$RegistryMobileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegistryMetadata _$RegistryMetadataFromJson(Map<String, dynamic> json) {
  return _RegistryMetadata.fromJson(json);
}

/// @nodoc
mixin _$RegistryMetadata {
  /// Yes this is inconsistent with the other metadata field naming
  @JsonKey(name: 'shortName')
  String? get shortName => throw _privateConstructorUsedError;
  Map<String, String?>? get colors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegistryMetadataCopyWith<RegistryMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistryMetadataCopyWith<$Res> {
  factory $RegistryMetadataCopyWith(
          RegistryMetadata value, $Res Function(RegistryMetadata) then) =
      _$RegistryMetadataCopyWithImpl<$Res, RegistryMetadata>;
  @useResult
  $Res call(
      {@JsonKey(name: 'shortName') String? shortName,
      Map<String, String?>? colors});
}

/// @nodoc
class _$RegistryMetadataCopyWithImpl<$Res, $Val extends RegistryMetadata>
    implements $RegistryMetadataCopyWith<$Res> {
  _$RegistryMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shortName = freezed,
    Object? colors = freezed,
  }) {
    return _then(_value.copyWith(
      shortName: freezed == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      colors: freezed == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegistryMetadataImplCopyWith<$Res>
    implements $RegistryMetadataCopyWith<$Res> {
  factory _$$RegistryMetadataImplCopyWith(_$RegistryMetadataImpl value,
          $Res Function(_$RegistryMetadataImpl) then) =
      __$$RegistryMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'shortName') String? shortName,
      Map<String, String?>? colors});
}

/// @nodoc
class __$$RegistryMetadataImplCopyWithImpl<$Res>
    extends _$RegistryMetadataCopyWithImpl<$Res, _$RegistryMetadataImpl>
    implements _$$RegistryMetadataImplCopyWith<$Res> {
  __$$RegistryMetadataImplCopyWithImpl(_$RegistryMetadataImpl _value,
      $Res Function(_$RegistryMetadataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shortName = freezed,
    Object? colors = freezed,
  }) {
    return _then(_$RegistryMetadataImpl(
      shortName: freezed == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      colors: freezed == colors
          ? _value._colors
          : colors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class _$RegistryMetadataImpl implements _RegistryMetadata {
  const _$RegistryMetadataImpl(
      {@JsonKey(name: 'shortName') this.shortName,
      final Map<String, String?>? colors})
      : _colors = colors;

  factory _$RegistryMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegistryMetadataImplFromJson(json);

  /// Yes this is inconsistent with the other metadata field naming
  @override
  @JsonKey(name: 'shortName')
  final String? shortName;
  final Map<String, String?>? _colors;
  @override
  Map<String, String?>? get colors {
    final value = _colors;
    if (value == null) return null;
    if (_colors is EqualUnmodifiableMapView) return _colors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'RegistryMetadata(shortName: $shortName, colors: $colors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistryMetadataImpl &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            const DeepCollectionEquality().equals(other._colors, _colors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, shortName, const DeepCollectionEquality().hash(_colors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistryMetadataImplCopyWith<_$RegistryMetadataImpl> get copyWith =>
      __$$RegistryMetadataImplCopyWithImpl<_$RegistryMetadataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegistryMetadataImplToJson(
      this,
    );
  }
}

abstract class _RegistryMetadata implements RegistryMetadata {
  const factory _RegistryMetadata(
      {@JsonKey(name: 'shortName') final String? shortName,
      final Map<String, String?>? colors}) = _$RegistryMetadataImpl;

  factory _RegistryMetadata.fromJson(Map<String, dynamic> json) =
      _$RegistryMetadataImpl.fromJson;

  @override

  /// Yes this is inconsistent with the other metadata field naming
  @JsonKey(name: 'shortName')
  String? get shortName;
  @override
  Map<String, String?>? get colors;
  @override
  @JsonKey(ignore: true)
  _$$RegistryMetadataImplCopyWith<_$RegistryMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegistryStandard _$RegistryStandardFromJson(Map<String, dynamic> json) {
  return _RegistryStandard.fromJson(json);
}

/// @nodoc
mixin _$RegistryStandard {
  String? get id => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  int? get standardId => throw _privateConstructorUsedError;
  String? get standardPrefix => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegistryStandardCopyWith<RegistryStandard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistryStandardCopyWith<$Res> {
  factory $RegistryStandardCopyWith(
          RegistryStandard value, $Res Function(RegistryStandard) then) =
      _$RegistryStandardCopyWithImpl<$Res, RegistryStandard>;
  @useResult
  $Res call(
      {String? id,
      String? url,
      String? title,
      int? standardId,
      String? standardPrefix});
}

/// @nodoc
class _$RegistryStandardCopyWithImpl<$Res, $Val extends RegistryStandard>
    implements $RegistryStandardCopyWith<$Res> {
  _$RegistryStandardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? title = freezed,
    Object? standardId = freezed,
    Object? standardPrefix = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      standardId: freezed == standardId
          ? _value.standardId
          : standardId // ignore: cast_nullable_to_non_nullable
              as int?,
      standardPrefix: freezed == standardPrefix
          ? _value.standardPrefix
          : standardPrefix // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegistryStandardImplCopyWith<$Res>
    implements $RegistryStandardCopyWith<$Res> {
  factory _$$RegistryStandardImplCopyWith(_$RegistryStandardImpl value,
          $Res Function(_$RegistryStandardImpl) then) =
      __$$RegistryStandardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? url,
      String? title,
      int? standardId,
      String? standardPrefix});
}

/// @nodoc
class __$$RegistryStandardImplCopyWithImpl<$Res>
    extends _$RegistryStandardCopyWithImpl<$Res, _$RegistryStandardImpl>
    implements _$$RegistryStandardImplCopyWith<$Res> {
  __$$RegistryStandardImplCopyWithImpl(_$RegistryStandardImpl _value,
      $Res Function(_$RegistryStandardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? title = freezed,
    Object? standardId = freezed,
    Object? standardPrefix = freezed,
  }) {
    return _then(_$RegistryStandardImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      standardId: freezed == standardId
          ? _value.standardId
          : standardId // ignore: cast_nullable_to_non_nullable
              as int?,
      standardPrefix: freezed == standardPrefix
          ? _value.standardPrefix
          : standardPrefix // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class _$RegistryStandardImpl extends _RegistryStandard {
  const _$RegistryStandardImpl(
      {this.id, this.url, this.title, this.standardId, this.standardPrefix})
      : super._();

  factory _$RegistryStandardImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegistryStandardImplFromJson(json);

  @override
  final String? id;
  @override
  final String? url;
  @override
  final String? title;
  @override
  final int? standardId;
  @override
  final String? standardPrefix;

  @override
  String toString() {
    return 'RegistryStandard(id: $id, url: $url, title: $title, standardId: $standardId, standardPrefix: $standardPrefix)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistryStandardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.standardId, standardId) ||
                other.standardId == standardId) &&
            (identical(other.standardPrefix, standardPrefix) ||
                other.standardPrefix == standardPrefix));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, url, title, standardId, standardPrefix);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistryStandardImplCopyWith<_$RegistryStandardImpl> get copyWith =>
      __$$RegistryStandardImplCopyWithImpl<_$RegistryStandardImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegistryStandardImplToJson(
      this,
    );
  }
}

abstract class _RegistryStandard extends RegistryStandard {
  const factory _RegistryStandard(
      {final String? id,
      final String? url,
      final String? title,
      final int? standardId,
      final String? standardPrefix}) = _$RegistryStandardImpl;
  const _RegistryStandard._() : super._();

  factory _RegistryStandard.fromJson(Map<String, dynamic> json) =
      _$RegistryStandardImpl.fromJson;

  @override
  String? get id;
  @override
  String? get url;
  @override
  String? get title;
  @override
  int? get standardId;
  @override
  String? get standardPrefix;
  @override
  @JsonKey(ignore: true)
  _$$RegistryStandardImplCopyWith<_$RegistryStandardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExplorerRegistryListing _$ExplorerRegistryListingFromJson(
    Map<String, dynamic> json) {
  return _ExplorerRegistryListing.fromJson(json);
}

/// @nodoc
mixin _$ExplorerRegistryListing {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get homepage => throw _privateConstructorUsedError;
  List<String>? get chains =>
      throw _privateConstructorUsedError; //  CAIP-2 formatted Blockchain ID  [ "eip155:1" ]
  List<String>? get versions => throw _privateConstructorUsedError;
  List<String>? get sdks => throw _privateConstructorUsedError;
  String? get appType => throw _privateConstructorUsedError;
  String? get imageId => throw _privateConstructorUsedError;
  RegistryImageUrl? get image_url => throw _privateConstructorUsedError;
  RegistryApp? get app => throw _privateConstructorUsedError;
  List<Injected>? get injected => throw _privateConstructorUsedError;
  RegistryMobile? get mobile => throw _privateConstructorUsedError;
  RegistryDesktop? get desktop => throw _privateConstructorUsedError;
  List<RegistryStandard>? get supportedStandards =>
      throw _privateConstructorUsedError;
  RegistryMetadata? get metadata => throw _privateConstructorUsedError;

  /// Date the registry listing was last updated so we can cache results
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExplorerRegistryListingCopyWith<ExplorerRegistryListing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplorerRegistryListingCopyWith<$Res> {
  factory $ExplorerRegistryListingCopyWith(ExplorerRegistryListing value,
          $Res Function(ExplorerRegistryListing) then) =
      _$ExplorerRegistryListingCopyWithImpl<$Res, ExplorerRegistryListing>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? slug,
      String? description,
      String? homepage,
      List<String>? chains,
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
      DateTime? updatedAt});

  $RegistryImageUrlCopyWith<$Res>? get image_url;
  $RegistryAppCopyWith<$Res>? get app;
  $RegistryMobileCopyWith<$Res>? get mobile;
  $RegistryDesktopCopyWith<$Res>? get desktop;
  $RegistryMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class _$ExplorerRegistryListingCopyWithImpl<$Res,
        $Val extends ExplorerRegistryListing>
    implements $ExplorerRegistryListingCopyWith<$Res> {
  _$ExplorerRegistryListingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = freezed,
    Object? description = freezed,
    Object? homepage = freezed,
    Object? chains = freezed,
    Object? versions = freezed,
    Object? sdks = freezed,
    Object? appType = freezed,
    Object? imageId = freezed,
    Object? image_url = freezed,
    Object? app = freezed,
    Object? injected = freezed,
    Object? mobile = freezed,
    Object? desktop = freezed,
    Object? supportedStandards = freezed,
    Object? metadata = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      homepage: freezed == homepage
          ? _value.homepage
          : homepage // ignore: cast_nullable_to_non_nullable
              as String?,
      chains: freezed == chains
          ? _value.chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      versions: freezed == versions
          ? _value.versions
          : versions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      sdks: freezed == sdks
          ? _value.sdks
          : sdks // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      appType: freezed == appType
          ? _value.appType
          : appType // ignore: cast_nullable_to_non_nullable
              as String?,
      imageId: freezed == imageId
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as String?,
      image_url: freezed == image_url
          ? _value.image_url
          : image_url // ignore: cast_nullable_to_non_nullable
              as RegistryImageUrl?,
      app: freezed == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as RegistryApp?,
      injected: freezed == injected
          ? _value.injected
          : injected // ignore: cast_nullable_to_non_nullable
              as List<Injected>?,
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as RegistryMobile?,
      desktop: freezed == desktop
          ? _value.desktop
          : desktop // ignore: cast_nullable_to_non_nullable
              as RegistryDesktop?,
      supportedStandards: freezed == supportedStandards
          ? _value.supportedStandards
          : supportedStandards // ignore: cast_nullable_to_non_nullable
              as List<RegistryStandard>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as RegistryMetadata?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RegistryImageUrlCopyWith<$Res>? get image_url {
    if (_value.image_url == null) {
      return null;
    }

    return $RegistryImageUrlCopyWith<$Res>(_value.image_url!, (value) {
      return _then(_value.copyWith(image_url: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RegistryAppCopyWith<$Res>? get app {
    if (_value.app == null) {
      return null;
    }

    return $RegistryAppCopyWith<$Res>(_value.app!, (value) {
      return _then(_value.copyWith(app: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RegistryMobileCopyWith<$Res>? get mobile {
    if (_value.mobile == null) {
      return null;
    }

    return $RegistryMobileCopyWith<$Res>(_value.mobile!, (value) {
      return _then(_value.copyWith(mobile: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RegistryDesktopCopyWith<$Res>? get desktop {
    if (_value.desktop == null) {
      return null;
    }

    return $RegistryDesktopCopyWith<$Res>(_value.desktop!, (value) {
      return _then(_value.copyWith(desktop: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RegistryMetadataCopyWith<$Res>? get metadata {
    if (_value.metadata == null) {
      return null;
    }

    return $RegistryMetadataCopyWith<$Res>(_value.metadata!, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplorerRegistryListingImplCopyWith<$Res>
    implements $ExplorerRegistryListingCopyWith<$Res> {
  factory _$$ExplorerRegistryListingImplCopyWith(
          _$ExplorerRegistryListingImpl value,
          $Res Function(_$ExplorerRegistryListingImpl) then) =
      __$$ExplorerRegistryListingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? slug,
      String? description,
      String? homepage,
      List<String>? chains,
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
      DateTime? updatedAt});

  @override
  $RegistryImageUrlCopyWith<$Res>? get image_url;
  @override
  $RegistryAppCopyWith<$Res>? get app;
  @override
  $RegistryMobileCopyWith<$Res>? get mobile;
  @override
  $RegistryDesktopCopyWith<$Res>? get desktop;
  @override
  $RegistryMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class __$$ExplorerRegistryListingImplCopyWithImpl<$Res>
    extends _$ExplorerRegistryListingCopyWithImpl<$Res,
        _$ExplorerRegistryListingImpl>
    implements _$$ExplorerRegistryListingImplCopyWith<$Res> {
  __$$ExplorerRegistryListingImplCopyWithImpl(
      _$ExplorerRegistryListingImpl _value,
      $Res Function(_$ExplorerRegistryListingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = freezed,
    Object? description = freezed,
    Object? homepage = freezed,
    Object? chains = freezed,
    Object? versions = freezed,
    Object? sdks = freezed,
    Object? appType = freezed,
    Object? imageId = freezed,
    Object? image_url = freezed,
    Object? app = freezed,
    Object? injected = freezed,
    Object? mobile = freezed,
    Object? desktop = freezed,
    Object? supportedStandards = freezed,
    Object? metadata = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ExplorerRegistryListingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      homepage: freezed == homepage
          ? _value.homepage
          : homepage // ignore: cast_nullable_to_non_nullable
              as String?,
      chains: freezed == chains
          ? _value._chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      versions: freezed == versions
          ? _value._versions
          : versions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      sdks: freezed == sdks
          ? _value._sdks
          : sdks // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      appType: freezed == appType
          ? _value.appType
          : appType // ignore: cast_nullable_to_non_nullable
              as String?,
      imageId: freezed == imageId
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as String?,
      image_url: freezed == image_url
          ? _value.image_url
          : image_url // ignore: cast_nullable_to_non_nullable
              as RegistryImageUrl?,
      app: freezed == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as RegistryApp?,
      injected: freezed == injected
          ? _value._injected
          : injected // ignore: cast_nullable_to_non_nullable
              as List<Injected>?,
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as RegistryMobile?,
      desktop: freezed == desktop
          ? _value.desktop
          : desktop // ignore: cast_nullable_to_non_nullable
              as RegistryDesktop?,
      supportedStandards: freezed == supportedStandards
          ? _value._supportedStandards
          : supportedStandards // ignore: cast_nullable_to_non_nullable
              as List<RegistryStandard>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as RegistryMetadata?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class _$ExplorerRegistryListingImpl extends _ExplorerRegistryListing {
  const _$ExplorerRegistryListingImpl(
      {this.id = 'Unknown ID',
      this.name = 'Unknown Name',
      this.slug,
      this.description,
      this.homepage,
      final List<String>? chains,
      final List<String>? versions,
      final List<String>? sdks,
      this.appType,
      this.imageId,
      this.image_url,
      this.app,
      final List<Injected>? injected,
      this.mobile,
      this.desktop,
      final List<RegistryStandard>? supportedStandards,
      this.metadata,
      this.updatedAt})
      : _chains = chains,
        _versions = versions,
        _sdks = sdks,
        _injected = injected,
        _supportedStandards = supportedStandards,
        super._();

  factory _$ExplorerRegistryListingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExplorerRegistryListingImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final String? slug;
  @override
  final String? description;
  @override
  final String? homepage;
  final List<String>? _chains;
  @override
  List<String>? get chains {
    final value = _chains;
    if (value == null) return null;
    if (_chains is EqualUnmodifiableListView) return _chains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

//  CAIP-2 formatted Blockchain ID  [ "eip155:1" ]
  final List<String>? _versions;
//  CAIP-2 formatted Blockchain ID  [ "eip155:1" ]
  @override
  List<String>? get versions {
    final value = _versions;
    if (value == null) return null;
    if (_versions is EqualUnmodifiableListView) return _versions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _sdks;
  @override
  List<String>? get sdks {
    final value = _sdks;
    if (value == null) return null;
    if (_sdks is EqualUnmodifiableListView) return _sdks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? appType;
  @override
  final String? imageId;
  @override
  final RegistryImageUrl? image_url;
  @override
  final RegistryApp? app;
  final List<Injected>? _injected;
  @override
  List<Injected>? get injected {
    final value = _injected;
    if (value == null) return null;
    if (_injected is EqualUnmodifiableListView) return _injected;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final RegistryMobile? mobile;
  @override
  final RegistryDesktop? desktop;
  final List<RegistryStandard>? _supportedStandards;
  @override
  List<RegistryStandard>? get supportedStandards {
    final value = _supportedStandards;
    if (value == null) return null;
    if (_supportedStandards is EqualUnmodifiableListView)
      return _supportedStandards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final RegistryMetadata? metadata;

  /// Date the registry listing was last updated so we can cache results
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ExplorerRegistryListing(id: $id, name: $name, slug: $slug, description: $description, homepage: $homepage, chains: $chains, versions: $versions, sdks: $sdks, appType: $appType, imageId: $imageId, image_url: $image_url, app: $app, injected: $injected, mobile: $mobile, desktop: $desktop, supportedStandards: $supportedStandards, metadata: $metadata, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplorerRegistryListingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.homepage, homepage) ||
                other.homepage == homepage) &&
            const DeepCollectionEquality().equals(other._chains, _chains) &&
            const DeepCollectionEquality().equals(other._versions, _versions) &&
            const DeepCollectionEquality().equals(other._sdks, _sdks) &&
            (identical(other.appType, appType) || other.appType == appType) &&
            (identical(other.imageId, imageId) || other.imageId == imageId) &&
            (identical(other.image_url, image_url) ||
                other.image_url == image_url) &&
            (identical(other.app, app) || other.app == app) &&
            const DeepCollectionEquality().equals(other._injected, _injected) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.desktop, desktop) || other.desktop == desktop) &&
            const DeepCollectionEquality()
                .equals(other._supportedStandards, _supportedStandards) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      slug,
      description,
      homepage,
      const DeepCollectionEquality().hash(_chains),
      const DeepCollectionEquality().hash(_versions),
      const DeepCollectionEquality().hash(_sdks),
      appType,
      imageId,
      image_url,
      app,
      const DeepCollectionEquality().hash(_injected),
      mobile,
      desktop,
      const DeepCollectionEquality().hash(_supportedStandards),
      metadata,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplorerRegistryListingImplCopyWith<_$ExplorerRegistryListingImpl>
      get copyWith => __$$ExplorerRegistryListingImplCopyWithImpl<
          _$ExplorerRegistryListingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplorerRegistryListingImplToJson(
      this,
    );
  }
}

abstract class _ExplorerRegistryListing extends ExplorerRegistryListing {
  const factory _ExplorerRegistryListing(
      {final String id,
      final String name,
      final String? slug,
      final String? description,
      final String? homepage,
      final List<String>? chains,
      final List<String>? versions,
      final List<String>? sdks,
      final String? appType,
      final String? imageId,
      final RegistryImageUrl? image_url,
      final RegistryApp? app,
      final List<Injected>? injected,
      final RegistryMobile? mobile,
      final RegistryDesktop? desktop,
      final List<RegistryStandard>? supportedStandards,
      final RegistryMetadata? metadata,
      final DateTime? updatedAt}) = _$ExplorerRegistryListingImpl;
  const _ExplorerRegistryListing._() : super._();

  factory _ExplorerRegistryListing.fromJson(Map<String, dynamic> json) =
      _$ExplorerRegistryListingImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get slug;
  @override
  String? get description;
  @override
  String? get homepage;
  @override
  List<String>? get chains;
  @override //  CAIP-2 formatted Blockchain ID  [ "eip155:1" ]
  List<String>? get versions;
  @override
  List<String>? get sdks;
  @override
  String? get appType;
  @override
  String? get imageId;
  @override
  RegistryImageUrl? get image_url;
  @override
  RegistryApp? get app;
  @override
  List<Injected>? get injected;
  @override
  RegistryMobile? get mobile;
  @override
  RegistryDesktop? get desktop;
  @override
  List<RegistryStandard>? get supportedStandards;
  @override
  RegistryMetadata? get metadata;
  @override

  /// Date the registry listing was last updated so we can cache results
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ExplorerRegistryListingImplCopyWith<_$ExplorerRegistryListingImpl>
      get copyWith => throw _privateConstructorUsedError;
}
