import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instantgram/constants/firestore_field_name.dart';
import 'package:instantgram/typedefs/comment_id.dart';
import 'package:instantgram/typedefs/post_id.dart';
import 'package:instantgram/typedefs/user_id.dart';

class Comment {
  final CommentId commentId;
  final PostId postId;
  final UserId userId;
  final String content;
  final DateTime createdAt;
  const Comment({
    required this.commentId,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
  });
  Comment.fromJson(Map<String, dynamic> json, {required String id})
      : commentId = id,
        postId = json[FirestoreFieldName.postId],
        userId = json[FirestoreFieldName.userId],
        content = json[FirestoreFieldName.comment],
        createdAt = (json[FirestoreFieldName.createdAt] as Timestamp).toDate();
}
