import 'package:myownmenu/models/Recipe.dart';
import 'package:myownmenu/models/Ingredient.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class RecipeIngredient implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'recipe-ingredients';

  Recipe recipe = new Recipe(
      title: '',
      preparationTime: 0,
      ingredients: List.empty(),
      preparationMethod: List.empty());
  Ingredient ingredient = new Ingredient(name: '', type: '');
  final double quantity = 0;

  RecipeIngredient({required recipe, required ingredient, required quantity});

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      RecipeIngredient(
          recipe: json['recipe'],
          ingredient: json['ingredient'],
          quantity: json['quantity']);

  @override
  Map<String, Object?> toJson() =>
      {'recipe': recipe, 'ingredient': ingredient, 'quantity': quantity};
}
