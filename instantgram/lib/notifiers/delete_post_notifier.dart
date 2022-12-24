import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/firestore_collection_name.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/constants/storage_collection_name.dart';
import 'package:instantgram/enums/file_type.dart';
import 'package:instantgram/models/post.dart';
import 'package:instantgram/typedefs/is_loading.dart';

class DeletePostNotifier extends StateNotifier<IsLoading> {
  DeletePostNotifier() : super(false);
  set isLoading(bool loading) => state = loading;
  Future<void> deletePost({
    required Post post,
  }) async {
    isLoading = true;
    final userId = post.userId;
    // delete files
    final originalRef = FirebaseStorage.instance
        .ref('$userId/${post.fileType.getStorageName()}/${post.fileName}}');
    final thumbnailRef = FirebaseStorage.instance
        .ref('$userId/${StorageCollectionName.thumbnails}/${post.fileName}}');
    try {
      await originalRef.delete();
      await thumbnailRef.delete();
    } catch (e) {
      debugPrint('Error deleting files: $e');
    }
    // delete likes
    try {
      final likes = await FirebaseFirestore.instance
          .collection(FirestoreCollectionName.likes)
          .where(FirestoreFieldName.postId, isEqualTo: post.postId)
          .get();
      for (var doc in likes.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      debugPrint('Error deleting likes: $e');
    }
    // delete comments
    try {
      final comments = await FirebaseFirestore.instance
          .collection(FirestoreCollectionName.comments)
          .where(FirestoreFieldName.postId, isEqualTo: post.postId)
          .get();
      for (var doc in comments.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      debugPrint('Error deleting comments: $e');
    }

    // delete post
    try {
      await FirebaseFirestore.instance
          .collection(FirestoreCollectionName.posts)
          .doc(post.postId)
          .delete();
    } catch (e) {
      debugPrint('Error deleting post: $e');
    }

    isLoading = false;
  }
}
