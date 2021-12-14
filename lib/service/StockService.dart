import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myownmenu/models/Stock.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/service/FileService.dart';
import 'package:myownmenu/service/auth/AuthService.dart';
import 'package:myownmenu/utils/Service.dart';

class StockService {
  static create(
      {required String name,
      required Type type,
      required String quantity,
      required String image}) async {
    AuthService auth = AuthService.getInstance();
    String uid = auth.user!.uid;
    Map typeMap = type.toJson();

    await Service.getCollection(Stock.COLLECTION).doc(uid + "-" + name).set(
        {'name': name, 'type': typeMap, 'quantity': quantity, 'image': image});
  }

  static saveImage({required XFile image, required String name}) async {
    FileServive.uploadFile("/ingredients/" + name, image);
  }

  static Future<List<Stock>> getAll() async {
    List<Stock> listIngredients = [];
    final CollectionReference<Stock> ingredientCollection = await parseAll();
    var allIngredients = await ingredientCollection.get();
    List<QueryDocumentSnapshot<Stock>> snapshots = allIngredients.docs;
    for (var snapshot in snapshots) {
      Stock ingredient = Stock.fromSnapshot(snapshot);
      listIngredients.add(ingredient);
    }
    return listIngredients;
  }

  static Future<String?> getIngedientUid(String name) async {
    String uid = "";
    final CollectionReference<Stock> ingredientCollection = await parseAll();
    final allUsers = await ingredientCollection.get();
    for (final snapshot in allUsers.docs) {
      if (snapshot.get('name') == name) uid = snapshot.id;
    }
    return uid;
  }

  static Future<CollectionReference<Stock>> parseAll() async {
    CollectionReference ingredientCollection =
        Service.getCollection(Stock.COLLECTION);

    return ingredientCollection.withConverter<Stock>(
      fromFirestore: (snapshots, _) => Stock.fromSnapshot(snapshots.data()!),
      toFirestore: (ingredient, _) => ingredient.toJson(),
    );
  }
}
