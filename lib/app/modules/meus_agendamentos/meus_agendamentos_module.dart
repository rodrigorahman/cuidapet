import 'package:cuidapet/app/modules/meus_agendamentos/meus_agendamentos_controller.dart';
import 'package:cuidapet/app/repositories/agendamento_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidapet/app/modules/meus_agendamentos/meus_agendamentos_page.dart';

class MeusAgendamentosModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AgendamentoRepository()),
        Bind((i) => MeusAgendamentosController(i.get<AgendamentoRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute,
            child: (_, args) => MeusAgendamentosPage()),
      ];

  static Inject get to => Inject<MeusAgendamentosModule>.of();
}
