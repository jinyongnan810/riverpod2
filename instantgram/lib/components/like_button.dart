import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/lottie_animation_view.dart';
import 'package:instantgram/providers/likes_notifier_provider.dart';
import 'package:instantgram/providers/likes_provider.dart';
import 'package:instantgram/providers/user_id_provider.dart';
import 'package:instantgram/typedefs/post_id.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;
  const LikeButton({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liked = ref.watch(likedProvider(postId));
    return liked.when(
      data: (liked) => IconButton(
          onPressed: () async {
            final userId = ref.read(userIdProvider);
            if (userId == null) {
              return;
            }
            await ref
                .read(likesNotifierProvider.notifier)
                .likeOrUnlike(postId: postId, userId: userId);
          },
          icon: Icon(liked ? Icons.thumb_up : Icons.thumb_up_outlined)),
      error: (_, __) => LottieAnimationView.smallError(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
