import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/firestore_collection_name.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/extensions/sort_comments.dart';
import 'package:instantgram/models/comment.dart';
import 'package:instantgram/models/post_comments_request.dart';

final commentsProvider = StreamProvider.autoDispose
    .family<Iterable<Comment>, PostCommentsRequest>(((ref, arg) {
  final controller = StreamController<Iterable<Comment>>();

  final limit = arg.limit;
  final subscription = FirebaseFirestore.instance
      .collection(FirestoreCollectionName.comments)
      .where(
        FirestoreFieldName.postId,
        isEqualTo: arg.postId,
      )
      .limit(limit ?? 9999)
      .snapshots()
      .listen((snapshot) {
    final comments = snapshot.docs
        .where((element) => !element.metadata.hasPendingWrites)
        .map((doc) => Comment.fromJson(doc.data(), id: doc.id));
    controller.add(comments.sortBy(arg.orderByCreatedAt, arg.sortingMethod));
  });

  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });
  return controller.stream;
}));
