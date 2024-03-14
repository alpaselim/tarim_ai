import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarim_ai/Data/app_constant_env.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Named constructor, only accessible within this class
  AuthService._internal();

  // Factory constructor to return the instance
  factory AuthService() {
    return _instance;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      loginScreenPath,
      (route) => false,
    );
  }
}

final AuthService authService = AuthService();
