import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/models/auth_result.dart';
import 'package:instantgram/providers/auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});
