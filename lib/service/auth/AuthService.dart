import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier{
  FirebaseAuth _auth =  FirebaseAuth.instance;
  User? user;
  bool isLoading = true;

  AuthService() {
      _verify();
  }

  _verify() {
    _auth.authStateChanges().listen((User? user) {
      this.user = user;
      this.isLoading = false;
      notifyListeners();
    });
  }
}