import 'package:flutter/material.dart';
import 'package:instantgram/extensions/string_remove_all.dart';

extension ConvertHtmlColorToColor on String {
  Color htmlColorToColor() {
    return Color(int.parse(removeAll(['#', "0x"]).padLeft(8, 'ff'), radix: 16));
  }
}
