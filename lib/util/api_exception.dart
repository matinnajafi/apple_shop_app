// Exception class for API-related errors
class ApiException implements Exception {
  int? code;
  String? message;

  ApiException(this.code, this.message);
}
