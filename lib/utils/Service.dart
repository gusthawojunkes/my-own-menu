import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  static Future<FirebaseFirestore> getInstance() async {
    return FirebaseFirestore.instance;
  }

  static Future<CollectionReference<Object?>> getCollection(String name) async {
    FirebaseFirestore instance = await getInstance();
    return instance.collection(name);
  }

  static Future<DocumentReference<Object?>> getDocument(String collectionName, { String documentName = '' }) async {
    FirebaseFirestore instance = await getInstance();
    return instance.collection(collectionName).doc(documentName);
  }
}
