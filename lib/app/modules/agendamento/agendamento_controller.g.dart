// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamento_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AgendamentoController on _AgendamentoControllerBase, Store {
  final _$dataAgendamentoAtom =
      Atom(name: '_AgendamentoControllerBase.dataAgendamento');

  @override
  DateTime get dataAgendamento {
    _$dataAgendamentoAtom.reportRead();
    return super.dataAgendamento;
  }

  @override
  set dataAgendamento(DateTime value) {
    _$dataAgendamentoAtom.reportWrite(value, super.dataAgendamento, () {
      super.dataAgendamento = value;
    });
  }

  final _$_AgendamentoControllerBaseActionController =
      ActionController(name: '_AgendamentoControllerBase');

  @override
  void changeDataAgendamento(DateTime data) {
    final _$actionInfo = _$_AgendamentoControllerBaseActionController
        .startAction(name: '_AgendamentoControllerBase.changeDataAgendamento');
    try {
      return super.changeDataAgendamento(data);
    } finally {
      _$_AgendamentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataAgendamento: ${dataAgendamento}
    ''';
  }
}
