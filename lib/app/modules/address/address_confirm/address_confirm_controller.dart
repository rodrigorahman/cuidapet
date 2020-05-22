import 'package:cuidapet/app/models/address_model.dart';
import 'package:cuidapet/app/repositories/addresses_repository.dart';
import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';

part 'address_confirm_controller.g.dart';

class AddressConfirmController = _AddressConfirmControllerBase with _$AddressConfirmController;

abstract class _AddressConfirmControllerBase with Store {
  TextEditingController addressTextController = TextEditingController();
  TextEditingController complementTextController = TextEditingController();
  final AdressesRepository _repository = Modular.get<AdressesRepository>();

  @observable
  bool editAddress;

  @observable
  AddressModel addressModel;

  @action
  Future<void> getMyLocation() async {
    var position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    var place = placemark[0];
    var address = '${place.thoroughfare} ${place.subThoroughfare}';
    addressModel = AddressModel(address: address, latitude: place.position.latitude, longitude: place.position.longitude);
    addressTextController.text = address;
  }

  @action
  void setAddress(PlaceDetails place) {
    Future.delayed(Duration.zero, () => Loader.show());
    if (place == null) {
      getMyLocation();
      Future.delayed(Duration.zero, () => Loader.hide());
    } else {
      var address = '${place.formattedAddress}';
      addressModel = AddressModel(address: address, latitude: place.geometry.location.lat, longitude: place.geometry.location.lng);
      addressTextController.text = address;
      Future.delayed(Duration.zero, () => Loader.hide());
    }
  }

  Future<void> saveAddress() async {
    Loader.show();
    addressModel.complemento = complementTextController.text;
    await _repository.saveAddress(addressModel);
    Loader.hide();
    Modular.to.pop();
  }

  @action
  void clearForm() {
    addressTextController.clear();
    complementTextController.clear();
    addressModel = null;
    editAddress = false;
  }
}
