import 'package:flutter/src/widgets/framework.dart';
import 'package:instantgram/components/post_image.dart';
import 'package:instantgram/components/post_video.dart';
import 'package:instantgram/enums/file_type.dart';
import 'package:instantgram/models/post.dart';

class PostMedia extends StatelessWidget {
  final Post post;
  const PostMedia({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    if (post.fileType == FileType.video) {
      return PostVideo(post: post);
    }
    return PostImage(post: post);
  }
}
