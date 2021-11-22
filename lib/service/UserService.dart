import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/User.dart';
import 'package:myownmenu/utils/Service.dart';

class UserService {
  static Future<List<User>> getAll() async {
    List<User> users = List.empty();
    final CollectionReference<User> parsedUsersCollection = parseAll();
    final allUsers = await parsedUsersCollection.get();
    for (final snapshot in allUsers.docs) {
      User user = User.createFromSnapshot(snapshot);
      users.add(user);
      print(user);
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
      'firebase-auth-uid': uid
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

  static setIntoUser(
      {required String uid, required String property, required dynamic value}) {
    Service.getDocument(User.COLLECTION, documentName: uid)
        .set({property: value});
  }
}
