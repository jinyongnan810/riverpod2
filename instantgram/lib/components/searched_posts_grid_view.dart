import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/animation_with_text.dart';
import 'package:instantgram/components/lottie_animation_view.dart';
import 'package:instantgram/components/post_grid_view.dart';
import 'package:instantgram/constants/strings.dart';
import 'package:instantgram/providers/all_posts_provider.dart';
import 'package:instantgram/typedefs/search_term.dart';

class SearchedPostsGridView extends ConsumerWidget {
  final SearchTerm term;
  const SearchedPostsGridView({super.key, required this.term});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (term.trim().isEmpty) {
      return AnimationWithText(
        text: Strings.enterSearchTerm,
        animation: LottieAnimationView.empty(),
      );
    }
    final searchedPosts = ref.watch(allPostsSearchedProvider(term));
    return searchedPosts.when(
      data: (posts) => posts.isEmpty
          ? LottieAnimationView.dataNotFound()
          : PostGridView(posts: posts),
      error: (_, __) => LottieAnimationView.error(),
      loading: () => LottieAnimationView.loading(),
    );
  }
}
