import 'package:myownmenu/models/serialization/JsonMapper.dart';

class RecipeIngredient implements JsonMapper {
  String ingredient = '';
  String quantity = '';

  RecipeIngredient(String ingredient, String quantity) {
    this.ingredient = ingredient;
    this.quantity = quantity;
  }

  @override
  Map<String, Object?> toJson() => {
    'ingredient': ingredient, 
    'quantity': quantity
  };

  static RecipeIngredient fromSnapshot(snapshot) {
    String ingredient = snapshot['ingredient'];
    String quantity = snapshot['quantity'];

    return new RecipeIngredient(ingredient, quantity);
  }
}
