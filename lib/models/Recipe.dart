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
    String title, 
    int preparationTime, 
    List<RecipeIngredient> ingredients,
    List<Step> preparationMethod
  ) {
    this.title = title;
    this.preparationTime = preparationTime;
    this.ingredients = ingredients;
    this.preparationMethod = preparationMethod;
  }

  @override
  Map<String, Object?> toJson() => {
    'title': title,
    'preparationTime': preparationTime,
    'ingredients': ingredients,
    'preparationMethod': preparationMethod
  };

  static Recipe fromSnapshot(snapshot) {
    List<RecipeIngredient> ingredients = [];
    List<Step> steps = [];
    String title = snapshot['title'];
    int preparationTime = snapshot['preparationTime'];
    for (var ing in snapshot['ingredients']) {
      RecipeIngredient ingredient = RecipeIngredient.fromSnapshot(ing);
      ingredients.add(ingredient);
    }
    for (var st in snapshot['preparationMethod']) {
      Step step = Step.fromSnapshot(st);
      steps.add(step);
    }

    return Recipe(title, preparationTime, ingredients, steps);
  }
}
