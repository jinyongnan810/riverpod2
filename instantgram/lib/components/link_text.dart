import 'package:flutter/foundation.dart';
import 'package:instantgram/components/base_text.dart';

class LinkText extends BaseText {
  final VoidCallback callback;
  const LinkText({
    required super.text,
    super.style,
    required this.callback,
  });
}
