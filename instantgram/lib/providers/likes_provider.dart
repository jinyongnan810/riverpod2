import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/firestore_collection_name.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/typedefs/post_id.dart';

final likesProvider =
    StreamProvider.autoDispose.family<int, PostId>(((ref, postId) {
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
}));
