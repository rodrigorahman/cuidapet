import 'package:cuidapet/app/models/agendamento_model.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'meus_agendamentos_controller.dart';

class MeusAgendamentosPage extends StatefulWidget {
  const MeusAgendamentosPage({Key key}) : super(key: key);

  @override
  _MeusAgendamentosPageState createState() => _MeusAgendamentosPageState();
}

class _MeusAgendamentosPageState extends ModularState<MeusAgendamentosPage, MeusAgendamentosController> {
  //use 'controller' variable to access controller
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final status = {
    'P': 'Pendente',
    'CN': 'Confirmada',
    'F': 'Finalizado',
    'C': 'Cancelado',
  };

  @override
  void initState() {
    super.initState();
    controller.buscarHistoricoAgendamentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Agendamentos', style: TextStyle(fontSize: 15),),
      ),
      body: FutureBuilder<List<AgendamentoModel>>(
        future: controller.agendamentosFuture,
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              if (snapshot.data.isEmpty) {
                return Center(
                  child: Text('Nenhum agendamento realizado'),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  var item = snapshot.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dateFormat.format(item.dataAgendamento),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(item.fornecedor.logo),
                                ),
                                title: Text(item.fornecedor.nome),
                                subtitle: Text(status[item.status] ?? ''),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: item.servicos.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var serv = item.servicos[index];
                                    return ListTile(
                                      leading: Icon(
                                        Icons.looks_one,
                                        color: ThemeUtils.primaryColor,
                                      ),
                                      title: Text(serv.nome),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
              break;
            default:
              return Container();
          }
        },
      ),
    );
  }
}
