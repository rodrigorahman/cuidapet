// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsuarioModel _$UsuarioModelFromJson(Map<String, dynamic> json) {
  return UsuarioModel(
    id: json['id'] as int,
    email: json['email'] as String,
    tipoCadastro: json['tipoCadastro'] as String,
    imgAvatar: json['imgAvatar'] as String,
  );
}

Map<String, dynamic> _$UsuarioModelToJson(UsuarioModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'tipoCadastro': instance.tipoCadastro,
      'imgAvatar': instance.imgAvatar,
    };
