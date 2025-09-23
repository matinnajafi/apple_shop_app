import 'package:apple_shop_app/util/auth_manager.dart';
import 'package:dio/dio.dart';

// Provider for Dio instance
class DioProvider {
  static Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://startflutter.ir/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthManager.readAuth()}',
        },
      ),
    );
    return dio;
  }

  // for authentication (login, register) we don't have token
  static Dio createDioWithoutHeader() {
    Dio dio = Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/'));
    return dio;
  }
}
