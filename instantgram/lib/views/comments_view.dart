import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/animation_with_text.dart';
import 'package:instantgram/components/comment_tile.dart';
import 'package:instantgram/components/lottie_animation_view.dart';
import 'package:instantgram/constants/strings.dart';
import 'package:instantgram/enums/sorting_method.dart';
import 'package:instantgram/extensions/remove_focus.dart';
import 'package:instantgram/models/comment_payload.dart';
import 'package:instantgram/models/post_comments_request.dart';
import 'package:instantgram/providers/comments_notifier_provider.dart';
import 'package:instantgram/providers/comments_provider.dart';
import 'package:instantgram/providers/user_id_provider.dart';
import 'package:instantgram/typedefs/post_id.dart';

class CommentsView extends HookConsumerWidget {
  final PostId postId;
  const CommentsView({super.key, required this.postId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsRequest = PostCommentsRequest(
      postId: postId,
      limit: 20,
      orderByCreatedAt: true,
      sortingMethod: SortingMethod.fromNewest,
    );
    final asyncComments = ref.watch(commentsProvider(commentsRequest));
    final textController = useTextEditingController();
    final canSendComment = useState(false);
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.comments), actions: [
        IconButton(
            onPressed:
                canSendComment.value ? () => submit(textController, ref) : null,
            icon: const Icon(Icons.send))
      ]),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: asyncComments.when(
                data: (comments) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.refresh(commentsProvider(commentsRequest));
                    },
                    child: comments.isEmpty
                        ? AnimationWithText(
                            text: Strings.noComments,
                            animation: LottieAnimationView.empty(),
                          )
                        : ListView.builder(
                            itemBuilder: ((context, index) => InkWell(
                                onTap: () => removeFocus(),
                                child: CommentTile(
                                    comment: comments.elementAt(index)))),
                            itemCount: comments.length,
                          ),
                  );
                },
                error: (_, __) => LottieAnimationView.error(),
                loading: () => LottieAnimationView.loading(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: Strings.commentHere),
                    textInputAction: TextInputAction.send,
                    onChanged: (value) =>
                        canSendComment.value = value.trim().isNotEmpty,
                    onSubmitted: (_) {
                      submit(textController, ref);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> submit(TextEditingController controller, WidgetRef ref) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final CommentPayload payload = CommentPayload(
      postId: postId,
      userId: userId,
      content: controller.text,
    );
    await ref
        .read(commentsNotifierProvider.notifier)
        .addComment(payload: payload);
    controller.clear();
    removeFocus();
  }
}
