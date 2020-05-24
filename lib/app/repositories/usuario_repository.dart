import 'dart:io';

import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/access_service_model.dart';
import 'package:cuidapet/app/models/usuario_model.dart';
import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';

class UsuarioRepository {
  Future<AccessServiceModel> login(String user, {String password, bool facebookLogin = false, String avatar = ''}) {
    return CustomDio.instance.post(
      '/login',
      data: {
        'login': user,
        'senha': password,
        'facebookLogin': facebookLogin,
        'avatar': avatar,
      },
    ).then((response) {
      var dataAccess = AccessServiceModel.fromJson(response.data);
      if (response.statusCode == HttpStatus.created) {
        dataAccess.created = true;
      }
      return dataAccess;
    });
  }

  Future<AccessServiceModel> confirmLogin() async {
    String androidToken, iosToken;
    final sharedPrefsRepository = await SharedPrefsRepository.instance;

    if (Platform.isAndroid) {
      androidToken = sharedPrefsRepository.deviceToken;
    } else {
      iosToken = sharedPrefsRepository.deviceToken;
    }

    return CustomDio.authInstance.patch('/login/confirmar', data: {
      'ios_token': iosToken,
      'android_token': androidToken,
    }).then((res) => AccessServiceModel.fromJson(res.data));
  }


  Future<void> changePassword(String password) async {
    return CustomDio.authInstance.put('/login/password', data: {
      'password': password,
    });
  }

  Future<UsuarioModel> recuperarDadosUsuario() async {
    return CustomDio.authInstance.get('/usuario').then((res) => UsuarioModel.fromJson(res.data));
  }

  Future<void> createUsuario(String user, String password) {
    return CustomDio.instance.post(
      '/login/cadastrar',
      data: {
        'email': user,
        'senha': password,
      },
    );
  }

  Future<bool> isSupplier() {
    return CustomDio.authInstance.get('/login/isSupplier')
      .then((res) => res.data['isSupplier']);
  }

}
