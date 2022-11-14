import 'package:flutter/material.dart'
    show Colors, TextDecoration, TextStyle, VoidCallback;
import 'package:instantgram/components/link_text.dart';

class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({required this.text, this.style});
  factory BaseText.plain(
          {required String text, TextStyle? style = const TextStyle()}) =>
      BaseText(text: text, style: style);
  factory BaseText.link({
    required String text,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
    required VoidCallback callback,
  }) =>
      LinkText(
        text: text,
        style: style,
        callback: callback,
      );
}
