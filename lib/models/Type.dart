import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Type implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'type';

  String name = '';
  String image = '';

  Type(String name, String image) {
    this.name = name;
    this.image = image;
  }

  @override
  Map<String, Object?> toJson() => {
        'name': name,
        'image': image,
      };

  static Type fromSnapshot(snapshot) {
    String name = snapshot['name'];
    String image = snapshot['image'];
    return Type(name, image);
  }
}
