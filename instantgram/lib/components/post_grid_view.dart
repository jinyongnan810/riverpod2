import 'package:flutter/material.dart';
import 'package:instantgram/components/post_thumbnail_view.dart';
import 'package:instantgram/models/post.dart';
import 'package:instantgram/views/post_detail_view.dart';

class PostGridView extends StatelessWidget {
  const PostGridView({super.key, required this.posts});
  final Iterable<Post> posts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
        itemCount: posts.length,
        itemBuilder: ((context, index) {
          final post = posts.elementAt(index);
          return PostThumbnailView(
              post: post,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => PostDetailView(
                      post: post,
                    ),
                  ),
                );
              });
        }));
  }
}
