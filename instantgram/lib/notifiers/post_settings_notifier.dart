import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/enums/post_settings.dart';

class PostSettingsNotifier extends StateNotifier<Map<PostSettings, bool>> {
  PostSettingsNotifier()
      : super(MapView(
            {for (final setting in PostSettings.values) setting: true}));
  void setSetting(PostSettings setting, bool value) {
    final current = state[setting];
    if (current == null || current == value) {
      return;
    }
    state = Map.from(state)..[setting] = value;
  }
}
