import 'package:myownmenu/models/RecipeIngredient.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Recipe implements JsonMapper {
  final String title = '';
  final int preparationTime = 0;
  final List<RecipeIngredient> ingredients = List.empty();

  Recipe({
    required title,
    required preparationTime,
    required ingredients
  });

  factory Recipe.fromJson(Map<String, dynamic> json) =>
    Recipe(
      title: json['title'], 
      preparationTime: json['preparationTime'],
      ingredients: json['ingredients']
    );

  @override
  Map<String, Object?> toJson() => {
    'title': title,
    'preparationTime': preparationTime,
  };
}
