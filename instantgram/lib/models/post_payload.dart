import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/enums/file_type.dart';
import 'package:instantgram/enums/post_settings.dart';
import 'package:instantgram/typedefs/user_id.dart';

class PostPayload extends MapView<String, dynamic> {
  PostPayload({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required FileType fileType,
    required String fileName,
    required double aspectRatio,
    required String thumbnailStorageId,
    required String originalFileStorageId,
    required Map<PostSettings, bool> postSettings,
  }) : super(
          {
            FirestoreFieldName.userId: userId,
            FirestoreFieldName.message: message,
            FirestoreFieldName.createdAt: FieldValue.serverTimestamp(),
            FirestoreFieldName.thumbnailUrl: thumbnailUrl,
            FirestoreFieldName.fileUrl: fileUrl,
            FirestoreFieldName.fileType: fileType.name,
            FirestoreFieldName.fileName: fileName,
            FirestoreFieldName.aspectRatio: aspectRatio,
            FirestoreFieldName.thumbnailStorageId: thumbnailStorageId,
            FirestoreFieldName.originalFileStorageId: originalFileStorageId,
            FirestoreFieldName.postSettings: {
              for (final postSetting in postSettings.entries)
                postSetting.key.storageKey: postSetting.value,
            },
          },
        );
}
