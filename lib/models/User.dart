import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class User implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'users';

  final String name = '';
  final String email = '';
  final String username = '';
  final String password = '';
  final String uid = '';

  User(
      {required name,
      required email,
      required username,
      required password,
      required uid});

  static User createFromSnapshot(QueryDocumentSnapshot<User> userSnapshot) {
    String name = userSnapshot['name'];
    String email = userSnapshot['email'];
    String username = userSnapshot['username'];
    String password = userSnapshot['password'];
    String uid = userSnapshot['uid'];

    return User(
        name: name,
        email: email,
        username: username,
        password: password,
        uid: uid);
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json['name'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      uid: json['uid']);

  @override
  Map<String, Object?> toJson() => {
        'name': name,
        'email': email,
        'username': username,
        'password': password,
        'uid': uid
      };
}
