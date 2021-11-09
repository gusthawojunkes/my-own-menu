import 'package:myownmenu/models/Ingredient.dart';
import 'package:myownmenu/models/Stock.dart';
import 'package:myownmenu/utils/Service.dart';

class StockService {
  static create({required Ingredient ingredient, required double quantity}) {
    Service.getCollection(Stock.COLLECTION)
        .doc()
        .set({'ingredient': ingredient, 'quantity': quantity});
  }
}
