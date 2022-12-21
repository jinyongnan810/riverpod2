import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/typedefs/post_id.dart';
import 'package:instantgram/typedefs/user_id.dart';

class LikePayload extends MapView<String, dynamic> {
  LikePayload({
    required PostId postId,
    required UserId userId,
  }) : super(
          {
            FirestoreFieldName.userId: userId,
            FirestoreFieldName.createdAt: FieldValue.serverTimestamp(),
            FirestoreFieldName.postId: postId,
          },
        );
}
