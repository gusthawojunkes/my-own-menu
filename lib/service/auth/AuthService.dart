import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:myownmenu/models/error/AuthException.dart';
import 'package:myownmenu/service/UserService.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
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

  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _setUser();
    } on FirebaseAuthException catch (error) {
      handleAuthenticationError(error);
    } catch (e) {
      print(e);
    }
  }

  register(String name, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _setUser();
      UserService.create(
          name: name,
          email: email,
          password: password,
          uid: _auth.currentUser!.uid);
    } on FirebaseAuthException catch (error) {
      handleAuthenticationError(error);
    } catch (e) {
      print(e);
    }
  }

  logout() async {
    await _auth.signOut();
    _setUser();
  }

  _setUser() {
    this.user = _auth.currentUser;
    notifyListeners();
  }

  handleAuthenticationError(FirebaseAuthException error) {
    print(error.code);
    if (error.code == 'wrong-password') {
      throw AuthException('Senha incorreta, tente novamente.');
    } else if (error.code == 'user-not-found') {
      throw AuthException('Não há um usuário com esse e-mail cadastrado.');
    } else if (error.code == 'weak-password') {
      throw AuthException('Senha muito fraca, escolha outra.');
    } else if (error.code == 'email-already-in-use') {
      throw AuthException('Este e-mail já está cadastrado.');
    }
  }
}
