import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/lottie_animation_view.dart';
import 'package:instantgram/providers/likes_provider.dart';
import 'package:instantgram/typedefs/post_id.dart';

class LikesCount extends ConsumerWidget {
  final PostId postId;
  const LikesCount({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likes = ref.watch(likesProvider(postId));
    return likes.when(
        data: (count) {
          final String text;
          switch (count) {
            case 1:
              {
                text = '1 person liked this';
                break;
              }
            default:
              {
                text = '$count people liked this';
              }
          }
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(text),
          );
        },
        error: (error, stackTrace) {
          return LottieAnimationView.smallError();
        },
        loading: () => const CircularProgressIndicator());
  }
}
