import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/RecipeIngredient.dart';
import 'package:myownmenu/models/Step.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Recipe implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'recipes';

  String title = '';
  int preparationTime = 0;
  List<RecipeIngredient> ingredients = [];
  List<Step> preparationMethod = [];

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

  static Recipe fromSnapshot(QueryDocumentSnapshot<Recipe> snapshot) {
    List<RecipeIngredient> ingredients = [];
    List<Step> steps = [];
    String title = snapshot['title'];
    int preparationTime = snapshot['preparationTime'];
    for (var ing in snapshot['ingredients']) {
      RecipeIngredient ingredient = RecipeIngredient.fromJson(ing);
      ingredients.add(ingredient);
    }
    for (var st in snapshot['preparationMethod']) {
      Step step = Step.fromJson(st);
      steps.add(step);
    }

    return Recipe(
        title: title,
        preparationTime: preparationTime,
        ingredients: ingredients,
        preparationMethod: steps);
  }
}
