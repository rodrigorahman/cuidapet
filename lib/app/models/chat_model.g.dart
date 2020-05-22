// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return ChatModel(
    id: json['id'] as int,
    usuario: json['usuario'] as int,
    nome: json['nome'] as String,
    nomePet: json['nome_pet'] as String,
    fornecedor: json['fornecedor'] == null
        ? null
        : FornecedorModel.fromJson(json['fornecedor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'id': instance.id,
      'usuario': instance.usuario,
      'nome': instance.nome,
      'nome_pet': instance.nomePet,
      'fornecedor': instance.fornecedor,
    };
