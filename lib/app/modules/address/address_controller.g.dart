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

  final _$findAddressGoogleAsyncAction =
      AsyncAction('_AddressControllerBase.findAddressGoogle');

  @override
  Future<List<Prediction>> findAddressGoogle(String query) {
    return _$findAddressGoogleAsyncAction
        .run(() => super.findAddressGoogle(query));
  }

  final _$goToConfirmAsyncAction =
      AsyncAction('_AddressControllerBase.goToConfirm');

  @override
  Future<String> goToConfirm(Prediction pred) {
    return _$goToConfirmAsyncAction.run(() => super.goToConfirm(pred));
  }

  @override
  String toString() {
    return '''
adressesFuture: ${adressesFuture}
    ''';
  }
}
