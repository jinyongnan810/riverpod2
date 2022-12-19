import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/lottie_animation_view.dart';
import 'package:instantgram/components/two_parts_rich_text.dart';
import 'package:instantgram/models/post.dart';
import 'package:instantgram/providers/user_info_provider.dart';
import 'package:intl/intl.dart';

class PostBasicInfo extends ConsumerWidget {
  final Post post;
  const PostBasicInfo({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider(post.userId));
    final formatter = DateFormat('d MMMM, yyyy, hh:mm a');
    return userInfo.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TwoPartsRichText(left: data.displayName, right: post.message),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(formatter.format(post.createdAt)),
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return LottieAnimationView.smallError();
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
