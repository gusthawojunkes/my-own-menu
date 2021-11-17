class PreferenceModule {
  static Map<int, String> getMapPreferencesTwo() {
    Map<int, String> mapChoices =
        Map.unmodifiable({0: 'Massa', 1: 'Carnes no geral', 2: 'Grãos'});

    return mapChoices;
  }
}
