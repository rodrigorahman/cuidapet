import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthInterceptorsWrapper extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    var shared = await SharedPrefsRepository.instance;
    options.headers['Authorization'] = shared.accessToken;
    print('url: ${options.uri}');
    print('method: ${options.method}');
    print('data: ${options.data}');
    print('headers: ${options.headers}');
  }

  @override
  Future onResponse(Response response) async {
    if (DotEnv().env['profile'] == 'dev') {
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
      // Modular.get<UsuarioRepository>().logout();
      // Get.offAllNamed('/');
    }
    return err;
  }
}
