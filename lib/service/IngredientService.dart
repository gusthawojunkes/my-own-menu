import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/Ingredient.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/utils/Service.dart';

class IngredientService {
  static create({required String name, required Type type}) {
    Service.getCollection(Ingredient.COLLECTION)
        .doc()
        .set({'name': name, 'type': type});
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

  static Future<CollectionReference<Ingredient>> parseAll() async {
    CollectionReference ingredientCollection =
        Service.getCollection(Ingredient.COLLECTION);

    return ingredientCollection.withConverter<Ingredient>(
      fromFirestore: (snapshots, _) => Ingredient.fromJson(snapshots.data()!),
      toFirestore: (ingredient, _) => ingredient.toJson(),
    );
  }
}
