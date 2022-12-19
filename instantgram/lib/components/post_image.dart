import 'package:flutter/material.dart';
import 'package:instantgram/components/lottie_animation_view.dart';
import 'package:instantgram/models/post.dart';

class PostImage extends StatelessWidget {
  final Post post;
  const PostImage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: post.aspectRatio,
      child: Image.network(
        post.fileUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return LottieAnimationView.loading();
        },
      ),
    );
  }
}
