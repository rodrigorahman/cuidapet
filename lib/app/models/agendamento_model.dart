import 'package:json_annotation/json_annotation.dart';

import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/models/fornecedor_servicos.dart';

part 'agendamento_model.g.dart';

@JsonSerializable()
class AgendamentoModel {
  
  AgendamentoModel({
    this.id,
    this.nome,
    this.nomePet,
    this.dataAgendamento,
    this.fornecedor,
    this.status,
    this.servicos,
  });
  
  int id;
  String nome;
  String nomePet;
  DateTime dataAgendamento;
  FornecedorModel fornecedor;
  String status;
  List<FornecedorServicos> servicos;
 
  factory AgendamentoModel.fromJson(Map<String, dynamic> json) => _$AgendamentoModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgendamentoModelToJson(this);
}
