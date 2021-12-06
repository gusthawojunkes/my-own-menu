import 'package:myownmenu/models/Ingredient.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class RecipeIngredient implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'recipe-ingredients';

  Ingredient ingredient = new Ingredient(name: '', type: new Type('', ''));
  String quantity = '';

  RecipeIngredient({required ingredient, required quantity});

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      RecipeIngredient(
          ingredient: json['ingredient'], quantity: json['quantity']);

  @override
  Map<String, Object?> toJson() =>
      {'ingredient': ingredient, 'quantity': quantity};
}
