import 'package:myownmenu/models/Ingredient.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Stock implements JsonMapper {
  final Ingredient ingredient = new Ingredient(name: '', type: '');
  final int quantity = 0;

  Stock({
    required ingredient,
    required quantity,
  });

  factory Stock.fromJson(Map<String, dynamic> json) =>
    Stock(
      ingredient: json['ingredient'], 
      quantity: json['quantity']
    );

  @override
  Map<String, Object?> toJson() => {
    'ingredient': ingredient,
    'quantity': quantity,
  };
}
