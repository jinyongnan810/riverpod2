import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/providers/auth_state_provider.dart';
import 'package:instantgram/typedefs/user_id.dart';

final userIdProvider = Provider<UserId?>(
  (ref) {
    final authState = ref.watch(authStateProvider);
    return authState.userId;
  },
);
