import 'package:cuidapet/app/repositories/addresses_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapet/app/modules/address/address_controller.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
 
  final AdressesRepository _addressesRepository;

  _HomeControllerBase(
    this._addressesRepository,
  );


  Future<bool> hasAddress() async {
    return await _addressesRepository.hasAddress();
  }

  
  

 
}

