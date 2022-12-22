import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/lottie_animation_view.dart';
import 'package:instantgram/components/two_parts_rich_text.dart';
import 'package:instantgram/models/comment.dart';
import 'package:instantgram/providers/user_info_provider.dart';

class CommentPreviewItem extends ConsumerWidget {
  final Comment comment;
  const CommentPreviewItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider(comment.userId));
    return userInfo.when(data: (user) {
      return TwoPartsRichText(left: user.displayName, right: comment.content);
    }, error: (error, _) {
      debugPrint('Error loading comment user: $error');
      return LottieAnimationView.smallError();
    }, loading: () {
      return LottieAnimationView.loading();
    });
  }
}
