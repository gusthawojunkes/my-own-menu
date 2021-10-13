import 'package:myownmenu/models/serialization/JsonMapper.dart';

class User implements JsonMapper {
  final String name = '';
  final String email = '';
  final String username = '';
  final String password = '';

  User({required name, required email, required username, required password});

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json['name'],
    email: json['email'],
    username: json['username'],
    password: json['password'],
  );

  @override
  Map<String, Object?> toJson() => {
    'name': name,
    'email': email,
    'username': username,
    'password': password
  };
}
