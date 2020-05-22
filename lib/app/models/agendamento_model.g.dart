// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamento_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgendamentoModel _$AgendamentoModelFromJson(Map<String, dynamic> json) {
  return AgendamentoModel(
    id: json['id'] as int,
    nome: json['nome'] as String,
    nomePet: json['nomePet'] as String,
    dataAgendamento: json['dataAgendamento'] == null
        ? null
        : DateTime.parse(json['dataAgendamento'] as String),
    fornecedor: json['fornecedor'] == null
        ? null
        : FornecedorModel.fromJson(json['fornecedor'] as Map<String, dynamic>),
    status: json['status'] as String,
    servicos: (json['servicos'] as List)
        ?.map((e) => e == null
            ? null
            : FornecedorServicos.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AgendamentoModelToJson(AgendamentoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'nomePet': instance.nomePet,
      'dataAgendamento': instance.dataAgendamento?.toIso8601String(),
      'fornecedor': instance.fornecedor,
      'status': instance.status,
      'servicos': instance.servicos,
    };
