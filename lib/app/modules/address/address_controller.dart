import 'package:cuidapet/app/models/address_model.dart';
import 'package:cuidapet/app/repositories/addresses_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';

import 'address_confirm/address_confirm_page.dart';

part 'address_controller.g.dart';

class AddressController = _AddressControllerBase with _$AddressController;

abstract class _AddressControllerBase with Store {
  
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

  Future<List<Prediction>> findAddressGoogle(String query) async {
    return await _repository.findAddressByGooglePlaces(query);
  }

  Future<String> goToConfirm(Prediction pred) async {
    var detail = await _repository.findGooglePlacesDetail(pred.placeId);
    return Get.to<String>(AddressConfirmPage(address: detail.result,));
  }

}
