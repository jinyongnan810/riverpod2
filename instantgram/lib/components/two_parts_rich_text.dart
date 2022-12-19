import 'package:flutter/material.dart';

class TwoPartsRichText extends StatelessWidget {
  final String left;
  final String right;
  const TwoPartsRichText({super.key, required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: const TextStyle(color: Colors.white70, height: 1.5),
          children: [
            TextSpan(
                text: left,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' $right'),
          ]),
    );
  }
}
