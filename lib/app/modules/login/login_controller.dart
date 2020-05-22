import 'package:cuidapet/app/models/access_service_model.dart';
import 'package:cuidapet/app/repositories/facebook_repository.dart';
import 'package:cuidapet/app/repositories/usuario_repository.dart';
import 'package:cuidapet/app/repositories/security_storage_repository.dart';
import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:cuidapet/app/utils/store_utils.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UsuarioRepository _repository;
  final loginEditController = TextEditingController();
  final passwordEditController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  _LoginControllerBase(this._repository);

  @observable
  AccessServiceModel accessModel;

  @observable
  ObservableFuture<AccessServiceModel> _loginFuture;

  @computed
  StoreState get loginState => StoreUtils.statusCheck(_loginFuture);

  @observable
  ObservableFuture<AccessServiceModel> _confirmLoginFuture;

  @computed
  StoreState get confirmLoginState => StoreUtils.statusCheck(_confirmLoginFuture);

  @observable
  String errorMessage;

  @action
  Future<void> login() async {
    errorMessage = null;
    var fireAuth = FirebaseAuth.instance;
    if (formKey.currentState.validate()) {
      _loginFuture = ObservableFuture(_repository.login(loginEditController.text, password: passwordEditController.text));
      try {
        
        accessModel = await _loginFuture;
        var sharedPrefsRepository = (await SharedPrefsRepository.instance);
        await sharedPrefsRepository.registerAccessToken(accessModel.accessToken);
        await fireAuth.signInWithEmailAndPassword(email: loginEditController.text, password: passwordEditController.text);

      } on DioError catch (e) {
        errorMessage = e.response.data['message'];
      }
    }
  }

  @action
  Future<void> confirmLogin() async {
    _confirmLoginFuture = ObservableFuture(_repository.confirmLogin());
    final access = await _confirmLoginFuture;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: null,
      statusBarColor: ThemeUtils.primaryColor, // status bar color
    ));
    var sharedPrefsRepository = (await SharedPrefsRepository.instance);
    
    await sharedPrefsRepository.registerAccessToken(access.accessToken);

    await SecurityStorageRepository().registerRefreshToken(access.refreshToken);
    
    final usuario = await _repository.recuperarDadosUsuario();
    await sharedPrefsRepository.registerUserData(usuario);
    
  }

  @action
  Future<void> facebookLogin() async {
    // TODO: Adicionar para funcionar o plugin
    // !alterando podfile
    // adicionado
    //       target 'Runner' do
    // # Flutter Pod
    // use_frameworks!
    // use_modular_headers!
    try {
      Loader.show();
      final facebookData = await FacebookRepository().login();
      Loader.hide();
      _loginFuture = ObservableFuture(_repository.login(facebookData.email, facebookLogin: true, avatar: facebookData.largePicture));
      accessModel = await _loginFuture;
      var sharedPrefsRepository = (await SharedPrefsRepository.instance);
      await sharedPrefsRepository.registerAccessToken(accessModel.accessToken);
    } catch (e) {
      print(e);
    }
  }
}
