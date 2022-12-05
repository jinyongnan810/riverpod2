import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/firestore_collection_name.dart';
import 'package:instantgram/constants/storage_collection_name.dart';
import 'package:instantgram/constants/thumbnail_settings.dart';
import 'package:instantgram/enums/file_type.dart';
import 'package:instantgram/enums/post_settings.dart';
import 'package:instantgram/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:instantgram/extensions/image_aspect.dart';
import 'package:instantgram/models/post_payload.dart';
import 'package:instantgram/typedefs/is_loading.dart';
import 'package:instantgram/typedefs/user_id.dart';
import 'package:uuid/uuid.dart';
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
    final thumbnailAspectRatio = await thumbnailUint8List.getAspectRatio();
    // generate file name
    final fileName = const Uuid().v4();
    // get firebase storage ref
    final originalRef = FirebaseStorage.instance
        .ref('$userId/${fileType.getStorageName()}/$fileName}');
    final thumbnailRef = FirebaseStorage.instance
        .ref('$userId/${StorageCollectionName.thumbnails}/$fileName}');

    try {
      // upload files
      final originalUploadTask = await originalRef.putFile(file);
      final originalStorageId = originalUploadTask.ref.name;
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;
      // create post payload
      final postPayload = PostPayload(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbnailAspectRatio,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalStorageId,
        postSettings: postSettings,
      );
      // upload to firestore
      await FirebaseFirestore.instance
          .collection(FirestoreCollectionName.posts)
          .add(postPayload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
