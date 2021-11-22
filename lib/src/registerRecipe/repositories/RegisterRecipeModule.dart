import 'package:myownmenu/service/IngredientService.dart';

class RegisterRecipeModule {
  static load() {
    IngredientService.getAll();
  }
}
