import 'package:myownmenu/models/error/AuthException.dart';
import 'package:myownmenu/service/auth/AuthService.dart';

class LoginModule {
  static Future<bool> execute(String email, String password) async {
    AuthService auth = AuthService();
    bool authenticated = false;
    try {
      auth
          .login(email, password)
          .then((user) => {authenticated = user != null});
    } on AuthException catch (e) {
      throw e;
    } catch (ex) {
      throw ex;
    }
    return authenticated;
  }
}
