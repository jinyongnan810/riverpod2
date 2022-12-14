import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/firestore_collection_name.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/models/user_info_model.dart';

import '../typedefs/user_id.dart';

final userInfoProvider =
    StreamProvider.family.autoDispose<UserInfoModel, UserId>(
  (ref, userId) {
    final controller = StreamController<UserInfoModel>();

    final subscription = FirebaseFirestore.instance
        .collection(FirestoreCollectionName.users)
        .where(FirestoreFieldName.userId, isEqualTo: userId)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      final doc = snapshot.docs.first;
      final json = doc.data();
      final userInfo = UserInfoModel.fromJson(json);
      controller.add(userInfo);
    });

    ref.onDispose(() {
      subscription.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
