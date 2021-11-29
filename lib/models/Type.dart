import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Type implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'type';

  final String name = '';
  final String image = '';

  Type({
    required name,
    required image,
  });

  factory Type.fromJson(Map<String, dynamic> json) =>
      Type(name: json['name'], image: json['image']);

  @override
  Map<String, Object?> toJson() => {
        'name': name,
        'image': image,
      };
}
