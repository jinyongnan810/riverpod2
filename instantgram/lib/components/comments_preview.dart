import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/comment_preview_item.dart';
import 'package:instantgram/components/lottie_animation_view.dart';
import 'package:instantgram/enums/sorting_method.dart';
import 'package:instantgram/models/post_comments_request.dart';
import 'package:instantgram/providers/comments_provider.dart';
import 'package:instantgram/typedefs/post_id.dart';
import 'package:instantgram/views/comments_view.dart';

class CommentsPreview extends ConsumerWidget {
  final PostId postId;
  const CommentsPreview({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsRequest = PostCommentsRequest(
      postId: postId,
      limit: 3,
      orderByCreatedAt: true,
      sortingMethod: SortingMethod.fromNewest,
    );
    final asyncComments = ref.watch(commentsProvider(commentsRequest));
    return asyncComments.when(
      data: (comments) => comments.isEmpty
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => CommentsView(postId: postId))),
                child: Column(
                  children: comments
                      .map((comment) => CommentPreviewItem(comment: comment))
                      .toList(),
                ),
              ),
            ),
      error: (_, __) => LottieAnimationView.smallError(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
