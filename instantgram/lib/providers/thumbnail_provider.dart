import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/thumbnail_settings.dart';
import 'package:instantgram/enums/file_type.dart';
import 'package:instantgram/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:instantgram/extensions/image_aspect.dart';
import 'package:instantgram/models/image_with_aspect_ratio.dart';
import 'package:instantgram/models/thumbnail_request.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final thumbnailProvider =
    FutureProvider.family.autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
  (ref, thumbnailRequest) async {
    final Image image;
    switch (thumbnailRequest.fileType) {
      case FileType.image:
        image = Image.file(
          thumbnailRequest.file,
          fit: BoxFit.fitHeight,
        );
        break;
      case FileType.video:
        final thumbnail = await VideoThumbnail.thumbnailData(
          video: thumbnailRequest.file.path,
          imageFormat: ImageFormat.JPEG,
          quality: ThumbnailSettings.videoThumbnailQuality,
        );
        if (thumbnail == null) {
          throw const CouldNotBuildThumbnailException();
        }
        image = Image.memory(
          thumbnail,
          fit: BoxFit.fitHeight,
        );
        break;
    }
    final aspectRatio = await image.getAspectRatio();
    return ImageWithAspectRatio(
      image: image,
      aspectRatio: aspectRatio,
    );
  },
);
