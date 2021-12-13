import 'package:myownmenu/models/Stock.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class RecipeIngredient implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'recipe-ingredients';

  Type type = new Type('', '');
  Stock ingredient = new Stock('', new Type('', ''), '', '');
  String quantity = '';

  RecipeIngredient(Type type, Stock ingredient, String quantity) {
    this.type = type;
    this.ingredient = ingredient;
    this.quantity = quantity;
  }

  @override
  Map<String, Object?> toJson() =>
      {'ingredient': ingredient, 'quantity': quantity};

  static RecipeIngredient fromSnapshot(snapshot) {
    Type type = new Type(snapshot['type']['name'], snapshot['type']['image']);
    Stock ingredient = snapshot['ingredient'];
    String quantity = snapshot['quantity'];

    return new RecipeIngredient(type, ingredient, quantity);
  }
}
