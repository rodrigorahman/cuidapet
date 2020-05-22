import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  int id;
  int usuario;
  String nome;
  @JsonKey(name: 'nome_pet')
  String nomePet;
  FornecedorModel fornecedor;

  ChatModel({
    this.id,
    this.usuario,
    this.nome,
    this.nomePet,
    this.fornecedor,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}