import 'package:cuidapet/app/models/agendamento_model.dart';
import 'package:cuidapet/app/repositories/agendamento_repository.dart';
import 'package:mobx/mobx.dart';

part 'meus_agendamentos_controller.g.dart';

class MeusAgendamentosController = _MeusAgendamentosControllerBase
    with _$MeusAgendamentosController;

abstract class _MeusAgendamentosControllerBase with Store {
  
  final AgendamentoRepository _repository;
  _MeusAgendamentosControllerBase(this._repository);

  @observable
  ObservableFuture<List<AgendamentoModel>> agendamentosFuture;

  @action
  Future<void> buscarHistoricoAgendamentos() async {
    try {
      agendamentosFuture = ObservableFuture(_repository.buscarAgendamento());
    await agendamentosFuture;
    } catch (e) {
      print(e);
    }
  }

}
