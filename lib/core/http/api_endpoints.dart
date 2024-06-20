// ignore_for_file: constant_identifier_names

class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  static const String HTTPS = "http://";
  static const String PORT = ":5050";

  //localhost
  static const String ADDRESS = "192.168.56.1";
  static const String SERVER_ADDRESS = "$HTTPS$ADDRESS$PORT";

  static const String LOGIN = "/login";
}
