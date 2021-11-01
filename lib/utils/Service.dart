import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  Service._();

  static FirebaseFirestore getInstance() {
    return FirebaseFirestore.instance;
  }

  static CollectionReference getCollection(String name) {
    FirebaseFirestore instance = getInstance();
    return instance.collection(name);
  }

  static DocumentReference getDocument(String collectionName,
      {String documentName = ''}) {
    FirebaseFirestore instance = getInstance();
    return instance.collection(collectionName).doc(documentName);
  }
}
