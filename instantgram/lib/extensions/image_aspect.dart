import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension ImageAspect on Image {
  Future<double> getAspectRatio() async {
    final completer = Completer<double>();
    image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
      final ratio = image.image.width / image.image.height;
      image.image.dispose();
      completer.complete(ratio);
    }));
    return completer.future;
  }
}

extension DataImageAspect on Uint8List {
  Future<double> getAspectRatio() async {
    final image = Image.memory(this);
    return image.getAspectRatio();
  }
}
