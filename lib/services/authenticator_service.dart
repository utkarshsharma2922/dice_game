import 'dart:async';

import 'package:dice_game/services/firebase_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticatorService extends ChangeNotifier{
  User user;
  AuthenticatorService() {
    user = FirebaseAuth.instance.currentUser;
  }

  Future<AuthResult>signInWith({@required String email,@required String password})async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      user = userCredential.user;
      FirebaseDBService.instance.fetchUserData();
      return AuthResult(success: true);

    } on FirebaseAuthException catch (e) {
      String error;
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      }
      return AuthResult(success: false,error: error);
    }
  }

  Future<AuthResult>signUpWith({@required String email,@required String password})async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      user = userCredential.user;
      FirebaseDBService.instance.createUserData();
      return AuthResult(success: true);
    } on FirebaseAuthException catch (e) {
      String error;
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
      }
      return AuthResult(success: false,error: error);

    } catch (e) {
      print(e);
      return AuthResult(success: false,error: e.toString());
    }
  }
}

class AuthResult{
  final bool success;
  final String error;
  AuthResult({this.success, this.error = ""});
}