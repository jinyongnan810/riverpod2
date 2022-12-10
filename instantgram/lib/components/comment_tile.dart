import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/models/comment.dart';
import 'package:instantgram/providers/comments_notifier_provider.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  final bool isMine;
  const CommentTile({
    required this.comment,
    required this.isMine,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(comment.userName),
      subtitle: Text(comment.content),
      trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: isMine
              ? () {
                  ref
                      .read(commentsNotifierProvider.notifier)
                      .deleteComment(comment.commentId);
                }
              : null),
    );
  }
}
