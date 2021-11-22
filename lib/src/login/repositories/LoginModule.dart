import 'package:myownmenu/service/auth/AuthService.dart';

class LoginModule {
  static Future<bool> execute(String email, String password) async {
    AuthService auth = AuthService();
    bool authenticated = false;
    auth.login(email, password).then((user) => {authenticated = user != null});
    return authenticated;
  }
}
