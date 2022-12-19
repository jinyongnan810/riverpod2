import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/post_basic_info.dart';
import 'package:instantgram/components/post_media.dart';
import 'package:instantgram/models/post.dart';

class PostDetailView extends ConsumerWidget {
  final Post post;
  const PostDetailView({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Detail')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostMedia(post: post),
            PostBasicInfo(post: post),
          ],
        ),
      )),
    );
  }
}
