import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthDataSource {
  Future<UserCredential> signIn();
  Future<void> signOut();
  Future<User?> isAuthenticated();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth firebaseAuth;
  AuthDataSourceImpl({required this.firebaseAuth});
  @override
  Future<UserCredential> signIn() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw Exception('Google sign in aborted');
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> isAuthenticated() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      rethrow;
    }
  }
}
