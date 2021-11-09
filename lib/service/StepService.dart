import 'package:myownmenu/models/Recipe.dart';
import 'package:myownmenu/models/Step.dart';
import 'package:myownmenu/utils/Service.dart';

class StepService {
  static create(
      {required Recipe recipe,
      required String description,
      required int sequence}) {
    Service.getCollection(Step.COLLECTION).doc().set(
        {'recipe': recipe, 'description': description, 'sequence': sequence});
  }
}
