import 'package:cuidapet/app/modules/meus_agendamentos_fornecedor/meus_agendamentos_fornecedor_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidapet/app/modules/meus_agendamentos_fornecedor/meus_agendamentos_fornecedor_page.dart';

class MeusAgendamentosFornecedorModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MeusAgendamentosFornecedorController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute,
            child: (_, args) => MeusAgendamentosFornecedorPage()),
      ];

  static Inject get to => Inject<MeusAgendamentosFornecedorModule>.of();
}
