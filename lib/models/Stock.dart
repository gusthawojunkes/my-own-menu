import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Stock implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'stock';

  Type type = new Type('', '');
  String name = '';
  String quantity = '';
  String image = '';

  Stock(String name, Type type, String quantity, String image) {
    this.name = name;
    this.type = type;
    this.quantity = quantity;
    this.image = image;
  }

  @override
  Map<String, Object?> toJson() => {
        'name': name,
        'quantity': quantity,
        'image': image,
      };

  static Stock fromSnapshot(snapshot) {
    String name = snapshot['name'];
    String quantity = snapshot['quantity'];
    String image = snapshot['image'];
    Type type = new Type(snapshot['type']['name'], snapshot['type']['image']);

    return new Stock(name, type, quantity, image);
  }

  String getName() {
    return this.name;
  }
}
