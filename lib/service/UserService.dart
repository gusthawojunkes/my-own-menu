import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/User.dart';
import 'package:myownmenu/utils/Service.dart';

class UserService {
  static Future<List<User>> getAll() async {
    List<User> users = List.empty();
    final CollectionReference<User> usersCollection = parseAll();
    final allUsers = await usersCollection.get();
    for (final snapshot in allUsers.docs) {
      User user = User.createFromSnapshot(snapshot);
      users.add(user);
    }
    return users;
  }

  static create(
      {required String name,
      required String email,
      required String password,
      required String uid}) {
    Service.getCollection(User.COLLECTION).doc().set({
      'name': name,
      'email': email,
      'username': name,
      'password': password,
      'uid': uid
    });
  }

  static CollectionReference<User> parseAll() {
    CollectionReference usersCollection =
        Service.getCollection(User.COLLECTION);

    return usersCollection.withConverter<User>(
      fromFirestore: (snapshots, _) => User.fromJson(snapshots.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
  }
}
