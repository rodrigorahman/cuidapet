// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_confirm_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddressConfirmController on _AddressConfirmControllerBase, Store {
  final _$editAddressAtom =
      Atom(name: '_AddressConfirmControllerBase.editAddress');

  @override
  bool get editAddress {
    _$editAddressAtom.reportRead();
    return super.editAddress;
  }

  @override
  set editAddress(bool value) {
    _$editAddressAtom.reportWrite(value, super.editAddress, () {
      super.editAddress = value;
    });
  }

  final _$addressModelAtom =
      Atom(name: '_AddressConfirmControllerBase.addressModel');

  @override
  AddressModel get addressModel {
    _$addressModelAtom.reportRead();
    return super.addressModel;
  }

  @override
  set addressModel(AddressModel value) {
    _$addressModelAtom.reportWrite(value, super.addressModel, () {
      super.addressModel = value;
    });
  }

  final _$getMyLocationAsyncAction =
      AsyncAction('_AddressConfirmControllerBase.getMyLocation');

  @override
  Future<void> getMyLocation() {
    return _$getMyLocationAsyncAction.run(() => super.getMyLocation());
  }

  final _$_AddressConfirmControllerBaseActionController =
      ActionController(name: '_AddressConfirmControllerBase');

  @override
  void setAddress(PlaceDetails place) {
    final _$actionInfo = _$_AddressConfirmControllerBaseActionController
        .startAction(name: '_AddressConfirmControllerBase.setAddress');
    try {
      return super.setAddress(place);
    } finally {
      _$_AddressConfirmControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearForm() {
    final _$actionInfo = _$_AddressConfirmControllerBaseActionController
        .startAction(name: '_AddressConfirmControllerBase.clearForm');
    try {
      return super.clearForm();
    } finally {
      _$_AddressConfirmControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
editAddress: ${editAddress},
addressModel: ${addressModel}
    ''';
  }
}
