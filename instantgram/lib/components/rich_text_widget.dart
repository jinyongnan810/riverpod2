import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instantgram/components/base_text.dart';
import 'package:instantgram/components/link_text.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> texts;
  final TextStyle? commonStyle;

  const RichTextWidget({
    super.key,
    required this.texts,
    this.commonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            children: texts.map((baseText) {
      if (baseText is LinkText) {
        return TextSpan(
          text: baseText.text,
          style: commonStyle?.merge(baseText.style),
          recognizer: TapGestureRecognizer()..onTap = baseText.callback,
        );
      } else {
        return TextSpan(
          text: baseText.text,
          style: commonStyle?.merge(baseText.style),
        );
      }
    }).toList()));
  }
}
