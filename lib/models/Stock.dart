import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Stock implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'ingredients';

  Type type = new Type('', '');
  String name = '';

  Stock(String name, Type type) {
    this.name = name;
    this.type = type;
  }

  @override
  Map<String, Object?> toJson() => {
        'name': name,
        'type': type.toJson()
      };

  static Stock fromSnapshot(snapshot) {
    String name = snapshot['name'];
    Type type = new Type(snapshot['type']['name'], snapshot['type']['image']);

    return new Stock(name, type);
  }

  String getName() {
    return this.name;
  }
}
