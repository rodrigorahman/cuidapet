import 'package:cuidapet/app/modules/address/address_confirm/address_confirm_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'address_confirm_controller.dart';

class AddressConfirmModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => AddressConfirmController()),
  ];

  @override
  List<Router> get routers => [
    Router(Modular.initialRoute, child: (_, args) => AddressConfirmPage(address: args.data,)),
  ];

  static Inject get to => Inject<AddressConfirmModule>.of();
}
