import 'dart:collection' show MapView;

import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/typedefs/user_id.dart';

class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String displayName,
    required String? email,
  }) : super({
          FirestoreFieldName.userId: userId,
          FirestoreFieldName.displayName: displayName,
          FirestoreFieldName.email: email ?? '',
        });
}
