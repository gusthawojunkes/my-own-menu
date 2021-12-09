import 'package:myownmenu/models/serialization/JsonMapper.dart';

class Step implements JsonMapper {

  String description = '';
  int sequence = 0;

  Step(String description, int sequence) {
    this.description = description;
    this.sequence = sequence;
  }

  @override
  Map<String, Object?> toJson() => {
    'description': description, 
    'sequence': sequence
  };

  static Step fromSnapshot(snapshot) {
    String description = snapshot['description'];
    int sequence = snapshot['sequence'];

    return new Step(description, sequence);
  }
}
