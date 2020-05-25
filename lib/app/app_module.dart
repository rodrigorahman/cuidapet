import 'package:cuidapet/app/core/database/connection_adm.dart';
import 'package:cuidapet/app/modules/address/address_module.dart';
import 'package:cuidapet/app/modules/agendamento/agendamento_module.dart';
import 'package:cuidapet/app/modules/chat_list/chat_list_module.dart';
import 'package:cuidapet/app/modules/estabelecimento/estabelecimento_module.dart';
import 'package:cuidapet/app/modules/home/home_module.dart';
import 'package:cuidapet/app/modules/meus_agendamentos/meus_agendamentos_module.dart';
import 'package:cuidapet/app/repositories/addresses_repository.dart';
import 'package:cuidapet/app/repositories/fornecedor_repository.dart';
import 'package:cuidapet/app/repositories/usuario_repository.dart';
import 'package:cuidapet/app/app_controller.dart';
import 'package:cuidapet/app/modules/splash/splash_module.dart';
import 'package:cuidapet/app/shared/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet/app/app_widget.dart';

import 'modules/image_profile/image_profile_module.dart';
import 'modules/login/login_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        // Administra a conexão com o banco
        Bind((i) => ConnectionADM(), lazy: false),
        
        Bind((i) => AuthStore()),

        // Repositories Geral da aplicacao
        Bind((i) => UsuarioRepository()),
        Bind((i) => AdressesRepository()),
        Bind((i) => FornecedorRepository()),

        Bind((i) => AppController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: SplashModule()),
        Router('/login', module: LoginModule()),
        Router('/home', module: HomeModule()),
        Router('/address', module: AddressModule()),
        Router('/estabelecimento', module: EstabelecimentoModule()),
        Router('/agendamento', module: AgendamentoModule()),
        Router('/meus_agendamentos', module: MeusAgendamentosModule()),
        Router('/chat_list', module: ChatListModule()),
        Router('/image_profile', module: ImageProfileModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
