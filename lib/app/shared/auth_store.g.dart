// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
  final _$usuarioAtom = Atom(name: '_AuthStoreBase.usuario');

  @override
  UsuarioModel get usuario {
    _$usuarioAtom.reportRead();
    return super.usuario;
  }

  @override
  set usuario(UsuarioModel value) {
    _$usuarioAtom.reportWrite(value, super.usuario, () {
      super.usuario = value;
    });
  }

  final _$setUserAsyncAction = AsyncAction('_AuthStoreBase.setUser');

  @override
  Future<void> setUser(UsuarioModel userModel) {
    return _$setUserAsyncAction.run(() => super.setUser(userModel));
  }

  final _$loaderUserModelAsyncAction =
      AsyncAction('_AuthStoreBase.loaderUserModel');

  @override
  Future<void> loaderUserModel() {
    return _$loaderUserModelAsyncAction.run(() => super.loaderUserModel());
  }

  @override
  String toString() {
    return '''
usuario: ${usuario}
    ''';
  }
}
