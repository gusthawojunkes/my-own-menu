import 'package:myownmenu/models/Stock.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class RecipeIngredient implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'recipe-ingredients';

  Stock ingredient = new Stock('', new Type('', ''));
  String quantity = '';

  RecipeIngredient(Stock ingredient, String quantity) {
    this.ingredient = ingredient;
    this.quantity = quantity;
  }

  @override
  Map<String, Object?> toJson() =>
      {'ingredient': ingredient.name, 'quantity': quantity};

  static RecipeIngredient fromSnapshot(snapshot) {
    String ingredient = snapshot['ingredient'];
    String quantity = snapshot['quantity'];
    Type type = new Type('', '');
    Stock stock = new Stock(ingredient, type);

    return new RecipeIngredient(stock, quantity);
  }
}
