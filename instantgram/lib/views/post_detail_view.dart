import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/comments_preview.dart';
import 'package:instantgram/components/dialogs/alert_dialog_model.dart';
import 'package:instantgram/components/dialogs/delete_dialog.dart';
import 'package:instantgram/components/like_button.dart';
import 'package:instantgram/components/likes_count.dart';
import 'package:instantgram/components/post_basic_info.dart';
import 'package:instantgram/components/post_media.dart';
import 'package:instantgram/models/post.dart';
import 'package:instantgram/providers/delete_post_notifier_provider.dart';
import 'package:instantgram/providers/user_id_provider.dart';
import 'package:instantgram/views/comments_view.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailView extends ConsumerWidget {
  final Post post;
  const PostDetailView({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
        actions: [
          IconButton(
              onPressed: () {
                Share.share(post.fileUrl);
              },
              icon: const Icon(Icons.share)),
          if (userId == post.userId)
            IconButton(
                onPressed: () async {
                  final choice =
                      await const DeleteDialog(objectToDelete: 'post')
                          .present(context);
                  if (choice != true) {
                    return;
                  }
                  final notifier =
                      ref.read(deletePostNotifierProvider.notifier);
                  await notifier.deletePost(post: post);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostMedia(post: post),
            PostBasicInfo(post: post),
            Row(
              children: [
                if (post.allowsLikes) LikeButton(postId: post.postId),
                if (post.allowsComments)
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => CommentsView(postId: post.postId)));
                    },
                    icon: const FaIcon(FontAwesomeIcons.comments),
                  )
              ],
            ),
            const Divider(),
            CommentsPreview(postId: post.postId),
            LikesCount(postId: post.postId)
          ],
        ),
      )),
    );
  }
}
