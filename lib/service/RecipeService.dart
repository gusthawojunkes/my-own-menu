import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/Recipe.dart';
import 'package:myownmenu/models/RecipeIngredient.dart';
import 'package:myownmenu/models/Step.dart';
import 'package:myownmenu/utils/Service.dart';

class RecipeService {
  static create(
      {required String title,
      required int preparationTime,
      required List<RecipeIngredient> ingredients,
      required List<Step> steps}) {
    Service.getCollection(Recipe.COLLECTION).doc().set({
      'title': title,
      'preparationTime': preparationTime,
      'ingredients': ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'steps': steps.map((step) => step.toJson()).toList()
    });
  }

  static Future<List<Recipe>> getAll() async {
    List<Recipe> recipes = [];
    final CollectionReference<Recipe> recipeCollection = await parseAll();
    final allRecipes = await recipeCollection.get();
    for (final snapshot in allRecipes.docs) {
      Recipe recipe = Recipe.fromSnapshot(snapshot);
      recipes.add(recipe);
    }
    return recipes;
  }

  static Future<CollectionReference<Recipe>> parseAll() async {
    CollectionReference recipeCollection =
        Service.getCollection(Recipe.COLLECTION);

    return recipeCollection.withConverter<Recipe>(
      fromFirestore: (snapshots, _) => Recipe.fromSnapshot(snapshots.data()!),
      toFirestore: (recipe, _) => recipe.toJson(),
    );
  }
}
