import 'package:myownmenu/models/Recipe.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Step implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'step';

  Recipe recipe = new Recipe(
      title: '',
      preparationTime: 0,
      ingredients: List.empty(),
      preparationMethod: List.empty());
  final String description = '';
  final int sequence = 0;

  Step({required description, required sequence});

  factory Step.fromJson(Map<String, dynamic> json) =>
      Step(description: json['description'], sequence: json['sequence']);

  @override
  Map<String, Object?> toJson() =>
      {'recipe': recipe, 'description': description, 'sequence': sequence};
}
