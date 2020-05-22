import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/models/fornecedor_servicos.dart';
import 'package:cuidapet/app/repositories/agendamento_repository.dart';
import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:oktoast/oktoast.dart';

part 'agendamento_controller.g.dart';

class AgendamentoController = _AgendamentoControllerBase
    with _$AgendamentoController;

abstract class _AgendamentoControllerBase with Store {
  
  final AgendamentoRepository _repository;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController nomePetController = TextEditingController();
  FornecedorModel fornecedor;
  List<FornecedorServicos> servicos;
  @observable
  DateTime dataAgendamento = DateTime.now();

  _AgendamentoControllerBase(this._repository);
  
  @action
  void changeDataAgendamento(DateTime data) {
    dataAgendamento = data;
  }

  void initPage(fornecedor,servicos) {
    this.fornecedor = fornecedor;
    this.servicos = servicos;
  }

  Future<void> salvarAgendamento() async {
    try {
      if(formKey.currentState.validate()) {
      if(dataAgendamento != null && dataAgendamento.hour > 0) {
        Loader.show();
        await _repository.salvarAgendamento(dataAgendamento, fornecedor, servicos, nomeController.text, nomePetController.text);
        showToast('Agendamento realizado com sucesso');
        Loader.hide();
        await Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
      } else {
        showToast('Selecione uma data e horário para o agendamento');
      }
    }
    } catch (e) {
      print(e);
      showToast('Erro ao realizar agendamento');
    }
  }

}
