import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/models/fornecedor_servicos.dart';
import 'package:cuidapet/app/shared/cuidapet_text_form_field.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:intl/intl.dart';

import 'agendamento_controller.dart';

class AgendamentoPage extends StatefulWidget {
  final FornecedorModel fornecedor;
  final List<FornecedorServicos> servicos;

  const AgendamentoPage({
    Key key,
    this.fornecedor,
    this.servicos,
  }) : super(key: key);

  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends ModularState<AgendamentoPage, AgendamentoController> {
  NumberFormat numberFormat = NumberFormat.currency(locale: 'pt_BR', decimalDigits: 2, symbol: 'R\$ ');

  @override
  void initState() {
    super.initState();
    controller.initPage(widget.fornecedor, widget.servicos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Escolha uma data'),
          backgroundColor: Colors.transparent,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Observer(
              builder: (_) {
                return CalendarCarousel(
                    locale: 'pt_BR',
                    headerTextStyle: TextStyle(color: ThemeUtils.primaryColor, fontSize: 25),
                    iconColor: ThemeUtils.primaryColor,
                    height: 420,
                    customGridViewPhysics: NeverScrollableScrollPhysics(),
                    selectedDateTime: controller.dataAgendamento,
                    // todayButtonColor: Colors.transparent,
                    // todayTextStyle: controller.dataAgendamento != DateTime.now() ? TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    onDayPressed: (day, _) {
                      controller.changeDataAgendamento(day);
                    });
              },
            ),
            FlatButton(
              textColor: ThemeUtils.primaryColorDark,
              onPressed: () {
                DatePicker.showTimePicker(
                  context,
                  showTitleActions: true,
                  showSecondsColumn: false,
                  onChanged: (date) {
                    print(date);
                  },
                  onConfirm: (date) {
                    controller.changeDataAgendamento(date);
                  },
                  currentTime: controller.dataAgendamento,
                  locale: LocaleType.pt,
                );
              },
              child: Observer(builder: (_) {
                return Column(
                  children: [
                    Text(
                      'Selecione um horário',
                    ),
                    Text(
                      '${controller.dataAgendamento.hour.toString().padLeft(2, '0')}:${controller.dataAgendamento.minute.toString().padLeft(2, '0')}',
                    )
                  ],
                );
              }),
            ),
            Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Serviços',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: controller.servicos.length,
                      itemBuilder: (BuildContext _, int index) {
                        var s = controller.servicos[index];
                        return ListTile(
                          title: Text(s.nome),
                          subtitle: Text(numberFormat.format(s.valor)),
                        );
                      },
                    ),
                    Text(
                      'Dados para Reserva',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CuidapetTextFormField(
                      label: 'Seu Nome',
                      controller: controller.nomeController,
                      validator: (String value) {
                        if(value.isEmpty) {
                          return 'Nome obrigatorio';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CuidapetTextFormField(
                      label: 'Nome do PET',
                      controller: controller.nomePetController,
                      validator: (String value) {
                        if(value.isEmpty) {
                          return 'Nome do PET obrigatorio';
                        }
                        return null;
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: ScreenUtil.screenWidthDp * .9,
                      height: 60,
                      child: RaisedButton(
                        color: ThemeUtils.primaryColor,
                        onPressed: () => controller.salvarAgendamento(),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            'Agendar',
                            style: TextStyle(fontSize: 60, color: Colors.white),
                            textScaleFactor: ScreenUtil().scaleText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        )
      ],
    ));
  }
}
