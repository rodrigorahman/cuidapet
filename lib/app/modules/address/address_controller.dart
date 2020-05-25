import 'package:cuidapet/app/models/address_model.dart';
import 'package:cuidapet/app/repositories/addresses_repository.dart';
import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';

part 'address_controller.g.dart';

class AddressController = _AddressControllerBase with _$AddressController;

abstract class _AddressControllerBase with Store {
  FocusNode addressFocusNode = FocusNode();
  final AdressesRepository _repository;
  final TextEditingController addressTextController = TextEditingController();

  _AddressControllerBase(this._repository);

  @observable
  ObservableFuture<List<AddressModel>> adressesFuture;

  @action
  Future<void> findAllAdresses() async {
    adressesFuture = ObservableFuture(_repository.findAll());
    await adressesFuture;
  }

  @action
  Future<List<Prediction>> findAddressGoogle(String query) async {
    return await _repository.findAddressByGooglePlaces(query);
  }

  @action
  Future<String> goToConfirm(Prediction pred) async {
    var detail = await _repository.findGooglePlacesDetail(pred.placeId);
    return await Modular.to.pushNamed('/address/confirm', arguments: detail.result) as String;
  }

  void editAddress(String address) {
    if (address != null && address.isNotEmpty) {
      addressTextController.text = address;
      addressFocusNode.requestFocus();
    } else {
      addressTextController.clear();
    }
    findAllAdresses();
  }

  Future<void> selectedAddress(AddressModel address) async {
    Loader.show();
    final prefs = await SharedPrefsRepository.instance;
    await prefs.selectAddress(address);
    Loader.hide();
    Modular.to.pop();
  }

  Future<bool> get addressSelected async {
    final prefs = await SharedPrefsRepository.instance;
    return prefs.addressSelected != null;
  }

  Future<void> minhaLocalizacao() async {
    var editar = await Modular.to.pushNamed('/address/confirm');
    editAddress(editar);
  }
}
