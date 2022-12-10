import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/notifiers/comments_notifier.dart';
import 'package:instantgram/typedefs/is_loading.dart';

final commentsNotifierProvider =
    StateNotifierProvider<CommentsNotifier, IsLoading>(
  (ref) => CommentsNotifier(),
);
