import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/constants/strings.dart';

enum PostSettings {
  allowLikes(
    title: Strings.allowLikesTitle,
    description: Strings.allowLikesDescription,
    storageKey: FirestoreFieldName.allowLikes,
  ),
  allowComments(
    title: Strings.allowCommentsTitle,
    description: Strings.allowCommentsDescription,
    storageKey: FirestoreFieldName.allowComments,
  );

  final String title;
  final String description;
  final String storageKey;
  const PostSettings({
    required this.title,
    required this.description,
    required this.storageKey,
  });
}
