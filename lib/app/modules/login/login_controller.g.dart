// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<StoreState> _$loginStateComputed;

  @override
  StoreState get loginState =>
      (_$loginStateComputed ??= Computed<StoreState>(() => super.loginState,
              name: '_LoginControllerBase.loginState'))
          .value;
  Computed<StoreState> _$confirmLoginStateComputed;

  @override
  StoreState get confirmLoginState => (_$confirmLoginStateComputed ??=
          Computed<StoreState>(() => super.confirmLoginState,
              name: '_LoginControllerBase.confirmLoginState'))
      .value;

  final _$accessModelAtom = Atom(name: '_LoginControllerBase.accessModel');

  @override
  AccessServiceModel get accessModel {
    _$accessModelAtom.reportRead();
    return super.accessModel;
  }

  @override
  set accessModel(AccessServiceModel value) {
    _$accessModelAtom.reportWrite(value, super.accessModel, () {
      super.accessModel = value;
    });
  }

  final _$_loginFutureAtom = Atom(name: '_LoginControllerBase._loginFuture');

  @override
  ObservableFuture<AccessServiceModel> get _loginFuture {
    _$_loginFutureAtom.reportRead();
    return super._loginFuture;
  }

  @override
  set _loginFuture(ObservableFuture<AccessServiceModel> value) {
    _$_loginFutureAtom.reportWrite(value, super._loginFuture, () {
      super._loginFuture = value;
    });
  }

  final _$_confirmLoginFutureAtom =
      Atom(name: '_LoginControllerBase._confirmLoginFuture');

  @override
  ObservableFuture<AccessServiceModel> get _confirmLoginFuture {
    _$_confirmLoginFutureAtom.reportRead();
    return super._confirmLoginFuture;
  }

  @override
  set _confirmLoginFuture(ObservableFuture<AccessServiceModel> value) {
    _$_confirmLoginFutureAtom.reportWrite(value, super._confirmLoginFuture, () {
      super._confirmLoginFuture = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_LoginControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_LoginControllerBase.login');

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$confirmLoginAsyncAction =
      AsyncAction('_LoginControllerBase.confirmLogin');

  @override
  Future<void> confirmLogin() {
    return _$confirmLoginAsyncAction.run(() => super.confirmLogin());
  }

  final _$facebookLoginAsyncAction =
      AsyncAction('_LoginControllerBase.facebookLogin');

  @override
  Future<void> facebookLogin() {
    return _$facebookLoginAsyncAction.run(() => super.facebookLogin());
  }

  @override
  String toString() {
    return '''
accessModel: ${accessModel},
errorMessage: ${errorMessage},
loginState: ${loginState},
confirmLoginState: ${confirmLoginState}
    ''';
  }
}
