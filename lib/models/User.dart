import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class User implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'users';

  String name = '';
  String email = '';
  String username = '';
  String password = '';
  String firebaseAuthUid = '';

  User(
      {required name,
      required email,
      required username,
      required password,
      required firebaseAuthUid});

  static User fromSnapshot(QueryDocumentSnapshot<User> userSnapshot) {
    String name = userSnapshot['name'];
    String email = userSnapshot['email'];
    String username = userSnapshot['username'];
    String password = userSnapshot['password'];
    String firebaseAuthUid = userSnapshot['firebase-auth-uid'];

    return User(
        name: name,
        email: email,
        username: username,
        password: password,
        firebaseAuthUid: firebaseAuthUid);
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json['name'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      firebaseAuthUid: json['firebase-auth-uid']);

  @override
  Map<String, Object?> toJson() => {
        'name': name,
        'email': email,
        'username': username,
        'password': password,
        'firebase-auth-uid': firebaseAuthUid
      };
}
