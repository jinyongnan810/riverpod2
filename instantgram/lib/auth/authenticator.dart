import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instantgram/auth/constants.dart';
import 'package:instantgram/models/auth_result.dart';
// facebook && handling account-exists-with-different-credential
// see https://github.com/vandadnp/youtube-riverpodcourse-public/blob/main/lib/state/auth/backend/authenticator.dart

class Authenticator {
  String? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isLoggedIn => userId != null;
  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResult> loginWithGoogle() async {
    // for android, we need to set sha-1 & sha-256 to firebase project
    // https://developers.google.com/android/guides/client-auth
    final googleSignIn = GoogleSignIn(scopes: [Constants.emailScope]);
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await googleAccount.authentication;
    final googleAuthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(googleAuthCredentials);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
