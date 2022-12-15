import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/firestore_collection_name.dart';
import 'package:instantgram/models/comment_payload.dart';
import 'package:instantgram/typedefs/comment_id.dart';
import 'package:instantgram/typedefs/is_loading.dart';

class CommentsNotifier extends StateNotifier<IsLoading> {
  CommentsNotifier() : super(false);
  set isLoading(IsLoading loading) => state = loading;
  Future<bool> deleteComment(CommentId commentId) async {
    isLoading = true;
    try {
      await FirebaseFirestore.instance
          .collection(FirestoreCollectionName.comments)
          .doc(commentId)
          .delete();
      return true;
    } catch (e) {
      debugPrint('Error when deleting comment $commentId: $e');
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<bool> addComment({required CommentPayload payload}) async {
    isLoading = true;
    try {
      await FirebaseFirestore.instance
          .collection(FirestoreCollectionName.comments)
          .add(payload);
      return true;
    } catch (e) {
      debugPrint('Error when adding comment: $e');
      return false;
    } finally {
      isLoading = false;
    }
  }
}
