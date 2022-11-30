// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thumbnail_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ThumbnailRequest {
  File get file => throw _privateConstructorUsedError;
  FileType get fileType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThumbnailRequestCopyWith<ThumbnailRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThumbnailRequestCopyWith<$Res> {
  factory $ThumbnailRequestCopyWith(
          ThumbnailRequest value, $Res Function(ThumbnailRequest) then) =
      _$ThumbnailRequestCopyWithImpl<$Res, ThumbnailRequest>;
  @useResult
  $Res call({File file, FileType fileType});
}

/// @nodoc
class _$ThumbnailRequestCopyWithImpl<$Res, $Val extends ThumbnailRequest>
    implements $ThumbnailRequestCopyWith<$Res> {
  _$ThumbnailRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
    Object? fileType = null,
  }) {
    return _then(_value.copyWith(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File,
      fileType: null == fileType
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as FileType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ThumbnailRequestCopyWith<$Res>
    implements $ThumbnailRequestCopyWith<$Res> {
  factory _$$_ThumbnailRequestCopyWith(
          _$_ThumbnailRequest value, $Res Function(_$_ThumbnailRequest) then) =
      __$$_ThumbnailRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({File file, FileType fileType});
}

/// @nodoc
class __$$_ThumbnailRequestCopyWithImpl<$Res>
    extends _$ThumbnailRequestCopyWithImpl<$Res, _$_ThumbnailRequest>
    implements _$$_ThumbnailRequestCopyWith<$Res> {
  __$$_ThumbnailRequestCopyWithImpl(
      _$_ThumbnailRequest _value, $Res Function(_$_ThumbnailRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
    Object? fileType = null,
  }) {
    return _then(_$_ThumbnailRequest(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File,
      fileType: null == fileType
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as FileType,
    ));
  }
}

/// @nodoc

class _$_ThumbnailRequest implements _ThumbnailRequest {
  const _$_ThumbnailRequest({required this.file, required this.fileType});

  @override
  final File file;
  @override
  final FileType fileType;

  @override
  String toString() {
    return 'ThumbnailRequest(file: $file, fileType: $fileType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThumbnailRequest &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, file, fileType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ThumbnailRequestCopyWith<_$_ThumbnailRequest> get copyWith =>
      __$$_ThumbnailRequestCopyWithImpl<_$_ThumbnailRequest>(this, _$identity);
}

abstract class _ThumbnailRequest implements ThumbnailRequest {
  const factory _ThumbnailRequest(
      {required final File file,
      required final FileType fileType}) = _$_ThumbnailRequest;

  @override
  File get file;
  @override
  FileType get fileType;
  @override
  @JsonKey(ignore: true)
  _$$_ThumbnailRequestCopyWith<_$_ThumbnailRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
