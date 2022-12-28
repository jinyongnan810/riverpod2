import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/animation_with_text.dart';
import 'package:instantgram/components/lottie_animation_view.dart';
import 'package:instantgram/components/post_grid_view.dart';
import 'package:instantgram/constants/strings.dart';
import 'package:instantgram/providers/all_posts_provider.dart';
import 'package:instantgram/providers/user_posts_provider.dart';

class AllPostsView extends ConsumerWidget {
  const AllPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);
    return RefreshIndicator(
        child: posts.when(data: (posts) {
          if (posts.isEmpty) {
            return AnimationWithText(
              text: Strings.noPosts,
              animation: LottieAnimationView.empty(),
            );
          }
          return PostGridView(posts: posts);
        }, error: (error, stackTrace) {
          return LottieAnimationView.error();
        }, loading: () {
          return LottieAnimationView.loading();
        }),
        onRefresh: () async {
          final _ = ref.refresh(userPostsProvider);
          await Future.delayed(const Duration(seconds: 1));
        });
  }
}
