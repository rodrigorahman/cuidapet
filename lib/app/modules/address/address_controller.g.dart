// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddressController on _AddressControllerBase, Store {
  final _$adressesFutureAtom =
      Atom(name: '_AddressControllerBase.adressesFuture');

  @override
  ObservableFuture<List<AddressModel>> get adressesFuture {
    _$adressesFutureAtom.reportRead();
    return super.adressesFuture;
  }

  @override
  set adressesFuture(ObservableFuture<List<AddressModel>> value) {
    _$adressesFutureAtom.reportWrite(value, super.adressesFuture, () {
      super.adressesFuture = value;
    });
  }

  final _$findAllAdressesAsyncAction =
      AsyncAction('_AddressControllerBase.findAllAdresses');

  @override
  Future<void> findAllAdresses() {
    return _$findAllAdressesAsyncAction.run(() => super.findAllAdresses());
  }

  @override
  String toString() {
    return '''
adressesFuture: ${adressesFuture}
    ''';
  }
}
