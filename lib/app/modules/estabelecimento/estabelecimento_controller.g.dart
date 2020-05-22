// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estabelecimento_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EstabelecimentoController on _EstabelecimentoControllerBase, Store {
  final _$servicosSelecionadosAtom =
      Atom(name: '_EstabelecimentoControllerBase.servicosSelecionados');

  @override
  ObservableList<FornecedorServicos> get servicosSelecionados {
    _$servicosSelecionadosAtom.reportRead();
    return super.servicosSelecionados;
  }

  @override
  set servicosSelecionados(ObservableList<FornecedorServicos> value) {
    _$servicosSelecionadosAtom.reportWrite(value, super.servicosSelecionados,
        () {
      super.servicosSelecionados = value;
    });
  }

  final _$fornecedorFutureAtom =
      Atom(name: '_EstabelecimentoControllerBase.fornecedorFuture');

  @override
  ObservableFuture<FornecedorModel> get fornecedorFuture {
    _$fornecedorFutureAtom.reportRead();
    return super.fornecedorFuture;
  }

  @override
  set fornecedorFuture(ObservableFuture<FornecedorModel> value) {
    _$fornecedorFutureAtom.reportWrite(value, super.fornecedorFuture, () {
      super.fornecedorFuture = value;
    });
  }

  final _$fornecedorServcosFutureAtom =
      Atom(name: '_EstabelecimentoControllerBase.fornecedorServcosFuture');

  @override
  ObservableFuture<List<FornecedorServicos>> get fornecedorServcosFuture {
    _$fornecedorServcosFutureAtom.reportRead();
    return super.fornecedorServcosFuture;
  }

  @override
  set fornecedorServcosFuture(
      ObservableFuture<List<FornecedorServicos>> value) {
    _$fornecedorServcosFutureAtom
        .reportWrite(value, super.fornecedorServcosFuture, () {
      super.fornecedorServcosFuture = value;
    });
  }

  final _$_EstabelecimentoControllerBaseActionController =
      ActionController(name: '_EstabelecimentoControllerBase');

  @override
  void initPage(dynamic fornecedorId) {
    final _$actionInfo = _$_EstabelecimentoControllerBaseActionController
        .startAction(name: '_EstabelecimentoControllerBase.initPage');
    try {
      return super.initPage(fornecedorId);
    } finally {
      _$_EstabelecimentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void adicionarServico(FornecedorServicos serv) {
    final _$actionInfo = _$_EstabelecimentoControllerBaseActionController
        .startAction(name: '_EstabelecimentoControllerBase.adicionarServico');
    try {
      return super.adicionarServico(serv);
    } finally {
      _$_EstabelecimentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
servicosSelecionados: ${servicosSelecionados},
fornecedorFuture: ${fornecedorFuture},
fornecedorServcosFuture: ${fornecedorServcosFuture}
    ''';
  }
}
