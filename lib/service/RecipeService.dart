import 'package:myownmenu/models/Recipe.dart';
import 'package:myownmenu/models/RecipeIngredient.dart';
import 'package:myownmenu/models/Step.dart';
import 'package:myownmenu/utils/Service.dart';

class RecipeService {
  static create(
      {required String title,
      required int preparationTime,
      required List<RecipeIngredient> ingredients,
      required List<Step> preparationMethod}) {
    Service.getCollection(Recipe.COLLECTION).doc().set({
      'title': title,
      'preparationTime': preparationTime,
      'ingredients': ingredients,
      'preparationMethod': preparationMethod
    });
  }
}
