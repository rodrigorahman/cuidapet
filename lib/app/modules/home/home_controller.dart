import 'package:cuidapet/app/models/address_model.dart';
import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/repositories/fornecedor_repository.dart';
import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapet/app/models/category_model.dart';
import 'package:cuidapet/app/repositories/addresses_repository.dart';
import 'package:cuidapet/app/repositories/categories_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  _HomeControllerBase(
    this._addressesRepository,
    this._categoriesRepository,
    this._fornecedorRepository,
  );

  final AdressesRepository _addressesRepository;
  final CategoriesRepository _categoriesRepository;
  SharedPrefsRepository _sharedPrefsRepository;
  final FornecedorRepository _fornecedorRepository;

  @observable
  int selectedPage = 0;
  List<FornecedorModel> resultadoFiltro;

  @observable
  int selectedCategory;

  @observable
  String nomeFiltro;

  @observable
  AddressModel addressSelected;

  @action
  void changeSelectedPage(int page) {
    selectedPage = page;
  }

  @action
  Future<void> initPage() async {
    var hasAddressResult = await hasAddress();
    if (!hasAddressResult) {
      await Modular.to.pushNamed('/address');
    }
    findCategories();
    _sharedPrefsRepository = await SharedPrefsRepository.instance;
    final addressStr = _sharedPrefsRepository.addressSelected;
    if (addressStr != null) {
      addressSelected = AddressModel.fromJson(addressStr);
      await findFornecedores();
    } else {
      await Modular.to.pushNamed('/address');
    }
  }

  Future<bool> hasAddress() async {
    return await _addressesRepository.hasAddress();
  }

  @observable
  ObservableFuture<List<CategoryModel>> categoriesFuture;

  void findCategories() {
    categoriesFuture = ObservableFuture(_categoriesRepository.findAll());
  }

  @observable
  ObservableFuture<List<FornecedorModel>> fornecedoresFuture;

  @action
  Future<void> findFornecedores() async {
    fornecedoresFuture = ObservableFuture(_fornecedorRepository.buscarFornecedoresProximos(addressSelected.latitude, addressSelected.longitude));
    resultadoFiltro = await fornecedoresFuture;
  }

  @action
  void filtrarFornecedoresPorCategoria(int id) {
    if (selectedCategory == id) {
      selectedCategory = null;
      filtrar();
    } else {
      selectedCategory = id;
      filtrar();
    }
  }

  @action
  void filtrarFornecedoresPorNome(String nome) {
    nomeFiltro = nome;
    filtrar();
  }

  void filtrar() {
    var fornec = resultadoFiltro.where((e) => selectedCategory != null ? e.categoria.id == selectedCategory : true).where((element) => nomeFiltro != null ? element.nome.toLowerCase().contains(nomeFiltro.toLowerCase()) : true).toList();
    fornecedoresFuture = ObservableFuture(Future.value(fornec));
  }
}
