import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/firestore_collection_name.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/models/post.dart';
import 'package:instantgram/providers/user_id_provider.dart';

final userPostsProvider = StreamProvider.autoDispose<Iterable<Post>>(
  (ref) {
    final controller = StreamController<Iterable<Post>>();
    ref.onDispose(() {
      controller.close();
    });
    controller.onListen = () {
      controller.sink.add([]);
    };

    final userId = ref.watch(userIdProvider);

    if (userId != null) {
      FirebaseFirestore.instance
          .collection(FirestoreCollectionName.posts)
          .orderBy(FirestoreFieldName.createdAt, descending: true)
          .where(FirestoreFieldName.userId, isEqualTo: userId)
          .snapshots()
          .listen((snapshot) {
        final docs = snapshot.docs;
        final posts = docs
            // not ones that are being written in the moment
            .where((doc) => !doc.metadata.hasPendingWrites)
            .map((doc) => Post(postId: doc.id, json: doc.data()));
        controller.sink.add(posts);
      });
    }

    return controller.stream;
  },
);
