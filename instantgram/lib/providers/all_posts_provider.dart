import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/firestore_collection_name.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/models/post.dart';
import 'package:instantgram/providers/user_id_provider.dart';
import 'package:instantgram/typedefs/search_term.dart';

final allPostsSearchedProvider =
    StreamProvider.autoDispose.family<Iterable<Post>, SearchTerm>(
  (ref, term) {
    final controller = StreamController<Iterable<Post>>();
    ref.onDispose(() {
      controller.close();
    });
    controller.onListen = () {
      controller.sink.add([]);
    };

    final userId = ref.watch(userIdProvider);

    if (userId != null) {
      final searchTermLower = term.toLowerCase();
      FirebaseFirestore.instance
          .collection(FirestoreCollectionName.posts)
          // need add index in Firestore
          // https://console.firebase.google.com/u/1/project/instantgram-69930/firestore/indexes
          .orderBy(FirestoreFieldName.createdAt, descending: true)
          .snapshots()
          .listen((snapshot) {
        final docs = snapshot.docs;
        final posts = docs
            // not ones that are being written in the moment
            .where((doc) => !doc.metadata.hasPendingWrites)
            .map((doc) => Post(postId: doc.id, json: doc.data()))
            .where(
                (post) => post.message.toLowerCase().contains(searchTermLower));
        controller.sink.add(posts);
      });
    }

    return controller.stream;
  },
);

final allPostsProvider = StreamProvider.autoDispose<Iterable<Post>>(
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
          // need add index in Firestore
          // https://console.firebase.google.com/u/1/project/instantgram-69930/firestore/indexes
          .orderBy(FirestoreFieldName.createdAt, descending: true)
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
