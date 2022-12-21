import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/providers/auth_state_provider.dart';
import 'package:instantgram/providers/comments_notifier_provider.dart';
import 'package:instantgram/providers/likes_notifier_provider.dart';
import 'package:instantgram/providers/upload_notifier_provider.dart';
import 'package:instantgram/typedefs/is_loading.dart';

final isLoadingProvider = Provider<IsLoading>(
  (ref) {
    final authState = ref.watch(authStateProvider);
    final uploadingState = ref.watch(uploadNotifierProvider);
    final commentsState = ref.watch(commentsNotifierProvider);
    final likeState = ref.watch(likesNotifierProvider);
    final isLoading = [
      authState.isLoading,
      uploadingState,
      commentsState,
      likeState
    ].any((loading) => loading);
    return isLoading;
  },
);
