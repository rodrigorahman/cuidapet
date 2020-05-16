import 'dart:convert';

import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/access_service_model.dart';
import 'package:cuidapet/app/models/facebook_model.dart';
import 'package:cuidapet/app/modules/login/change_password_modal/change_password_modal_widget.dart';
import 'package:cuidapet/app/repositories/facebook_repository.dart';
import 'package:cuidapet/app/repositories/login_repository.dart';
import 'package:cuidapet/app/repositories/security_storage_repository.dart';
import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:cuidapet/app/utils/store_utils.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final LoginRepository _repository;
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
    if (formKey.currentState.validate()) {
      _loginFuture = ObservableFuture(_repository.login(loginEditController.text, password: passwordEditController.text));
      try {
        accessModel = await _loginFuture;
        var sharedPrefsRepository = (await SharedPrefsRepository.instance);
        sharedPrefsRepository.registerAccessToken(accessModel.accessToken);
      } on DioError catch (e) {
        errorMessage = e.response.data['message'];
      }
    }
  }

  @action
  Future<void> confirmLogin() async {
    _confirmLoginFuture = ObservableFuture(_repository.confirmLogin());
    final access = await _confirmLoginFuture;
    print('terminou');
    (await SharedPrefsRepository.instance).registerAccessToken(accessModel.accessToken);
    await SecurityStorageRepository().registerRefreshToken(access.refreshToken);
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
      sharedPrefsRepository.registerAccessToken(accessModel.accessToken);
      
    } catch (e) {
      print(e);
    }
  }
}
