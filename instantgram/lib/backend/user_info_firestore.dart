import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instantgram/constants/firestore_collection_name.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/models/user_info_payload.dart';

class UserInfoFirestore {
  const UserInfoFirestore();
  Future<bool> saveUserInfo({
    required String userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      final currentUserInfo = await FirebaseFirestore.instance
          .collection(FirestoreCollectionName.users)
          .where(FirestoreFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();
      if (currentUserInfo.docs.isNotEmpty) {
        await currentUserInfo.docs.first.reference.update({
          FirestoreFieldName.displayName: displayName,
          FirestoreFieldName.email: email,
        });
        return true;
      }

      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      );
      await FirebaseFirestore.instance
          .collection(FirestoreCollectionName.users)
          .add(payload);
      return true;
    } catch (e) {
      debugPrint('Error when saving user info: $e');
      return false;
    }
  }
}
