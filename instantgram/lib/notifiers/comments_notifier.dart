import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/typedefs/comment_id.dart';
import 'package:instantgram/typedefs/is_loading.dart';

class CommentsNotifier extends StateNotifier<IsLoading> {
  CommentsNotifier() : super(false);
  set isLoading(IsLoading loading) => state = loading;
  Future<void> deleteComment(CommentId commentId) async {}
}
