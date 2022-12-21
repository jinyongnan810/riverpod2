import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/firestore_collection_name.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/providers/user_id_provider.dart';
import 'package:instantgram/typedefs/post_id.dart';

final likesProvider =
    StreamProvider.autoDispose.family<int, PostId>((ref, postId) {
  final controller = StreamController<int>();
  controller.add(0);
  final subscription = FirebaseFirestore.instance
      .collection(FirestoreCollectionName.likes)
      .where(
        FirestoreFieldName.postId,
        isEqualTo: postId,
      )
      .snapshots()
      .listen((snapshot) {
    final likesCount = snapshot.docs.length;
    controller.add(likesCount);
  });

  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });
  return controller.stream;
});

final likedProvider =
    StreamProvider.autoDispose.family<bool, PostId>((ref, postId) {
  final userId = ref.watch(userIdProvider);
  final controller = StreamController<bool>();
  controller.add(false);
  final subscription = FirebaseFirestore.instance
      .collection(FirestoreCollectionName.likes)
      .where(
        FirestoreFieldName.userId,
        isEqualTo: userId,
      )
      .where(
        FirestoreFieldName.postId,
        isEqualTo: postId,
      )
      .snapshots()
      .listen((snapshot) {
    controller.add(snapshot.docs.isNotEmpty);
  });

  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });
  return controller.stream;
});
