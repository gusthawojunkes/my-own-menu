import 'package:firebase_auth/firebase_auth.dart';
import 'package:myownmenu/service/auth/AuthService.dart';
import 'package:myownmenu/models/error/AuthException.dart';

class RegisterModule {
  static execute(String name, String email, String password) async {
    AuthService auth = AuthService.getInstance();
    try {
      var newUser = await auth.register(name, email, password);
      return newUser;
    } on FirebaseAuthException catch (error) {
      throw error;
    } on AuthException catch (error) {
      throw error;
    } catch (error) {
      throw error;
    }
  }
}
