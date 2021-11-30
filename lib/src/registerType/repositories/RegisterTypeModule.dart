import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/service/TypeService.dart';
import 'Dart:async';

class RegisterTypeModule {
  static getListTypes() async {
    Future<List> _futureOfList = TypeService.getAll();
    List list = await _futureOfList;
    Type type = list.first;
    print("1 - " + type.name);
    print("2 - " + type.image);
  }
}
