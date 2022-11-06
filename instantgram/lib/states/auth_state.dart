import 'package:instantgram/models/auth_result.dart';
import 'package:instantgram/typedefs/user_id.dart';

class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;
  AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });
  AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;
  AuthState copyWithIsLoading(bool isLoading) =>
      AuthState(result: result, isLoading: isLoading, userId: userId);
  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(result, isLoading, userId);
}
