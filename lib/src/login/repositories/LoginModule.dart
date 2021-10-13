import 'package:myownmenu/models/User.dart';
import 'package:myownmenu/service/UserService.dart';
import 'package:myownmenu/utils/Service.dart';

class LoginModule {
  static Future<bool> execute(String email, String password) async {
    UserService.getAll();
    final user = Service.getCollection("users").doc().get();
    print(user);
    // .then((users) => users
    // .where("email", isEqualTo: email)
    // .where("password", isEqualTo: password)
    // .limit(1));
    return true;
  }
}
