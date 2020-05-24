import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'meus_agendamentos_fornecedor_controller.dart';

class MeusAgendamentosFornecedorPage extends StatefulWidget {
  final String title;
  const MeusAgendamentosFornecedorPage(
      {Key key, this.title = "MeusAgendamentosFornecedor"})
      : super(key: key);

  @override
  _MeusAgendamentosFornecedorPageState createState() =>
      _MeusAgendamentosFornecedorPageState();
}

class _MeusAgendamentosFornecedorPageState extends ModularState<
    MeusAgendamentosFornecedorPage, MeusAgendamentosFornecedorController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
