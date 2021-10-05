import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Ingredient implements JsonMapper {
  final String name = '';
  final String type = '';

  Ingredient({
    required name, 
    required type,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    name: json['name'],
    type: json['type']
  );

  @override
  Map<String, Object?> toJson() => {
    'name': name,
    'type': type,
  };
}
