import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Ingredient implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'ingredients';

  String name = '';
  Type type = new Type('', '');

  Ingredient({
    required String name,
    required Type type,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
    Ingredient(
      name: json['name'], 
      type: new Type(json['type']['name'], json['type']['image'])
    );

  @override
  Map<String, Object?> toJson() => {
    'name': name,
    'type': type,
  };

  static Ingredient fromSnapshot(QueryDocumentSnapshot<Ingredient> snapshot) {
    String name = snapshot['name'];
    Type type = new Type(snapshot['type']['name'], snapshot['type']['image']);
    
    return Ingredient(name: name, type: type);
  }

  String getName() {
    return this.name;
  }
}
