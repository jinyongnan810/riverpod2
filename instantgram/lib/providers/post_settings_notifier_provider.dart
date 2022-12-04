import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/enums/post_settings.dart';
import 'package:instantgram/notifiers/post_settings_notifier.dart';

final postSettingsNotifierProvider =
    StateNotifierProvider<PostSettingsNotifier, Map<PostSettings, bool>>(
  (ref) => PostSettingsNotifier(),
);
