import 'package:cuidapet/app/core/dio/auth_interceptors_wrapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomDio {
  static CustomDio _simpleInstance;
  static CustomDio _authenticationInstance;
  Dio _dio;

  BaseOptions options = new BaseOptions(
    baseUrl: DotEnv().env['base_url'],
    connectTimeout: int.parse(DotEnv().env['dio_connectTimeout']),
    receiveTimeout: int.parse(DotEnv().env['dio_receiveTimeout']),
  );

  static Dio get instance {
    if (_simpleInstance == null) {
      _simpleInstance = CustomDio._();
    }
    return _simpleInstance._dio;
  }

  static Dio get authInstance {
    if (_authenticationInstance == null) {
      _authenticationInstance = CustomDio._auth();
    }
    return _authenticationInstance._dio;
  }

  CustomDio._() {
    _dio = Dio(options);
  }

  CustomDio._auth() {
    _dio = Dio(options);
    _dio.interceptors.add(AuthInterceptorsWrapper());
  }
}
