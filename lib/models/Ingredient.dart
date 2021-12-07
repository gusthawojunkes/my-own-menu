import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Ingredient implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'ingredients';

  String name = '';
  Type type = new Type('', '');

  Ingredient(String name, Type type) {
    this.name = name;
    this.type = type;
  }

  @override
  Map<String, Object?> toJson() => {
    'name': name,
    'type': type,
  };

  static Ingredient fromSnapshot(snapshot) {
    String name = snapshot['name'];
    Type type = new Type(snapshot['type']['name'], snapshot['type']['image']);

    return new Ingredient(name, type);
  }

  String getName() {
    return this.name;
  }
}
