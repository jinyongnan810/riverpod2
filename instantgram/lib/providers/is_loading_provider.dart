import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/providers/auth_state_provider.dart';

final isLoadingProvider = Provider(
  (ref) {
    final authState = ref.watch(authStateProvider);
    final isLoading = [authState.isLoading].any((loading) => loading);
    return isLoading;
  },
);
