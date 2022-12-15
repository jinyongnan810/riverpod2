import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/dialogs/alert_dialog_model.dart';
import 'package:instantgram/components/dialogs/delete_dialog.dart';
import 'package:instantgram/components/lottie_animation_view.dart';
import 'package:instantgram/models/comment.dart';
import 'package:instantgram/providers/comments_notifier_provider.dart';
import 'package:instantgram/providers/user_id_provider.dart';
import 'package:instantgram/providers/user_info_provider.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({
    required this.comment,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider(comment.userId));
    return userInfo.when(data: (user) {
      final isMine = ref.read(userIdProvider) == user.userId;
      return ListTile(
        title: Text(user.displayName),
        subtitle: Text(comment.content),
        trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: isMine
                ? () async {
                    final res =
                        await const DeleteDialog(objectToDelete: 'comment')
                            .present(context);
                    if (res == true) {
                      ref
                          .read(commentsNotifierProvider.notifier)
                          .deleteComment(comment.commentId);
                    }
                  }
                : null),
      );
    }, error: (error, _) {
      debugPrint('Error loading comment user: $error');
      return LottieAnimationView.smallError();
    }, loading: () {
      return LottieAnimationView.loading();
    });
  }
}
