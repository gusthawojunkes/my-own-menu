import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Ingredient implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'ingredients';

  String name = '';
  Type type = new Type('', '');

  Ingredient({
    required name,
    required type,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      Ingredient(name: json['name'], type: json['type']);

  @override
  Map<String, Object?> toJson() => {
        'name': name,
        'type': type,
      };

  static Ingredient createFromSnapshot(
      QueryDocumentSnapshot<Ingredient> snapshot) {
    return Ingredient(name: snapshot['name'], type: snapshot['type']);
  }
}
