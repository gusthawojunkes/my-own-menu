import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Type implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'type';

  String name = '';
  String image = '';

  Type(this.name, this.image);

  factory Type.fromJson(Map<String, dynamic> json) =>
      Type(json['name'], json['image']);

  @override
  Map<String, Object?> toJson() => {
        'name': name,
        'image': image,
      };

  static Type createFromSnapshot(QueryDocumentSnapshot<Type> snapshot) {
    return Type(snapshot['name'], snapshot['image']);
  }
}
