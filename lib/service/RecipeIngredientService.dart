import 'package:myownmenu/models/Ingredient.dart';
import 'package:myownmenu/models/Recipe.dart';
import 'package:myownmenu/models/RecipeIngredient.dart';
import 'package:myownmenu/utils/Service.dart';

class RecipeIngredientService {
  static create(
      {required Recipe recipe,
      required Ingredient ingredient,
      required double quantity}) {
    Service.getCollection(RecipeIngredient.COLLECTION).doc().set(
        {'recipe': recipe, 'ingredient': ingredient, 'quantity': quantity});
  }
}
