import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/thumbnail_settings.dart';
import 'package:instantgram/enums/file_type.dart';
import 'package:instantgram/enums/post_settings.dart';
import 'package:instantgram/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:instantgram/typedefs/is_loading.dart';
import 'package:instantgram/typedefs/user_id.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UploadNotifier extends StateNotifier<IsLoading> {
  UploadNotifier() : super(false);
  set isLoading(bool loading) => state = loading;
  Future<bool> upload({
    required File file,
    required FileType fileType,
    required UserId userId,
    required String message,
    required Map<PostSettings, bool> postSettings,
  }) async {
    isLoading = true;

    // get thumbnail
    late Uint8List thumbnailUint8List;
    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          throw const CouldNotBuildThumbnailException();
        }
        final thumbnail = img.copyResize(
          fileAsImage,
          width: ThumbnailSettings.imageThumbnailWidth,
        );
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final thumbnail = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          quality: ThumbnailSettings.videoThumbnailQuality,
          maxHeight: ThumbnailSettings.videoThumbnailMaxHeight,
        );
        if (thumbnail == null) {
          throw const CouldNotBuildThumbnailException();
        }
        thumbnailUint8List = thumbnail;
        break;
    }

    // get aspect ratio

    isLoading = false;
    return true;
  }
}
