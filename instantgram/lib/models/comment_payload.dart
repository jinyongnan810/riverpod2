import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/typedefs/post_id.dart';
import 'package:instantgram/typedefs/user_id.dart';

class CommentPayload extends MapView<String, dynamic> {
  CommentPayload({
    required PostId postId,
    required UserId userId,
    required String content,
    required DateTime createdAt,
  }) : super(
          {
            FirestoreFieldName.userId: userId,
            FirestoreFieldName.comment: content,
            FirestoreFieldName.createdAt: FieldValue.serverTimestamp(),
            FirestoreFieldName.postId: postId,
          },
        );
}
