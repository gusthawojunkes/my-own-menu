import 'package:myownmenu/models/Ingredient.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class RecipeIngredient implements JsonMapper {
  Ingredient ingredient = new Ingredient('', new Type('', ''));
  String quantity = '';

  RecipeIngredient(Ingredient ingredient, String quantity) {
    this.ingredient = ingredient;
    this.quantity = quantity;
  }

  @override
  Map<String, Object?> toJson() => {
    'ingredient': ingredient.getName(), 
    'quantity': quantity
  };

  static RecipeIngredient fromSnapshot(snapshot) {
    Ingredient ingredient = snapshot['ingredient'];
    String quantity = snapshot['quantity'];

    return new RecipeIngredient(ingredient, quantity);
  }
}
