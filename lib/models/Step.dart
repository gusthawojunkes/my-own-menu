import 'package:myownmenu/models/Recipe.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Step implements JsonMapper {
  Recipe recipe = new Recipe(title: '', preparationTime: 0, ingredients: List.empty());
  final String description = '';
  final int sequence = 0;

  Step({
    required recipe,
    required description,
    required sequence
  });

  factory Step.fromJson(Map<String, dynamic> json) =>
    Step(
      recipe: json['recipe'], 
      description: json['description'],
      sequence: json['sequence']
    );

  @override
  Map<String, Object?> toJson() => {
    'recipe': recipe,
    'description': description,
    'sequence': sequence
  };
}