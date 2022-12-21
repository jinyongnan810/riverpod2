import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/notifiers/likes_notifier.dart';
import 'package:instantgram/typedefs/is_loading.dart';

final likesNotifierProvider = StateNotifierProvider<LikesNotifier, IsLoading>(
  (ref) => LikesNotifier(),
);
