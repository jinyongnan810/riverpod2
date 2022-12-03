import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/lottie_animation_view.dart';
import 'package:instantgram/models/thumbnail_request.dart';
import 'package:instantgram/providers/thumbnail_provider.dart';

class FileThumbnailView extends ConsumerWidget {
  const FileThumbnailView({required this.thumbnailRequest, super.key});

  final ThumbnailRequest thumbnailRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailProvider(thumbnailRequest));
    return thumbnail.when(
      data: (image) => AspectRatio(
        aspectRatio: image.aspectRatio,
        child: image.image,
      ),
      loading: () => LottieAnimationView.loading(),
      error: (_, __) => LottieAnimationView.smallError(),
    );
  }
}
