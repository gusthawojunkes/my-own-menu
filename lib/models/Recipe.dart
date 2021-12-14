import 'package:myownmenu/models/RecipeIngredient.dart';
import 'package:myownmenu/models/Step.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Recipe implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'recipes';

  String title = '';
  int preparationTime = 0;
  List<RecipeIngredient> ingredients = [];
  List<Step> steps = [];

  Recipe(
    String title, 
    int preparationTime, 
    List<RecipeIngredient> ingredients, 
    List<Step> steps
  ) {
    this.title = title;
    this.preparationTime = preparationTime;
    this.ingredients = ingredients;
    this.steps = steps;
  }

  @override
  Map<String, Object?> toJson() => {
        'title': title,
        'preparationTime': preparationTime,
        'ingredients': ingredients,
        'steps': steps
      };

  static Recipe fromSnapshot(snapshot) {
    List<RecipeIngredient> ingredients = [];
    List<Step> steps = [];
    String title = snapshot['title'];
    int preparationTime = snapshot['preparationTime'];
    snapshot['ingredients'].forEach((ing) => {
      ingredients.add(RecipeIngredient.fromSnapshot(ing))
    });
    snapshot['steps'].forEach((st) => {
      steps.add(Step.fromSnapshot(st))
    });

    return Recipe(title, preparationTime, ingredients, steps);
  }
}
