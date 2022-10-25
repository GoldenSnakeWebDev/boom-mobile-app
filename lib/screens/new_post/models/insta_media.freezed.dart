// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'insta_media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InstaMedia _$InstaMediaFromJson(Map<String, dynamic> json) {
  return _InstaMedia.fromJson(json);
}

/// @nodoc
mixin _$InstaMedia {
  String get id => throw _privateConstructorUsedError;
  String get media_type => throw _privateConstructorUsedError;
  String get media_url => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InstaMediaCopyWith<InstaMedia> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstaMediaCopyWith<$Res> {
  factory $InstaMediaCopyWith(
          InstaMedia value, $Res Function(InstaMedia) then) =
      _$InstaMediaCopyWithImpl<$Res, InstaMedia>;
  @useResult
  $Res call(
      {String id,
      String media_type,
      String media_url,
      String username,
      String timestamp});
}

/// @nodoc
class _$InstaMediaCopyWithImpl<$Res, $Val extends InstaMedia>
    implements $InstaMediaCopyWith<$Res> {
  _$InstaMediaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? media_type = null,
    Object? media_url = null,
    Object? username = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      media_type: null == media_type
          ? _value.media_type
          : media_type // ignore: cast_nullable_to_non_nullable
              as String,
      media_url: null == media_url
          ? _value.media_url
          : media_url // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InstaMediaCopyWith<$Res>
    implements $InstaMediaCopyWith<$Res> {
  factory _$$_InstaMediaCopyWith(
          _$_InstaMedia value, $Res Function(_$_InstaMedia) then) =
      __$$_InstaMediaCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String media_type,
      String media_url,
      String username,
      String timestamp});
}

/// @nodoc
class __$$_InstaMediaCopyWithImpl<$Res>
    extends _$InstaMediaCopyWithImpl<$Res, _$_InstaMedia>
    implements _$$_InstaMediaCopyWith<$Res> {
  __$$_InstaMediaCopyWithImpl(
      _$_InstaMedia _value, $Res Function(_$_InstaMedia) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? media_type = null,
    Object? media_url = null,
    Object? username = null,
    Object? timestamp = null,
  }) {
    return _then(_$_InstaMedia(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      media_type: null == media_type
          ? _value.media_type
          : media_type // ignore: cast_nullable_to_non_nullable
              as String,
      media_url: null == media_url
          ? _value.media_url
          : media_url // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InstaMedia extends _InstaMedia {
  const _$_InstaMedia(
      {required this.id,
      required this.media_type,
      required this.media_url,
      required this.username,
      required this.timestamp})
      : super._();

  factory _$_InstaMedia.fromJson(Map<String, dynamic> json) =>
      _$$_InstaMediaFromJson(json);

  @override
  final String id;
  @override
  final String media_type;
  @override
  final String media_url;
  @override
  final String username;
  @override
  final String timestamp;

  @override
  String toString() {
    return 'InstaMedia(id: $id, media_type: $media_type, media_url: $media_url, username: $username, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InstaMedia &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.media_type, media_type) ||
                other.media_type == media_type) &&
            (identical(other.media_url, media_url) ||
                other.media_url == media_url) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, media_type, media_url, username, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InstaMediaCopyWith<_$_InstaMedia> get copyWith =>
      __$$_InstaMediaCopyWithImpl<_$_InstaMedia>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InstaMediaToJson(
      this,
    );
  }
}

abstract class _InstaMedia extends InstaMedia {
  const factory _InstaMedia(
      {required final String id,
      required final String media_type,
      required final String media_url,
      required final String username,
      required final String timestamp}) = _$_InstaMedia;
  const _InstaMedia._() : super._();

  factory _InstaMedia.fromJson(Map<String, dynamic> json) =
      _$_InstaMedia.fromJson;

  @override
  String get id;
  @override
  String get media_type;
  @override
  String get media_url;
  @override
  String get username;
  @override
  String get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$_InstaMediaCopyWith<_$_InstaMedia> get copyWith =>
      throw _privateConstructorUsedError;
}
