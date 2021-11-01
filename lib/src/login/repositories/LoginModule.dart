import 'package:myownmenu/service/UserService.dart';
import 'package:myownmenu/service/auth/AuthService.dart';

class LoginModule {
  static bool execute(String email, String password) {
    AuthService auth = AuthService();
    auth.login(email, password);
    bool authenticated = auth.user != null;
    UserService.getAll();
    if (authenticated) {
      print('Account of $email successfully authenticated');
    }
    return authenticated;
  }
}
