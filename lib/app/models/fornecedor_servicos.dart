import 'package:json_annotation/json_annotation.dart';

part 'fornecedor_servicos.g.dart';

@JsonSerializable()
class FornecedorServicos {
  
  int id;
  int fornecedorId;
  String nome;
  double valor;

  FornecedorServicos({
    this.id,
    this.fornecedorId,
    this.nome,
    this.valor,
  });

  factory FornecedorServicos.fromJson(Map<String, dynamic> json) => _$FornecedorServicosFromJson(json);
  Map<String, dynamic> toJson() => _$FornecedorServicosToJson(this);
}
