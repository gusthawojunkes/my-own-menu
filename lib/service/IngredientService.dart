import 'package:myownmenu/models/Ingredient.dart';
import 'package:myownmenu/utils/Service.dart';

class IngredientService {
  static create({required String name, required String type}) {
    Service.getCollection(Ingredient.COLLECTION)
        .doc()
        .set({'name': name, 'type': type});
  }
}
