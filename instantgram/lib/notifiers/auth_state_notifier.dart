import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/backend/authenticator.dart';
import 'package:instantgram/backend/user_info_firestore.dart';
import 'package:instantgram/models/auth_result.dart';
import 'package:instantgram/states/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoFirestore = const UserInfoFirestore();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isLoggedIn) {
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: _authenticator.userId);
    }
  }

  Future<void> logout() async {
    state = state.copyWithIsLoading(true);
    await _authenticator.logout();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    debugPrint('loginWithGoogle: $result');
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await _userInfoFirestore.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
    }
    state = AuthState(result: result, isLoading: false, userId: userId);
  }
}
