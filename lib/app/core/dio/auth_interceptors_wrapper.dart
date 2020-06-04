import 'package:connectivity/connectivity.dart';
import 'package:cuidapet/app/core/connection/connection_check.dart';
import 'package:cuidapet/app/core/connection/no_connection_dialog.dart';
import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet/app/repositories/security_storage_repository.dart';
import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:synchronized/synchronized.dart' as synchronized;

class AuthInterceptorsWrapper extends InterceptorsWrapper {

  synchronized.Lock lock = synchronized.Lock();

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

    if (DioErrorType.RECEIVE_TIMEOUT == err.type || DioErrorType.CONNECT_TIMEOUT == err.type) {
      Get.snackbar('Connection Error', 'O servidor não está acessível. Verifique sua conexão com a internet e tente novamente');
      return err;
    } else if (DioErrorType.RESPONSE == err.type) {
      if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
        await refreshToken();
        final req = err.request;
        return CustomDio.authInstance.request(req.path, options: req);
      }
    } else if (DioErrorType.DEFAULT == err.type) {
      if (err.message.contains('Network is unreachable')) {
        //  Modular.get<ConnectionCheck>().openDialog();
        await lock.synchronized(() async {
          
          var connectionStatus = await Connectivity().checkConnectivity();
          if(connectionStatus != ConnectivityResult.none) {
            return null;
          }

          return await Modular.to.pushNamed('/error');
        });
        final req = err.request;
        return CustomDio.authInstance.request(req.path, options: req);
        
      }
      return err;
    }
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
