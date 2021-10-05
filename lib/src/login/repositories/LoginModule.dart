import 'package:myownmenu/models/User.dart';
import 'package:myownmenu/utils/Service.dart';

class LoginModule {

  static Future<bool> execute(String email, String password) async {
    final user = Service.getCollection("users").then((users) => users
    .where("email", isEqualTo: email)
    .where("password", isEqualTo: password)
    .limit(1));
    // .withConverter(
    //   fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
    //   toFirestore: (user, _) => user.toJson()
    // ));
    return user != null;
  }

}