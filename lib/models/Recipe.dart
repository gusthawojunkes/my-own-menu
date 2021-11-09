import 'package:myownmenu/models/RecipeIngredient.dart';
import 'package:myownmenu/models/Step.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Recipe implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'recipes';

  final String title = '';
  final int preparationTime = 0;
  final List<RecipeIngredient> ingredients = List.empty();
  final List<Step> preparationMethod = List.empty();

  Recipe(
      {required title,
      required preparationTime,
      required ingredients,
      required preparationMethod});

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
      title: json['title'],
      preparationTime: json['preparationTime'],
      ingredients: json['ingredients'],
      preparationMethod: json['preparationMethod']);

  @override
  Map<String, Object?> toJson() => {
        'title': title,
        'preparationTime': preparationTime,
      };
}
