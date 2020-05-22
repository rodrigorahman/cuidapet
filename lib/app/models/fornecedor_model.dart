import 'package:json_annotation/json_annotation.dart';

import 'package:cuidapet/app/models/category_model.dart';

part 'fornecedor_model.g.dart';

@JsonSerializable()
class FornecedorModel {

  int id;
  String nome;
  String logo;
  String imagem;
  String endereco;
  String telefone;
  double latitude;
  double longitude;
  CategoryModel categoria;
  double distancia;

  FornecedorModel({
    this.id,
    this.nome,
    this.logo,
    this.imagem,
    this.endereco,
    this.telefone,
    this.latitude,
    this.longitude,
    this.categoria,
    this.distancia,
  });

  factory FornecedorModel.fromJson(Map<String, dynamic> json) => _$FornecedorModelFromJson(json);
  Map<String, dynamic> toJson() => _$FornecedorModelToJson(this);

  @override
  String toString() {
    return 'FornecedorModel(id: $id, nome: $nome, logo: $logo, imagem: $imagem, endereco: $endereco, telefone: $telefone, latitude: $latitude, longitude: $longitude, categoria: $categoria, distancia: $distancia)';
  }
}
