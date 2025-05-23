import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_vk/models/app_user.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign up a new user
  static Future<AppUser?> signUp(String email, String password) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return AppUser(
            uid: credential.user!.uid, email: credential.user!.email!);
      }
      return null;
    } catch (err) {
      return null;
    }
  }

  // Log out a new user
  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Sign in an existing user
  static Future<AppUser?> signIn(String email, String password) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return AppUser(
            uid: credential.user!.uid, email: credential.user!.email!);
      }
      return null;
    } catch (err) {
      return null;
    }
  }
}
