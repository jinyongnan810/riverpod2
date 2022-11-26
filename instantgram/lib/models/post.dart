import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/enums/file_type.dart';
import 'package:instantgram/enums/post_settings.dart';
import 'package:instantgram/typedefs/post_id.dart';
import 'package:instantgram/typedefs/user_id.dart';

class Post {
  final PostId postId;
  final UserId userId;
  final String message;
  final DateTime createdAt;
  final String thumbnailUrl;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final double aspectRatio;
  final String thumbnailStorageId;
  final String originalFileStorageId;
  final Map<PostSettings, bool> postSettings;

  Post({
    required this.postId,
    required Map<String, dynamic> json,
  })  : userId = json[FirestoreFieldName.userId],
        message = json[FirestoreFieldName.message],
        createdAt = (json[FirestoreFieldName.createdAt] as Timestamp).toDate(),
        thumbnailUrl = json[FirestoreFieldName.thumbnailUrl],
        fileUrl = json[FirestoreFieldName.fileUrl],
        fileType = FileType.values.firstWhere(
          (fileType) => fileType.name == json[FirestoreFieldName.fileType],
          orElse: () => FileType.image,
        ),
        fileName = json[FirestoreFieldName.fileName],
        aspectRatio = json[FirestoreFieldName.aspectRatio],
        thumbnailStorageId = json[FirestoreFieldName.thumbnailStorageId],
        originalFileStorageId = json[FirestoreFieldName.originalFileStorageId],
        postSettings = {
          for (final entry in json[FirestoreFieldName.postSettings].entries)
            PostSettings.values.firstWhere(
              (element) => element.storageKey == entry.key,
            ): entry.value,
        };
  bool get allowsLikes => postSettings[PostSettings.allowLikes] ?? false;
  bool get allowsComments => postSettings[PostSettings.allowComments] ?? false;
}
