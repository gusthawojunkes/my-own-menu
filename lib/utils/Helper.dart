abstract class Helper {
  static bool isNull(dynamic value) {
    bool isNull = false;
    isNull = (value == null) || value.toString() == '';
    return isNull;
  }

  static bool isNotNull(dynamic value) {
    return !isNull(value);
  }

  static List<dynamic> unique(List list) {
    return [...{...list}];
  }
}
