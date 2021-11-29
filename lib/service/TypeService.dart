import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/utils/Service.dart';

class TypeService {
  static create({required String name, required String image}) {
    Service.getCollection(Type.COLLECTION)
        .doc()
        .set({'name': name, 'image': image});
  }
}
