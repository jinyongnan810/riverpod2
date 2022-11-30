import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instantgram/enums/file_type.dart';
part 'thumbnail_request.freezed.dart';

@freezed
abstract class ThumbnailRequest with _$ThumbnailRequest {
  const factory ThumbnailRequest({
    required File file,
    required FileType fileType,
  }) = _ThumbnailRequest;
}
