import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/models/fornecedor_servicos.dart';

class FornecedorRepository {
  Future<List<FornecedorModel>> buscarFornecedoresProximos(double lat, double lng) {
    return CustomDio.authInstance.get(
      '/fornecedores',
      queryParameters: {'lat': lat, 'long': lng},
    ).then(
      (res) => res.data.map<FornecedorModel>((f) => FornecedorModel.fromJson(f)).toList(),
    );
  }

  Future<FornecedorModel> findById(int id) {
    return CustomDio.authInstance.get('/fornecedores/$id').then(
          (res) => FornecedorModel.fromJson(res.data),
        );
  }

  Future<List<FornecedorServicos>> buscarServicos(int fornecedorId) {
    return CustomDio.authInstance.get('/fornecedores/servicos/$fornecedorId').then(
          (res) => res.data.map<FornecedorServicos>((f) => FornecedorServicos.fromJson(f)).toList(),
        );
  }
}
