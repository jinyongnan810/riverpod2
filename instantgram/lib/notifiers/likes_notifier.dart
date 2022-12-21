import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/firestore_collection_name.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/models/like_payload.dart';
import 'package:instantgram/typedefs/is_loading.dart';
import 'package:instantgram/typedefs/post_id.dart';
import 'package:instantgram/typedefs/user_id.dart';

class LikesNotifier extends StateNotifier<IsLoading> {
  LikesNotifier() : super(false);
  set isLoading(IsLoading loading) => state = loading;
  Future<bool> likeOrUnlike(
      {required PostId postId, required UserId userId}) async {
    isLoading = true;
    try {
      final current = await FirebaseFirestore.instance
          .collection(FirestoreCollectionName.likes)
          .where(FirestoreFieldName.userId, isEqualTo: userId)
          .where(FirestoreFieldName.postId, isEqualTo: postId)
          .limit(1)
          .get();
      if (current.docs.isEmpty) {
        final payload = LikePayload(postId: postId, userId: userId);
        await FirebaseFirestore.instance
            .collection(FirestoreCollectionName.likes)
            .add(payload);
      } else {
        await current.docs[0].reference.delete();
      }
      return true;
    } catch (e) {
      debugPrint('Error when liking: $e');
      return false;
    } finally {
      isLoading = false;
    }
  }
}
