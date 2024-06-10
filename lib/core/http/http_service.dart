import 'package:dio/dio.dart' as dio_pkg;
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:venturelead/core/http/api_endpoints.dart';
import 'package:venturelead/core/toast.dart';

class HttpService extends GetxService {
  late dio_pkg.Dio dio;
  late String? userToken;

  @override
  void onInit() {
    super.onInit();
    dio = dio_pkg.Dio()
      ..options.baseUrl = ApiEndpoints.SERVER_ADDRESS
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(ErrorInterceptor())
      ..options.validateStatus = (int? status) => status != null;

    initializeHeaders(dio).then((_) {
      dio.interceptors.add(dio_pkg.InterceptorsWrapper(
        onError: (dio_pkg.DioException e, handler) {
          CustomToast.showToast(e.message.toString());
          handler.next(e);
        },
      ));

      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        responseBody: true,
        error: true,
        requestBody: true,
        responseHeader: true,
      ));
    });
  }
}

Future<Map<String, String>> getHeaders() async {
  Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer mmmmmmm',
  };

  return headers;
}

Future<void> initializeHeaders(dio_pkg.Dio dio) async {
  dio.options.headers = await getHeaders();
}

class ErrorInterceptor extends dio_pkg.Interceptor {
  @override
  void onResponse(
      dio_pkg.Response response, dio_pkg.ResponseInterceptorHandler handler) {
    final status = response.statusCode;
    final isValid = status != null && status >= 200 && status < 500;
    if (!isValid) {
      CustomToast.showToast("Error: $status");
    }
    super.onResponse(response, handler);
  }
}