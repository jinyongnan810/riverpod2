import 'package:flutter/material.dart';
import 'package:instantgram/constants/lottie_animation.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationView extends StatelessWidget {
  const LottieAnimationView({
    super.key,
    required this.animation,
    this.repeat = true,
    this.reverse = false,
  });

  factory LottieAnimationView.dataNotFound() =>
      const LottieAnimationView(animation: LottieAnimation.dataNotFound);
  factory LottieAnimationView.empty() => const LottieAnimationView(
        animation: LottieAnimation.empty,
        reverse: true,
      );
  factory LottieAnimationView.error() => const LottieAnimationView(
        animation: LottieAnimation.error,
        repeat: false,
      );
  factory LottieAnimationView.loading() =>
      const LottieAnimationView(animation: LottieAnimation.loading);
  factory LottieAnimationView.smallError() =>
      const LottieAnimationView(animation: LottieAnimation.smallError);

  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      animation.fullPath(),
      repeat: repeat,
      reverse: reverse,
    );
  }
}
