import 'package:myownmenu/models/serialization/JsonMapper.dart';

class User implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'users';

  String name = '';
  String email = '';
  String username = '';
  String password = '';
  String firebaseAuthUid = '';

  User(name, email, username, password, firebaseAuthUid) {
    this.name = name;
    this.email = email;
    this.username = username;
    this.password = password;
    this.firebaseAuthUid = firebaseAuthUid;
  }

  static User fromSnapshot(snapshot) {
    String name = snapshot['name'];
    String email = snapshot['email'];
    String username = snapshot['username'];
    String password = snapshot['password'];
    String firebaseAuthUid = snapshot['firebase-auth-uid'];

    return User(name, email, username, password, firebaseAuthUid);
  }

  @override
  Map<String, Object?> toJson() => {
    'name': name,
    'email': email,
    'username': username,
    'password': password,
    'firebase-auth-uid': firebaseAuthUid
  };
}
