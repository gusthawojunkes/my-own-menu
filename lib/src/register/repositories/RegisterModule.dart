import 'package:firebase_auth/firebase_auth.dart';
import 'package:myownmenu/service/auth/AuthService.dart';

class RegisterModule {
  static void register(String name, String email, String password) {
    AuthService auth = AuthService();
    try {
      auth.register(name, email, password);
    } on FirebaseAuthException catch (error) {
      print(error.code);
    }
  }
}
