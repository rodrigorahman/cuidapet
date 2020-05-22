import 'package:cuidapet/app/modules/address/address_confirm/address_confirm_module.dart';
import 'package:cuidapet/app/modules/address/address_page.dart';
import 'package:cuidapet/app/repositories/addresses_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'address_controller.dart';

class AddressModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AddressController(i.get<AdressesRepository>())),
      ];

  @override
  List<Router> get routers => [
    Router(Modular.initialRoute, child: (_, args) => AddressPage()),
    Router('/confirm', module: AddressConfirmModule()),
  ];

  static Inject get to => Inject<AddressModule>.of();
}
