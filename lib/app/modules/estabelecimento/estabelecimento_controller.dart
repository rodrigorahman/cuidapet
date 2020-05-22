import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/models/fornecedor_servicos.dart';
import 'package:cuidapet/app/repositories/fornecedor_repository.dart';
import 'package:mobx/mobx.dart';

part 'estabelecimento_controller.g.dart';

class EstabelecimentoController = _EstabelecimentoControllerBase
    with _$EstabelecimentoController;

abstract class _EstabelecimentoControllerBase with Store {

  _EstabelecimentoControllerBase(this._repository);

  final FornecedorRepository _repository;

  @observable
  ObservableList<FornecedorServicos> servicosSelecionados = <FornecedorServicos>[].asObservable();

  @observable
  ObservableFuture<FornecedorModel> fornecedorFuture;
  
  @observable
  ObservableFuture<List<FornecedorServicos>> fornecedorServcosFuture;

  @action
  void initPage(fornecedorId) {
    fornecedorFuture = ObservableFuture(_repository.findById(fornecedorId));
    fornecedorServcosFuture = ObservableFuture(_repository.buscarServicos(fornecedorId));
  }

  @action
  void adicionarServico(FornecedorServicos serv) {
    if(servicosSelecionados.contains(serv)) {
      servicosSelecionados.remove(serv);
    }else{
      servicosSelecionados.add(serv);
    }
    
  }

}
