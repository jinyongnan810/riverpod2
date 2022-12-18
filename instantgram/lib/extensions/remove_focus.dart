import 'package:flutter/material.dart';

extension RemoveFocus on Widget {
  void removeFocus() => FocusManager.instance.primaryFocus?.unfocus();
}
