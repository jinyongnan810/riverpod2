import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/notifiers/auth_state_notifier.dart';
import 'package:instantgram/states/auth_state.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
