class AuthException implements Exception {
  String message = '';
  AuthException(this.message) {
    print(this.message);
  }
}
