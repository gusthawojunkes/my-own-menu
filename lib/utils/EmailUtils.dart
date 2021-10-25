import 'package:myownmenu/utils/Helper.dart';

class EmailUtils {
  static bool isValid(String? email) {
    if (Helper.isNull(email))
      return false;
    else if (!email!.contains('@')) return false;
    return true;
  }

  static bool isNotValid(String? email) {
    return !isValid(email);
  }
}
