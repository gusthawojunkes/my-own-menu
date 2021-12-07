import 'package:myownmenu/models/Recipe.dart';
import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Step implements JsonMapper {
  // ignore: non_constant_identifier_names
  static final String COLLECTION = 'step';

  Recipe recipe = new Recipe('', 0, [], []);
  String description = '';
  int sequence = 0;

  Step(String description, int sequence) {
    this.description = description;
    this.sequence = sequence;
  }

  @override
  Map<String, Object?> toJson() =>
      {'recipe': recipe, 'description': description, 'sequence': sequence};

  static Step fromSnapshot(snapshot) {
    String description = snapshot['description'];
    int sequence = snapshot['sequence'];

    return new Step(description, sequence);
  }
}
