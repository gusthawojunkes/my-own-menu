import 'package:firebase_auth/firebase_auth.dart';
import 'package:myownmenu/models/error/AuthException.dart';
import 'package:myownmenu/service/auth/AuthService.dart';

class LoginModule {
  static Future<bool> execute(String email, String password) async {
    AuthService auth = AuthService.getInstance();
    if (auth.user != null) {
      return true;
    }
    try {
      var loginUser = await auth.login(email, password);
      return loginUser != null;
    } on FirebaseAuthException catch (error) {
      throw error;
    } on AuthException catch (error) {
      throw error;
    } catch (error) {
      throw error;
    }
  }
}
