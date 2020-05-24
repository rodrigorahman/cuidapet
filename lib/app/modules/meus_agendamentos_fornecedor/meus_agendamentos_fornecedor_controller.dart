import 'package:mobx/mobx.dart';

part 'meus_agendamentos_fornecedor_controller.g.dart';

class MeusAgendamentosFornecedorController = _MeusAgendamentosFornecedorControllerBase
    with _$MeusAgendamentosFornecedorController;

abstract class _MeusAgendamentosFornecedorControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
