import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/category_model.dart';

class CategoriesRepository {
  Future<List<CategoryModel>> findAll() {
    return CustomDio.authInstance.get('/categorias').then(
          (res) => res.data.map<CategoryModel>((c) => CategoryModel.fromJson(c)).toList(),
        );
  }
}
