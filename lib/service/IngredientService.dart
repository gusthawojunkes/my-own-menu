import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/Ingredient.dart';
import 'package:myownmenu/utils/Service.dart';

class IngredientService {
  static create({required String name, required Map type}) {
    ;
    Service.getCollection(Ingredient.COLLECTION)
        .doc()
        .set({'name': name, 'type': type});
  }

  static Future<List<Ingredient>> getAll() async {
    List<Ingredient> ingredients = List.empty();
    final CollectionReference<Ingredient> ingredientCollection = parseAll();
    final allUsers = await ingredientCollection.get();
    for (final snapshot in allUsers.docs) {
      Ingredient ingredient = Ingredient.createFromSnapshot(snapshot);
      ingredients.add(ingredient);
      print(ingredient);
    }
    return ingredients;
  }

  static CollectionReference<Ingredient> parseAll() {
    CollectionReference ingredientCollection =
        Service.getCollection(Ingredient.COLLECTION);

    return ingredientCollection.withConverter<Ingredient>(
      fromFirestore: (snapshots, _) => Ingredient.fromJson(snapshots.data()!),
      toFirestore: (ingredient, _) => ingredient.toJson(),
    );
  }
}
