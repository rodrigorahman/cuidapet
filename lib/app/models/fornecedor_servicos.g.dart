// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fornecedor_servicos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FornecedorServicos _$FornecedorServicosFromJson(Map<String, dynamic> json) {
  return FornecedorServicos(
    id: json['id'] as int,
    fornecedorId: json['fornecedorId'] as int,
    nome: json['nome'] as String,
    valor: (json['valor'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$FornecedorServicosToJson(FornecedorServicos instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fornecedorId': instance.fornecedorId,
      'nome': instance.nome,
      'valor': instance.valor,
    };
