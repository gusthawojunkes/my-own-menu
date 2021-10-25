import 'package:myownmenu/service/auth/AuthService.dart';

class LoginModule {
  static bool execute(String email, String password) {
    AuthService auth = AuthService();
    auth.login(email, password);
    print(auth.user);
    return auth.user != null;
  }
}
