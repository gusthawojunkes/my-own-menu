import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/User.dart';
import 'package:myownmenu/utils/Service.dart';

class UserService {
  static Future<List<User>> getAll() async {
    List<User> users = List.empty();
    final CollectionReference<User> usersCollection =
        Service.getCollection("users").withConverter<User>(
      fromFirestore: (snapshots, _) => User.fromJson(snapshots.data()!),
      toFirestore: (user, _) => user.toJson(),
    );

    print(usersCollection);

    return users;
  }
}
