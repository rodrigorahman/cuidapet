import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/repositories/security_storage_repository.dart';
import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthInterceptorsWrapper extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    var shared = await SharedPrefsRepository.instance;
    options.headers['Authorization'] = shared.accessToken;
    if (DotEnv().env['dio_debug'] == 'true') {
      print('########### Request Log');
      print('url: ${options.uri}');
      print('method: ${options.method}');
      print('data: ${options.data}');
      print('headers: ${options.headers}');
    }
  }

  @override
  Future onResponse(Response response) async {
    if (DotEnv().env['dio_debug'] == 'true') {
      print('########### Response Log');
      print(response.data);
      print('########### Response Log');
    }
  }

  @override
  Future onError(DioError err) async {
    print(err);
    print('error: $err');
    print('response: ${err.response}');
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      await refreshToken();
      final req = err.request;
      return CustomDio.authInstance.request(req.path, options: req);
    }
    return err;
  }

  Future<void> refreshToken() async {
    final prefs = await SharedPrefsRepository.instance;
    final security = SecurityStorageRepository();

    try {
      final refreshToken = await security.refreshToken;
      final response = await CustomDio.instance.put(
        '/login/refresh',
        data: {'token': prefs.accessToken, 'refresh_token': refreshToken},
      );
      await prefs.registerAccessToken(response.data['access_token']);
      await security.registerRefreshToken(response.data['refresh_token']);
    } catch (e, s) {
      print(e);
      print(s);
      await prefs.clear();
      await Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
    }
  }
}
