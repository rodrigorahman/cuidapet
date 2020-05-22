// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fornecedor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FornecedorModel _$FornecedorModelFromJson(Map<String, dynamic> json) {
  return FornecedorModel(
    id: json['id'] as int,
    nome: json['nome'] as String,
    logo: json['logo'] as String,
    imagem: json['imagem'] as String,
    endereco: json['endereco'] as String,
    telefone: json['telefone'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    categoria: json['categoria'] == null
        ? null
        : CategoryModel.fromJson(json['categoria'] as Map<String, dynamic>),
    distancia: (json['distancia'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$FornecedorModelToJson(FornecedorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'logo': instance.logo,
      'imagem': instance.imagem,
      'endereco': instance.endereco,
      'telefone': instance.telefone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'categoria': instance.categoria,
      'distancia': instance.distancia,
    };
