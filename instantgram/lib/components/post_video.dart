import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instantgram/components/lottie_animation_view.dart';
import 'package:instantgram/models/post.dart';
import 'package:video_player/video_player.dart';

class PostVideo extends HookWidget {
  final Post post;
  const PostVideo({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final controller = VideoPlayerController.network(post.fileUrl);
    final videoPlayerReady = useState(false);
    useEffect(() {
      controller.initialize().then((value) {
        videoPlayerReady.value = true;
        controller.setLooping(true);
        controller.play();
      });
      return controller.dispose;
    }, [controller]);
    if (videoPlayerReady.value) {
      return AspectRatio(
        aspectRatio: post.aspectRatio,
        child: VideoPlayer(controller),
      );
    }
    return LottieAnimationView.loading();
  }
}
