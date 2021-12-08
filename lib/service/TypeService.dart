import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/utils/Service.dart';

class TypeService {
  static create({required String name, required String image}) {
    Service.getCollection(Type.COLLECTION)
        .doc()
        .set({'name': name, 'image': image});
  }

  static Future<List<Type>> getAll() async {
    List<Type> types = [];
    final CollectionReference<Type> typeCollection = await parseAll();
    final allUsers = await typeCollection.get();
    for (final snapshot in allUsers.docs) {
      Type type = Type.fromSnapshot(snapshot);
      types.add(type);
    }
    return types;
  }

  static Future<CollectionReference<Type>> parseAll() async {
    CollectionReference typeCollection = Service.getCollection(Type.COLLECTION);

    return typeCollection.withConverter<Type>(
      fromFirestore: (snapshots, _) => Type.fromSnapshot(snapshots.data()!),
      toFirestore: (type, _) => type.toJson(),
    );
  }
}
