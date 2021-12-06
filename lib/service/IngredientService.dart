import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myownmenu/models/Ingredient.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/service/FileService.dart';
import 'package:myownmenu/utils/Service.dart';

class IngredientService {
  static create({required String name, required Type type}) {
    Map typeMap = type.toJson();
    Service.getCollection(Ingredient.COLLECTION)
        .doc()
        .set({'name': name, 'type': typeMap});
  }

  static saveImage({required XFile image, required String name}) async {
    String? uid = await getIngedientUid(name);
    FileServive.uploadFile("/ingredients/" + uid! + "/", image);
  }

  static Future<List<Ingredient>> getAll() async {
    List<Ingredient> ingredients = [];
    final CollectionReference<Ingredient> ingredientCollection = await parseAll();
    final allUsers = await ingredientCollection.get();
    for (final snapshot in allUsers.docs) {
      Ingredient ingredient = Ingredient.fromSnapshot(snapshot);
      ingredients.add(ingredient);
    }
    return ingredients;
  }

  static Future<String?> getIngedientUid(String name) async {
    String uid = "";
    final CollectionReference<Ingredient> ingredientCollection = await parseAll();
    final allUsers = await ingredientCollection.get();
    for (final snapshot in allUsers.docs) {
      if (snapshot.get('name') == name) uid = snapshot.id;
    }
    return uid;
  }

  static Future<CollectionReference<Ingredient>> parseAll() async {
    CollectionReference ingredientCollection =
        Service.getCollection(Ingredient.COLLECTION);

    return ingredientCollection.withConverter<Ingredient>(
      fromFirestore: (snapshots, _) => Ingredient.fromJson(snapshots.data()!),
      toFirestore: (ingredient, _) => ingredient.toJson(),
    );
  }
}
