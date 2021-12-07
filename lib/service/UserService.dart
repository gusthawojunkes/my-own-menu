import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/User.dart';
import 'package:myownmenu/utils/Service.dart';

class UserService {
  static Future<List<User>> getAll() async {
    List<User> users = List.empty(growable: true);
    final CollectionReference<User> parsedUsersCollection = parseAll();
    final allUsers = await parsedUsersCollection.get();
    for (final snapshot in allUsers.docs) {
      User user = User.fromSnapshot(snapshot);
      users.add(user);
    }
    return users;
  }

  static create(
    {
      required String name,
      required String email,
      required String password,
      required String uid
    }
  ) {
    Service.getCollection(User.COLLECTION).doc(uid).set({
      'name': name,
      'email': email,
      'username': name,
      'password': password,
      'firebase-auth-uid': uid
    });
  }

  static CollectionReference<User> parseAll() {
    CollectionReference usersCollection = Service.getCollection(User.COLLECTION);
    return usersCollection.withConverter<User>(
      fromFirestore: (snapshots, _) => User.fromSnapshot(snapshots.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
  }

  static update(
      {required String uid, required String property, required dynamic value}) {
    Service.getDocument(User.COLLECTION, documentName: uid)
        .update({property: value});
  }
}
