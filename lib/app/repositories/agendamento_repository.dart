import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/agendamento_model.dart';
import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/models/fornecedor_servicos.dart';

class AgendamentoRepository {
  void salvarAgendamento(DateTime dataAgendamento, FornecedorModel fornecedor, List<FornecedorServicos> servicos, String nome, String nomePet) {
    CustomDio.authInstance.post('/agendamento/agendar', data: {
      'data_agendamento': dataAgendamento.toIso8601String(),
      'fornecedor_id': fornecedor.id,
      'servicos': servicos.map((s) => s.id).toList(),
      'nome': nome,
      'nome_pet': nomePet,
    });
  }

  Future<List<AgendamentoModel>> buscarAgendamento() async {
    return CustomDio.authInstance.get('/agendamentos').then(
          (res) => res.data
              .map<AgendamentoModel>(
                (a) => AgendamentoModel.fromJson(a),
              )
              .toList(),
        );
  }
}
