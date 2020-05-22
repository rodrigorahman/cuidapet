// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$selectedPageAtom = Atom(name: '_HomeControllerBase.selectedPage');

  @override
  int get selectedPage {
    _$selectedPageAtom.reportRead();
    return super.selectedPage;
  }

  @override
  set selectedPage(int value) {
    _$selectedPageAtom.reportWrite(value, super.selectedPage, () {
      super.selectedPage = value;
    });
  }

  final _$selectedCategoryAtom =
      Atom(name: '_HomeControllerBase.selectedCategory');

  @override
  int get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(int value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  final _$nomeFiltroAtom = Atom(name: '_HomeControllerBase.nomeFiltro');

  @override
  String get nomeFiltro {
    _$nomeFiltroAtom.reportRead();
    return super.nomeFiltro;
  }

  @override
  set nomeFiltro(String value) {
    _$nomeFiltroAtom.reportWrite(value, super.nomeFiltro, () {
      super.nomeFiltro = value;
    });
  }

  final _$addressSelectedAtom =
      Atom(name: '_HomeControllerBase.addressSelected');

  @override
  AddressModel get addressSelected {
    _$addressSelectedAtom.reportRead();
    return super.addressSelected;
  }

  @override
  set addressSelected(AddressModel value) {
    _$addressSelectedAtom.reportWrite(value, super.addressSelected, () {
      super.addressSelected = value;
    });
  }

  final _$categoriesFutureAtom =
      Atom(name: '_HomeControllerBase.categoriesFuture');

  @override
  ObservableFuture<List<CategoryModel>> get categoriesFuture {
    _$categoriesFutureAtom.reportRead();
    return super.categoriesFuture;
  }

  @override
  set categoriesFuture(ObservableFuture<List<CategoryModel>> value) {
    _$categoriesFutureAtom.reportWrite(value, super.categoriesFuture, () {
      super.categoriesFuture = value;
    });
  }

  final _$fornecedoresFutureAtom =
      Atom(name: '_HomeControllerBase.fornecedoresFuture');

  @override
  ObservableFuture<List<FornecedorModel>> get fornecedoresFuture {
    _$fornecedoresFutureAtom.reportRead();
    return super.fornecedoresFuture;
  }

  @override
  set fornecedoresFuture(ObservableFuture<List<FornecedorModel>> value) {
    _$fornecedoresFutureAtom.reportWrite(value, super.fornecedoresFuture, () {
      super.fornecedoresFuture = value;
    });
  }

  final _$initPageAsyncAction = AsyncAction('_HomeControllerBase.initPage');

  @override
  Future<void> initPage() {
    return _$initPageAsyncAction.run(() => super.initPage());
  }

  final _$findFornecedoresAsyncAction =
      AsyncAction('_HomeControllerBase.findFornecedores');

  @override
  Future<void> findFornecedores() {
    return _$findFornecedoresAsyncAction.run(() => super.findFornecedores());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void changeSelectedPage(int page) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changeSelectedPage');
    try {
      return super.changeSelectedPage(page);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filtrarFornecedoresPorCategoria(int id) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.filtrarFornecedoresPorCategoria');
    try {
      return super.filtrarFornecedoresPorCategoria(id);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filtrarFornecedoresPorNome(String nome) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.filtrarFornecedoresPorNome');
    try {
      return super.filtrarFornecedoresPorNome(nome);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedPage: ${selectedPage},
selectedCategory: ${selectedCategory},
nomeFiltro: ${nomeFiltro},
addressSelected: ${addressSelected},
categoriesFuture: ${categoriesFuture},
fornecedoresFuture: ${fornecedoresFuture}
    ''';
  }
}
