import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/models/fornecedor_servicos.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'estabelecimento_controller.dart';

class EstabelecimentoPage extends StatefulWidget {
  final int id;
  const EstabelecimentoPage({Key key, this.id}) : super(key: key);

  @override
  _EstabelecimentoPageState createState() => _EstabelecimentoPageState();
}

class _EstabelecimentoPageState extends ModularState<EstabelecimentoPage, EstabelecimentoController> {

  @override
  void initState() {
    super.initState();
    controller.initPage(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Observer(builder: (_) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: controller.servicosSelecionados.isNotEmpty ? 1 : 0,
          child: FloatingActionButton.extended(
            label: Text('Fazer Agendamento'),
            onPressed: () => Modular.to.pushNamed('/agendamento', arguments: {'fornecedor': controller.fornecedorFuture.value, 'servicos': controller.servicosSelecionados}),
            icon: const Icon(Icons.schedule),
            backgroundColor: ThemeUtils.primaryColor,
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder<FornecedorModel>(
        future: controller.fornecedorFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var f = snapshot.data;
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 300,
                pinned: false,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                  title: Text(f.nome),
                  background: Image.network(
                    f.logo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Divider(
                          thickness: 1,
                          color: ThemeUtils.primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Informações do Estabelecimento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        InkWell(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(text: f.endereco)).then((_) {
                              Get.snackbar('Copia', 'Endereço copiado');
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Icon(Icons.location_city),
                                ),
                                Expanded(
                                  child: Text(
                                    f.endereco,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (await canLaunch('tel:${f.telefone}')) {
                              await launch('tel:${f.telefone}');
                            } else {
                              throw 'Could not launch tel:${f.telefone}';
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Icon(Icons.local_phone),
                                ),
                                Text(
                                  f.telefone,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: ThemeUtils.primaryColor,
                        ),
                      ],
                    ),
                    _buildServicos(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildServicos() {
    var format = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Observer(builder: (_) {
            return Text(
              'Serviços (${controller.servicosSelecionados.length} selecionado${controller.servicosSelecionados.length > 1 ? 's' : ''})',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            );
          }),
        ),
        FutureBuilder<List<FornecedorServicos>>(
          future: controller.fornecedorServcosFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
                return Container();
                break;
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.done:
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) {
                    final item = snapshot.data[index];
                    return Observer(builder: (_) {
                      return ListTile(
                        onTap: () => controller.adicionarServico(item),
                        leading: CircleAvatar(child: Icon(Icons.pets)),
                        title: Text(item.nome),
                        subtitle: Text('${format.format(item.valor)}'),
                        trailing: Icon(
                          controller.servicosSelecionados.contains(item) ? Icons.remove_circle : Icons.add_circle,
                          color: controller.servicosSelecionados.contains(item) ? Colors.red : ThemeUtils.primaryColor,
                          size: 30,
                        ),
                      );
                    });
                  },
                );
                break;
              default:
                return Container();
            }
          },
        )
      ],
    );
  }
}
