import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/constants/strings.dart';

class PostSettings {
  final String title;
  final String description;
  final String storageKey;
  const PostSettings({
    required this.title,
    required this.description,
    required this.storageKey,
  });
  factory PostSettings.allowLikes() => const PostSettings(
        title: Strings.allowLikesTitle,
        description: Strings.allowLikesDescription,
        storageKey: FirestoreFieldName.allowLikes,
      );
  factory PostSettings.allowComments() => const PostSettings(
        title: Strings.allowCommentsTitle,
        description: Strings.allowCommentsDescription,
        storageKey: FirestoreFieldName.allowComments,
      );
}
