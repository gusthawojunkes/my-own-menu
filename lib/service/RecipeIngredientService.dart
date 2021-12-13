import 'package:myownmenu/models/Stock.dart';
import 'package:myownmenu/models/Recipe.dart';
import 'package:myownmenu/models/RecipeIngredient.dart';
import 'package:myownmenu/utils/Service.dart';

class RecipeStockService {
  static create(
      {required Recipe recipe,
      required Stock ingredient,
      required double quantity}) {
    Service.getCollection(RecipeIngredient.COLLECTION).doc().set(
        {'recipe': recipe, 'ingredient': ingredient, 'quantity': quantity});
  }
}
