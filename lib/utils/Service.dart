import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  
  Service._();

  static FirebaseFirestore getInstance() {
    return FirebaseFirestore.instance;
  }

  static CollectionReference<Object?> getCollection(String name) {
    FirebaseFirestore instance = getInstance();
    return instance.collection(name);
  }

  static DocumentReference<Object?> getDocument(String collectionName, { String documentName = '' }) {
    FirebaseFirestore instance = getInstance();
    return instance.collection(collectionName).doc(documentName);
  }
}
