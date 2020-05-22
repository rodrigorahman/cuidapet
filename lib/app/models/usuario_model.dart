import 'package:json_annotation/json_annotation.dart';

part 'usuario_model.g.dart';

@JsonSerializable()
class UsuarioModel {

  int id;
  String email;
  String tipoCadastro;
  String imgAvatar;
  
  UsuarioModel({
    this.id,
    this.email,
    this.tipoCadastro,
    this.imgAvatar,
  });


  factory UsuarioModel.fromJson(Map<String, dynamic> json) => _$UsuarioModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsuarioModelToJson(this);
}
