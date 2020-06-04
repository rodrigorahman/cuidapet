import 'dart:io';

import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet/app/models/access_service_model.dart';
import 'package:cuidapet/app/models/usuario_model.dart';
import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    ).then((_) async {
      return FirebaseAuth.instance.createUserWithEmailAndPassword(email: user, password: password);
    }).catchError((e) {
      print(e);
      throw CreateUserException('Erro ao criar usuário', exception: e);
    });
  }
  
  Future<UsuarioModel> updateImageAvatar(String urlImagem) {
    return CustomDio.authInstance.put(
      '/usuario/avatar',
      data: {
        'url_avatar': urlImagem
      },
    ).then((res) => UsuarioModel.fromJson(res.data));
  }

  Future<bool> isSupplier() {
    return CustomDio.authInstance.get('/login/isSupplier')
      .then((res) => res.data['isSupplier']);
  }

  Future<void> updateToken(String token) async {
    await CustomDio.authInstance.put('/usuario/device', data: {
      'token': token,
      'platform': Platform.isIOS ? 'IOS' : 'ANDROID'
    });
  }

}
