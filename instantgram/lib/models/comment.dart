import 'package:instantgram/typedefs/comment_id.dart';
import 'package:instantgram/typedefs/post_id.dart';
import 'package:instantgram/typedefs/user_id.dart';

class Comment {
  final CommentId commentId;
  final PostId postId;
  final UserId userId;
  final String content;
  final DateTime createdAt;
  final String userName;
  const Comment({
    required this.commentId,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.userName,
  });
}
