import 'package:flutter/material.dart';
import 'package:instantgram/components/lottie_animation_view.dart';

class AnimationWithText extends StatelessWidget {
  const AnimationWithText({
    super.key,
    required this.text,
    required this.animation,
  });

  final String text;
  final LottieAnimationView animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white54),
          ),
        ),
        animation,
      ]),
    );
  }
}
