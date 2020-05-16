import 'package:cuidapet/app/modules/address/address_controller.dart';
import 'package:cuidapet/app/core/database/connection_adm.dart';
import 'package:cuidapet/app/modules/home/home_module.dart';
import 'package:cuidapet/app/repositories/addresses_repository.dart';
import 'package:cuidapet/app/repositories/login_repository.dart';
import 'package:cuidapet/app/app_controller.dart';
import 'package:cuidapet/app/modules/splash/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet/app/app_widget.dart';

import 'modules/address/address_confirm/address_confirm_controller.dart';
import 'modules/login/login_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AddressController(i.get<AdressesRepository>())),
        Bind((i) => AddressConfirmController()),

        // Administra a conexão com o banco
        Bind((i) => ConnectionADM(), lazy: false),

        // Repositories Geral da aplicacao
        Bind((i) => LoginRepository()),
        Bind((i) => AdressesRepository()),

        Bind((i) => AppController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: SplashModule()),
        Router('/login', module: LoginModule()),
        Router('/home', module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
