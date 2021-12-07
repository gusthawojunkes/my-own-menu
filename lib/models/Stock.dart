import 'package:myownmenu/models/Ingredient.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Stock implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'stock';

  Ingredient ingredient = new Ingredient('', new Type('', ''));
  double quantity = 0;

  Stock(ingredient, quantity) {
    this.ingredient = ingredient;
    this.quantity = quantity;
  }

  @override
  Map<String, Object?> toJson() => {
    'ingredient': ingredient,
    'quantity': quantity,
  };

  static Stock fromSnapshot(snapshot) {
    Ingredient ingredient = snapshot['ingredient'];
    double quantity = snapshot['quantity'];

    return new Stock(ingredient, quantity);
  }
}
